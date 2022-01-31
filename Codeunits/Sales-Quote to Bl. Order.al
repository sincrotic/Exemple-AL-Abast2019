codeunit 50003 "Sales-Quote to Blanket Order"
{
    // version NAVW111.00.00.22292

    TableNo = "Sales Header";

    trigger OnRun();
    var
        Cust: Record Customer;
        SalesCommentLine: Record "Sales Comment Line";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        RecordLinkManagement: Codeunit "Record Link Management";
        ShouldRedistributeInvoiceAmount: Boolean;
    begin
        TESTFIELD("Document Type", "Document Type"::Quote);
        ShouldRedistributeInvoiceAmount := SalesCalcDiscountByType.ShouldRedistributeInvoiceDiscountAmount(Rec);

        //OnCheckSalesPostRestrictions;

        Cust.GET("Sell-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust, "Document Type"::"Blanket Order", TRUE, FALSE);
        IF "Sell-to Customer No." <> "Bill-to Customer No." THEN BEGIN
            Cust.GET("Bill-to Customer No.");
            Cust.CheckBlockedCustOnDocs(Cust, "Document Type"::"Blanket Order", TRUE, FALSE);
        END;
        CALCFIELDS("Amount Including VAT", "Work Description");

        //CheckItemAvailabilityInLines;

        ValidateSalesPersonOnSalesHeader(Rec, TRUE, FALSE);

        CheckInProgressOpportunities(Rec);

        CreateSalesHeader(Rec, Cust."Prepayment %");

        TransferQuoteToSalesBlanketOrderLines(SalesQuoteLine, Rec, SalesBlanketOrderLine, SalesBlanketOrderHeader, Cust);
        OnAfterInsertAllSalesOrderLines(SalesBlanketOrderLine, Rec);

        SalesSetup.GET;
        IF SalesSetup."Archive Orders" and (SalesSetup."Archive Quotes" = SalesSetup."Archive Quotes"::Always) THEN
            ArchiveManagement.ArchSalesDocumentNoConfirm(Rec);

        IF SalesSetup."Default Posting Date" = SalesSetup."Default Posting Date"::"No Date" THEN BEGIN
            SalesBlanketOrderHeader."Posting Date" := 0D;
            SalesBlanketOrderHeader.MODIFY;
        END;

        SalesCommentLine.CopyComments("Document Type", SalesBlanketOrderHeader."Document Type", "No.", SalesBlanketOrderHeader."No.");
        RecordLinkManagement.CopyLinks(Rec, SalesBlanketOrderHeader);

        AssignItemCharges("Document Type", "No.", SalesBlanketOrderHeader."Document Type", SalesBlanketOrderHeader."No.");

        MoveWonLostOpportunites(Rec, SalesBlanketOrderHeader);

        ApprovalsMgmt.CopyApprovalEntryQuoteToOrder(RECORDID, SalesBlanketOrderHeader."No.", SalesBlanketOrderHeader.RECORDID);
        ApprovalsMgmt.DeleteApprovalEntries(RECORDID);

        OnBeforeDeleteSalesQuote(Rec, SalesBlanketOrderHeader);

        DELETELINKS;
        DELETE;

        SalesQuoteLine.DELETEALL;

        IF NOT ShouldRedistributeInvoiceAmount THEN
            SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(SalesBlanketOrderHeader);

        OnAfterOnRun(Rec, SalesBlanketOrderHeader);
    end;

    var
        Text000: TextConst Comment = 'An open Opportunity is linked to this Quote. The Opportunity has to be closed before the Quote can be converted to an Order. Do you want to close the Opportunity now and continue the conversion?', ENU = 'An open %1 is linked to this %2. The %1 has to be closed before the %2 can be converted to an %3. Do you want to close the %1 now and continue the conversion?', ESP = 'Una %1 abierta se une a esta %2. La %1 tiene que estar cerrada antes de que %2 pueda convertirse en un %3. ¿Confirma que desea cerrar %1 y continuar la conversación?';
        Text001: TextConst Comment = 'An open Opportunity is still linked to this Quote. The conversion to an Order was aborted.', ENU = 'An open %1 is still linked to this %2. The conversion to an %3 was aborted.', ESP = 'Una %1 abierta sigue vinculada a esta %2. Se canceló la conversión a un %3.';
        SalesQuoteLine: Record "Sales Line";
        SalesBlanketOrderHeader: Record "Sales Header";
        SalesBlanketOrderLine: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";

    local procedure CreateSalesHeader(SalesHeader: Record "Sales Header"; PrepmtPercent: Decimal);
    begin
        WITH SalesHeader DO BEGIN
            SalesBlanketOrderHeader := SalesHeader;
            SalesBlanketOrderHeader."Document Type" := SalesBlanketOrderHeader."Document Type"::"Blanket Order";

            SalesBlanketOrderHeader."No. Printed" := 0;
            SalesBlanketOrderHeader.Status := SalesBlanketOrderHeader.Status::Open;
            SalesBlanketOrderHeader."No." := '';
            SalesBlanketOrderHeader."Quote No." := "No.";

            //-218
            //MARTI SalesBlanketOrderHeader."ProForma No." := "ProForma No.";
            //+218
            SalesBlanketOrderLine.LOCKTABLE;
            SalesBlanketOrderHeader.INSERT(TRUE);

            SalesBlanketOrderHeader."Order Date" := "Order Date";
            IF "Posting Date" <> 0D THEN
                SalesBlanketOrderHeader."Posting Date" := "Posting Date";

            SalesBlanketOrderHeader.InitFromSalesHeader(SalesHeader);
            SalesBlanketOrderHeader."Outbound Whse. Handling Time" := "Outbound Whse. Handling Time";
            SalesBlanketOrderHeader.Reserve := Reserve;

            SalesBlanketOrderHeader."Prepayment %" := PrepmtPercent;
            IF SalesBlanketOrderHeader."Posting Date" = 0D THEN
                SalesBlanketOrderHeader."Posting Date" := WORKDATE;
            OnBeforeInsertSalesOrderHeader(SalesBlanketOrderHeader, SalesHeader);
            SalesBlanketOrderHeader.MODIFY;
        END;
    end;

    local procedure AssignItemCharges(FromDocType: Option; FromDocNo: Code[20]; ToDocType: Option; ToDocNo: Code[20]);
    var
        ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
    begin
        ItemChargeAssgntSales.RESET;
        ItemChargeAssgntSales.SETRANGE("Document Type", FromDocType);
        ItemChargeAssgntSales.SETRANGE("Document No.", FromDocNo);
        WHILE ItemChargeAssgntSales.FINDFIRST DO BEGIN
            ItemChargeAssgntSales.DELETE;
            ItemChargeAssgntSales."Document Type" := SalesBlanketOrderHeader."Document Type";
            ItemChargeAssgntSales."Document No." := SalesBlanketOrderHeader."No.";
            IF NOT (ItemChargeAssgntSales."Applies-to Doc. Type" IN
                    [ItemChargeAssgntSales."Applies-to Doc. Type"::Shipment,
                     ItemChargeAssgntSales."Applies-to Doc. Type"::"Return Receipt"])
            THEN BEGIN
                ItemChargeAssgntSales."Applies-to Doc. Type" := ToDocType;
                ItemChargeAssgntSales."Applies-to Doc. No." := ToDocNo;
            END;
            ItemChargeAssgntSales.INSERT;
        END;
    end;

    [Scope('Personalization')]
    procedure GetSalesOrderHeader(var SalesHeader2: Record "Sales Header");
    begin
        SalesHeader2 := SalesBlanketOrderHeader;
    end;

    [Scope('Personalization')]
    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    begin
        IF NewHideValidationDialog THEN
            EXIT;
    end;

    local procedure CheckInProgressOpportunities(var SalesHeader: Record "Sales Header");
    var
        Opp: Record Opportunity;
        TempOpportunityEntry: Record "Opportunity Entry" temporary;
    begin
        Opp.RESET;
        Opp.SETCURRENTKEY("Sales Document Type", "Sales Document No.");
        Opp.SETRANGE("Sales Document Type", Opp."Sales Document Type"::Quote);
        Opp.SETRANGE("Sales Document No.", SalesHeader."No.");
        Opp.SETRANGE(Status, Opp.Status::"In Progress");
        IF Opp.FINDFIRST THEN BEGIN
            IF NOT CONFIRM(Text000, TRUE, Opp.TABLECAPTION, Opp."Sales Document Type"::Quote, Opp."Sales Document Type"::Order) THEN
                ERROR('');
            TempOpportunityEntry.DELETEALL;
            TempOpportunityEntry.INIT;
            TempOpportunityEntry.VALIDATE("Opportunity No.", Opp."No.");
            TempOpportunityEntry."Sales Cycle Code" := Opp."Sales Cycle Code";
            TempOpportunityEntry."Contact No." := Opp."Contact No.";
            TempOpportunityEntry."Contact Company No." := Opp."Contact Company No.";
            TempOpportunityEntry."Salesperson Code" := Opp."Salesperson Code";
            TempOpportunityEntry."Campaign No." := Opp."Campaign No.";
            TempOpportunityEntry."Action Taken" := TempOpportunityEntry."Action Taken"::Won;
            TempOpportunityEntry."Calcd. Current Value (LCY)" := TempOpportunityEntry.GetSalesDocValue(SalesHeader);
            TempOpportunityEntry."Cancel Old To Do" := TRUE;
            TempOpportunityEntry."Wizard Step" := 1;
            TempOpportunityEntry.INSERT;
            TempOpportunityEntry.SETRANGE("Action Taken", TempOpportunityEntry."Action Taken"::Won);
            PAGE.RUNMODAL(PAGE::"Close Opportunity", TempOpportunityEntry);
            Opp.RESET;
            Opp.SETCURRENTKEY("Sales Document Type", "Sales Document No.");
            Opp.SETRANGE("Sales Document Type", Opp."Sales Document Type"::Quote);
            Opp.SETRANGE("Sales Document No.", SalesHeader."No.");
            Opp.SETRANGE(Status, Opp.Status::"In Progress");
            IF Opp.FINDFIRST THEN
                ERROR(Text001, Opp.TABLECAPTION, Opp."Sales Document Type"::Quote, Opp."Sales Document Type"::Order);
            COMMIT;
            SalesHeader.GET(SalesHeader."Document Type", SalesHeader."No.");
        END;
    end;

    local procedure MoveWonLostOpportunites(var SalesQuoteHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header");
    var
        Opp: Record Opportunity;
        OpportunityEntry: Record "Opportunity Entry";
    begin
        Opp.RESET;
        Opp.SETCURRENTKEY("Sales Document Type", "Sales Document No.");
        Opp.SETRANGE("Sales Document Type", Opp."Sales Document Type"::Quote);
        Opp.SETRANGE("Sales Document No.", SalesQuoteHeader."No.");
        IF Opp.FINDFIRST THEN
            IF Opp.Status = Opp.Status::Won THEN BEGIN
                Opp."Sales Document Type" := Opp."Sales Document Type";
                Opp."Sales Document No." := SalesOrderHeader."No.";
                Opp.MODIFY;
                OpportunityEntry.RESET;
                OpportunityEntry.SETCURRENTKEY(Active, "Opportunity No.");
                OpportunityEntry.SETRANGE(Active, TRUE);
                OpportunityEntry.SETRANGE("Opportunity No.", Opp."No.");
                IF OpportunityEntry.FINDFIRST THEN BEGIN
                    OpportunityEntry."Calcd. Current Value (LCY)" := OpportunityEntry.GetSalesDocValue(SalesOrderHeader);
                    OpportunityEntry.MODIFY;
                END;
            END ELSE
                IF Opp.Status = Opp.Status::Lost THEN BEGIN
                    Opp."Sales Document Type" := Opp."Sales Document Type"::" ";
                    Opp."Sales Document No." := '';
                    Opp.MODIFY;
                END;
    end;

    local procedure TransferQuoteToSalesBlanketOrderLines(var QuoteSalesLine: Record "Sales Line"; var QuoteSalesHeader: Record "Sales Header"; var OrderBlanketSalesLine: Record "Sales Line"; var OrderBlanketSalesHeader: Record "Sales Header"; Customer: Record "Customer");
    var
        ATOLink: Record "Assemble-to-Order Link";
        Resource: Record Resource;
        PrepmtMgt: Codeunit "Prepayment Mgt.";
        SalesLineReserve: Codeunit "Sales Line-Reserve";
    begin
        QuoteSalesLine.RESET;
        QuoteSalesLine.SETRANGE("Document Type", QuoteSalesHeader."Document Type");
        QuoteSalesLine.SETRANGE("Document No.", QuoteSalesHeader."No.");
        IF QuoteSalesLine.FINDSET THEN
            REPEAT
                IF QuoteSalesLine.Type = QuoteSalesLine.Type::Resource THEN
                    IF QuoteSalesLine."No." <> '' THEN
                        IF Resource.GET(QuoteSalesLine."No.") THEN BEGIN
                            Resource.CheckResourcePrivacyBlocked(FALSE);
                            Resource.TESTFIELD(Blocked, FALSE);
                        END;
                OrderBlanketSalesLine := QuoteSalesLine;
                OrderBlanketSalesLine."Document Type" := OrderBlanketSalesHeader."Document Type";
                OrderBlanketSalesLine."Document No." := OrderBlanketSalesHeader."No.";
                OrderBlanketSalesLine."Shortcut Dimension 1 Code" := QuoteSalesLine."Shortcut Dimension 1 Code";
                OrderBlanketSalesLine."Shortcut Dimension 2 Code" := QuoteSalesLine."Shortcut Dimension 2 Code";
                OrderBlanketSalesLine."Dimension Set ID" := QuoteSalesLine."Dimension Set ID";
                SalesBlanketOrderLine.VALIDATE("Qty. to Ship", 0);
                IF Customer."Prepayment %" <> 0 THEN
                    OrderBlanketSalesLine."Prepayment %" := Customer."Prepayment %";
                PrepmtMgt.SetSalesPrepaymentPct(OrderBlanketSalesLine, OrderBlanketSalesHeader."Posting Date");
                OrderBlanketSalesLine.VALIDATE("Prepayment %");
                IF OrderBlanketSalesLine."No." <> '' THEN
                    OrderBlanketSalesLine.DefaultDeferralCode;
                OnBeforeInsertSalesOrderLine(OrderBlanketSalesLine, OrderBlanketSalesHeader, QuoteSalesLine, QuoteSalesHeader);
                OrderBlanketSalesLine.INSERT;
                OnAfterInsertSalesOrderLine(OrderBlanketSalesLine, OrderBlanketSalesHeader, QuoteSalesLine, QuoteSalesHeader);
                ATOLink.MakeAsmOrderLinkedToSalesOrderLine(QuoteSalesLine, OrderBlanketSalesLine);
                SalesLineReserve.TransferSaleLineToSalesLine(
                  QuoteSalesLine, OrderBlanketSalesLine, QuoteSalesLine."Outstanding Qty. (Base)");
                SalesLineReserve.VerifyQuantity(OrderBlanketSalesLine, QuoteSalesLine);

                IF OrderBlanketSalesLine.Reserve = OrderBlanketSalesLine.Reserve::Always THEN
                    OrderBlanketSalesLine.AutoReserve;

            UNTIL QuoteSalesLine.NEXT = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDeleteSalesQuote(var QuoteSalesHeader: Record "Sales Header"; var OrderSalesHeader: Record "Sales Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertAllSalesOrderLines(var SalesOrderLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRun(var SalesHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header");
    begin
    end;
}