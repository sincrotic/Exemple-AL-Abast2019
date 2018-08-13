//HEB.122 MT 24052018. Publicación de campo "Shipment Method Code Ext.".
//                     Ocultación de campo "Shipment Method Code".
//HEB.242 MR 11062018 Formularis vendes i compres no confirmades i pedido cliente. SP20150603_HEB
//HEB.244 MR 11062018 Camps relacionats venedor a fitxa client i traspassar a documents
pageextension 50041 SalesQuoteExt extends "Sales Quote"
{
    layout
    {
        //-HEB.122
        addfirst("Shipment Method")
        {
            field("Shipment Method Code Ext."; "Shipment Method Code Ext.")
            {
                Caption = 'Code';
                Visible = true;
                // Lookup = true;
                // LookupPageId = ShipmentMethodsNew;
            }
        }
        //+HEB.122
        //-HEB.244
        addafter("Assigned User ID")
        {
            field("Distributor Code";"Distributor Code") { }
            field("Salesperson/Resp. Code";"Salesperson/Resp. Code") { }
            field("Administr/Resp. Code";"Administr/Resp. Code") { }
        }
        //+HEB.244
        //-HEB.242
        addafter("Transaction Specification")
        {
            field("Customer Quote No.";"Customer Quote No.") { }
        }
        //+HEB.242
        addafter("Sell-to Contact")
        {
            field("Your Reference";"Your Reference")
            {
                Enabled = StatusOpenEnabled;
            }
        }
        addafter("Document Date")
        {
            field("Price Validity Date";"Price Validity Date")
            {
                Enabled = StatusOpenEnabled;
            }
            field("Days Validity";"Days Validity")
            {
                Enabled = StatusOpenEnabled;
            }
            field("Product Availability (value)";"Product Availability (value)")
            {
                Enabled = StatusOpenEnabled;
            }
            field("Product Availability (period)";"Product Availability (period)")
            {
                Enabled = StatusOpenEnabled;
            }
        }
        //-HEB.242
        addafter("No. of Archived Versions")
        {
            field("Non Accepted";"Non Accepted")
            {
                trigger OnValidate();
                begin
                    //-999
                    ActivateFieldsExt;
                    //+999
                end;
            }
            field("Cause NA";"Cause NA")
            {
                Editable = CauseNAEditable;
            }
            field("Date NA";"Date NA")
            {
                Editable = false;
            }
            field("ProForma No.";"ProForma No.") { }
        }
        //+HEB.242
        modify("Payment Terms Code")
        {
            Enabled = StatusOpenEnabled;
        }
        //-HEB.122
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        //+HEB.122
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate();
            begin
                ActivateFieldsExt;
                VisibleFields;
                CurrPage.Update;
            end;
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            group(PrintExt)
            {
                Caption = 'Print';
                group(Proforma)
                {
                    Caption = 'Document';
                    //PENDIENTE HACER REPORT
                    //FUNCION YA HECHA
                    // action(ReleaseExt)
                    // {
                    //     Caption = 'Documento';
                    //     ApplicationArea = All;
                    //     trigger OnAction();
                    //     var
                    //         ReleaseSalesDoc : Codeunit "Release Sales Document";
                    //         DocPrint : Codeunit "Sales Abast Library";
                    //     begin
                    //         //-218
                    //         GetProFormaNo;
                    //         ReleaseSalesDoc.PerformManualRelease(Rec);
                    //         DocPrint.PrintProforma(Rec);
                    //         //+218
                    //     end;
                    // }
                    action(EmailPDFProforma)
                    {
                        Caption = 'Enviar por Mail en PDF';
                        Image = SendMail;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        trigger OnAction();
                        var
                            SalesAbastLibrary : Codeunit "Sales Abast Library";
                            ReleaseSalesDoc : Codeunit "Release Sales Document";
                        begin
                            //-218
                            GetProFormaNo;
                            CurrPage.UPDATE(FALSE);
                            ReleaseSalesDoc.PerformManualRelease(Rec);
                            SalesAbastLibrary.DirectPrintSalesHeader(Rec, true);
                            //+218
                        end;
                    }
                }
            }
        }
        addafter(MakeOrder)
        {
            action(MakeBlanketOrder)
            {
                Caption = 'Make Blanket Order';
                Enabled = ("Sell-to Customer No." <> '') OR ("Sell-to Contact No." <> '');
                ToolTip = 'Convert the sales quote to a blanket sales order.';
                ApplicationArea = All;
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction();
                var
                    PurchaseHeader : Record "Purchase Header";
                    ApprovalMgt : Codeunit "Approvals Mgmt.";
                    SalesQuoteToBlanketOrder : Codeunit "Sales Abast Library";
                begin
                    //-999
                    IF ApprovalMgt.PrePostApprovalCheckSales(Rec) THEN
                        SalesQuoteToBlanketOrder.SalesQuoteToOrderYesNo(Rec);
                        //CODEUNIT.RUN(CODEUNIT::"Sales-Quote to Bl. Order (Y/N)",Rec);
                    //+999
                end;
            }
        }
        addafter(Print)
        {
            action(EmailPDF)
            {
                Caption = 'Enviar por Mail en PDF';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction();
                var
                    ApplicationAreaSetup : Record "Application Area Setup";
                    LinesInstructionMgt : Codeunit "Lines Instruction Mgt.";
                    SalesAbastLibrary : Codeunit "Sales Abast Library";
                    ReleaseSalesDoc : Codeunit "Release Sales Document";
                begin
                    IF ApplicationAreaSetup.IsFoundationEnabled THEN
                        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
                    ReleaseSalesDoc.PerformManualRelease(Rec);
                    SalesAbastLibrary.DirectPrintSalesHeader(Rec, true);
                end;
            }
        }
        modify(Email)
        {
            Visible = false;
            Enabled = false;
        }
    }
    var
        EspecialesVisible : Boolean;
        VariablesVisible : Boolean;
        StatusOpenEnabled : Boolean;
        CauseNAEditable : Boolean;

    trigger OnAfterGetCurrRecord();
    begin
        ActivateFieldsExt;
        //UpdateInfoPanel;
        VisibleFields;
    end;

    // local procedure UpdateInfoPanel()
    // begin
    //     DifferSellToBillTo := "Sell-to Customer No." <> "Bill-to Customer No.";
    //     CurrPage.SalesHistoryBtn.VISIBLE := DifferSellToBillTo;
    //     CurrPage.BillToCommentPict.VISIBLE := DifferSellToBillTo;
    //     CurrPage.BillToCommentBtn.VISIBLE := DifferSellToBillTo;
    //     CurrPage.SalesHistoryStn.VISIBLE := SalesInfoPaneMgt.DocExist(Rec,"Sell-to Customer No.");
    //     IF DifferSellToBillTo THEN
    //         CurrPage.SalesHistoryBtn.VISIBLE := SalesInfoPaneMgt.DocExist(Rec,"Bill-to Customer No.")
    // end;

    local procedure VisibleFields()
    var
        recCust : Record Customer;
    begin
        IF NOT recCust.GET("Sell-to Customer No.") THEN
            recCust.INIT;

        EspecialesVisible := recCust."Special Conditions";
        VariablesVisible := recCust."Variable Payment Conditions";
    end;
    local procedure ActivateFieldsExt()
    begin
        //+156
        StatusOpenEnabled := Status = Status::Open;
        //CurrPage."Price Validity Date".ENABLED(
        //CurrPage."Days Validity".ENABLED(
        //CurrPage."Product Availability (value)".ENABLED(
        //CurrPage."Product Availability (period)".ENABLED(
        //CurrPage."Your Reference".ENABLED(
        //CurrPage."Payment Terms Code".ENABLED(
        //-156
        //-999
        CauseNAEditable := "Non Accepted";
        //CurrPage."Cause NA".EDITABLE("Non Accepted");
        //+999
    end;
}