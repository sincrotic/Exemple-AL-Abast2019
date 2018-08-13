report 50061 "Bill Group Listing Ext"
{
    // version NAVES11.00

    DefaultLayout = RDLC;
    RDLCLayout = '.\Reports\Layouts\Bill Group Listing.rdlc';
    Caption = 'Bill Group Listing';

    dataset
    {
        dataitem(BillGr;"Bill Group")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(BillGr_No_;"No.")
            {
            }
            dataitem(CopyLoop;Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop;Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number=CONST(1));
                    column(BillGr__No__;BillGr."No.")
                    {
                    }
                    column(STRSUBSTNO_Text1100003_CopyText_;STRSUBSTNO(Text1100003,CopyText))
                    {
                    }
                    column(STRSUBSTNO_Text1100004_FORMAT_CurrReport_PAGENO__;STRSUBSTNO(Text1100004,FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(CompanyAddr_1_;CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr_2_;CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_3_;CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_4_;CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr_5_;CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr_6_;CompanyAddr[6])
                    {
                    }
                    column(CompanyInfo__Phone_No__;CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo__Fax_No__;CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__;CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(BillGr__Posting_Date_;FORMAT(BillGr."Posting Date"))
                    {
                    }
                    column(BankAccAddr_4_;BankAccAddr[4])
                    {
                    }
                    column(BankAccAddr_5_;BankAccAddr[5])
                    {
                    }
                    column(BankAccAddr_6_;BankAccAddr[6])
                    {
                    }
                    column(BankAccAddr_7_;BankAccAddr[7])
                    {
                    }
                    column(BankAccAddr_3_;BankAccAddr[3])
                    {
                    }
                    column(BankAccAddr_2_;BankAccAddr[2])
                    {
                    }
                    column(BankAccAddr_1_;BankAccAddr[1])
                    {
                    }
                    column(BillGr__Currency_Code_;BillGr."Currency Code")
                    {
                    }
                    column(Operation;Operation)
                    {
                    }
                    column(FactoringType;FactoringType)
                    {
                    }
                    column(OutputNo;OutputNo)
                    {
                    }
                    column(PrintAmountsInLCY;PrintAmountsInLCY)
                    {
                    }
                    column(verObserv;verObserv)
                    {
                    }
                    column(PageLoop_Number;Number)
                    {
                    }
                    column(BillGr__No__Caption;BillGr__No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Phone_No__Caption;CompanyInfo__Phone_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption;CompanyInfo__Fax_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__Caption;CompanyInfo__VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(BillGr__Posting_Date_Caption;BillGr__Posting_Date_CaptionLbl)
                    {
                    }
                    column(BillGr__Currency_Code_Caption;BillGr__Currency_Code_CaptionLbl)
                    {
                    }
                    column(PageCaption;PageCaptionLbl)
                    {
                    }
                    dataitem("BG/PO Comment Line";"BG/PO Comment Line")
                    {
                        DataItemLink = "BG/PO No."=FIELD("No.");
                        DataItemLinkReference = BillGr;
                        DataItemTableView = SORTING("BG/PO No.",Type,"Line No.") 
                                            WHERE(Type=CONST(Receivable));
                        column(ComemntLine_Observaciones_Caption;ComemntLine_ObservacionesLbl)
                        {
                        }
                        column(Comment;Comment)
                        {

                        }
                    }
                    dataitem("Cartera Doc.";"Cartera Doc.")
                    {
                        DataItemLink = "Bill Gr./Pmt. Order No."=FIELD("No.");
                        DataItemLinkReference = BillGr;
                        DataItemTableView = SORTING(Type,"Collection Agent","Bill Gr./Pmt. Order No.")
                                            WHERE("Collection Agent"=CONST(Bank),
                                                  Type=CONST(Receivable));
                        column(BillGrAmount;BillGrAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(BillGrAmount_Control23;BillGrAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(CustBA_CCC_No;recCustomerBA."CCC No.")
                        {
                        }
                        column(CustBA_CCC_No_Caption;CustBA_CCC_No_CaptionLbl)
                        {
                        }
                        column(Cust_City;Cust.City)
                        {
                        }
                        column(Cust_County;Cust.County)
                        {
                        }
                        column(Cust__Post_Code_;Cust."Post Code")
                        {
                        }
                        column(Cust_Name;Cust.Name)
                        {
                        }
                        column(Cartera_Doc___Account_No__;"Account No.")
                        {
                        }
                        column(Cartera_Doc___Document_No__;"Document No.")
                        {
                        }
                        column(Cartera_Doc___Due_Date_;FORMAT("Due Date"))
                        {
                        }
                        column(Cartera_Doc___Document_Type_;"Document Type")
                        {
                        }
                        column(Cartera_Doc____Document_Type______Cartera_Doc____Document_Type___Bill;"Document Type" <> "Document Type"::Bill)
                        {
                        }
                        column(Cust_Name_Control28;Cust.Name)
                        {
                        }
                        column(Cust_City_Control30;Cust.City)
                        {
                        }
                        column(BillGrAmount_Control31;BillGrAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Cust_County_Control35;Cust.County)
                        {
                        }
                        column(Cartera_Doc___Document_No___Control3;"Document No.")
                        {
                        }
                        column(Cartera_Doc___No__;"No.")
                        {
                        }
                        column(Cust__Post_Code__Control9;Cust."Post Code")
                        {
                        }
                        column(Cartera_Doc___Due_Date__Control8;FORMAT("Due Date"))
                        {
                        }
                        column(Cartera_Doc___Account_No___Control1;"Account No.")
                        {
                        }
                        column(Cartera_Doc___Document_Type__Control66;"Document Type")
                        {
                        }
                        column(Cartera_Doc____Document_Type_____Cartera_Doc____Document_Type___Bill;"Document Type" = "Document Type"::Bill)
                        {
                        }
                        column(BillGrAmount_Control36;BillGrAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(BillGrAmount_Control39;BillGrAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Cartera_Doc__Type;Type)
                        {
                        }
                        column(Cartera_Doc__Entry_No_;"Entry No.")
                        {
                        }
                        column(Cartera_Doc__Bill_Gr__Pmt__Order_No_;"Bill Gr./Pmt. Order No.")
                        {
                        }
                        column(All_amounts_are_in_LCYCaption;All_amounts_are_in_LCYCaptionLbl)
                        {
                        }
                        column(Cartera_Doc___Account_No___Control1Caption;Cartera_Doc___Account_No___Control1CaptionLbl)
                        {
                        }
                        column(Cust_Name_Control28Caption;Cust_Name_Control28CaptionLbl)
                        {
                        }
                        column(Cust__Post_Code__Control9Caption;Cust__Post_Code__Control9CaptionLbl)
                        {
                        }
                        column(Cust_City_Control30Caption;Cust_City_Control30CaptionLbl)
                        {
                        }
                        column(BillGrAmount_Control31Caption;BillGrAmount_Control31CaptionLbl)
                        {
                        }
                        column(Cust_County_Control35Caption;Cust_County_Control35CaptionLbl)
                        {
                        }
                        column(Cartera_Doc___Due_Date__Control8Caption;Cartera_Doc___Due_Date__Control8CaptionLbl)
                        {
                        }
                        column(Bill_No_Caption;Bill_No_CaptionLbl)
                        {
                        }
                        column(Document_No_Caption;Document_No_CaptionLbl)
                        {
                        }
                        column(Cartera_Doc___Document_Type__Control66Caption;FIELDCAPTION("Document Type"))
                        {
                        }
                        column(ContinuedCaption;ContinuedCaptionLbl)
                        {
                        }
                        column(EmptyStringCaption;EmptyStringCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control15;ContinuedCaption_Control15Lbl)
                        {
                        }
                        column(TotalCaption;TotalCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            Cust.GET("Account No.");

                            IF PrintAmountsInLCY THEN
                              BillGrAmount := "Remaining Amt. (LCY)"
                            ELSE
                              BillGrAmount := "Remaining Amount";
                        end;

                        trigger OnPreDataItem();
                        begin
                            CurrReport.CREATETOTALS(BillGrAmount);
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    IF Number > 1 THEN
                      CopyText := Text1100002;
                    CurrReport.PAGENO := 1;

                    OutputNo := OutputNo + 1;
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number,1,NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                IF "Dealing Type" = "Dealing Type"::Discount THEN
                  Operation := Text1100000
                ELSE
                  Operation := Text1100001;
                FactoringType := GetFactoringType;

                WITH BankAcc DO BEGIN
                    GET(BillGr."Bank Account No.");
                    FormatAddress.FormatAddr(
                        BankAccAddr,Name,"Name 2",'',Address,"Address 2",
                        City,"Post Code",County,"Country/Region Code");
                END;

                IF NOT CurrReport.PREVIEW THEN
                  PrintCounter.PrintCounter(DATABASE::"Bill Group","No.");
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET;
                FormatAddress.Company(CompanyAddr,CompanyInfo);
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
                    field(NoOfCopies;NoOfCopies)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(PrintAmountsInLCY;PrintAmountsInLCY)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Amounts in LCY';
                        ToolTip = 'Specifies if the reported amounts are shown in the local currency.';
                    }
                    field(verObserv;verObserv)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Comments';
                        ToolTip = 'Specifies whether comments are displayed.';
                    }
                }
            }
        }
    }

    var
        Text1100000 : Label 'For Discount';
        Text1100001 : Label 'For Collection';
        Text1100002 : Label 'COPY';
        Text1100003 : Label 'Bill Group %1';
        Text1100004 : Label 'Page %1';
        Text1100005 : Label 'Risked Factoring';
        Text1100006 : Label 'Unrisked Factoring';
        CompanyInfo : Record "Company Information";
        BankAcc : Record "Bank Account";
        Cust : Record "Customer";
        FormatAddress : Codeunit "Format Address";
        PrintCounter : Codeunit "Sales Abast Library";
        BankAccAddr : array [8] of Text[50];
        CompanyAddr : array [8] of Text[50];
        Operation : Text[80];
        NoOfLoops : Integer;
        NoOfCopies : Integer;
        CopyText : Text[30];
        City : Text[30];
        County : Text[30];
        Name : Text[50];
        PrintAmountsInLCY : Boolean;
        verObserv :Boolean;
        BillGrAmount : Decimal;
        FactoringType : Text[30];
        OutputNo : Integer;
        recCustomerBA : Record "Customer Bank Account";
        CustBA_CCC_No_CaptionLbl : Label 'No. c.c.c:';
        BillGr__No__CaptionLbl : Label 'Bill Group No.';
        CompanyInfo__Phone_No__CaptionLbl : Label 'Phone No.';
        CompanyInfo__Fax_No__CaptionLbl : Label 'Fax No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl : Label 'VAT Reg. No.';
        BillGr__Posting_Date_CaptionLbl : Label 'Date';
        BillGr__Currency_Code_CaptionLbl : Label 'Currency Code';
        PageCaptionLbl : Label 'Page';
        All_amounts_are_in_LCYCaptionLbl : Label 'All amounts are in LCY';
        Cartera_Doc___Account_No___Control1CaptionLbl : Label 'Customer No.';
        Cust_Name_Control28CaptionLbl : Label 'Name';
        Cust__Post_Code__Control9CaptionLbl : Label 'Post Code';
        Cust_City_Control30CaptionLbl : Label 'City /';
        BillGrAmount_Control31CaptionLbl : Label 'Remaining Amount';
        Cust_County_Control35CaptionLbl : Label 'County';
        Cartera_Doc___Due_Date__Control8CaptionLbl : Label 'Due Date';
        Bill_No_CaptionLbl : Label 'Bill No.';
        Document_No_CaptionLbl : Label 'Document No.';
        ContinuedCaptionLbl : Label 'Continued';
        EmptyStringCaptionLbl : Label '/';
        ContinuedCaption_Control15Lbl : Label 'Continued';
        TotalCaptionLbl : Label 'Total';
        ComemntLine_ObservacionesLbl: Label 'Observations:';
        NoGlobal : Code[20];

    procedure GetCurrencyCode() : Code[10];
    begin
        IF PrintAmountsInLCY THEN
          EXIT('');

        EXIT("Cartera Doc."."Currency Code");
    end;

    procedure GetFactoringType() : Text[30];
    begin
        IF BillGr.Factoring <> BillGr.Factoring::" " THEN BEGIN
          IF BillGr.Factoring = BillGr.Factoring::Risked THEN
            EXIT(Text1100005);

          EXIT(Text1100006);
        END;
    end;

    procedure SetRec(No : Code[20])
    begin
        NoGlobal := No;
    end;
}

