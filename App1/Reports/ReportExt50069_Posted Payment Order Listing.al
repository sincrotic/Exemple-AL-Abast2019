report 50069 "Posted Payment Order ListingEx"
{
    // version NAVES11.00

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Posted Payment Order Listing.rdlc';
    Caption = 'Posted Payment Order Listing';
    
    Permissions = TableData "Posted Payment Order"=r;

    dataset
    {
        dataitem(PostedPmtOrd;"Posted Payment Order")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(PostedPmtOrd_No_;"No.") { }
            dataitem(CopyLoop;Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop;Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number=CONST(1));
                    column(PostedPmtOrd__No__;PostedPmtOrd."No.") { }
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
                    column(PostedPmtOrd__Posting_Date_;FORMAT(PostedPmtOrd."Posting Date")) { }
                    column(BankAccAddr_4_;BankAccAddr[4]) { }
                    column(BankAccAddr_5_;BankAccAddr[5]) { }
                    column(BankAccAddr_6_;BankAccAddr[6]) { }
                    column(BankAccAddr_7_;BankAccAddr[7]) { }
                    column(BankAccAddr_3_;BankAccAddr[3]) { }
                    column(BankAccAddr_2_;BankAccAddr[2]) { }
                    column(BankAccAddr_1_;BankAccAddr[1]) { }
                    column(PostedPmtOrd__Currency_Code_;PostedPmtOrd."Currency Code") { }
                    column(PrintAmountsInLCY;PrintAmountsInLCY) { }
                    column(OutputNo;OutputNo) { }
                    column(PageLoop_Number;Number) { }
                    column(PostedPmtOrd__No__Caption;PostedPmtOrd__No__CaptionLbl) { }
                    column(CompanyInfo__Phone_No__Caption;CompanyInfo__Phone_No__CaptionLbl) { }
                    column(CompanyInfo__Fax_No__Caption;CompanyInfo__Fax_No__CaptionLbl) { }
                    column(CompanyInfo__VAT_Registration_No__Caption;CompanyInfo__VAT_Registration_No__CaptionLbl) { }
                    column(PostedPmtOrd__Posting_Date_Caption;PostedPmtOrd__Posting_Date_CaptionLbl) { }
                    column(PostedPmtOrd__Currency_Code_Caption;PostedPmtOrd__Currency_Code_CaptionLbl) { }
                    column(PageCaption;PageCaptionLbl) { }
                    dataitem("BG/PO Comment Line";"BG/PO Comment Line")
                    {
                        DataItemTableView = SORTING("BG/PO No.",Type,"Line No.") WHERE(Type=CONST(Payable));
                        DataItemLinkReference = PostedPmtOrd;
                        DataItemLink = "BG/PO No."=FIELD("No.");
                        PrintOnlyIfDetail = true;
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
                        DataItemLinkReference = PostedPmtOrd;
                        DataItemTableView = SORTING("Bill Gr./Pmt. Order No.",Status,"Category Code",Redrawn,"Due Date")
                                            WHERE("Collection Agent"=CONST(Bank),
                                                  Type=CONST(Payable));
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
                        column(Vendor_City;Vendor.City) { }
                        column(Vendor_County;Vendor.County) { }
                        column(Vendor__Post_Code_;Vendor."Post Code") { }
                        column(Vendor_Name;Vendor.Name) { }
                        column(PostedDoc__Account_No__;"Account No.") { }
                        column(PostedDoc__Honored_Rejtd__at_Date_;"Honored/Rejtd. at Date") { }
                        column(PostedDoc_Status;Status) { }
                        column(PostedDoc__Document_No__;"Document No.") { }
                        column(PostedDoc__Document_Type_;"Document Type") { }
                        column(PostedDoc__Due_Date_;FORMAT("Due Date")) { }
                        column(Vendor_Name_Control28;Vendor.Name) { }
                        column(Vendor_City_Control30;Vendor.City) { }
                        column(AmtForCollection_Control31;AmtForCollection)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Vendor_County_Control35;Vendor.County) { }
                        column(PostedDoc__Document_No___Control3;"Document No.") { }
                        column(PostedDoc__No__;"No.") { }
                        column(Vendor__Post_Code__Control9;Vendor."Post Code") { }
                        column(PostedDoc_Status_Control78;Status) { }
                        column(PostedDoc__Honored_Rejtd__at_Date__Control80;"Honored/Rejtd. at Date") { }
                        column(PostedDoc__Due_Date__Control8;FORMAT("Due Date")) { }
                        column(PostedDoc__Account_No___Control1;"Account No.") { }
                        column(PostedDoc__Document_Type__Control23;"Document Type") { }
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
                        column(Vendor_Name_Control28Caption;Vendor_Name_Control28CaptionLbl) { }
                        column(Vendor__Post_Code__Control9Caption;Vendor__Post_Code__Control9CaptionLbl) { }
                        column(Vendor_City_Control30Caption;Vendor_City_Control30CaptionLbl) { }
                        column(AmtForCollection_Control31Caption;AmtForCollection_Control31CaptionLbl) { }
                        column(Vendor_County_Control35Caption;Vendor_County_Control35CaptionLbl) { }
                        column(PostedDoc_Status_Control78Caption;FIELDCAPTION(Status)) { }
                        column(PostedDoc__Honored_Rejtd__at_Date__Control80Caption;FIELDCAPTION("Honored/Rejtd. at Date")) { }
                        column(PostedDoc__Due_Date__Control8Caption;PostedDoc__Due_Date__Control8CaptionLbl) { }
                        column(PostedDoc__Account_No___Control1Caption;PostedDoc__Account_No___Control1CaptionLbl) { }
                        column(PostedDoc__Document_Type__Control23Caption;FIELDCAPTION("Document Type")) { }
                        column(ContinuedCaption;ContinuedCaptionLbl) { }
                        column(EmptyStringCaption;EmptyStringCaptionLbl) { }
                        column(ContinuedCaption_Control15;ContinuedCaption_Control15Lbl) { }
                        column(TotalCaption;TotalCaptionLbl) { }
                        Column(CCCNo_recCustomerBA;recVendorBA."CCC No.") { }
                        column(NCCCLbl;NCCCLbl) { }

                        trigger OnAfterGetRecord();
                        begin
                            Vendor.GET("Account No.");
                            IF PrintAmountsInLCY THEN
                              AmtForCollection := "Amt. for Collection (LCY)"
                            ELSE
                              AmtForCollection := "Amount for Collection";

                            //-129
                            CLEAR(recVendorBA);
                            IF "Cust./Vendor Bank Acc. Code" <> '' THEN
                                recVendorBA.GET("Account No.","Cust./Vendor Bank Acc. Code");
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
                      CopyText := Text1100000;
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
                WITH BankAcc DO BEGIN
                  GET(PostedPmtOrd."Bank Account No.");
                  FormatAddress.FormatAddr(
                    BankAccAddr,Name,"Name 2",'',Address,"Address 2",
                    City,"Post Code",County,"Country/Region Code");
                END;
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
        Vendor : Record "Vendor";
        FormatAddress : Codeunit "Format Address";
        BankAccAddr : array [8] of Text[50];
        CompanyAddr : array [8] of Text[50];
        NoOfLoops : Integer;
        NoOfCopies : Integer;
        CopyText : Text[30];
        City : Text[30];
        County : Text[30];
        Name : Text[50];
        PrintAmountsInLCY : Boolean;
        AmtForCollection : Decimal;
        OutputNo : Integer;
        PostedPmtOrd__No__CaptionLbl : Label 'Payment Order No.';
        CompanyInfo__Phone_No__CaptionLbl : Label 'Phone No.';
        CompanyInfo__Fax_No__CaptionLbl : Label 'Fax No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl : Label 'VAT Reg. No';
        PostedPmtOrd__Posting_Date_CaptionLbl : Label 'Date';
        PostedPmtOrd__Currency_Code_CaptionLbl : Label 'Currency Code';
        PageCaptionLbl : Label 'Page';
        All_amounts_are_in_LCYCaptionLbl : Label 'All amounts are in LCY';
        Document_No_CaptionLbl : Label 'Document No.';
        Bill_No_CaptionLbl : Label 'Bill No.';
        Vendor_Name_Control28CaptionLbl : Label 'Name',;
        Vendor__Post_Code__Control9CaptionLbl : Label 'Post Code';
        Vendor_City_Control30CaptionLbl : Label 'City /';
        AmtForCollection_Control31CaptionLbl : Label 'Amount for Collection';
        Vendor_County_Control35CaptionLbl : Label 'County';
        PostedDoc__Due_Date__Control8CaptionLbl : Label 'Due Date';
        PostedDoc__Account_No___Control1CaptionLbl : Label 'Vendor No.';
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

        EXIT(PostedDoc."Currency Code");
    end;
}

