report 50067 "Closed Bill Group Listing Ext"
{
    // version NAVES11.00

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Closed Bill Group Listing.rdlc';
    Caption = 'Closed Bill Group Listing';

    dataset
    {
        dataitem(ClosedBillGr;"Closed Bill Group")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(No_ClosedBillGr;"No.")
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
                    column(CopyText;STRSUBSTNO(Text1100003,CopyText)) { }
                    column(CompanyAddr1;CompanyAddr[1]) { }
                    column(CompanyAddr2;CompanyAddr[2]) { }
                    column(CompanyAddr3;CompanyAddr[3]) { }
                    column(CompanyAddr4;CompanyAddr[4]) { }
                    column(CompanyAddr5;CompanyAddr[5]) { }
                    column(CompanyAddr6;CompanyAddr[6]) { }
                    column(CompanyInfoPhoneNo;CompanyInfo."Phone No.") { }
                    column(CompanyInfoFaxNo;CompanyInfo."Fax No.") { }
                    column(CompanyInfoVATRegNo;CompanyInfo."VAT Registration No.") { }
                    column(ClosedBillGrPostingDate;FORMAT(ClosedBillGr."Posting Date")) { }
                    column(BankAccAddr4;BankAccAddr[4]) { }
                    column(BankAccAddr5;BankAccAddr[5]) { }
                    column(BankAccAddr6;BankAccAddr[6]) { }
                    column(BankAccAddr7;BankAccAddr[7]) { }
                    column(BankAccAddr3;BankAccAddr[3]) { }
                    column(BankAccAddr2;BankAccAddr[2]) { }
                    column(BankAccAddr1;BankAccAddr[1]) { }
                    column(ClosedBillGrCurrencyCode;ClosedBillGr."Currency Code") { }
                    column(FactoringType;FactoringType) { }
                    column(OutputNo;OutputNo) { }
                    column(PrintAmountsInLCY;PrintAmountsInLCY) { }
                    column(BillGroupNoCaption;BillGroupNoCaptionLbl) { }
                    column(PhoneNoCaption;PhoneNoCaptionLbl) { }
                    column(FaxNoCaption;FaxNoCaptionLbl) { }
                    column(VATRegistrationNoCaption;VATRegistrationNoCaptionLbl) { }
                    column(DateCaption;DateCaptionLbl) { }
                    column(CurrencyCodeCaption;CurrencyCodeCaptionLbl) { }
                    column(PageCaption;PageCaptionLbl) { }
                    dataitem("BG/PO Comment Line";"BG/PO Comment Line")
                    {
                        DataItemTableView = SORTING("BG/PO No.",Type,"Line No.") WHERE(Type=CONST(Receivable));
                        DataItemLinkReference = ClosedBillGr;
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
                    dataitem(ClosedDoc;"Closed Cartera Doc.")
                    {
                        DataItemLink = "Bill Gr./Pmt. Order No."=FIELD("No.");
                        DataItemLinkReference = ClosedBillGr;
                        DataItemTableView = SORTING(Type,"Collection Agent","Bill Gr./Pmt. Order No.")
                                            WHERE("Collection Agent"=CONST(Bank),
                                                  Type=CONST(Receivable));
                        column(AmtForCollection;AmtForCollection)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(CustomerCity;Customer.City) { }
                        column(CustomerCounty;Customer.County) { }
                        column(CustomerPostCode;Customer."Post Code") { }
                        column(CustomerName;Customer.Name) { }
                        column(AccountNo_ClosedDoc;"Account No.") { }
                        column(HonoredRejtdatDate_ClosedDoc;FORMAT("Honored/Rejtd. at Date")) { }
                        column(Status_ClosedDoc;Status) { }
                        column(DocumentNo_ClosedDoc;"Document No.") { }
                        column(DocumentType_ClosedDoc;"Document Type") { }
                        column(DueDate_ClosedDoc;FORMAT("Due Date")) { }
                        column(ClosedDocDocTypeNotBill;ClosedDoc."Document Type" <> ClosedDoc."Document Type"::Bill) { }
                        column(No_ClosedDoc;"No.") { }
                        column(ClosedDocDocTypeBill;ClosedDoc."Document Type" = ClosedDoc."Document Type"::Bill) { }
                        column(Type_ClosedDoc;Type) { }
                        column(EntryNo_ClosedDoc;"Entry No.") { }
                        column(BillGrPmtOrderNo_ClosedDoc;"Bill Gr./Pmt. Order No.") { }
                        column(AllAmtareinLCYCaption;AllAmtareinLCYCaptionLbl) { }
                        column(DocumentNoCaption;DocumentNoCaptionLbl) { }
                        column(BillNoCaption;BillNoCaptionLbl) { }
                        column(NameCaption;NameCaptionLbl) { }
                        column(PostCodeCaption;PostCodeCaptionLbl) { }
                        column(CityCaption;CityCaptionLbl) { }
                        column(AmtForCollectioCaption;AmtForCollectioCaptionLbl) { }
                        column(CountyCaption;CountyCaptionLbl) { }
                        column(StatusCaption_ClosedDoc;FIELDCAPTION(Status)) { }
                        column(HonoredRejtdatDateCaption;HonoredRejtdatDateCaptionLbl) { }
                        column(DueDateCaption;DueDateCaptionLbl) { }
                        column(CustomerNoCaption;CustomerNoCaptionLbl) { }
                        column(DocTypeCaption_ClosedDoc;FIELDCAPTION("Document Type")) { }
                        column(EmptyStringCaption;EmptyStringCaptionLbl) { }
                        column(TotalCaption;TotalCaptionLbl) { }
                        Column(CCCNo_recCustomerBA;recCustomerBA."CCC No.") { }
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
                    IF Number > 1 THEN BEGIN
                      CopyText := Text1100002;
                      OutputNo := OutputNo + 1;
                    END;
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
                  GET(ClosedBillGr."Bank Account No.");
                  FormatAddress.FormatAddr(
                    BankAccAddr,Name,"Name 2",'',Address,"Address 2",
                    City,"Post Code",County,"Country/Region Code");
                END;

                IF NOT CurrReport.PREVIEW THEN
                  PrintCounter.PrintCounterExt(DATABASE::"Closed Bill Group","No.");
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

    labels
    {
    }

    var
        Text1100000 : Label 'For Discount';
        Text1100001 : Label 'For Collection';
        Text1100002 : Label 'COPY';
        Text1100003 : Label 'Bill Group %1';
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
        BillGroupNoCaptionLbl : Label 'Bill Group No.';
        PhoneNoCaptionLbl : Label 'Phone No.';
        FaxNoCaptionLbl : Label 'Fax No.';
        VATRegistrationNoCaptionLbl : Label 'VAT Reg. No.';
        DateCaptionLbl : Label 'Date';
        CurrencyCodeCaptionLbl : Label 'Currency Code';
        PageCaptionLbl : Label 'Page';
        AllAmtareinLCYCaptionLbl : Label 'All amounts are in LCY';
        DocumentNoCaptionLbl : Label 'Document No.';
        BillNoCaptionLbl : Label 'Bill No.';
        NameCaptionLbl : Label 'Name';
        PostCodeCaptionLbl : Label 'Post Code';
        CityCaptionLbl : Label 'City /';
        AmtForCollectioCaptionLbl : Label 'Amount for Collection';
        CountyCaptionLbl : Label 'County';
        HonoredRejtdatDateCaptionLbl : Label 'Honored/Rejtd. at Date';
        DueDateCaptionLbl : Label 'Due Date';
        CustomerNoCaptionLbl : Label 'Customer No.';
        EmptyStringCaptionLbl : Label '/', Blocked = true;
        TotalCaptionLbl : Label 'Total';
        ObservacionesLbl : Label 'Observations: ';
        recCustomerBA : Record "Customer Bank Account";
        verObserv : Boolean;
        NCCCLbl : Label 'nº c.c.c.:';

    procedure GetCurrencyCode() : Code[10];
    begin
        IF PrintAmountsInLCY THEN
          EXIT('')
        ELSE
          EXIT(ClosedDoc."Currency Code");
    end;

    procedure GetFactoringType() : Text[30];
    begin
        IF ClosedBillGr.Factoring <> ClosedBillGr.Factoring::" " THEN BEGIN
          IF ClosedBillGr.Factoring = ClosedBillGr.Factoring::Risked THEN
            EXIT(Text1100005)
          ELSE
            EXIT(Text1100006);
        END;
    end;
}

