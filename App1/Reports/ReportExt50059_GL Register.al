report 50059 "G/L Register Ext"
{
    // version NAVW111.00.00.20348,NAVES11.00.00.20348

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/GL Register.rdlc';
    Caption = 'G/L Register';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    
    dataset
    {
        dataitem("G/L Register"; "G/L Register")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.","Posting Date";
            column(CompanyName;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(Filter_GLReg;"G/L Register".TABLECAPTION + ': ' + GLRegFilter)
            {
            }
            column(GLRegFilter;GLRegFilter)
            {
            }
            column(TransactionNo_GLReg;"No.")
            {
            }
            column(GLEntryAmt;"G/L Entry".Amount)
            {
            }
            column(G_L_RegisterCaption;G_L_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PageNoCaption;CurrReport_PageNoCaptionLbl)
            {
            }
            column(PostDate_GLEntryCaption;PostDate_GLEntryCaptionLbl)
            {
            }
            column(DocType_GLEntryCaption;DocType_GLEntryCaptionLbl)
            {
            }
            column(GLAccNameCaption;GLAccNameCaptionLbl)
            {
            }
            column(GenPostType_GLEntryCaption;GenPostType_GLEntryCaptionLbl)
            {
            }
            column(GenBusPostGroup_GLEntryCaption;GenBusPostGroup_GLEntryCaptionLbl)
            {
            }
            column(GenProdPostGroup_GLEntryCaption;GenProdPostGroup_GLEntryCaptionLbl)
            {
            }
            column(TransactionNo_GLRegCaption;FIELDCAPTION("No."))
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            dataitem("G/L Entry";"G/L Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                column(PostDate_GLEntry;FORMAT("Posting Date"))
                {
                }
                column(DocType_GLEntry;"Document Type")
                {
                }
                column(DocNo_GLEntry;"Document No.")
                {
                    IncludeCaption = true;
                }
                column(GLAccNo_GLEntry;"G/L Account No.")
                {
                    IncludeCaption = true;
                }
                column(GLAccName;GLAcc.Name)
                {
                }
                column(Desc_GLEntry;Description)
                {
                    IncludeCaption = true;
                }
                column(GenPostType_GLEntry;"Gen. Posting Type")
                {
                }
                column(GenBusPostGroup_GLEntry;"Gen. Bus. Posting Group")
                {
                }
                column(GenProdPostGroup_GLEntry;"Gen. Prod. Posting Group")
                {
                }
                column(EntryNo_GLEntry;"Entry No.")
                {
                    IncludeCaption = true;
                }
                column(DebitAmt_GLEntry;"Debit Amount")
                {
                    IncludeCaption = true;
                }
                column(CreditAmt_GLEntry;"Credit Amount")
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord();
                var
                    ClosingDate : Date;
                begin
                    IF NOT GLAcc.GET("G/L Account No.") THEN
                      GLAcc.INIT;
                end;

                trigger OnPreDataItem();
                var
                    COnfUsu : Record "User Setup";
                begin
                    SETCURRENTKEY("Transaction No.");
                    SETRANGE("Transaction No.","G/L Register"."No.");
                    //-145
                    COnfUsu.GET(USERID);
                    IF NOT COnfUsu."Allow see detailed salaris" THEN
                        SETFILTER("G/L Account No.",'<%1|>%2','640000','649999');
                    //+145
                    CurrReport.CREATETOTALS("Debit Amount","Credit Amount",Amount);
                end;
            }

            trigger OnPreDataItem();
            begin
                IF "G/L Register"."No." <> 0 THEN
                  SETRANGE("No.","G/L Register".GETRANGEMIN("No."),"G/L Register".GETRANGEMAX("No."));
                CurrReport.CREATETOTALS("G/L Entry".Amount);
            end;
        }
    }

    trigger OnPreReport();
    begin
        GLRegFilter := "G/L Register".GETFILTERS;
    end;

    var
        GLAcc : Record "G/L Account";
        GLRegFilter : Text;
        G_L_RegisterCaptionLbl : Label 'G/L Register';
        CurrReport_PageNoCaptionLbl : Label 'Page';
        PostDate_GLEntryCaptionLbl : Label 'Posting Date';
        DocType_GLEntryCaptionLbl : Label 'Document Type';
        GLAccNameCaptionLbl : Label 'Name';
        GenPostType_GLEntryCaptionLbl : Label 'Gen. Posting Type';
        GenBusPostGroup_GLEntryCaptionLbl : Label 'Gen. Bus. Posting Group';
        GenProdPostGroup_GLEntryCaptionLbl : Label 'Gen. Prod. Posting Group';
        TotalCaptionLbl : Label 'Total';
}

