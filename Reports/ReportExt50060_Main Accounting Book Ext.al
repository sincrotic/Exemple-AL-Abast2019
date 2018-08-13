report 50060 "Main Accounting Book Ext"
{
    // version NAVES11.00

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Main Accounting Book.rdlc';
    Caption = 'Main Accounting Book';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    
    dataset
    {
        dataitem("G/L Account";"G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Date Filter","No.","Global Dimension 1 Filter","Global Dimension 2 Filter","Account Type";
            column(COMPANYNAME;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(STRSUBSTNO_Text1100002_GLFilter_;STRSUBSTNO(Text1100002,GLFilter))
            {
            }
            column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
            {
            }
            column(CurrReport_PAGENO;CurrReport.PAGENO)
            {
            }
            column(USERID;USERID)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilterAcc;TABLECAPTION + ': ' + GLFilterAcc)
            {
            }
            column(HeaderText;HeaderText)
            {
            }
            column(EmptyString;'')
            {
            }
            column(NumAcc;NumAcc)
            {
            }
            column(TransDebit___TransCredit;TransDebit - TransCredit)
            {
            }
            column(TransDebit;TransDebit)
            {
            }
            column(TransCredit;TransCredit)
            {
            }
            column(NameAcc;NameAcc)
            {
            }
            column(NumAcc_Control24;NumAcc)
            {
            }
            column(TransDebit___TransCredit_Control94;TransDebit - TransCredit)
            {
            }
            column(NumAcc_Control8;NumAcc)
            {
            }
            column(TransDebit_Control54;TransDebit)
            {
            }
            column(TransCredit_Control93;TransCredit)
            {
            }
            column(TD;TD)
            {
            }
            column(TB;TB)
            {
            }
            column(TC;TC)
            {
            }
            column(G_L_Account_No_;"No.")
            {
            }
            column(G_L_Account_Date_Filter;"Date Filter")
            {
            }
            column(G_L_Account_Global_Dimension_1_Filter;"Global Dimension 1 Filter")
            {
            }
            column(G_L_Account_Global_Dimension_2_Filter;"Global Dimension 2 Filter")
            {
            }
            column(G_L_Account_Business_Unit_Filter;"Business Unit Filter")
            {
            }
            column(Main_Accounting_BookCaption;Main_Accounting_BookCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Posting_DateCaption;Posting_DateCaptionLbl)
            {
            }
            column(DescriptionCaption;DescriptionCaptionLbl)
            {
            }
            column(DebitCaption;DebitCaptionLbl)
            {
            }
            column(CreditCaption;CreditCaptionLbl)
            {
            }
            column(Acum__Balance_at_dateCaption;Acum__Balance_at_dateCaptionLbl)
            {
            }
            column(Net_ChangeCaption;Net_ChangeCaptionLbl)
            {
            }
            column(Continued____________________________Caption;Continued____________________________CaptionLbl)
            {
            }
            column(Num_Account_Caption;Num_Account_CaptionLbl)
            {
            }
            column(Continued____________________________Caption_Control51;Continued____________________________Caption_Control51Lbl)
            {
            }
            column(Num_Account_Caption_Control6;Num_Account_Caption_Control6Lbl)
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            dataitem(Intger;Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));
                column(GLBalance;GLBalance)
                {
                }
                column(TotalDebit;TotalDebit)
                {
                }
                column(FromDate;FORMAT(FromDate))
                {
                }
                column(TotalCredit;TotalCredit)
                {
                }
                column(Open;Open)
                {
                }
                column(Integer_Number;Number)
                {
                }
                column(Total_Opening_EntriesCaption;Total_Opening_EntriesCaptionLbl)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    Open := FALSE;
                    GLBalance := 0;
                    IF GLFilterDim1 <> '' THEN
                      GLAccount.SETFILTER("Global Dimension 1 Filter",GLFilterDim1);
                    IF GLFilterDim2 <> '' THEN
                      GLAccount.SETFILTER("Global Dimension 2 Filter",GLFilterDim2);
                    IF InitPeriodDate = FromDate THEN
                      Open := TRUE;
                    GLAccount.SETRANGE("Date Filter",0D,CLOSINGDATE(CALCDATE('<-1D>',FromDate)));
                    IF GLFilterAccType = Text1100000Lbl THEN BEGIN
                      GLAccount.SETFILTER("No.","G/L Account".Totaling);
                      GLAccount.SETRANGE("Account Type",0);
                    END ELSE
                      GLAccount.SETFILTER("No.","G/L Account"."No.");
                    IF GLAccount.FIND('-') THEN
                      REPEAT
                        GLAccount.CALCFIELDS("Additional-Currency Net Change","Net Change");
                        IF PrintAmountsInAddCurrency THEN BEGIN
                          IF GLAccount."Additional-Currency Net Change" > 0 THEN
                            TotalDebit := TotalDebit + GLAccount."Additional-Currency Net Change"
                          ELSE
                            TotalCredit := TotalCredit + ABS(GLAccount."Additional-Currency Net Change");
                        END ELSE BEGIN
                          IF GLAccount."Net Change" > 0 THEN
                            TotalDebit := TotalDebit + GLAccount."Net Change"
                          ELSE
                            TotalCredit := TotalCredit + ABS(GLAccount."Net Change");
                        END;
                      UNTIL GLAccount.NEXT = 0;

                    GLBalance := TotalDebit - TotalCredit;
                    IF GLBalance = 0 THEN BEGIN
                      TotalDebit := 0;
                      TotalCredit := 0;
                    END;
                    TransDebit := TFTotalDebitAmt;
                    TransCredit := TFTotalCreditAmt;
                    IF Open AND (GLBalance <> 0) THEN BEGIN
                      TFTotalDebitAmt := TFTotalDebitAmt + TotalDebit;
                      TFTotalCreditAmt := TFTotalCreditAmt + TotalCredit;
                    END;
                end;
            }
            dataitem("<Accounting Period2>";"Accounting Period")
            {
                DataItemTableView = SORTING("Starting Date");
                column(CLOSINGDATE_CALCDATE_Text1100001__Starting_Date___;FORMAT(CLOSINGDATE(CALCDATE('<-1D>',"Starting Date"))))
                {
                }
                column(Accounting_Period2___Starting_Date_;FORMAT("Starting Date"))
                {
                }
                column(GLBalance_Control13;GLBalance)
                {
                }
                column(TotalDebit_Control2;TotalDebit)
                {
                }
                column(TotalCredit_Control9;TotalCredit)
                {
                }
                column(TotalDebit_Control27;TotalDebit)
                {
                }
                column(TotalCredit_Control28;TotalCredit)
                {
                }
                column(NotFound;NotFound)
                {
                }
                column(Accounting_Period2__Starting_Date;"Starting Date")
                {
                }
                column(Total_Opening_EntriesCaption_Control31;Total_Opening_EntriesCaption_Control31Lbl)
                {
                }
                column(Total_Closing_EntriesCaption;Total_Closing_EntriesCaptionLbl)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF GLBalance = 0 THEN BEGIN
                      TotalDebit := 0;
                      TotalCredit := 0;
                    END;
                    IF (NOT NotFound) AND (GLBalance <> 0) THEN BEGIN
                      TFTotalDebitAmt := TFTotalDebitAmt + TotalDebit + TotalCredit;
                      TFTotalCreditAmt := TFTotalCreditAmt + TotalDebit + TotalCredit;
                    END;
                    TransDebit := TFTotalDebitAmt;
                    TransCredit := TFTotalCreditAmt;
                end;

                trigger OnPreDataItem();
                begin
                    PostDate := FromDate;
                    GLEntry3.SETCURRENTKEY("G/L Account No.","Posting Date");
                    IF GLFilterDim1 <> '' THEN
                      GLEntry3.SETFILTER("Global Dimension 1 Code",GLFilterDim1);
                    IF GLFilterDim2 <> '' THEN
                      GLEntry3.SETFILTER("Global Dimension 2 Code",GLFilterDim2);
                    GLEntry3.SETRANGE("Posting Date",FromDate,ToDate);
                    IF GLFilterAccType = Text1100000Lbl THEN
                      GLEntry3.SETFILTER("G/L Account No.","G/L Account".Totaling)
                    ELSE
                      GLEntry3.SETFILTER("G/L Account No.","G/L Account"."No.");
                    IF GLEntry3.FIND('-') THEN BEGIN
                      GLEntry3.NEXT(-1);
                      PostDate := GLEntry3."Posting Date";
                    END ELSE BEGIN
                      NotFound := TRUE
                    END;

                    SETRANGE("New Fiscal Year",TRUE);
                    SETFILTER("Starting Date",'> %1 & <= %2',FromDate,PostDate);

                    IF NotFound THEN
                      CurrReport.SKIP;
                end;
            }
            dataitem("G/L Entry";"G/L Entry")
            {
                DataItemLink = "Posting Date"=FIELD("Date Filter"),
                               "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                               "Business Unit Code"=FIELD("Business Unit Filter");
                DataItemLinkReference = "G/L Account";
                DataItemTableView = SORTING("Posting Date","G/L Account No.");
                column(G_L_Entry__Posting_Date_;FORMAT("Posting Date"))
                {
                }
                column(G_L_Entry_Description;Description)
                {
                }
                column(G_L_Entry__Add__Currency_Debit_Amount_;"Add.-Currency Debit Amount")
                {
                }
                column(G_L_Entry__Add__Currency_Credit_Amount_;"Add.-Currency Credit Amount")
                {
                }
                column(GLBalance_Control76;GLBalance)
                {
                }
                column(PrintAmountsInAddCurrency;PrintAmountsInAddCurrency)
                {
                }
                column(GLFilterAccType;GLFilterAccType)
                {
                }
                column(Text1100000;Text1100000Lbl)
                {
                }
                column(G_L_Entry__Posting_Date__Control3;FORMAT("Posting Date"))
                {
                }
                column(G_L_Entry_Description_Control1100111;Description)
                {
                }
                column(GLBalance_Control14;GLBalance)
                {
                }
                column(G_L_Entry__Debit_Amount_;"Debit Amount")
                {
                }
                column(G_L_Entry__Credit_Amount_;"Credit Amount")
                {
                }
                column(GLBalance_Control48;GLBalance)
                {
                }
                column(TotalCreditHead;TotalCreditHead)
                {
                }
                column(TotalDebitHead;TotalDebitHead)
                {
                }
                column(Num;Num)
                {
                }
                column(TempTotalCreditHead;TempTotalCreditHead)
                {
                }
                column(TempTotalDebitHead;TempTotalDebitHead)
                {
                }
                column(TotalDebitHead_Control26;TotalDebitHead)
                {
                }
                column(TotalCreditHead_Control47;TotalCreditHead)
                {
                }
                column(GLBalance_Control49;GLBalance)
                {
                }
                column(G_L_Entry_Entry_No_;"Entry No.")
                {
                }
                column(G_L_Entry_Posting_Date;"Posting Date")
                {
                }
                column(G_L_Entry_Global_Dimension_1_Code;"Global Dimension 1 Code")
                {
                }
                column(G_L_Entry_Global_Dimension_2_Code;"Global Dimension 2 Code")
                {
                }
                column(G_L_Entry_Business_Unit_Code;"Business Unit Code")
                {
                }
                column(Total_Period_EntriesCaption;Total_Period_EntriesCaptionLbl)
                {
                }
                column(Total_Period_EntriesCaption_Control50;Total_Period_EntriesCaption_Control50Lbl)
                {
                }
                dataitem("<Accounting Period3>";"Accounting Period")
                {
                    DataItemTableView = SORTING("Starting Date");
                    column(AccPeriodNum;AccPeriodNum)
                    {
                    }
                    column(Accounting_Period3___Starting_Date_;FORMAT("Starting Date"))
                    {
                    }
                    column(CLOSINGDATE_CALCDATE_Text1100001__Starting_Date____Control102;FORMAT(CLOSINGDATE(CALCDATE('<-1D>',"Starting Date"))))
                    {
                    }
                    column(GLBalance_Control63;GLBalance)
                    {
                    }
                    column(TotalDebit_Control16;TotalDebit)
                    {
                    }
                    column(TotalCredit_Control19;TotalCredit)
                    {
                    }
                    column(TotalCredit_Control29;TotalCredit)
                    {
                    }
                    column(TotalDebit_Control30;TotalDebit)
                    {
                    }
                    column(Accounting_Period3__Starting_Date;"Starting Date")
                    {
                    }
                    column(Total_Opening_EntriesCaption_Control108;Total_Opening_EntriesCaption_Control108Lbl)
                    {
                    }
                    column(Total_Closing_EntriesCaption_Control109;Total_Closing_EntriesCaption_Control109Lbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        IF Num = 0 THEN
                          CurrReport.SKIP;
                        AccPeriodNum += 1;
                        TempTotalCreditHead := TotalCreditHead;
                        TempTotalDebitHead := TotalDebitHead;
                        TotalDebitHead := 0;
                        TotalCreditHead := 0;
                        TotalDebit := 0;
                        TotalCredit := 0;
                        GLAccount.SETRANGE("Date Filter");
                        IF GLFilterDim1 <> '' THEN
                          GLAccount.SETFILTER("Global Dimension 1 Filter",GLFilterDim1);
                        IF GLFilterDim2 <> '' THEN
                          GLAccount.SETFILTER("Global Dimension 2 Filter",GLFilterDim2);
                        GLAccount.SETRANGE("Date Filter",0D,CLOSINGDATE(CALCDATE('<-1D>',"Starting Date")));
                        IF GLFilterAccType = Text1100000Lbl THEN BEGIN
                          GLAccount.SETFILTER("No.","G/L Account".Totaling);
                          GLAccount.SETRANGE("Account Type",GLAccount."Account Type"::Posting);
                        END ELSE
                          GLAccount.SETFILTER("No.","G/L Account"."No.");
                        IF GLAccount.FIND('-') THEN
                          REPEAT
                            GLAccount.CALCFIELDS("Additional-Currency Net Change","Net Change");
                            IF PrintAmountsInAddCurrency THEN BEGIN
                              IF GLAccount."Additional-Currency Net Change" > 0 THEN
                                TotalDebit := TotalDebit + GLAccount."Additional-Currency Net Change"
                              ELSE
                                TotalCredit := TotalCredit + ABS(GLAccount."Additional-Currency Net Change");
                            END ELSE BEGIN
                              IF GLAccount."Net Change" > 0 THEN
                                TotalDebit := TotalDebit + GLAccount."Net Change"
                              ELSE
                                TotalCredit := TotalCredit + ABS(GLAccount."Net Change");
                            END;
                          UNTIL GLAccount.NEXT = 0;

                        IF GLBalance = 0 THEN BEGIN
                          TotalDebit := 0;
                          TotalCredit := 0;
                        END ELSE BEGIN
                          TFTotalDebitAmt := TFTotalDebitAmt + TotalDebit + TotalCredit;
                          TFTotalCreditAmt := TFTotalCreditAmt + TotalDebit + TotalCredit;
                        END;
                        TransDebit := TFTotalDebitAmt;
                        TransCredit := TFTotalCreditAmt;
                    end;

                    trigger OnPreDataItem();
                    begin
                        IF Num > 0 THEN BEGIN
                          SETFILTER("Starting Date",'>%1 & <= %2',LastDate,NormPostDate);
                          SETRANGE("New Fiscal Year",TRUE);
                          AccPeriodNum := 0;
                        END;
                        IF Num = 0 THEN BEGIN
                          SETRANGE("New Fiscal Year",TRUE);
                          FIND('-');
                          CurrReport.SKIP;
                        END;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    Num := 0;
                    TransDebit := TFTotalDebitAmt;
                    TransCredit := TFTotalCreditAmt;
                    TotalDebit := 0;
                    TotalCredit := 0;

                    IF NOT PrintAmountsInAddCurrency THEN BEGIN
                      TFTotalDebitAmt := TFTotalDebitAmt + "Debit Amount";
                      TFTotalCreditAmt := TFTotalCreditAmt + "Credit Amount";
                      TFGLBalance := TFGLBalance + "Debit Amount" - "Credit Amount";
                    END ELSE BEGIN
                      TFTotalDebitAmt := TFTotalDebitAmt + "Add.-Currency Debit Amount";
                      TFTotalCreditAmt := TFTotalCreditAmt + "Add.-Currency Credit Amount";
                      TFGLBalance := TFGLBalance + "Add.-Currency Debit Amount" - "Add.-Currency Credit Amount";
                    END;
                    IF NOT PrintAmountsInAddCurrency THEN BEGIN
                      TotalDebit := TotalDebit + "Debit Amount";
                      TotalCredit := TotalCredit + "Credit Amount";
                      GLBalance := GLBalance + "Debit Amount" - "Credit Amount";
                    END ELSE BEGIN
                      TotalDebit := TotalDebit + "Add.-Currency Debit Amount";
                      TotalCredit := TotalCredit + "Add.-Currency Credit Amount";
                      GLBalance := GLBalance + "Add.-Currency Debit Amount" - "Add.-Currency Credit Amount";
                    END;
                    TotalDebitHead := TotalDebitHead + TotalDebit;
                    TotalCreditHead := TotalCreditHead + TotalCredit;

                    PostDate := "Posting Date";
                    LastDate := "Posting Date";
                    i := i + 1;
                    Print := TRUE;

                    IF NEXT <> 0 THEN BEGIN
                      NormPostDate := NORMALDATE("Posting Date");
                      Num := CalcAccountingPeriod(NormPostDate,LastDate);
                      NEXT(-1);
                    END;
                end;

                trigger OnPreDataItem();
                begin
                    SETCURRENTKEY("Posting Date","G/L Account No.");
                    IF GLFilterDim1 <> '' THEN
                      SETFILTER("Global Dimension 1 Code",GLFilterDim1);
                    IF GLFilterDim2 <> '' THEN
                      SETFILTER("Global Dimension 2 Code",GLFilterDim2);
                    SETRANGE("Posting Date",FromDate,ToDate);
                    IF GLFilterAccType = Text1100000Lbl THEN
                      SETFILTER("G/L Account No.","G/L Account".Totaling)
                    ELSE
                      SETFILTER("G/L Account No.","G/L Account"."No.");
                    LastDate := 0D;
                    Print := FALSE;
                    Open := FALSE;
                    i := 0;
                    TotalDebit := 0;
                    TotalCredit := 0;
                end;
            }
            dataitem("Accounting Period";"Accounting Period")
            {
                DataItemTableView = SORTING("Starting Date");
                column(DateOpen;FORMAT(DateOpen))
                {
                }
                column(CLOSINGDATE_DateClose_;FORMAT(CLOSINGDATE(DateClose)))
                {
                }
                column(GLBalance_Control84;GLBalance)
                {
                }
                column(TotalDebit_Control21;TotalDebit)
                {
                }
                column(TotalCredit_Control22;TotalCredit)
                {
                }
                column(TotalCredit_Control43;TotalCredit)
                {
                }
                column(TotalDebit_Control44;TotalDebit)
                {
                }
                column(Accounting_Period_Starting_Date;"Starting Date")
                {
                }
                column(Total_Opening_EntriesCaption_Control68;Total_Opening_EntriesCaption_Control68Lbl)
                {
                }
                column(Total_Closing_EntriesCaption_Control70;Total_Closing_EntriesCaption_Control70Lbl)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    DateOpen := "Starting Date";
                    DateClose := CLOSINGDATE(CALCDATE('<-1D>',"Starting Date"));
                    TotalDebitHead := 0;
                    TotalCreditHead := 0;
                    TotalDebit := 0;
                    TotalCredit := 0;
                    GLAccount.SETRANGE("Date Filter");
                    IF GLFilterDim1 <> '' THEN
                      GLAccount.SETFILTER("Global Dimension 1 Filter",GLFilterDim1);
                    IF GLFilterDim2 <> '' THEN
                      GLAccount.SETFILTER("Global Dimension 2 Filter",GLFilterDim2);
                    GLAccount.SETRANGE("Date Filter",0D,DateClose);
                    IF GLFilterAccType = Text1100000Lbl THEN BEGIN
                      GLAccount.SETFILTER("No.","G/L Account".Totaling);
                      GLAccount.SETRANGE("Account Type",0);
                    END ELSE
                      GLAccount.SETFILTER("No.","G/L Account"."No.");
                    IF GLAccount.FIND('-') THEN
                      REPEAT
                        GLAccount.CALCFIELDS("Additional-Currency Net Change","Net Change");
                        IF PrintAmountsInAddCurrency THEN BEGIN
                          IF GLAccount."Additional-Currency Net Change" > 0 THEN
                            TotalDebit := TotalDebit + GLAccount."Additional-Currency Net Change"
                          ELSE
                            TotalCredit := TotalCredit + ABS(GLAccount."Additional-Currency Net Change");
                        END ELSE BEGIN
                          IF GLAccount."Net Change" > 0 THEN
                            TotalDebit := TotalDebit + GLAccount."Net Change"
                          ELSE
                            TotalCredit := TotalCredit + ABS(GLAccount."Net Change");
                        END;
                      UNTIL GLAccount.NEXT = 0;

                    IF GLBalance = 0 THEN BEGIN
                      TotalDebit := 0;
                      TotalCredit := 0;
                    END ELSE BEGIN
                      TFTotalDebitAmt := TFTotalDebitAmt + TotalDebit + TotalCredit;
                      TFTotalCreditAmt := TFTotalCreditAmt + TotalDebit + TotalCredit;
                    END;
                    TransDebit := TFTotalDebitAmt;
                    TransCredit := TFTotalCreditAmt;
                end;

                trigger OnPreDataItem();
                begin
                    IF Print THEN BEGIN
                      "Accounting Period".SETRANGE("New Fiscal Year",TRUE);
                      "Accounting Period".SETFILTER("Starting Date",'> %1 & <= %2',LastDate,ToDate);
                    END ELSE BEGIN
                      "Accounting Period".SETRANGE("New Fiscal Year",TRUE);
                      "Accounting Period".SETFILTER("Starting Date",'> %1 & <= %2',FromDate,ToDate);
                    END;
                end;
            }
            dataitem("<Integer2>";Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));
                column(CLOSINGDATE_DateClose__Control90;FORMAT(CLOSINGDATE(DateClose)))
                {
                }
                column(TotalCredit_Control45;TotalCredit)
                {
                }
                column(TotalDebit_Control46;TotalDebit)
                {
                }
                column(Found;Found)
                {
                }
                column(TFTotalDebitAmt;TFTotalDebitAmt)
                {
                }
                column(TFTotalCreditAmt;TFTotalCreditAmt)
                {
                }
                column(NumAcc_Control1100105;NumAcc)
                {
                }
                column(Integer2__Number;Number)
                {
                }
                column(Total_Closing_EntriesCaption_Control91;Total_Closing_EntriesCaption_Control91Lbl)
                {
                }
                column(Num_Account_Caption_Control62;Num_Account_Caption_Control62Lbl)
                {
                }
                column(TotalCaption_Control64;TotalCaption_Control64Lbl)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    // CHANGE
                    DateClose := ToDate;
                    IF  Found THEN BEGIN
                      PrintClosing := TRUE;
                      TotalDebit := 0;
                      TotalCredit := 0;
                      GLAccount.SETRANGE("Date Filter");
                      IF GLFilterDim1 <> '' THEN
                        GLAccount.SETFILTER("Global Dimension 1 Filter",GLFilterDim1);
                      IF GLFilterDim2 <> '' THEN
                        GLAccount.SETFILTER("Global Dimension 2 Filter",GLFilterDim2);
                      GLAccount.SETRANGE("Date Filter",0D,ToDate);
                      IF GLFilterAccType = Text1100000Lbl THEN BEGIN
                        GLAccount.SETFILTER("No.","G/L Account".Totaling);
                        GLAccount.SETRANGE("Account Type",0);
                      END ELSE
                        GLAccount.SETFILTER("No.","G/L Account"."No.");
                      IF GLAccount.FIND('-') THEN
                        REPEAT
                          GLAccount.CALCFIELDS("Additional-Currency Net Change","Net Change");
                          IF PrintAmountsInAddCurrency THEN BEGIN
                            IF GLAccount."Additional-Currency Net Change" > 0 THEN
                              TotalDebit := TotalDebit + GLAccount."Additional-Currency Net Change"
                            ELSE
                              TotalCredit := TotalCredit + ABS(GLAccount."Additional-Currency Net Change");
                          END ELSE BEGIN
                            IF GLAccount."Net Change" > 0 THEN
                              TotalDebit := TotalDebit + GLAccount."Net Change"
                            ELSE
                              TotalCredit := TotalCredit + ABS(GLAccount."Net Change");
                          END;
                        UNTIL GLAccount.NEXT = 0;

                      TFTotalDebitAmt := TFTotalDebitAmt + TotalCredit;
                      TFTotalCreditAmt := TFTotalCreditAmt + TotalDebit;
                    END;

                    TotalBalance := TFTotalDebitAmt - TFTotalCreditAmt;
                    TD := TD + TFTotalDebitAmt;
                    TC := TC + TFTotalCreditAmt;
                    TB := TB + TFTotalDebitAmt - TFTotalCreditAmt;
                end;

                trigger OnPreDataItem();
                begin
                    Found := FALSE;
                    "Accounting Period".RESET;
                    "Accounting Period".SETRANGE("New Fiscal Year",TRUE);
                    "Accounting Period".FIND('+');
                    IF ToDate <> NORMALDATE(ToDate) THEN
                      IF "Accounting Period".GET(CALCDATE('<1D>',NORMALDATE(ToDate))) THEN BEGIN
                        IF "Accounting Period"."New Fiscal Year" = TRUE THEN
                          Found := TRUE
                        ELSE
                          Found := FALSE;
                      END;
                end;
            }

            trigger OnAfterGetRecord();
            var
              ConfUsu : Record "User Setup";
              Grupo : Text[3];
            begin
                //-145

                IF NOT ConfUsu."Allow see detailed salaris" THEN BEGIN
                  Grupo := COPYSTR("No.",1,3);
                  IF Grupo IN ['640','641','642'] THEN
                      CurrReport.SKIP;
                END;
                //+145
                TotalDebit := 0;
                TotalCredit := 0;
                GLBalance := 0;
                TFTotalDebitAmt := 0;
                TFTotalCreditAmt := 0;
                TFGLBalance := 0;
                TransDebit := 0;
                TransCredit := 0;
                TotalDebitHead := 0;
                TotalCreditHead := 0;
                NotFound := FALSE;
                Print := FALSE;
                IF GLFilterAccType = Text1100000Lbl THEN BEGIN
                  IF STRLEN("No.") <> 3 THEN
                    CurrReport.SKIP;
                END;

                FromDate := GETRANGEMIN("Date Filter");
                ToDate := GETRANGEMAX("Date Filter");
                NameAcc := Name;
                NumAcc := "No.";

                SETRANGE("Date Filter",FromDate,ToDate);
                CALCFIELDS("Debit Amount","Credit Amount",Balance,"Balance at Date","Additional-Currency Balance","Net Change");
                IF "Balance at Date" = 0 THEN
                  HaveEntries := CalcEntries(FromDate)
                ELSE
                  HaveEntries := CalcEntries(0D);
                IF (NOT HaveEntries) AND (NOT ZeroBalance) THEN
                  CurrReport.SKIP;

                InitPeriodDate := CalcPeriod(FromDate);
                EndPeriodDate := CalcPeriodEnd(ToDate);
                IF ((InitPeriodDate <> FromDate) AND
                    (CLOSINGDATE(CALCDATE('<-1D>',EndPeriodDate)) <> ToDate) AND
                    ("Net Change" = 0) AND (NOT ZeroBalance))
                THEN
                  CurrReport.SKIP;

                GLSetup.GET;
                IF PrintAmountsInAddCurrency THEN
                  HeaderText := STRSUBSTNO(Text1100003,GLSetup."Additional Reporting Currency")
                ELSE BEGIN
                  GLSetup.TESTFIELD("LCY Code");
                  HeaderText := STRSUBSTNO(Text1100003,GLSetup."LCY Code");
                END;
            end;

            trigger OnPreDataItem();
            begin
                GLFilterDim1 := GETFILTER("Global Dimension 1 Filter");
                GLFilterDim2 := GETFILTER("Global Dimension 2 Filter");
                GLFilter := GETFILTER("Date Filter");
                GLFilterAcc := GETFILTER("No.");
                GLFilterAccType := GETFILTER("Account Type");
                IF GLFilterAccType = Text1100000Lbl THEN
                  SETRANGE("Account Type","Account Type"::Heading)
                ELSE
                  SETRANGE("Account Type","Account Type"::Posting);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowAmountsInAddCurrency;PrintAmountsInAddCurrency)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Amounts In Add Currency';
                        ToolTip = 'Specifies if amounts in the additional currency are included.';
                    }
                    field(ZeroBalance;ZeroBalance)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Acc. with Zero Balance';
                        ToolTip = 'Specifies if you also want accounts with a zero balance to be included.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Text1100002 : Label 'Period: %1';
        Text1100003 : Label 'All Amounts are in %1';
        Text1100005 : Label 'There is no period within this date range.';
        GLSetup : Record "General Ledger Setup";
        GLAccount : Record "G/L Account";
        GLEntry3 : Record "G/L Entry";
        NumAcc : Code[20];
        GLFilterAccType : Text[30];
        GLFilterAcc : Text;
        HeaderText : Text[40];
        GLFilter : Text[30];
        NameAcc : Text[50];
        Num : Integer;
        AccPeriodNum : Integer;
        i : Integer;
        FromDate : Date;
        ToDate : Date;
        PostDate : Date;
        InitPeriodDate : Date;
        DateClose : Date;
        EndPeriodDate : Date;
        DateOpen : Date;
        LastDate : Date;
        NormPostDate : Date;
        PrintAmountsInAddCurrency : Boolean;
        Print : Boolean;
        PrintClosing : Boolean;
        HaveEntries : Boolean;
        NotFound : Boolean;
        Found : Boolean;
        Open : Boolean;
        TFTotalDebitAmt : Decimal;
        TFTotalCreditAmt : Decimal;
        TFGLBalance : Decimal;
        TD : Decimal;
        TC : Decimal;
        TB : Decimal;
        TotalDebit : Decimal;
        TotalBalance : Decimal;
        TotalCredit : Decimal;
        GLBalance : Decimal;
        TotalDebitHead : Decimal;
        TotalCreditHead : Decimal;
        TransDebit : Decimal;
        TransCredit : Decimal;
        ZeroBalance : Boolean;
        GLFilterDim1 : Code[20];
        GLFilterDim2 : Code[20];
        TempTotalCreditHead : Decimal;
        TempTotalDebitHead : Decimal;
        Main_Accounting_BookCaptionLbl : Label 'Main Accounting Book';
        CurrReport_PAGENOCaptionLbl : Label 'Page';
        Posting_DateCaptionLbl : Label 'Posting Date';
        DescriptionCaptionLbl : Label 'Description';
        DebitCaptionLbl : Label 'Debit';
        CreditCaptionLbl : Label 'Credit';
        Acum__Balance_at_dateCaptionLbl : Label 'Accum. Bal. at Date';
        Net_ChangeCaptionLbl : Label 'Net Change';
        Continued____________________________CaptionLbl : Label 'Continued............................';
        Num_Account_CaptionLbl : Label 'Num.Account:';
        Continued____________________________Caption_Control51Lbl : Label 'Continued............................';
        Num_Account_Caption_Control6Lbl : Label 'Num.Account:';
        TotalCaptionLbl : Label 'Total';
        Total_Opening_EntriesCaptionLbl : Label 'Total Opening Entries';
        Total_Opening_EntriesCaption_Control31Lbl : Label 'Total Opening Entries';
        Total_Closing_EntriesCaptionLbl : Label 'Total Closing Entries';
        Text1100000Lbl : Label 'Heading';
        Total_Period_EntriesCaptionLbl : Label 'Total Period Entries';
        Total_Period_EntriesCaption_Control50Lbl : Label 'Total Period Entries';
        Total_Opening_EntriesCaption_Control108Lbl : Label 'Total Opening Entries';
        Total_Closing_EntriesCaption_Control109Lbl : Label 'Total Closing Entries';
        Total_Opening_EntriesCaption_Control68Lbl : Label 'Total Opening Entries';
        Total_Closing_EntriesCaption_Control70Lbl : Label 'Total Closing Entries';
        Total_Closing_EntriesCaption_Control91Lbl : Label 'Total Closing Entries';
        Num_Account_Caption_Control62Lbl : Label 'Num.Account:';
        TotalCaption_Control64Lbl : Label 'Total';

    procedure CalcPeriod(InitialDate : Date) : Date;
    var
        AccPeriod : Record "Accounting Period";
    begin
        AccPeriod.SETRANGE("New Fiscal Year",TRUE);
        AccPeriod.SETFILTER("Starting Date",'<=%1',InitialDate);
        IF AccPeriod.FINDLAST THEN
          EXIT(AccPeriod."Starting Date");

        ERROR(Text1100005);
    end;

    procedure CalcAccountingPeriod(DateAux : Date;Lastdate : Date) : Integer;
    var
        AccPeriod : Record "Accounting Period";
    begin
        AccPeriod.SETRANGE("New Fiscal Year",TRUE);
        AccPeriod.SETFILTER("Starting Date",'>%1 & <=%2',Lastdate,DateAux);
        EXIT(AccPeriod.COUNT);
    end;

    procedure CalcEntries(EndDate : Date) : Boolean;
    var
        GLEntry : Record "G/L Entry";
    begin
        GLEntry.SETCURRENTKEY("Posting Date","G/L Account No.");
        IF GLFilterDim1 <> '' THEN
          GLEntry.SETFILTER("Global Dimension 1 Code",GLFilterDim1);
        IF GLFilterDim2 <> '' THEN
          GLEntry.SETFILTER("Global Dimension 2 Code",GLFilterDim2);
        GLEntry.SETRANGE("Posting Date",EndDate,ToDate);
        IF GLFilterAccType = Text1100000Lbl THEN
          GLEntry.SETFILTER("G/L Account No.","G/L Account".Totaling)
        ELSE
          GLEntry.SETFILTER("G/L Account No.","G/L Account"."No.");
        IF GLEntry.FINDFIRST THEN
          EXIT(TRUE);

        EXIT(FALSE);
    end;

    procedure CalcPeriodEnd(EndPeriodDate : Date) : Date;
    var
        AccPeriod : Record "Accounting Period";
    begin
        AccPeriod.SETRANGE("New Fiscal Year",TRUE);
        AccPeriod.SETFILTER("Starting Date",'<=%1',CALCDATE('<1D>',NORMALDATE(EndPeriodDate)));
        IF AccPeriod.FINDLAST THEN
          EXIT(AccPeriod."Starting Date");

        ERROR(Text1100005);
    end;
}

