report 50027 "Proveedor - Movimientos Divisa"
{
    // version NAVW111.00.00.21836,NAVES11.00.00.21836

    DefaultLayout = RDLC;
    RDLCLayout = './REPORTS/LAYOUTS/Vendor - Detail Trial Balance.rdlc';
    Caption = 'Vendor - Detail Trial Balance';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.","Search Name","Vendor Posting Group","Date Filter";
            column(DateFilter;STRSUBSTNO(Text000,VendDateFilter))
            {
            }
            column(CompanyName;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(TableFilter;Vendor.TABLECAPTION + ': ' + VendFilter)
            {
            }
            column(VendFilter;VendFilter)
            {
            }
            column(PageGroupNo;PageGroupNo)
            {
            }
            column(PrintAmountsInLCY;PrintAmountsInLCY)
            {
            }
            column(ExcludeBalanceOnly;ExcludeBalanceOnly)
            {
            }
            column(PrintOnlyOnePerPage;PrintOnlyOnePerPage)
            {
            }
            column(RemainingAmtCaption;RemainingAmtCaption)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(No_Vend;"No.")
            {
            }
            column(Name_Vend;Name)
            {
            }
            column(PhoneNo_Vend;"Phone No.")
            {
                IncludeCaption = true;
            }
            column(StartBalanceLCY;StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartVendDebitAmtAdj;StartVendDebitAmountAdj)
            {
                AutoFormatType = 1;
            }
            column(StartVendCreditAmtAdj;StartVendCreditAmountAdj)
            {
                AutoFormatType = 1;
            }
            column(VendBalanceLCY;VendBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(BalLBalAdjLVendLedgEntryAmtLCY;StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(VendDebitAmtDebitCorrDebit;StartVendDebitAmount + DebitCorrection + DebitApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCYStartBalAdjLCY;StartBalanceLCY + StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(VendCreditAmtCreditCredit;StartVendCreditAmount + CreditCorrection + CreditApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartVendDebitAmtTotal;StartVendDebitAmountTotal)
            {
            }
            column(StartVendCreditAmtTotal;StartVendCreditAmountTotal)
            {
            }
            column(CreditAppRound; CreditApplicationRounding)
            {
            }
            column(DebitAppRound;DebitApplicationRounding)
            {
            }
            column(CreditCorrect; CreditCorrection)
            {
            }
            column(DebitCorrect;DebitCorrection)
            {
            }
            column(DateFilter1_Vend;"Date Filter")
            {
            }
            column(GlobalDim2Filter_Vend;"Global Dimension 2 Filter")
            {
            }
            column(VendorDetailTrialBalCaption;VendorDetailTrialBalCaptionLbl)
            {
            }
            column(PageNoCaption;PageNoCaptionLbl)
            {
            }
            column(AllamountsareinLCYCaption;AllamountsareinLCYCaptionLbl)
            {
            }
            column(vendorsbalancesCaption;vendorsbalancesCaptionLbl)
            {
            }
            column(PostingDateCaption;PostingDateCaptionLbl)
            {
            }
            column(DocumentTypeCaption;DocumentTypeCaptionLbl)
            {
            }
            column(BalanceLCYCaption;BalanceLCYCaptionLbl)
            {
            }
            column(DueDateCaption;DueDateCaptionLbl)
            {
            }
            column(CreditCaption;CreditCaptionLbl)
            {
            }
            column(DebitCaption;DebitCaptionLbl)
            {
            }
            column(AdjofOpeningBalanceCaption;AdjofOpeningBalanceCaptionLbl)
            {
            }
            column(TotalLCYCaption;TotalLCYCaptionLbl)
            {
            }
            column(TotalAdjofOpeningBalCaption;TotalAdjofOpeningBalCaptionLbl)
            {
            }
            column(TotalLCYBeforePeriodCaption;TotalLCYBeforePeriodCaptionLbl)
            {
            }
            dataitem("Vendor Ledger Entry";"Vendor Ledger Entry") 
            {
                DataItemLink = "Vendor No."=FIELD("No."),
                               "Posting Date"=FIELD("Date Filter"),
                               "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                               "Date Filter"=FIELD("Date Filter");
                DataItemTableView = SORTING("Vendor No.","Posting Date");
                column(StartBalLCYAmtLCY;StartBalanceLCY + "Amount (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(PostingDate_VendLedgEntry;FORMAT("Posting Date"))
                {
                }
                column(DocType_VendLedgEntry;"Document Type")
                {
                }
                column(DocNo_VendLedgEntry;"Document No.")
                {
                    IncludeCaption = true;
                }
                column(ExtDocNo_VendLedgEntry;"External Document No.")
                {
                    IncludeCaption = true;
                }
                column(VendLedgEntryDescp;Description)
                {
                    IncludeCaption = true;
                }
                column(VendCreditAmt;VendCreditAmount)
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VendDebitAmt;VendDebitAmount)
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VendBalLCY;VendBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(VendRemainAmt;VendRemainAmount)
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VendEntryDueDate;FORMAT(VendEntryDueDate))
                {
                }
                column(EntryNo_VendLedgEntry;"Entry No.")
                {
                    IncludeCaption = true;
                }
                column(VendCurrencyCode;VendCurrencyCode)
                {
                }
                column(VendorNo_VendLedgEntry;"Vendor No.")
                {
                }
                column(GlbalDim1Code_VendLedgEntry;"Global Dimension 1 Code")
                {
                }
                column(DateFilter_VendLedgEntry;"Date Filter")
                {
                }
                column(Applies_to_Doc__No_;"Applies-to Doc. No.")
                {                    
                }
                dataitem("Detailed Vendor Ledg. Entry";"Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No."=FIELD("Entry No.");                    
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date")                    
                                        WHERE("Entry Type"=CONST("Correction of Remaining Amount"));

                    column(DocNo1_VendLedgEntry;"Vendor Ledger Entry"."Document No.")
                    {
                    }
                    column(EntryType_DtdVendLedgEntry;"Entry Type")
                    {
                    }
                    column(DebitCorrection;DebitCorrection)
                    {
                        AutoFormatType = 1;
                    }
                    column(CreditCorrection;CreditCorrection)
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord();
                    begin                        
                        IF PrintAmountsInLCY THEN BEGIN
                            Correction := Correction + "Amount (LCY)";
                            VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                        END ELSE BEGIN
                            Correction := Correction + Amount;
                            VendBalanceLCY := VendBalanceLCY + Amount;
                        END;
                    end;

                    trigger OnPostDataItem();
                    begin
                        SumCorrections := SumCorrections + Correction;
                    end;

                    trigger OnPreDataItem();
                    begin
                        SETFILTER("Posting Date",VendDateFilter);
                        Correction := 0;                        
                        IF currencyCode <> '' THEN
                          SETRANGE("Currency Code",currencyCode);
                    end;
                }
                dataitem("Detailed Vendor Ledg. Entry2";"Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Vendor Ledger Entry No.","Entry Type","Posting Date")
                                        WHERE("Entry Type" = CONST("Appln. Rounding"));
                    column(EntryType_DtdVendLedgEntry2;"Entry Type")
                    {
                    }
                    column(VendBalanceLCY1;VendBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(DebitAppRounding;DebitApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }
                    column(CreditApplicationRounding;CreditApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }
                    column(DocType_VendLedgEntry2;"Vendor Ledger Entry"."Document Type")
                    {
                    }
                    column(VendLEtrNo_DtdVendLedgEntry2;"Vendor Ledger Entry No.")
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        IF PrintAmountsInLCY THEN BEGIN
                            ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                            VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                        END ELSE BEGIN
                            ApplicationRounding := ApplicationRounding + Amount;
                            VendBalanceLCY := VendBalanceLCY + Amount;
                        END;
                    end;

                    trigger OnPreDataItem();
                    begin
                        SETFILTER("Posting Date",VendDateFilter);                        
                        IF currencyCode <> '' THEN
                            SETRANGE("Currency Code",currencyCode);
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CALCFIELDS(Amount,"Remaining Amount","Credit Amount (LCY)","Debit Amount (LCY)","Amount (LCY)","Remaining Amt. (LCY)",
                      "Credit Amount","Debit Amount");

                    VendLedgEntryExists := TRUE;
                    IF PrintAmountsInLCY THEN BEGIN
                      VendCreditAmount := "Credit Amount (LCY)";
                      VendDebitAmount := "Debit Amount (LCY)";
                      VendRemainAmount := "Remaining Amt. (LCY)";
                      VendCurrencyCode := '';  
                      VendBalanceLCY   := VendBalanceLCY + "Amount (LCY)";
                      StartVendCreditAmount := StartVendCreditAmount + "Credit Amount (LCY)";
                      StartVendDebitAmount  := StartVendDebitAmount + "Debit Amount (LCY)";
                      StartVendCreditAmountTotal := StartVendCreditAmountTotal + "Credit Amount (LCY)";
                      StartVendDebitAmountTotal := StartVendDebitAmountTotal + "Debit Amount (LCY)";
                    END ELSE BEGIN
                      VendCreditAmount := "Credit Amount";
                      VendDebitAmount := "Debit Amount";
                      VendRemainAmount := "Remaining Amount";
                      VendCurrencyCode := "Currency Code";  
                      VendBalanceLCY   := VendBalanceLCY + Amount;
                      StartVendCreditAmount := StartVendCreditAmount + "Credit Amount";
                      StartVendDebitAmount  := StartVendDebitAmount + "Debit Amount";
                      StartVendCreditAmountTotal := StartVendCreditAmountTotal + "Credit Amount";
                      StartVendDebitAmountTotal := StartVendDebitAmountTotal + "Debit Amount";
                    END;                    
                    IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                      VendEntryDueDate := 0D
                    ELSE
                      VendEntryDueDate := "Due Date";
                end;

                trigger OnPreDataItem();
                begin
                    
                    VendLedgEntryExists := FALSE;                    
                    CurrReport.CREATETOTALS(VendAmount,VendDebitAmount,VendCreditAmount,"Amount (LCY)");
                    
                    IF currencyCode <> '' THEN
                        SETRANGE("Currency Code",currencyCode);

                    StartVendDebitAmount := 0;
                    StartVendCreditAmount := 0;
                end;
            }
            dataitem(integer;integer)
            {
                DataItemTableView=SORTING(Number) WHERE(Number=CONST(1));
                column(VendorName;Vendor.Name)
                {
                }
                column(VendBalanceLCY2;VendBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(StartBalAdjLCY;StartBalAdjLCY)
                {
                }
                column(StartBalanceLCY1;StartBalanceLCY)
                {
                }
                column(VendBalLCYDebitAmtDebitAmtAdj;StartVendDebitAmount)
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VendBalLCYCreditAmtCreditAmtAdj;StartVendCreditAmount)
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord();
                begin
                    IF NOT VendLedgEntryExists AND ((StartBalanceLCY = 0) OR ExcludeBalanceOnly) THEN BEGIN
                      StartBalanceLCY := 0;
                      CurrReport.SKIP;
                    END;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                IF PrintOnlyOnePerPage THEN
                  PageGroupNo := PageGroupNo + 1;

                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                IF VendDateFilter <> '' THEN BEGIN
                  IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN                      
                    SETRANGE("Date Filter",0D,GETRANGEMIN("Date Filter") - 1);
                    IF currencyCode <> '' THEN 
                       SETRANGE("Currency Filter",currencyCode);
                       IF PrintAmountsInLCY THEN BEGIN                    
                         CALCFIELDS("Net Change (LCY)");
                         StartBalanceLCY := -"Net Change (LCY)";
                         StartVendDebitAmount := "Vendor Ledger Entry"."Debit Amount (LCY)";
                         StartVendCreditAmount := "Vendor Ledger Entry"."Credit Amount (LCY)";
                       END;
                       SETFILTER("Date Filter",VendDateFilter);
                       IF currencyCode <> '' THEN 
                         SETRANGE("Currency Filter",currencyCode);                          
                       IF PrintAmountsInLCY THEN BEGIN
                         CALCFIELDS("Net Change (LCY)");
                         StartBalAdjLCY := -"Net Change (LCY)";
                       END ELSE BEGIN
                         CALCFIELDS("Net Change");
                         StartBalAdjLCY := -"Net Change";
                       END;  
                       VendorLedgerEntry.SETCURRENTKEY("Vendor No.","Posting Date");
                       VendorLedgerEntry.SETRANGE("Vendor No.",Vendor."No.");
                       VendorLedgerEntry.SETFILTER("Posting Date", VendDateFilter);
                       IF currencyCode <> '' THEN
                         VendorLedgerEntry.SETRANGE("Currency Code",currencyCode);
                       IF VendorLedgerEntry.FIND('-') THEN
                         REPEAT
                            VendorLedgerEntry.SETFILTER("Date Filter",VendDateFilter);
                            VendorLedgerEntry.CALCFIELDS("Amount (LCY)");
                            IF PrintAmountsInLCY THEN
                                StartBalAdjLCY := StartBalAdjLCY - VendorLedgerEntry."Amount (LCY)"
                            ELSE
                                StartBalAdjLCY := StartBalAdjLCY - VendorLedgerEntry.Amount;                      
                            "Detailed Vendor Ledg. Entry".SETCURRENTKEY("Vendor Ledger Entry No.","Entry Type","Posting Date");
                            "Detailed Vendor Ledg. Entry".SETRANGE("Vendor Ledger Entry No.",VendorLedgerEntry."Entry No.");
                            "Detailed Vendor Ledg. Entry".SETFILTER("Entry Type",'%1|%2',
                            "Detailed Vendor Ledg. Entry"."Entry Type"::"Correction of Remaining Amount",
                            "Detailed Vendor Ledg. Entry"."Entry Type"::"Appln. Rounding");
                            "Detailed Vendor Ledg. Entry".SETFILTER("Posting Date",VendDateFilter);                            
                            IF currencyCode <> '' THEN
                                "Detailed Vendor Ledg. Entry".SETRANGE("Currency Code",currencyCode);
                            IF "Detailed Vendor Ledg. Entry".FIND('-') THEN
                                REPEAT
                                    StartBalAdjLCY := StartBalAdjLCY - "Detailed Vendor Ledg. Entry"."Amount (LCY)";                                    
                                    IF PrintAmountsInLCY THEN
                                      StartBalAdjLCY := StartBalAdjLCY - "Detailed Vendor Ledg. Entry"."Amount (LCY)"
                                    ELSE
                                      StartBalAdjLCY := StartBalAdjLCY - "Detailed Vendor Ledg. Entry".Amount;
                                UNTIL "Detailed Vendor Ledg. Entry".NEXT = 0;
                                "Detailed Vendor Ledg. Entry".RESET;
                         UNTIL VendorLedgerEntry.NEXT = 0;
                       END;
                    end;                                    
                    // CurrReport.PRINTONLYIFDETAIL :=  ExcludeBalanceOnly OR (StartBalanceLCY = 0);
                    VendBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                    IF StartBalAdjLCY > 0 THEN BEGIN
                        StartVendDebitAmountAdj := StartBalAdjLCY;
                        StartVendCreditAmountAdj := 0;
                    END ELSE BEGIN
                        StartVendDebitAmountAdj := 0;
                        StartVendCreditAmountAdj := StartBalAdjLCY;
                    END;
                end;            
                trigger OnPreDataItem();
                begin
                    PageGroupNo := 1;
                    SumCorrections := 0;
                    CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                    CurrReport.CREATETOTALS("Vendor Ledger Entry"."Amount (LCY)",StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding,
                                            "Vendor Ledger Entry"."Debit Amount (LCY)", "Vendor Ledger Entry"."Credit Amount (LCY)",
                                            StartBalanceLCY,StartVendDebitAmount,StartVendCreditAmount);
                    CurrReport.CREATETOTALS("Vendor Ledger Entry".Amount,
                                            "Vendor Ledger Entry"."Debit Amount",
                                            "Vendor Ledger Entry"."Credit Amount");                                  
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
                    Caption ='Opciones';
                    field(ShowAmountsInLCY;PrintAmountsInLCY)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Muestra importes en DL';
                        ToolTip = 'Especifica si los importes notificados se muestran en la divisa local.';
                        trigger OnValidate();
                        begin
                            IF PrintAmountsInLCY THEN BEGIN
                                currencyCode := '';
                                CurrencyCodeEnableBool := FALSE;
                            END ELSE begin
                                CurrencyCodeEnableBool := TRUE;
                            END;
                        end;
                    }                    
                    field(PrintOnlyOnePerPage;PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Página nueva por proveedor';
                        ToolTip = 'Especifica si la información de cada proveedor se imprime en una nueva página en caso que haya elegido incluir dos o más proveedores en el informe.';
                    }
                    field(ExcludeBalanceOnly;ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Excluye sólo proveedores con saldo a fecha';
                        MultiLine = true;
                        ToolTip = 'Especifica si no desea incluir en el informe los movimientos de proveedores que tienen saldo, pero no tienen un saldo de período durante el período seleccionado.';
                    }
                    field(CodDivisa;currencyCode)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Cod.Divisa';                        
                        MultiLine = false;
                        TableRelation = currency;
                        Enabled = CurrencyCodeEnableBool;
                    }
                }            
            }            
        }

        trigger OnOpenPage();
        begin
            IF PrintAmountsInLCY THEN BEGIN
                currencyCode := '';
                CurrencyCodeEnableBool := FALSE;
            END ELSE begin
                CurrencyCodeEnableBool := TRUE;
            END;
        end;
    }

    trigger OnPreReport();
    var
        CaptionManagement : Codeunit "CaptionManagement";
    begin
        VendFilter := CaptionManagement.GetRecordFiltersWithCaptions(Vendor);
        VendDateFilter := Vendor.GETFILTER("Date Filter");
        WITH "Vendor Ledger Entry" DO
          IF PrintAmountsInLCY THEN BEGIN
            AmountCaption := FIELDCAPTION("Amount (LCY)");
            RemainingAmtCaption := FIELDCAPTION("Remaining Amt. (LCY)");
          END ELSE BEGIN
            AmountCaption := FIELDCAPTION(Amount);
            RemainingAmtCaption := FIELDCAPTION("Remaining Amount");
          END;          
    end;    
    var
        Text000 : Label 'Period: %1';
        VendorLedgerEntry : Record "Vendor Ledger Entry";
        VendFilter : Text[250];
        VendDateFilter : Text[250];
        VendAmount : Decimal;
        VendRemainAmount : Decimal;
        VendBalanceLCY : Decimal;
        VendEntryDueDate : Date;
        StartBalanceLCY : Decimal;
        StartBalAdjLCY : Decimal;
        Correction : Decimal;
        ApplicationRounding : Decimal;
        ExcludeBalanceOnly : Boolean;
        PrintAmountsInLCY : Boolean;
        PrintOnlyOnePerPage : Boolean;
        VendLedgEntryExists : Boolean;
        AmountCaption : Text[30];
        RemainingAmtCaption : Text[30];
        VendCurrencyCode : Code[10];
        PageGroupNo : Integer;
        SumCorrections : Decimal;
        VendDebitAmount : Decimal;
        VendCreditAmount : Decimal;
        StartVendCreditAmount : Decimal;
        StartVendDebitAmount : Decimal;
        StartVendDebitAmountAdj : Decimal;
        StartVendCreditAmountAdj : Decimal;
        DebitCorrection : Decimal;
        CreditCorrection : Decimal;
        DebitApplicationRounding : Decimal;
        CreditApplicationRounding : Decimal;
        StartVendDebitAmountTotal : Decimal;
        StartVendCreditAmountTotal : Decimal;
        StartBalAdjLCYTotal : Decimal;
        VendorDetailTrialBalCaptionLbl : Label 'Vendor - Detail Trial Balance';
        PageNoCaptionLbl : Label 'Page';
        AllamountsareinLCYCaptionLbl : Label 'All amounts are in LCY.';
        vendorsbalancesCaptionLbl : Label 'This report also includes vendors that only have balances.';
        PostingDateCaptionLbl : Label 'Posting Date';
        DocumentTypeCaptionLbl : Label 'Document Type';
        BalanceLCYCaptionLbl : Label 'Balance (LCY)';
        DueDateCaptionLbl : Label 'Due Date';
        CreditCaptionLbl : Label 'Credit';
        DebitCaptionLbl : Label 'Debit';
        AdjofOpeningBalanceCaptionLbl : Label 'Adj. of Opening Balance';
        TotalLCYCaptionLbl : Label 'Total (LCY)';
        TotalAdjofOpeningBalCaptionLbl : Label 'Total Adj. of Opening Balance';
        TotalLCYBeforePeriodCaptionLbl : Label 'Total (LCY) Before Period';             
        currencyCode : Code[10];
        formula : Decimal;
        CurrencyCodeEnableBool : Boolean;

    procedure InitializeRequest(NewPrintAmountsInLCY : Boolean;NewPrintOnlyOnePerPage : Boolean;NewExcludeBalanceOnly : Boolean);
    begin
        PrintAmountsInLCY := NewPrintAmountsInLCY;
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;                
    end;
}

