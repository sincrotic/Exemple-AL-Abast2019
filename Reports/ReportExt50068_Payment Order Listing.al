report 50068 "Payment Order Listing Ext"
{
    // version NAVES11.00

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Payment Order Listing.rdlc';
    Caption = 'Payment Order Listing';
    Permissions = TableData "Payment Order"=r;

    dataset
    {
        dataitem(PmtOrd;"Payment Order")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(PmtOrd_No_;"No.")
            {
            }
            dataitem(CopyLoop;Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop;Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number=CONST(1));
                    column(PmtOrd__No__;PmtOrd."No.") { }
                    column(STRSUBSTNO_Text1100001_CopyText_;STRSUBSTNO(Text1100001,CopyText)) { }
                    column(STRSUBSTNO_Text1100002_FORMAT_CurrReport_PAGENO__;STRSUBSTNO(Text1100002,FORMAT(CurrReport.PAGENO))) { }
                    column(CompanyAddr_1_;CompanyAddr[1]) { }
                    column(CompanyAddr_2_;CompanyAddr[2]) { }
                    column(CompanyAddr_3_;CompanyAddr[3]) { }
                    column(CompanyAddr_4_;CompanyAddr[4]) { }
                    column(CompanyAddr_5_;CompanyAddr[5]) { }
                    column(CompanyAddr_6_;CompanyAddr[6]) { }
                    column(CompanyInfo__Phone_No__;CompanyInfo."Phone No.") { }
                    column(CompanyInfo__Fax_No__;CompanyInfo."Fax No.") { }
                    column(CompanyInfo__VAT_Registration_No__;CompanyInfo."VAT Registration No.") { }
                    column(PmtOrd__Posting_Date_;FORMAT(PmtOrd."Posting Date")) { }
                    column(BankAccAddr_4_;BankAccAddr[4]) { }
                    column(BankAccAddr_5_;BankAccAddr[5]) { }
                    column(BankAccAddr_6_;BankAccAddr[6]) { }
                    column(BankAccAddr_7_;BankAccAddr[7]) { }
                    column(BankAccAddr_3_;BankAccAddr[3]) { }
                    column(BankAccAddr_2_;BankAccAddr[2]) { }
                    column(BankAccAddr_1_;BankAccAddr[1]) { }
                    column(PmtOrd__Currency_Code_;PmtOrd."Currency Code") { }
                    column(PrintAmountsInLCY;PrintAmountsInLCY) { }
                    column(OutputNo;OutputNo) { }
                    column(PageLoop_Number;Number) { }
                    column(PmtOrd__No__Caption;PmtOrd__No__CaptionLbl) { }
                    column(CompanyInfo__Phone_No__Caption;CompanyInfo__Phone_No__CaptionLbl) { }
                    column(CompanyInfo__Fax_No__Caption;CompanyInfo__Fax_No__CaptionLbl) { }
                    column(CompanyInfo__VAT_Registration_No__Caption;CompanyInfo__VAT_Registration_No__CaptionLbl) { }
                    column(PmtOrd__Posting_Date_Caption;PmtOrd__Posting_Date_CaptionLbl) { }
                    column(PmtOrd__Currency_Code_Caption;PmtOrd__Currency_Code_CaptionLbl) { }
                    column(PageCaption;PageCaptionLbl) { }
                    dataitem("BG/PO Comment Line";"BG/PO Comment Line")
                    {
                        DataItemTableView = SORTING("BG/PO No.",Type,"Line No.") WHERE(Type=CONST(Payable));
                        DataItemLinkReference = PmtOrd;
                        DataItemLink = "BG/PO No."=FIELD("No.");
                        column(ObservacionesLbl;ObservacionesLbl) { }
                        column(Comment;Comment) { }
                        column(BG_PO_No_;"BG/PO No.") { }
                        column(Code;Code) { }
                        column(Date;Date) { }
                        column(Line_No_;"Line No.") { }
                        column(Type;Type) { }
                        trigger OnPreDataItem();
                        begin
                            IF NOT verObserv THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("Cartera Doc.";"Cartera Doc.")
                    {
                        DataItemLink = "Bill Gr./Pmt. Order No."=FIELD("No.");
                        DataItemLinkReference = PmtOrd;
                        DataItemTableView = SORTING(Type,"Collection Agent","Bill Gr./Pmt. Order No.")
                                            WHERE("Collection Agent"=CONST(Bank),
                                                  Type=CONST(Payable));
                        column(PmtOrdAmount;PmtOrdAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(PmtOrdAmount_Control23;PmtOrdAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Vend_City;Vend.City) { }
                        column(Vend_County;Vend.County) { }
                        column(Vend__Post_Code_;Vend."Post Code") { }
                        column(Vend_Name;Vend.Name) { }
                        column(Cartera_Doc___Account_No__;"Account No.") { }
                        column(Cartera_Doc___Document_No__;"Document No.") { }
                        column(Cartera_Doc___Due_Date_;FORMAT("Due Date")) { }
                        column(Cartera_Doc___Document_Type_;"Document Type") { }
                        column(Cartera_Doc____Document_Type______Cartera_Doc____Document_Type___Bill;"Document Type" <> "Document Type"::Bill) { }
                        column(Vend_Name_Control28;Vend.Name) { }
                        column(Vend_City_Control30;Vend.City) { }
                        column(PmtOrdAmount_Control31;PmtOrdAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Vend_County_Control35;Vend.County) { }
                        column(Cartera_Doc___Document_No___Control3;"Document No.") { }
                        column(Cartera_Doc___No__;"No.") { }
                        column(Vend__Post_Code__Control9;Vend."Post Code") { }
                        column(Cartera_Doc___Due_Date__Control8;FORMAT("Due Date")) { }
                        column(Cartera_Doc___Account_No___Control1;"Account No.") { }
                        column(Cartera_Doc___Document_Type__Control66;"Document Type") { }
                        column(Cartera_Doc____Document_Type_____Cartera_Doc____Document_Type___Bill;"Document Type" = "Document Type"::Bill) { }
                        column(PmtOrdAmount_Control36;PmtOrdAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(PmtOrdAmount_Control39;PmtOrdAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Cartera_Doc__Type;Type) { }
                        column(Cartera_Doc__Entry_No_;"Entry No.") { }
                        column(Cartera_Doc__Bill_Gr__Pmt__Order_No_;"Bill Gr./Pmt. Order No.") { }
                        column(All_amounts_are_in_LCYCaption;All_amounts_are_in_LCYCaptionLbl) { }
                        column(VendorNoCaption;VendorNoCaptionLbl) { }
                        column(Vend_Name_Control28Caption;Vend_Name_Control28CaptionLbl) { }
                        column(Vend__Post_Code__Control9Caption;Vend__Post_Code__Control9CaptionLbl) { }
                        column(Vend_City_Control30Caption;Vend_City_Control30CaptionLbl) { }
                        column(PmtOrdAmount_Control31Caption;PmtOrdAmount_Control31CaptionLbl) { }
                        column(Vend_County_Control35Caption;Vend_County_Control35CaptionLbl) { }
                        column(Cartera_Doc___Due_Date__Control8Caption;Cartera_Doc___Due_Date__Control8CaptionLbl) { }
                        column(Bill_No_Caption;Bill_No_CaptionLbl) { }
                        column(Document_No_Caption;Document_No_CaptionLbl) { }
                        column(Cartera_Doc___Document_Type__Control66Caption;FIELDCAPTION("Document Type")) { }
                        column(ContinuedCaption;ContinuedCaptionLbl) { }
                        column(EmptyStringCaption;EmptyStringCaptionLbl) { }
                        column(ContinuedCaption_Control15;ContinuedCaption_Control15Lbl) { }
                        column(TotalCaption;TotalCaptionLbl) { }
                        Column(CCCNo_recCustomerBA;recVendorBA."CCC No.") { }
                        column(NCCCLbl;NCCCLbl) { }

                        trigger OnAfterGetRecord();
                        begin
                            Vend.GET("Account No.");

                            IF PrintAmountsInLCY THEN
                              PmtOrdAmount := "Remaining Amt. (LCY)"
                            ELSE
                              PmtOrdAmount := "Remaining Amount";
                            
                            //-129
                            CLEAR(recVendorBA);
                            IF "Cust./Vendor Bank Acc. Code" <> '' THEN
                                recVendorBA.GET("Account No.","Cust./Vendor Bank Acc. Code");
                            //+129 
                        end;

                        trigger OnPreDataItem();
                        begin
                            CurrReport.CREATETOTALS(PmtOrdAmount);
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    IF Number > 1 THEN BEGIN
                      CopyText := Text1100000;
                      OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
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
                WITH BankAcc DO BEGIN
                  GET(PmtOrd."Bank Account No.");
                  FormatAddress.FormatAddr(
                    BankAccAddr,Name,"Name 2",'',Address,"Address 2",
                    City,"Post Code",County,"Country/Region Code");
                END;

                IF NOT CurrReport.PREVIEW THEN
                  PrintCounter.PrintCounterExt(DATABASE::"Payment Order","No.");
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
                        Caption = 'Show amounts in LCY';
                        ToolTip = 'Specifies if the reported amounts are shown in the local currency.';
                    }
                }
            }
        }
    }

    var
        Text1100000 : Label 'COPY';
        Text1100001 : Label 'Payment Order %1';
        Text1100002 : Label 'Page %1';
        CompanyInfo : Record "Company Information";
        BankAcc : Record "Bank Account";
        Vend : Record Vendor;
        FormatAddress : Codeunit "Format Address";
        PrintCounter : Codeunit "Sales Abast Library";
        BankAccAddr : array [8] of Text[50];
        CompanyAddr : array [8] of Text[50];
        NoOfLoops : Integer;
        NoOfCopies : Integer;
        CopyText : Text[30];
        City : Text[30];
        County : Text[30];
        Name : Text[50];
        PrintAmountsInLCY : Boolean;
        PmtOrdAmount : Decimal;
        OutputNo : Integer;
        PmtOrd__No__CaptionLbl : Label 'Payment Order No.';
        CompanyInfo__Phone_No__CaptionLbl : Label 'Phone No.';
        CompanyInfo__Fax_No__CaptionLbl : Label 'Fax No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl : Label 'VAT Reg. No.';
        PmtOrd__Posting_Date_CaptionLbl : Label 'Date';
        PmtOrd__Currency_Code_CaptionLbl : Label 'Currency Code';
        PageCaptionLbl : Label 'Page';
        All_amounts_are_in_LCYCaptionLbl : Label 'All amounts are in LCY';
        VendorNoCaptionLbl : Label 'Vendor No.';
        Vend_Name_Control28CaptionLbl : Label 'Name';
        Vend__Post_Code__Control9CaptionLbl : Label 'Post Code';
        Vend_City_Control30CaptionLbl : Label 'City /';
        PmtOrdAmount_Control31CaptionLbl : Label 'Remaining Amount';
        Vend_County_Control35CaptionLbl : Label 'County';
        Cartera_Doc___Due_Date__Control8CaptionLbl : Label 'Due Date';
        Bill_No_CaptionLbl : Label 'Bill No.';
        Document_No_CaptionLbl : Label 'Document No.';
        ContinuedCaptionLbl : Label 'Continued';
        EmptyStringCaptionLbl : Label '/', Blocked = true;
        ContinuedCaption_Control15Lbl : Label 'Continued';
        TotalCaptionLbl : Label 'Total';
        ObservacionesLbl : Label 'Observations: ';
        recVendorBA : Record "Vendor Bank Account";
        verObserv : Boolean;
        NCCCLbl : Label 'nº c.c.c.:';

    procedure GetCurrencyCode() : Code[10];
    begin
        IF PrintAmountsInLCY THEN
          EXIT('');

        EXIT("Cartera Doc."."Currency Code");
    end;
}

