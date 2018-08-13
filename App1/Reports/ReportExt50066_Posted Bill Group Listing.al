report 50066 "Posted Bill Group Listing Ext"
{
    // version NAVES11.00

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Posted Bill Group Listing.rdlc';
    Caption = 'Posted Bill Group Listing';

    dataset
    {
        dataitem(PostedBillGr;"Posted Bill Group")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(PostedBillGr_No_;"No.")
            {
            }
            dataitem(CopyLoop;Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop;Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number=CONST(1));
                    column(Operation;Operation) { }
                    column(PostedBillGr__No__;PostedBillGr."No.") { }
                    column(STRSUBSTNO_Text1100003_CopyText_;STRSUBSTNO(Text1100003,CopyText)) { }
                    column(STRSUBSTNO_Text1100004_FORMAT_CurrReport_PAGENO__;STRSUBSTNO(Text1100004,FORMAT(CurrReport.PAGENO))) { }
                    column(CompanyAddr_1_;CompanyAddr[1]) { }
                    column(CompanyAddr_2_;CompanyAddr[2]) { }
                    column(CompanyAddr_3_;CompanyAddr[3]) { }
                    column(CompanyAddr_4_;CompanyAddr[4]) { }
                    column(CompanyAddr_5_;CompanyAddr[5]) { }
                    column(CompanyAddr_6_;CompanyAddr[6]) { }
                    column(CompanyInfo__Phone_No__;CompanyInfo."Phone No.") { }
                    column(CompanyInfo__Fax_No__;CompanyInfo."Fax No.") { }
                    column(CompanyInfo__VAT_Registration_No__;CompanyInfo."VAT Registration No.") { }
                    column(FORMAT_PostedBillGr__Posting_Date__;FORMAT(PostedBillGr."Posting Date")) { }
                    column(BankAccAddr_4_;BankAccAddr[4]) { }
                    column(BankAccAddr_5_;BankAccAddr[5]) { }
                    column(BankAccAddr_6_;BankAccAddr[6]) { }
                    column(BankAccAddr_7_;BankAccAddr[7]) { }
                    column(BankAccAddr_3_;BankAccAddr[3]) { }
                    column(BankAccAddr_2_;BankAccAddr[2]) { }
                    column(BankAccAddr_1_;BankAccAddr[1]) { }
                    column(PostedBillGr__Currency_Code_;PostedBillGr."Currency Code") { }
                    column(FactoringType;FactoringType) { }
                    column(OutputNo;OutputNo) { }
                    column(PrintAmountsInLCY;PrintAmountsInLCY) { }
                    column(PageLoop_Number;Number) { }
                    column(PostedBillGr__No__Caption;PostedBillGr__No__CaptionLbl) { }
                    column(CompanyInfo__Phone_No__Caption;CompanyInfo__Phone_No__CaptionLbl) { }
                    column(CompanyInfo__Fax_No__Caption;CompanyInfo__Fax_No__CaptionLbl) { }
                    column(CompanyInfo__VAT_Registration_No__Caption;CompanyInfo__VAT_Registration_No__CaptionLbl) { }
                    column(PostedBillGr__Posting_Date_Caption;PostedBillGr__Posting_Date_CaptionLbl) { }
                    column(PostedBillGr__Currency_Code_Caption;PostedBillGr__Currency_Code_CaptionLbl) { }
                    column(PageCaption;PageCaptionLbl) { }
                    dataitem("BG/PO Comment Line";"BG/PO Comment Line")
                    {
                        DataItemTableView = SORTING("BG/PO No.",Type,"Line No.") WHERE(Type=CONST(Receivable));
                        DataItemLinkReference = PostedBillGr;
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
                    dataitem(PostedDoc;"Posted Cartera Doc.")
                    {
                        DataItemLink = "Bill Gr./Pmt. Order No."=FIELD("No.");
                        DataItemLinkReference = PostedBillGr;
                        DataItemTableView = SORTING("Bill Gr./Pmt. Order No.",Status,"Category Code",Redrawn,"Due Date")
                                            WHERE("Collection Agent"=CONST(Bank),
                                                  Type=CONST(Receivable));
                        column(AmtForCollection;AmtForCollection)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmtForCollection_Control32;AmtForCollection)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Customer_City;Customer.City) { }
                        column(Customer_County;Customer.County) { }
                        column(Customer__Post_Code_;Customer."Post Code") { }
                        column(Customer_Name;Customer.Name) { }
                        column(PostedDoc__Account_No__;"Account No.") { }
                        column(PostedDoc__Honored_Rejtd__at_Date_;"Honored/Rejtd. at Date") { }
                        column(PostedDoc_Status;Status) { }
                        column(PostedDoc__Document_No__;"Document No.") { }
                        column(PostedDoc__Document_Type_;"Document Type") { }
                        column(FORMAT__Due_Date__;FORMAT("Due Date")) { }
                        column(PostedDoc__Document_Type_____PostedDoc__Document_Type___Bill;"Document Type" <> "Document Type"::Bill) { }
                        column(Customer_Name_Control28;Customer.Name) { }
                        column(Customer_City_Control30;Customer.City) { }
                        column(AmtForCollection_Control31;AmtForCollection)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Customer_County_Control35;Customer.County) { }
                        column(PostedDoc__Document_No___Control3;"Document No.") { }
                        column(PostedDoc__No__;"No.") { }
                        column(Customer__Post_Code__Control9;Customer."Post Code") { }
                        column(PostedDoc_Status_Control78;Status) { }
                        column(PostedDoc__Honored_Rejtd__at_Date__Control80;"Honored/Rejtd. at Date") { }
                        column(FORMAT__Due_Date___Control8;FORMAT("Due Date")) { }
                        column(PostedDoc__Account_No___Control1;"Account No.") { }
                        column(PostedDoc__Document_Type__Control23;"Document Type") { }
                        column(PostedDoc__Document_Type____PostedDoc__Document_Type___Bill;"Document Type" = "Document Type"::Bill) { }
                        column(AmtForCollection_Control36;AmtForCollection)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmtForCollection_Control39;AmtForCollection)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(PostedDoc_Type;Type) { }
                        column(PostedDoc_Entry_No_;"Entry No.") { }
                        column(PostedDoc_Bill_Gr__Pmt__Order_No_;"Bill Gr./Pmt. Order No.") { }
                        column(All_amounts_are_in_LCYCaption;All_amounts_are_in_LCYCaptionLbl) { }
                        column(Document_No_Caption;Document_No_CaptionLbl) { }
                        column(Bill_No_Caption;Bill_No_CaptionLbl) { }
                        column(Customer_Name_Control28Caption;Customer_Name_Control28CaptionLbl) { }
                        column(Customer__Post_Code__Control9Caption;Customer__Post_Code__Control9CaptionLbl) { }
                        column(Customer_City_Control30Caption;Customer_City_Control30CaptionLbl) { }
                        column(AmtForCollection_Control31Caption;AmtForCollection_Control31CaptionLbl) { }
                        column(Customer_County_Control35Caption;Customer_County_Control35CaptionLbl) { }
                        column(PostedDoc_Status_Control78Caption;FIELDCAPTION(Status)) { }
                        column(PostedDoc__Honored_Rejtd__at_Date__Control80Caption;FIELDCAPTION("Honored/Rejtd. at Date")) { }
                        column(PostedDoc__Due_Date__Control8Caption;PostedDoc__Due_Date__Control8CaptionLbl) { }
                        column(Customer_No_Caption;Customer_No_CaptionLbl) { }
                        column(PostedDoc__Document_Type__Control23Caption;FIELDCAPTION("Document Type")) { }
                        column(ContinuedCaption;ContinuedCaptionLbl) { }
                        column(EmptyStringCaption;EmptyStringCaptionLbl) { }
                        column(ContinuedCaption_Control15;ContinuedCaption_Control15Lbl) { }
                        column(TotalCaption;TotalCaptionLbl) { }
                        column(CCCNo_recCustomerBA;recCustomerBA."CCC No.") { }
                        column(NCCCLbl;NCCCLbl) { }

                        trigger OnAfterGetRecord();
                        begin
                            Customer.GET("Account No.");
                            IF PrintAmountsInLCY THEN
                              AmtForCollection := "Amt. for Collection (LCY)"
                            ELSE
                              AmtForCollection := "Amount for Collection";
                             
                            //-129
                            CLEAR(recCustomerBA);
                            IF "Cust./Vendor Bank Acc. Code" <> '' THEN
                                recCustomerBA.GET("Account No.","Cust./Vendor Bank Acc. Code");
                            //+129 
                        end;

                        trigger OnPreDataItem();
                        begin
                            CurrReport.CREATETOTALS(AmtForCollection);
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
                  GET(PostedBillGr."Bank Account No.");
                  FormatAddress.FormatAddr(
                    BankAccAddr,Name,"Name 2",'',Address,"Address 2",
                    City,"Post Code",County,"Country/Region Code");
                END;

                IF NOT CurrReport.PREVIEW THEN
                  PrintCounter.PrintCounterExt(DATABASE::"Posted Bill Group","No.");
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
        Text1100000 : Label 'For Discount';
        Text1100001 : Label 'For Collection';
        Text1100002 : Label 'COPY';
        Text1100003 : Label 'Bill Group %1';
        Text1100004 : Label 'Page %1';
        Text1100005 : Label 'Risked Factoring';
        Text1100006 : Label 'Unrisked Factoring';
        CompanyInfo : Record "Company Information";
        BankAcc : Record "Bank Account";
        Customer : Record "Customer";
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
        AmtForCollection : Decimal;
        FactoringType : Text[30];
        OutputNo : Integer;
        PostedBillGr__No__CaptionLbl : Label 'Bill Group No.';
        CompanyInfo__Phone_No__CaptionLbl : Label 'Phone No.';
        CompanyInfo__Fax_No__CaptionLbl : Label 'Fax No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl : Label 'VAT Reg. No.';
        PostedBillGr__Posting_Date_CaptionLbl : Label 'Date';
        PostedBillGr__Currency_Code_CaptionLbl : Label 'Currency Code';
        PageCaptionLbl : Label 'Page';
        All_amounts_are_in_LCYCaptionLbl : Label 'All amounts are in LCY';
        Document_No_CaptionLbl : Label 'Document No.';
        Bill_No_CaptionLbl : Label 'Bill No.';
        Customer_Name_Control28CaptionLbl : Label 'Name';
        Customer__Post_Code__Control9CaptionLbl : Label 'Post Code';
        Customer_City_Control30CaptionLbl : Label 'City /';
        AmtForCollection_Control31CaptionLbl : Label 'Amount for Collection';
        Customer_County_Control35CaptionLbl : Label 'County';
        PostedDoc__Due_Date__Control8CaptionLbl : Label 'Due Date';
        Customer_No_CaptionLbl : Label 'Customer No.';
        ContinuedCaptionLbl : Label 'Continued';
        EmptyStringCaptionLbl : Label '/', Blocked = true;
        ContinuedCaption_Control15Lbl : Label 'Continued';
        TotalCaptionLbl : Label 'Total';
        ObservacionesLbl : Label 'Observations: ';
        recCustomerBA : Record "Customer Bank Account";
        verObserv : Boolean;
        NCCCLbl : Label 'nº c.c.c.:';

    procedure GetCurrencyCode() : Code[10];
    begin
        IF PrintAmountsInLCY THEN
          EXIT('');

        EXIT(PostedDoc."Currency Code");
    end;

    procedure GetFactoringType() : Text[30];
    begin
        IF PostedBillGr.Factoring <> PostedBillGr.Factoring::" " THEN BEGIN
          IF PostedBillGr.Factoring = PostedBillGr.Factoring::Risked THEN
            EXIT(Text1100005);

          EXIT(Text1100006);
        END;
    end;
}

