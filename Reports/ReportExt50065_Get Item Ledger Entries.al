report 50065 "Get Item Ledger Entries Ext"
{
    // version NAVW19.00.00.45480,NAVES9.00.00.45480,INTRASTAT

    // //TECNOCOM-001-JLR-08/06/15 Arrastrar Nº Cli/Pro. y NIF a Diario Intrastat
    // //000.TRA - Se modifica el filtro de Item Ledger Entry para que no salgan los pedidos de transferencia

    Caption = 'Get Item Ledger Entries';
    Permissions = TableData "General Posting Setup"=imd;
    ProcessingOnly = true;
    Description = 'HEB.506';

    dataset
    {
        dataitem("Country/Region";"Country/Region")
        {
            DataItemTableView = SORTING("Intrastat Code")
                                WHERE("Intrastat Code"=FILTER(<>''));
            dataitem("Item Ledger Entry";"Item Ledger Entry")
            {
                DataItemTableView = SORTING("Country/Region Code","Entry Type","Posting Date")
                                    WHERE("Entry Type"=FILTER(Purchase|Sale),
                                          Correction=CONST(false));

                trigger OnAfterGetRecord();
                var
                    ItemLedgEntry : Record "Item Ledger Entry";
                begin
                    IntrastatJnlLine2.SETRANGE("Source Entry No.","Entry No.");
                    IF IntrastatJnlLine2.FINDFIRST THEN
                      CurrReport.SKIP;
                    IF NOT HasCrossedBorder("Item Ledger Entry") OR IsService("Item Ledger Entry") THEN
                      CurrReport.SKIP;

                    IF "Entry Type" IN ["Entry Type"::Sale,"Entry Type"::Purchase] THEN BEGIN
                      ItemLedgEntry.RESET;
                      ItemLedgEntry.SETCURRENTKEY("Document No.","Document Type");
                      ItemLedgEntry.SETRANGE("Document No.","Document No.");
                      ItemLedgEntry.SETRANGE("Item No.","Item No.");
                      ItemLedgEntry.SETRANGE(Correction,TRUE);
                      IF "Document Type" IN ["Document Type"::"Sales Shipment","Document Type"::"Sales Return Receipt",
                                             "Document Type"::"Purchase Receipt","Document Type"::"Purchase Return Shipment"]
                      THEN BEGIN
                        ItemLedgEntry.SETRANGE("Document Type","Document Type");
                        IF ItemLedgEntry.FINDSET THEN
                          REPEAT
                            IF IsItemLedgerEntryCorrected(ItemLedgEntry,"Entry No.") THEN
                              CurrReport.SKIP;
                          UNTIL ItemLedgEntry.NEXT = 0;
                      END;
                    END;

                    CalculateTotals("Item Ledger Entry");

                    IF (TotalAmt = 0) AND SkipZeroAmounts THEN
                      CurrReport.SKIP;

                    InsertItemJnlLine;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Posting Date",StartDate,EndDate);

                    IF ("Country/Region".Code = CompanyInfo."Country/Region Code") OR
                       ((CompanyInfo."Country/Region Code" = '') AND NOT ShowBlank)
                    THEN BEGIN
                      ShowBlank := TRUE;
                      SETFILTER("Country/Region Code",'%1|%2',"Country/Region".Code,'');
                    END ELSE
                      SETRANGE("Country/Region Code","Country/Region".Code);

                    IntrastatJnlLine2.SETCURRENTKEY("Source Type","Source Entry No.");
                    IntrastatJnlLine2.SETRANGE("Source Type",IntrastatJnlLine2."Source Type"::"Item entry");

                    WITH ValueEntry DO BEGIN
                      SETCURRENTKEY("Item Ledger Entry No.");
                      SETRANGE("Entry Type","Entry Type"::"Direct Cost");
                      SETFILTER(
                        //SENSOFAR
                        //"Item Ledger Entry Type",'%1|%2|%3',
                        "Item Ledger Entry Type",'%1|%2',
                        "Item Ledger Entry Type"::Sale,

                        //SENSOFAR
                        "Item Ledger Entry Type"::Purchase);
                        //"Item Ledger Entry Type"::Purchase,
                        //"Item Ledger Entry Type"::Transfer);
                    END;
                end;
            }
            dataitem("Job Ledger Entry";"Job Ledger Entry")
            {
                DataItemLink = "Country/Region Code"=FIELD(Code);
                DataItemTableView = SORTING(Type,"Entry Type","Country/Region Code","Source Code","Posting Date")
                                    WHERE(Type=CONST(Item),
                                          "Source Code"=FILTER(<>''),
                                          "Entry Type"=CONST(Usage));

                trigger OnAfterGetRecord();
                begin
                    IntrastatJnlLine2.SETRANGE("Source Entry No.","Entry No.");
                    IF IntrastatJnlLine2.FINDFIRST OR (CompanyInfo."Country/Region Code" = "Country/Region Code") THEN
                      CurrReport.SKIP;

                    IF IsJobService("Job Ledger Entry") THEN
                      CurrReport.SKIP;

                    InsertJobLedgerLine;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Posting Date",StartDate,EndDate);
                    IntrastatJnlLine2.SETCURRENTKEY("Source Type","Source Entry No.");
                    IntrastatJnlLine2.SETRANGE("Source Type",IntrastatJnlLine2."Source Type"::"Job entry");
                end;
            }
        }
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = SORTING("Entry No.");

            trigger OnAfterGetRecord();
            begin
                IF ShowItemCharges THEN BEGIN
                  IntrastatJnlLine2.SETRANGE("Source Entry No.","Item Ledger Entry No.");
                  IF IntrastatJnlLine2.FINDFIRST THEN
                    CurrReport.SKIP;

                  IF "Item Ledger Entry".GET("Item Ledger Entry No.")
                  THEN BEGIN
                    IF "Item Ledger Entry"."Posting Date" IN [StartDate..EndDate] THEN
                      CurrReport.SKIP;
                    IF "Country/Region".GET("Item Ledger Entry"."Country/Region Code") THEN
                      IF "Country/Region"."EU Country/Region Code" = '' THEN
                        CurrReport.SKIP;
                    IF NOT HasCrossedBorder("Item Ledger Entry") THEN
                      CurrReport.SKIP;
                    InsertValueEntryLine;
                  END;
                END;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Posting Date",StartDate,EndDate);
                SETFILTER("Item Charge No.",'<> %1','');
                "Item Ledger Entry".SETRANGE("Posting Date");

                IntrastatJnlLine2.SETRANGE("Journal Batch Name",IntrastatJnlBatch.Name);
                IntrastatJnlLine2.SETCURRENTKEY("Source Type","Source Entry No.");
                IntrastatJnlLine2.SETRANGE("Source Type",IntrastatJnlLine2."Source Type"::"Item entry");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartingDate;StartDate)
                    {
                        Caption = 'Starting Date';
                    }
                    field(EndingDate;EndDate)
                    {
                        Caption = 'Ending Date';
                    }
                    field(IndirectCostPctReq;IndirectCostPctReq)
                    {
                        Caption = 'Cost Regulation %';
                        DecimalPlaces = 0:6;
                        MaxValue = 100;
                        MinValue = 0;
                    }
                }
                group(Additional)
                {
                    Caption = 'Additional';
                    field(SkipRecalcForZeros;SkipRecalcZeroAmounts)
                    {
                        Caption = 'Skip Recalculation for Zero Amounts';
                    }
                    field(SkipZeros;SkipZeroAmounts)
                    {
                        Caption = 'Skip Zero Amounts';
                    }
                    field(ShowingItemCharges;ShowItemCharges)
                    {
                        Caption = 'Show Item Charge Entries';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            IntraJnlTemplate.GET(IntrastatJnlLine."Journal Template Name");
            IntrastatJnlBatch.GET(IntrastatJnlLine."Journal Template Name",IntrastatJnlLine."Journal Batch Name");
            IntrastatJnlBatch.TESTFIELD("Statistics Period");
            Century := DATE2DMY(WORKDATE,3) DIV 100;
            EVALUATE(Year,COPYSTR(IntrastatJnlBatch."Statistics Period",1,2));
            Year := Year + Century * 100;
            EVALUATE(Month,COPYSTR(IntrastatJnlBatch."Statistics Period",3,2));
            StartDate := DMY2DATE(1,Month,Year);
            EndDate := CALCDATE('<+1M-1D>',StartDate);
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        CompanyInfo.FINDFIRST;
    end;

    trigger OnPreReport();
    begin
        IntrastatJnlLine.SETRANGE("Journal Template Name",IntrastatJnlLine."Journal Template Name");
        IntrastatJnlLine.SETRANGE("Journal Batch Name",IntrastatJnlLine."Journal Batch Name");
        IntrastatJnlLine.LOCKTABLE;
        IF IntrastatJnlLine.FINDLAST THEN;

        IntrastatJnlBatch.GET(IntrastatJnlLine."Journal Template Name",IntrastatJnlLine."Journal Batch Name");
        IntrastatJnlBatch.TESTFIELD(Reported,FALSE);

        GetGLSetup;
        IF IntrastatJnlBatch."Amounts in Add. Currency" THEN BEGIN
          GLSetup.TESTFIELD("Additional Reporting Currency");
          AddCurrencyFactor :=
            CurrExchRate.ExchangeRate(EndDate,GLSetup."Additional Reporting Currency");
        END;
    end;

    var
        Text000 : Label 'Prices including VAT cannot be calculated when %1 is %2.';
        IntraJnlTemplate : Record "Intrastat Jnl. Template";
        IntrastatJnlBatch : Record "Intrastat Jnl. Batch";
        IntrastatJnlLine : Record "Intrastat Jnl. Line";
        IntrastatJnlLine2 : Record "Intrastat Jnl. Line";
        Item : Record "Item";
        ValueEntry : Record "Value Entry";
        GLSetup : Record "General Ledger Setup";
        CurrExchRate : Record "Currency Exchange Rate";
        CompanyInfo : Record "Company Information";
        Currency : Record "Currency";
        StartDate : Date;
        EndDate : Date;
        IndirectCostPctReq : Decimal;
        TotalAmt : Decimal;
        Century : Integer;
        Year : Integer;
        Month : Integer;
        AddCurrencyFactor : Decimal;
        AverageCost : Decimal;
        AverageCostACY : Decimal;
        GLSetupRead : Boolean;
        ShowBlank : Boolean;
        SkipRecalcZeroAmounts : Boolean;
        SkipZeroAmounts : Boolean;
        ShowItemCharges : Boolean;

    procedure SetIntrastatJnlLine(NewIntrastatJnlLine : Record "Intrastat Jnl. Line");
    begin
        IntrastatJnlLine := NewIntrastatJnlLine;
    end;

    local procedure InsertItemJnlLine();
    var
        Location : Record "Location";
        lRecVendor : Record "Vendor";
        lRecCustomer : Record "Customer";
        TransportMethod : Record "Transport Method";
    begin
        GetGLSetup;
        WITH IntrastatJnlLine DO BEGIN
          INIT;
          "Line No." := "Line No." + 10000;
          Date := "Item Ledger Entry"."Posting Date";
          "Country/Region Code" := "Item Ledger Entry"."Country/Region Code";
          "Transaction Type" := "Item Ledger Entry"."Transaction Type";
          "Transport Method" := "Item Ledger Entry"."Transport Method";
          "Shipment Method Code #1" := "Item Ledger Entry"."Shipment Method Code";
          "Source Entry No." := "Item Ledger Entry"."Entry No.";
          Amount := TotalAmt;
          Quantity := "Item Ledger Entry".Quantity;
          "Document No." := "Item Ledger Entry"."Document No.";
          "Item No." := "Item Ledger Entry"."Item No.";
          "Entry/Exit Point" := "Item Ledger Entry"."Entry/Exit Point";
          //Sensofar
          IF TransportMethod.GET("Item Ledger Entry"."Transport Method") THEN
            IF NOT TransportMethod."Port/Airport" THEN
              "Entry/Exit Point" := '';
          //End Sensofar
          Area := "Item Ledger Entry".Area;
          "Transaction Specification" := "Item Ledger Entry"."Transaction Specification";

          IF Quantity < 0 THEN
            Type := Type::Shipment
          ELSE
            Type := Type::Receipt;

          IF IntrastatJnlBatch."Amounts in Add. Currency" THEN
            Amount := ROUND(ABS(Amount),Currency."Amount Rounding Precision")
          ELSE
            Amount := ROUND(ABS(Amount),GLSetup."Amount Rounding Precision");

          IF ("Country/Region Code" = '') OR
             ("Country/Region Code" = CompanyInfo."Country/Region Code")
          THEN
            IF "Item Ledger Entry"."Location Code" = '' THEN
              "Country/Region Code" := CompanyInfo."Ship-to Country/Region Code"
            ELSE BEGIN
              Location.GET("Item Ledger Entry"."Location Code");
              "Country/Region Code" := Location."Country/Region Code"
            END;

          VALIDATE("Item No.");
          "Source Type" := "Source Type"::"Item entry";
          VALIDATE(Quantity,ROUND(ABS(Quantity),0.000001));

          IF IndirectCostPctReq <> 0 THEN
            VALIDATE("Cost Regulation %",IndirectCostPctReq)
          ELSE BEGIN
            Item.GET("Item No.");
            VALIDATE("Cost Regulation %",Item."Cost Regulation %");
          END;

          //TEC-001
          IF "Item Ledger Entry"."Source Type" = "Item Ledger Entry"."Source Type"::Vendor THEN BEGIN
            "Partner No." := "Item Ledger Entry"."Source No.";
            IF lRecVendor.GET("Item Ledger Entry"."Source No.") THEN
              "Partner VAT Registration No." := lRecVendor."VAT Registration No.";
          END;
          IF "Item Ledger Entry"."Source Type" = "Item Ledger Entry"."Source Type"::Customer THEN BEGIN
            "Partner No." := "Item Ledger Entry"."Source No.";
            IF lRecCustomer.GET("Item Ledger Entry"."Source No.") THEN
              "Partner VAT Registration No." := lRecCustomer."VAT Registration No.";
          END;
          //


          INSERT;
        END;
    end;

    local procedure InsertJobLedgerLine();
    begin
        WITH IntrastatJnlLine DO BEGIN
          INIT;
          "Line No." := "Line No." + 10000;

          Date := "Job Ledger Entry"."Posting Date";
          "Country/Region Code" := "Job Ledger Entry"."Country/Region Code";
          "Transaction Type" := "Job Ledger Entry"."Transaction Type";
          "Transport Method" := "Job Ledger Entry"."Transport Method";
          "Shipment Method Code #1" := "Job Ledger Entry"."Shipment Method Code";
          Quantity := "Job Ledger Entry"."Quantity (Base)";
          IF Quantity > 0 THEN
            Type := Type::Shipment
          ELSE
            Type := Type::Receipt;
          IF IntrastatJnlBatch."Amounts in Add. Currency" THEN
            Amount := "Job Ledger Entry"."Add.-Currency Line Amount"
          ELSE
            Amount := "Job Ledger Entry"."Line Amount (LCY)";
          "Source Entry No." := "Job Ledger Entry"."Entry No.";
          "Document No." := "Job Ledger Entry"."Document No.";
          "Item No." := "Job Ledger Entry"."No.";
          "Entry/Exit Point" := "Job Ledger Entry"."Entry/Exit Point";
          Area := "Job Ledger Entry".Area;
          "Transaction Specification" := "Job Ledger Entry"."Transaction Specification";

          IF IntrastatJnlBatch."Amounts in Add. Currency" THEN
            Amount := ROUND(ABS(Amount),Currency."Amount Rounding Precision")
          ELSE
            Amount := ROUND(ABS(Amount),GLSetup."Amount Rounding Precision");

          VALIDATE("Item No.");
          "Source Type" := "Source Type"::"Job entry";
          VALIDATE(Quantity,ROUND(ABS(Quantity),0.000001));

          IF IndirectCostPctReq <> 0 THEN
            VALIDATE("Cost Regulation %",IndirectCostPctReq)
          ELSE BEGIN
            Item.GET("Item No.");
            VALIDATE("Cost Regulation %",Item."Cost Regulation %");
          END;

          INSERT;
        END;
    end;

    local procedure GetGLSetup();
    begin
        IF NOT GLSetupRead THEN BEGIN
          GLSetup.GET;
          IF GLSetup."Additional Reporting Currency" <> '' THEN
            Currency.GET(GLSetup."Additional Reporting Currency");
        END;
        GLSetupRead := TRUE;
    end;

    local procedure CalculateAverageCost(var AverageCost : Decimal;var AverageCostACY : Decimal) : Boolean;
    var
        ValueEntry : Record "Value Entry";
        ItemLedgEntry : Record "Item Ledger Entry";
        AverageQty : Decimal;
    begin
        WITH ItemLedgEntry DO BEGIN
          SETCURRENTKEY("Item No.","Entry Type");
          SETRANGE("Item No.","Item Ledger Entry"."Item No.");
          SETRANGE("Entry Type","Item Ledger Entry"."Entry Type");
          CALCSUMS(Quantity);
        END;

        WITH ValueEntry DO BEGIN
          SETCURRENTKEY("Item No.","Posting Date","Item Ledger Entry Type");
          SETRANGE("Item No.","Item Ledger Entry"."Item No.");
          SETRANGE("Item Ledger Entry Type","Item Ledger Entry"."Entry Type");
          CALCSUMS(
            "Cost Amount (Actual)",
            "Cost Amount (Expected)");
          "Cost Amount (Actual) (ACY)" :=
            CurrExchRate.ExchangeAmtLCYToFCY(
              EndDate,GLSetup."Additional Reporting Currency","Cost Amount (Actual)",AddCurrencyFactor);
          "Cost Amount (Expected) (ACY)" :=
            CurrExchRate.ExchangeAmtLCYToFCY(
              EndDate,GLSetup."Additional Reporting Currency","Cost Amount (Expected)",AddCurrencyFactor);
          AverageQty := ItemLedgEntry.Quantity;
          AverageCost := "Cost Amount (Actual)" + "Cost Amount (Expected)";
          AverageCostACY := "Cost Amount (Actual) (ACY)" + "Cost Amount (Expected) (ACY)";
        END;
        IF AverageQty <> 0 THEN BEGIN
          AverageCost := AverageCost / AverageQty;
          AverageCostACY := AverageCostACY / AverageQty;
          IF (AverageCost < 0) OR (AverageCostACY < 0) THEN BEGIN
            AverageCost := 0;
            AverageCostACY := 0;
          END;
        END ELSE BEGIN
          AverageCost := 0;
          AverageCostACY := 0;
        END;

        EXIT(AverageQty >= 0);
    end;

    local procedure CountryOfOrigin(CountryRegionCode : Code[20]) : Boolean;
    var
        CountryRegion : Record "Country/Region";
    begin
        IF ("Item Ledger Entry"."Country/Region Code" IN [CompanyInfo."Country/Region Code",'']) =
           (CountryRegionCode IN [CompanyInfo."Country/Region Code",''])
        THEN
          EXIT(FALSE);

        IF CountryRegionCode <> '' THEN BEGIN
          CountryRegion.GET(CountryRegionCode);
          IF CountryRegion."Intrastat Code" = '' THEN
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;

    local procedure HasCrossedBorder(ItemLedgEntry : Record "Item Ledger Entry") : Boolean;
    var
        ItemLedgEntry2 : Record "Item Ledger Entry";
        Location : Record "Location";
        Include : Boolean;
        "------------------------SENSOFAR" : Integer;
        ServiceItem : Record "Item";
    begin
        WITH ItemLedgEntry DO
          CASE TRUE OF
            "Drop Shipment":
              BEGIN
                IF ("Country/Region Code" = CompanyInfo."Country/Region Code") OR
                   ("Country/Region Code" = '')
                THEN
                  EXIT(FALSE);
                IF "Applies-to Entry" = 0 THEN BEGIN
                  ItemLedgEntry2.SETCURRENTKEY("Item No.","Posting Date");
                  ItemLedgEntry2.SETRANGE("Item No.","Item No.");
                  ItemLedgEntry2.SETRANGE("Posting Date","Posting Date");
                  ItemLedgEntry2.SETRANGE("Applies-to Entry","Entry No.");
                  ItemLedgEntry2.FINDFIRST;
                END ELSE
                  ItemLedgEntry2.GET("Applies-to Entry");
                IF (ItemLedgEntry2."Country/Region Code" <> CompanyInfo."Country/Region Code") AND
                   (ItemLedgEntry2."Country/Region Code" <> '')
                THEN
                  EXIT(FALSE);
              END;
            //SENSOFAR
            /*
            "Entry Type" = "Entry Type"::Transfer:
              BEGIN
                IF ("Country/Region Code" = CompanyInfo."Country/Region Code") OR
                   ("Country/Region Code" = '')
                THEN
                  EXIT(FALSE);
                IF ("Order Type" <> "Order Type"::Transfer) OR ("Order No." = '') THEN BEGIN
                  Location.GET("Location Code");
                  IF (Location."Country/Region Code" <> '') AND
                     (Location."Country/Region Code" <> CompanyInfo."Country/Region Code")
                  THEN
                    EXIT(FALSE);
                END ELSE BEGIN
                  ItemLedgEntry2.SETCURRENTKEY("Order Type","Order No.");
                  ItemLedgEntry2.SETRANGE("Order Type","Order Type"::Transfer);
                  ItemLedgEntry2.SETRANGE("Order No.","Order No.");
                  ItemLedgEntry2.SETFILTER("Country/Region Code",'%1 | %2','',CompanyInfo."Country/Region Code");
                  IF ItemLedgEntry2.FINDSET THEN
                    REPEAT
                      Location.GET(ItemLedgEntry2."Location Code");
                      IF Location."Use As In-Transit" THEN
                        Include := TRUE;
                    UNTIL Include OR (ItemLedgEntry2.NEXT = 0);
                  IF NOT Include THEN
                    EXIT(FALSE);
                END;
              END;
            */
            //End SENSOFAR
            "Location Code" <> '':
              BEGIN
                Location.GET("Location Code");
                IF NOT CountryOfOrigin(Location."Country/Region Code") THEN
                  EXIT(FALSE);
              END;
            ELSE BEGIN
              IF "Entry Type" = "Entry Type"::Purchase THEN
                IF NOT CountryOfOrigin(CompanyInfo."Ship-to Country/Region Code") THEN
                  EXIT(FALSE);
              IF "Entry Type" = "Entry Type"::Sale THEN
                IF NOT CountryOfOrigin(CompanyInfo."Country/Region Code") THEN
                  EXIT(FALSE);
            END;
          END;
        EXIT(TRUE);

    end;

    local procedure InsertValueEntryLine();
    var
        Location : Record "Location";
    begin
        GetGLSetup;
        WITH IntrastatJnlLine DO BEGIN
          INIT;
          "Line No." := "Line No." + 10000;
          Date := "Value Entry"."Posting Date";
          "Country/Region Code" := "Item Ledger Entry"."Country/Region Code";
          "Transaction Type" := "Item Ledger Entry"."Transaction Type";
          "Transport Method" := "Item Ledger Entry"."Transport Method";
          "Source Entry No." := "Item Ledger Entry"."Entry No.";
          Quantity := "Item Ledger Entry".Quantity;
          "Document No." := "Value Entry"."Document No.";
          "Item No." := "Item Ledger Entry"."Item No.";
          "Entry/Exit Point" := "Item Ledger Entry"."Entry/Exit Point";
          Area := "Item Ledger Entry".Area;
          "Transaction Specification" := "Item Ledger Entry"."Transaction Specification";
          Amount := ROUND(ABS("Value Entry"."Sales Amount (Actual)"),1);

          IF Quantity < 0 THEN
            Type := Type::Shipment
          ELSE
            Type := Type::Receipt;

          IF ("Country/Region Code" = '') OR
             ("Country/Region Code" = CompanyInfo."Country/Region Code")
          THEN
            IF "Item Ledger Entry"."Location Code" = '' THEN
              "Country/Region Code" := CompanyInfo."Ship-to Country/Region Code"
            ELSE BEGIN
              Location.GET("Item Ledger Entry"."Location Code");
              "Country/Region Code" := Location."Country/Region Code"
            END;

          VALIDATE("Item No.");
          "Source Type" := "Source Type"::"Item entry";
          VALIDATE(Quantity,ROUND(ABS(Quantity),0.00001));
          VALIDATE("Cost Regulation %",IndirectCostPctReq);

          INSERT;
        END;
    end;

    local procedure IsService(ItemLedgEntry : Record "Item Ledger Entry") : Boolean;
    var
        SalesShipmentLine : Record "Sales Shipment Line";
        ReturnReceiptLine : Record "Return Receipt Line";
        SalesCrMemoLine : Record "Sales Cr.Memo Line";
        SalesInvLine : Record "Sales Invoice Line";
        PurchRcptLine : Record "Purch. Rcpt. Line";
        ReturnShipmentLine : Record "Return Shipment Line";
        PurchInvLine : Record "Purch. Inv. Line";
        PurchCrMemoLine : Record "Purch. Cr. Memo Line";
        ServiceShipmentLine : Record "Service Shipment Line";
        ServiceCrMemoLine : Record "Service Cr.Memo Line";
        ServiceInvLine : Record "Service Invoice Line";
        VATPostingSetup : Record "VAT Posting Setup";
    begin
        WITH ItemLedgEntry DO BEGIN
          CASE TRUE OF
            "Document Type" = "Document Type"::"Sales Shipment":
              IF SalesShipmentLine.GET("Document No.","Document Line No.") THEN
                IF VATPostingSetup.GET(SalesShipmentLine."VAT Bus. Posting Group",SalesShipmentLine."VAT Prod. Posting Group") THEN;
            "Document Type" = "Document Type"::"Sales Return Receipt":
              IF ReturnReceiptLine.GET("Document No.","Document Line No.") THEN
                IF VATPostingSetup.GET(ReturnReceiptLine."VAT Bus. Posting Group",ReturnReceiptLine."VAT Prod. Posting Group") THEN;
            "Document Type" = "Document Type"::"Sales Invoice":
              IF SalesInvLine.GET("Document No.","Document Line No.") THEN
                IF VATPostingSetup.GET(SalesInvLine."VAT Bus. Posting Group",SalesInvLine."VAT Prod. Posting Group") THEN;
            "Document Type" = "Document Type"::"Sales Credit Memo":
              IF SalesCrMemoLine.GET("Document No.","Document Line No.") THEN
                IF VATPostingSetup.GET(SalesCrMemoLine."VAT Bus. Posting Group",SalesCrMemoLine."VAT Prod. Posting Group") THEN;
            "Document Type" = "Document Type"::"Purchase Receipt":
              IF PurchRcptLine.GET("Document No.","Document Line No.") THEN
                IF VATPostingSetup.GET(PurchRcptLine."VAT Bus. Posting Group",PurchRcptLine."VAT Prod. Posting Group") THEN;
            "Document Type" = "Document Type"::"Purchase Return Shipment":
              IF ReturnShipmentLine.GET("Document No.","Document Line No.") THEN
                IF VATPostingSetup.GET(ReturnShipmentLine."VAT Bus. Posting Group",ReturnShipmentLine."VAT Prod. Posting Group") THEN;
            "Document Type" = "Document Type"::"Purchase Invoice":
              IF PurchInvLine.GET("Document No.","Document Line No.") THEN
                IF VATPostingSetup.GET(PurchInvLine."VAT Bus. Posting Group",PurchInvLine."VAT Prod. Posting Group") THEN;
            "Document Type" = "Document Type"::"Purchase Credit Memo":
              IF PurchCrMemoLine.GET("Document No.","Document Line No.") THEN
                IF VATPostingSetup.GET(PurchCrMemoLine."VAT Bus. Posting Group",PurchCrMemoLine."VAT Prod. Posting Group") THEN;
            "Document Type" = "Document Type"::"Service Shipment":
              IF ServiceShipmentLine.GET("Document No.","Document Line No.") THEN
                IF VATPostingSetup.GET(ServiceShipmentLine."VAT Bus. Posting Group",ServiceShipmentLine."VAT Prod. Posting Group") THEN;
            "Document Type" = "Document Type"::"Service Credit Memo":
              IF ServiceCrMemoLine.GET("Document No.","Document Line No.") THEN
                IF VATPostingSetup.GET(ServiceCrMemoLine."VAT Bus. Posting Group",ServiceCrMemoLine."VAT Prod. Posting Group") THEN;
            "Document Type" = "Document Type"::"Service Invoice":
              IF ServiceInvLine.GET("Document No.","Document Line No.") THEN
                IF VATPostingSetup.GET(ServiceInvLine."VAT Bus. Posting Group",ServiceInvLine."VAT Prod. Posting Group") THEN;
          END;
          EXIT(VATPostingSetup."EU Service");
        END;
    end;

    local procedure CalculateTotals(ItemLedgerEntry : Record "Item Ledger Entry");
    var
        VATPostingSetup : Record "VAT Posting Setup";
        TotalInvoicedQty : Decimal;
        TotalCostAmt : Decimal;
        TotalAmtExpected : Decimal;
        TotalCostAmtExpected : Decimal;
    begin
        WITH ItemLedgerEntry DO BEGIN
          TotalInvoicedQty := 0;
          TotalAmt := 0;
          TotalAmtExpected := 0;
          TotalCostAmt := 0;
          TotalCostAmtExpected := 0;

          ValueEntry.SETRANGE("Item Ledger Entry No.","Entry No.");
          IF ValueEntry.FIND('-') THEN
            REPEAT
              //IF ValueEntry."Item Charge No." = '' THEN BEGIN //Sensofar incluir coste transporte
                TotalInvoicedQty := TotalInvoicedQty + ValueEntry."Invoiced Quantity";
                IF NOT IntrastatJnlBatch."Amounts in Add. Currency" THEN BEGIN
                  TotalAmt := TotalAmt + ValueEntry."Sales Amount (Actual)";
                  TotalCostAmt := TotalCostAmt + ValueEntry."Cost Amount (Actual)";
                  TotalAmtExpected := TotalAmtExpected + ValueEntry."Sales Amount (Expected)";
                  TotalCostAmtExpected := TotalCostAmtExpected + ValueEntry."Cost Amount (Expected)";
                END ELSE BEGIN
                  TotalCostAmt := TotalCostAmt + ValueEntry."Cost Amount (Actual) (ACY)";
                  TotalCostAmtExpected := TotalCostAmtExpected + ValueEntry."Cost Amount (Expected) (ACY)";
                  IF ValueEntry."Cost per Unit" <> 0 THEN BEGIN
                    TotalAmt :=
                      TotalAmt +
                      ValueEntry."Sales Amount (Actual)" * ValueEntry."Cost per Unit (ACY)" / ValueEntry."Cost per Unit";
                    TotalAmtExpected :=
                      TotalAmtExpected +
                      ValueEntry."Sales Amount (Expected)" * ValueEntry."Cost per Unit (ACY)" / ValueEntry."Cost per Unit";
                  END ELSE BEGIN
                    TotalAmt :=
                      TotalAmt +
                      CurrExchRate.ExchangeAmtLCYToFCY(
                        ValueEntry."Posting Date",GLSetup."Additional Reporting Currency",
                        ValueEntry."Sales Amount (Actual)",AddCurrencyFactor);
                    TotalAmtExpected :=
                      TotalAmtExpected +
                      CurrExchRate.ExchangeAmtLCYToFCY(
                        ValueEntry."Posting Date",GLSetup."Additional Reporting Currency",
                        ValueEntry."Sales Amount (Expected)",AddCurrencyFactor);
                  END;
                END;
              //END; //Sensofar
            UNTIL ValueEntry.NEXT = 0;

          IF Quantity <> TotalInvoicedQty THEN BEGIN
            TotalAmt := TotalAmt + TotalAmtExpected;
            TotalCostAmt := TotalCostAmt + TotalCostAmtExpected;
          END;

          IF "Entry Type" IN ["Entry Type"::Purchase,"Entry Type"::Transfer] THEN BEGIN
            IF TotalCostAmt = 0 THEN BEGIN
              CalculateAverageCost(AverageCost,AverageCostACY);
              IF IntrastatJnlBatch."Amounts in Add. Currency" THEN
                TotalCostAmt :=
                  TotalCostAmt + Quantity * AverageCostACY
              ELSE
                TotalCostAmt :=
                  TotalCostAmt + Quantity * AverageCost;
            END;
            TotalAmt := TotalCostAmt;
          END;

          IF (TotalAmt = 0) AND ("Entry Type" = "Entry Type"::Sale) AND (NOT SkipRecalcZeroAmounts) THEN BEGIN
            IF Item."No." <> "Item No." THEN
              Item.GET("Item No.");
            IF IntrastatJnlBatch."Amounts in Add. Currency" THEN
              Item."Unit Price" :=
                CurrExchRate.ExchangeAmtLCYToFCY(
                  EndDate,GLSetup."Additional Reporting Currency",
                  Item."Unit Price",AddCurrencyFactor);
            IF Item."Price Includes VAT" THEN BEGIN
              VATPostingSetup.GET(Item."VAT Bus. Posting Gr. (Price)",Item."VAT Prod. Posting Group");
              CASE VATPostingSetup."VAT Calculation Type" OF
                VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                  VATPostingSetup."VAT+EC %" := 0;
                VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                  ERROR(
                    Text000,
                    VATPostingSetup.FIELDCAPTION("VAT Calculation Type"),
                    VATPostingSetup."VAT Calculation Type");
              END;
              TotalAmt :=
                TotalAmt + Quantity *
                (Item."Unit Price" / (1 + (VATPostingSetup."VAT+EC %" / 100)));
            END ELSE
              TotalAmt := TotalAmt + Quantity * Item."Unit Price";
          END;
        END;
    end;

    local procedure IsJobService(JobLedgEntry : Record "Job Ledger Entry") : Boolean;
    var
        Job : Record "Job";
        Customer : Record "Customer";
        VATPostingSetup : Record "VAT Posting Setup";
    begin
        IF Job.GET(JobLedgEntry."Job No.") THEN
          IF Customer.GET(Job."Bill-to Customer No.") THEN;
        IF Item.GET(JobLedgEntry."No.") THEN
          IF VATPostingSetup.GET(Customer."VAT Bus. Posting Group",Item."VAT Prod. Posting Group") THEN
            IF VATPostingSetup."EU Service" THEN
              EXIT(TRUE);
        EXIT(FALSE);
    end;

    procedure InitializeRequest(NewStartDate : Date;NewEndDate : Date;NewIndirectCostPctReq : Decimal);
    begin
        StartDate := NewStartDate;
        EndDate := NewEndDate;
        IndirectCostPctReq := NewIndirectCostPctReq;
    end;

    local procedure IsItemLedgerEntryCorrected(ItemLedgerEntryCorrection : Record "Item Ledger Entry";ItemLedgerEntryNo : Integer) : Boolean;
    var
        ItemApplicationEntry : Record "Item Application Entry";
    begin
        ItemApplicationEntry.SETRANGE("Item Ledger Entry No.",ItemLedgerEntryCorrection."Entry No.");
        CASE ItemLedgerEntryCorrection."Document Type" OF
          ItemLedgerEntryCorrection."Document Type"::"Sales Shipment",
          ItemLedgerEntryCorrection."Document Type"::"Purchase Return Shipment":
            ItemApplicationEntry.SETRANGE("Outbound Item Entry No.",ItemLedgerEntryNo);
          ItemLedgerEntryCorrection."Document Type"::"Purchase Receipt",
          ItemLedgerEntryCorrection."Document Type"::"Sales Return Receipt":
            ItemApplicationEntry.SETRANGE("Inbound Item Entry No.",ItemLedgerEntryNo);
        END;
        EXIT(NOT ItemApplicationEntry.ISEMPTY);
    end;
}

