report 50005 "Sales - Credit Memo HEB"
{
    // version NAVW111.00.00.20783,NAVES11.00.00.20783

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Sales - Credit Memo HEB.rdlc';
    Caption = 'Sales - Credit Memo';
    Permissions = TableData 7190=rimd;
    Description = 'HEB.109';


    dataset
    {
        dataitem("Sales Cr.Memo Header";"Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.","Sell-to Customer No.","No. Printed";
            RequestFilterHeading = 'Posted Sales Credit Memo';
            column(No_SalesCrMemoHeader;"No.")
            {
            }
            column(DocDate_SalesCrMemoHeader;FORMAT("Document Date",0,'<Day,2>/<Month,2>/<Year,2>'))
            {
            }
            column(BillToCustomerNo_SalesInvHdr;"Bill-to Customer No.")
            {
            }
            column(FiscalAddr1;FiscalAddr[1])
            {
            }
            column(FiscalAddr2;FiscalAddr[2])
            {
            }
            column(FiscalAddr3;FiscalAddr[3])
            {
            }
            column(FiscalAddr4;FiscalAddr[4])
            {
            }
            column(FiscalAddr5;FiscalAddr[5])
            {
            }
            column(FiscalAddr6;FiscalAddr[6])
            {
            }
            column(FiscalAddr7;FiscalAddr[7])
            {
            }
            column(FiscalAddr8;FiscalAddr[8])
            {
            }
            column(ShipToAddr1;ShipToAddr[1])
            {
            }
            column(ShipToAddr2;ShipToAddr[2])
            {
            }
            column(ShipToAddr3;ShipToAddr[3])
            {
            }
            column(ShipToAddr4;ShipToAddr[4])
            {
            }
            column(ShipToAddr5;ShipToAddr[5])
            {
            }
            column(ShipToAddr6;ShipToAddr[6])
            {
            }
            column(ShipToAddr7;ShipToAddr[7])
            {
            }
            column(ShipToAddr8;ShipToAddr[8])
            {
            }
            column(ShiptoAddressCaption;ShiptoAddressCaptionLbl)
            {
            }
            column(SelltoCustNo_SalesCrMemoHeaderCaption;"Sales Cr.Memo Header".FIELDCAPTION("Sell-to Customer No."))
            {
            }
            column(cCodSWIFT;cCodSWIFT)
            {
            }
            column(dFechaVto1;FORMAT(dFechaVto1,0,'<Day,2>/<Month,2>/<Year,2>'))
            {
            }
            column(dFechaVto2;FORMAT(dFechaVto2,0,'<Day,2>/<Month,2>/<Year,2>'))
            {
            }
            column(comentarios1;comentarios[1])
            {
            }
            column(comentarios2;comentarios[2])
            {
            }
            column(comentarios3;comentarios[3])
            {
            }
            column(comentarios4;comentarios[4])
            {
            }
            column(PaymentTermsDescription;PaymentTerms.Description)
            {
            }
            column(PaymentMethodDescription;PaymentMethod.Description)
            {
            }
            column(RegistroMercantil;RegistroMercantil)
            {
            }
            column(cNombreBanco;cNombreBanco)
            {
            }
            column(cDirBanco;cDirBanco)
            {
            }
            column(cIBANBanco;cIBANBanco)
            {
            }
            column(CompanyInfoName;CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress;CompanyInfo.Address)
            {
            }
            column(CompanyInfoPostCode;CompanyInfo."Post Code")
            {
            }
            column(CompanyInfoCity;CompanyInfo.City)
            {
            }
            column(CompanyInfoCounty;CompanyInfo.County)
            {
            }
            column(CompanyInfoTel;CompanyInfo."Telex No.")
            {
            }
            column(CompanyInfoFax;CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfoHomePage;CompanyInfo."Home Page")
            {
            }
            dataitem(CopyLoop;Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop;Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number=CONST(1));
                    column(CompanyInfoPicture;CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo2Picture;CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture;CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture;CompanyInfo3.Picture)
                    {
                    }
                    column(SalesCorrectiveInvCopy;STRSUBSTNO(Text1100001,CopyText))
                    {
                    }
                    column(CompanyInfoPicture2;CompanyInfo."Imagen adic. 1")
                    {
                    }
                    column(CompanyInfo_CondicionesMercancia;CompanyInfo."Condiciones Mercancía")
                    {
                    }
                    column(CompanyInfo_ResponsabilidadMercancia;CompanyInfo."Responsabilidad Mercancía")
                    {
                    }
                    column(CompanyInfo_CondicionesVentaUrl;CompanyInfo."Sales URL Terms")
                    {
                    }
                    column(CompanyInfo_EntregaBienes;CompanyInfo."Entrega Bienes")
                    {
                    }
                    column(CompanyInfo_ModificacionDatos;CompanyInfo."Modificación Datos")
                    {
                    }
                    column(CustAddr1;CustAddr[1])
                    {
                    }
                    column(CompanyAddr1;CompanyAddr[1])
                    {
                    }
                    column(CustAddr2;CustAddr[2])
                    {
                    }
                    column(CompanyAddr2;CompanyAddr[2])
                    {
                    }
                    column(CustAddr3;CustAddr[3])
                    {
                    }
                    column(CompanyAddr3;CompanyAddr[3])
                    {
                    }
                    column(CustAddr4;CustAddr[4])
                    {
                    }
                    column(CompanyAddr4;CompanyAddr[4])
                    {
                    }
                    column(CustAddr5;CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo;CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6;CustAddr[6])
                    {
                    }
                    column(CompanyInfoEMail;CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoVATRegNo;CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo;CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName;CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo;CompanyInfo."Bank Account No.")
                    {
                    }
                    column(PostDate_SalesCrMemoHeader;FORMAT("Sales Cr.Memo Header"."Posting Date",0,'<Day,2>/<Month,2>/<Year,2>'))
                    {
                    }
                    column(VATNoText;VATNoText)
                    {
                    }
                    column(VATRegNo_SalesCrMemoHeader;"Sales Cr.Memo Header"."VAT Registration No.")
                    {
                    }
                    column(SalesPersonText;SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName;SalesPurchPerson.Name)
                    {
                    }
                    column(AppliedToText;AppliedToText)
                    {
                    }
                    column(ReferenceText;ReferenceText)
                    {
                    }
                    column(YourRef_SalesCrMemoHeader;"Sales Cr.Memo Header"."Your Reference")
                    {
                    }
                    column(CustAddr7;CustAddr[7])
                    {
                    }
                    column(CustAddr8;CustAddr[8])
                    {
                    }
                    column(CompanyAddr5;CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6;CompanyAddr[6])
                    {
                    }
                    column(PricIncVAT_SalesCrMemoHeader;"Sales Cr.Memo Header"."Prices Including VAT")
                    {
                    }
                    column(ReturnOrderNoText;ReturnOrderNoText)
                    {
                    }
                    column(RetOrderNo_SalesCrMemoHeader;"Sales Cr.Memo Header"."Return Order No.")
                    {
                    }
                    column(PageCaption;PageCaptionCap)
                    {
                    }
                    column(OutputNo;OutputNo)
                    {
                    }
                    column(PricInclVAT1_SalesCrMemoHeader;FORMAT("Sales Cr.Memo Header"."Prices Including VAT"))
                    {
                    }
                    column(VATBaseDiscPct_SalesCrMemoHeader;"Sales Cr.Memo Header"."VAT Base Discount %")
                    {
                    }
                    column(CorrInvNo_SalesCrMemoHeader;"Sales Cr.Memo Header"."Corrected Invoice No.")
                    {
                    }
                    column(CompanyInfoPhoneNoCaption;CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoHomePageCaption;CompanyInfoHomePageCaptionLbl)
                    {
                    }
                    column(CompanyInfoEMailCaption;CompanyInfoEMailCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegistrationNoCaption;CompanyInfoVATRegistrationNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption;CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption;CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccountNoCaption;CompanyInfoBankAccountNoCaptionLbl)
                    {
                    }
                    column(SalesCrMemoHeaderNoCaption;SalesCrMemoHeaderNoCaptionLbl)
                    {
                    }
                    column(SalesCrMemoHeaderPostingDateCaption;SalesCrMemoHeaderPostingDateCaptionLbl)
                    {
                    }
                    column(CorrectedInvoiceNoCaption;CorrectedInvoiceNoCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption;DocumentDateCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeaderCaption;"Sales Cr.Memo Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricIncVAT_SalesCrMemoHeaderCaption;"Sales Cr.Memo Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(CACCaption;CACCaptionLbl)
                    {
                    }
                    column(SelltoCustNo_SalesCrMemoHeader;"Sales Cr.Memo Header"."Sell-to Customer No.")
                    {
                    }
                    dataitem(DimensionLoop1;Integer)
                    {
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=FILTER(1..));
                        column(DimText;DimText)
                        {
                        }
                        column(Number_IntegerLine;Number)
                        {
                        }
                        column(HeaderDimensionsCaption;HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            IF Number = 1 THEN BEGIN
                              IF NOT DimSetEntry1.FINDSET THEN
                                CurrReport.BREAK;
                            END ELSE
                              IF NOT Continue THEN
                                CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                              OldDimText := DimText;
                              IF DimText = '' THEN
                                DimText := STRSUBSTNO('%1 %2',DimSetEntry1."Dimension Code",DimSetEntry1."Dimension Value Code")
                              ELSE
                                DimText :=
                                  STRSUBSTNO(
                                    '%1, %2 %3',DimText,
                                    DimSetEntry1."Dimension Code",DimSetEntry1."Dimension Value Code");
                              IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                DimText := OldDimText;
                                Continue := TRUE;
                                EXIT;
                              END;
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem();
                        begin
                            IF NOT ShowInternalInfo THEN
                              CurrReport.BREAK;
                        end;
                    }
                    dataitem("Sales Cr.Memo Line";"Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No."=FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.","Line No.");
                        column(VATLinesCount;VATLinesCount)
                        {
                        }
                        column(Descripcion;Descripcion)
                        {
                        }
                        column(cCodeRefCr;cCodeRefCr)
                        {
                        }
                        column(Descripcion2;Descripcion2)
                        {
                        }
                        column(Description2;"Description 2")
                        {
                        }
                        column(cMoneda;cMoneda)
                        {
                        }
                        column(LineAmt_SalesCrMemoLine;"Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(abono;abono)
                        {
                        }
                        column(Desc_SalesCrMemoLine;Description)
                        {
                        }
                        column(No_SalesCrMemoLine;"No.")
                        {
                        }
                        column(Qty_SalesCrMemoLine;Quantity)
                        {
                        }
                        column(UOM_SalesCrMemoLine;"Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesCrMemoLine;"Unit Price")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(LineDisc_SalesCrMemoLine;"Line Discount %")
                        {
                        }
                        column(VATIdent_SalesCrMemoLine;"VAT Identifier")
                        {
                        }
                        column(PostedReceiptDate;FORMAT("Shipment Date"))
                        {
                        }
                        column(Type_SalesCrMemoLine;FORMAT(Type))
                        {
                        }
                        column(NNCTotalLineAmt;NNC_TotalLineAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmtInclVat;NNC_TotalAmountInclVat)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalInvDiscAmt;NNC_TotalInvDiscAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmt;NNC_TotalAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(InvDiscAmt_SalesCrMemoLine;-"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(PmtDiscAmt_SalesCrMemoLine;-"Pmt. Disc. Given Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText;TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText;TotalInclVATText)
                        {
                        }
                        column(AmtIncVAT_SalesCrMemoLine;"Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmtIncVATAmt_SalesCrMemoLine;"Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText;VATAmountLine.VATAmountText)
                        {
                        }
                        column(Amt_SalesCrMemoLine;Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(DocNo_SalesCrMemoLine;"Document No.")
                        {
                        }
                        column(LineNo_SalesCrMemoLine;"Line No.")
                        {
                        }
                        column(UnitPriceCaption;UnitPriceCaptionLbl)
                        {
                        }
                        column(SalesCrMemoLineLineDiscountCaption;SalesCrMemoLineLineDiscountCaptionLbl)
                        {
                        }
                        column(AmountCaption;AmountCaptionLbl)
                        {
                        }
                        column(PostedReceiptDateCaption;PostedReceiptDateCaptionLbl)
                        {
                        }
                        column(InvDiscountAmountCaption;InvDiscountAmountCaptionLbl)
                        {
                        }
                        column(SubtotalCaption;SubtotalCaptionLbl)
                        {
                        }
                        column(PmtDiscGivenAmountCaption;PmtDiscGivenAmountCaptionLbl)
                        {
                        }
                        column(Desc_SalesCrMemoLineCaption;FIELDCAPTION(Description))
                        {
                        }
                        column(No_SalesCrMemoLineCaption;FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_SalesCrMemoLineCaption;FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesCrMemoLineCaption;FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdent_SalesCrMemoLineCaption;FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        dataitem(DimensionLoop2;Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number=FILTER(1..));
                            column(DimText1;DimText)
                            {
                            }
                            column(LineDimensionsCaption;LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                IF Number = 1 THEN BEGIN
                                  IF NOT DimSetEntry2.FIND('-') THEN
                                    CurrReport.BREAK;
                                END ELSE
                                  IF NOT Continue THEN
                                    CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                  OldDimText := DimText;
                                  IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2',DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code")
                                  ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3',DimText,
                                        DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code");
                                  IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                  END;
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem();
                            begin
                                IF NOT ShowInternalInfo THEN
                                  CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID","Sales Cr.Memo Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            NNC_TotalLineAmount += "Line Amount";
                            NNC_TotalAmountInclVat += "Amount Including VAT";
                            NNC_TotalInvDiscAmount += "Inv. Discount Amount";
                            NNC_TotalAmount += Amount;
                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                              "No." := '';

                            IF VATPostingSetup.GET("Sales Cr.Memo Line"."VAT Bus. Posting Group","Sales Cr.Memo Line"."VAT Prod. Posting Group") THEN BEGIN
                              VATAmountLine.INIT;
                              VATAmountLine."VAT Identifier" := "VAT Identifier";
                              VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                              VATAmountLine."Tax Group Code" := "Tax Group Code";
                              VATAmountLine."VAT %" := VATPostingSetup."VAT %";
                              VATAmountLine."EC %" := VATPostingSetup."EC %";
                              VATAmountLine."VAT Base" := "Sales Cr.Memo Line".Amount;
                              VATAmountLine."Amount Including VAT" := "Sales Cr.Memo Line"."Amount Including VAT";
                              VATAmountLine."Line Amount" := "Line Amount";
                              VATAmountLine."Pmt. Disc. Given Amount" := "Pmt. Disc. Given Amount";
                              VATAmountLine.SetCurrencyCode("Sales Cr.Memo Header"."Currency Code");
                              IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                              VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                              VATAmountLine."VAT Difference" := "VAT Difference";
                              VATAmountLine."EC Difference" := "EC Difference";
                              IF "Sales Cr.Memo Header"."Prices Including VAT" THEN
                                VATAmountLine."Prices Including VAT" := TRUE;
                              VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                              VATAmountLine.InsertLine;
                            END;


                            //-HEB.109
                            Descripcion := '';
                            Descripcion2 := '';
                            cCodeRefCr := '';

                            RefCruzArt.RESET;
                            RefCruzArt.SETRANGE("Cross-Reference Type",RefCruzArt."Cross-Reference Type"::Customer);
                            RefCruzArt.SETRANGE("Cross-Reference Type No.","Sales Cr.Memo Header"."Bill-to Customer No.");
                            RefCruzArt.SETRANGE("Item No.","Sales Cr.Memo Line"."No.");
                            IF RefCruzArt.FINDFIRST THEN BEGIN
                              cCodeRefCr := RefCruzArt."Cross-Reference No.";
                              Descripcion := RefCruzArt.Description;
                              Descripcion2 := RefCruzArt."Descripción 2";
                            END ELSE BEGIN
                              IF "Sales Cr.Memo Header"."Language Code" <> '' THEN BEGIN
                                recCustomer.RESET;
                                IF recCustomer.GET("Sales Cr.Memo Header"."Bill-to Customer No.") THEN
                                  IF recCustomer."Language Code" <> '' THEN
                                    cLanguage := recCustomer."Language Code";
                              END;

                              IF cLanguage <> '' THEN BEGIN
                                ItemTrans.RESET;
                                ItemTrans.SETRANGE("Item No.","Sales Cr.Memo Line"."No.");
                                ItemTrans.SETRANGE("Language Code",cLanguage);
                                IF ItemTrans.FINDFIRST THEN BEGIN
                                  cCodeRefCr := '';
                                  Descripcion := ItemTrans.Description;
                                  Descripcion2 := ItemTrans."Description 2";
                                END;
                              END;
                            END;

                            IF Descripcion = '' THEN BEGIN
                              cCodeRefCr := '';
                              Descripcion := "Sales Cr.Memo Line".Description;
                              Descripcion2 := "Sales Cr.Memo Line"."Description 2";
                            END;
                            //+HEB.109

                            //-HEB.107
                            texto := COPYSTR(Description,1,2);
                            IF texto = 'Nº' THEN
                                abono := TRUE;
                            //+HEB.107
                        end;

                        trigger OnPreDataItem();
                        begin
                            VATAmountLine.DELETEALL;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                              MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            SETRANGE("Line No.",0,"Line No.");
                            CurrReport.CREATETOTALS(Amount,"Amount Including VAT","Inv. Discount Amount","Pmt. Disc. Given Amount");

                            VATLinesCount := VATAmountLine.COUNT;
                        end;
                    }
                    dataitem(VATCounter;Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATECBase;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmtPmtDiscAmt;VATAmountLine."Invoice Discount Amount" + VATAmountLine."Pmt. Disc. Given Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineECAmt;VATAmountLine."EC Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtLineEC;VATAmountLine."EC %")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATCaption;VATAmountLineVATCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATECBaseControl105Caption;VATAmountLineVATECBaseControl105CaptionLbl)
                        {
                        }
                        column(VATAmountLineVATAmountControl106Caption;VATAmountLineVATAmountControl106CaptionLbl)
                        {
                        }
                        column(VATAmountSpecificationCaption;VATAmountSpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATIdentifierCaption;VATAmountLineVATIdentifierCaptionLbl)
                        {
                        }
                        column(VATAmountLineInvDiscBaseAmountControl130Caption;VATAmountLineInvDiscBaseAmountControl130CaptionLbl)
                        {
                        }
                        column(VATAmountLineLineAmountControl135Caption;VATAmountLineLineAmountControl135CaptionLbl)
                        {
                        }
                        column(InvandPmtDiscountsCaption;InvandPmtDiscountsCaptionLbl)
                        {
                        }
                        column(ECCaption;ECCaptionLbl)
                        {
                        }
                        column(ECAmountCaption;ECAmountCaptionLbl)
                        {
                        }
                        column(VATAmountLineVATECBaseControl113Caption;VATAmountLineVATECBaseControl113CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount",VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount",
                              VATAmountLine."EC Amount",VATAmountLine."Pmt. Disc. Given Amount");
                        end;
                    }
                    dataitem(VATClauseEntryCounter;Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATClauseVATIdentifier;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATClauseCode;VATAmountLine."VAT Clause Code")
                        {
                        }
                        column(VATClauseDescription;VATClause.Description)
                        {
                        }
                        column(VATClauseDescription2;VATClause."Description 2")
                        {
                        }
                        column(VATClauseAmount;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATClausesCaption;VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption;VATAmountLineVATIdentifierCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption;VATAmountLineVATAmountControl106CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                            IF NOT VATClause.GET(VATAmountLine."VAT Clause Code") THEN
                              CurrReport.SKIP;
                            VATClause.TranslateDescription("Sales Cr.Memo Header"."Language Code");
                        end;

                        trigger OnPreDataItem();
                        begin
                            CLEAR(VATClause);
                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY;Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALSpecLCYHeader;VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate;VALExchRate)
                        {
                        }
                        column(VALVATAmtLCY;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT1;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier1;VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Cr.Memo Header"."Posting Date","Sales Cr.Memo Header"."Currency Code",
                                "Sales Cr.Memo Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Cr.Memo Header"."Posting Date","Sales Cr.Memo Header"."Currency Code",
                                "Sales Cr.Memo Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem();
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Cr.Memo Header"."Currency Code" = '')
                            THEN
                              CurrReport.BREAK;

                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY,VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                              VALSpecLCYHeader := Text008 + Text009
                            ELSE
                              VALSpecLCYHeader := Text008 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Cr.Memo Header"."Posting Date","Sales Cr.Memo Header"."Currency Code",1);
                            CalculatedExchRate := ROUND(1 / "Sales Cr.Memo Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount",0.00001);
                            VALExchRate := STRSUBSTNO(Text010,CalculatedExchRate,CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total;Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    CurrReport.PAGENO := 1;
                    IF Number > 1 THEN BEGIN
                      CopyText := FormatDocument.GetCOPYText;
                      OutputNo += 1;
                    END;

                    NNC_TotalLineAmount := 0;
                    NNC_TotalAmountInclVat := 0;
                    NNC_TotalInvDiscAmount := 0;
                    NNC_TotalAmount := 0;
                end;

                trigger OnPostDataItem();
                begin
                    IF NOT CurrReport.PREVIEW THEN
                      CODEUNIT.RUN(CODEUNIT::"Sales Cr. Memo-Printed","Sales Cr.Memo Header");
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

                //-HEB.109
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                recCustomer.RESET;
                IF recCustomer.GET("Bill-to Customer No.") THEN BEGIN
                  IF recCustomer."Language Code" <> '' THEN BEGIN
                    IF recLanguage.GET(recCustomer."Language Code") THEN
                      CurrReport.LANGUAGE(recLanguage."Windows Language ID");
                  END;
                END;

                RegistroMercantil := CompanyInfo."Registro mercantil";

                //+HEB.109


                FormatAddressFields("Sales Cr.Memo Header");
                FormatDocumentFields("Sales Cr.Memo Header");

                DimSetEntry1.SETRANGE("Dimension Set ID","Dimension Set ID");


                //-HEB.109
                FormatAddressFields("Sales Cr.Memo Header");
                FormatDocumentFields("Sales Cr.Memo Header");

                BillToContact := "Sales Cr.Memo Header"."Bill-to Contact";
                FormatAddr.SalesCrMemoBillTo(FiscalAddr,"Sales Cr.Memo Header");
                FiscalAddr[8] := "Sales Cr.Memo Header"."VAT Registration No.";
                COMPRESSARRAY(FiscalAddr);

                //+HEB.109


                //-HEB.109
                IF "Pay-at Code" = '' THEN
                    FormatAddr.SalesCrMemoBillTo(CustAddr,"Sales Cr.Memo Header")
                  ELSE BEGIN
                    IF CustPayment.GET("Bill-to Customer No.", "Pay-at Code") THEN
                        FormatAddr.CustPmtAddress(CustAddr,CustPayment)
                      ELSE
                        FormatAddr.SalesCrMemoBillTo(CustAddr,"Sales Cr.Memo Header");
                  END;
                //+HEB.109


                //-HEB.107
                dFechaVto1 := 0D;
                dFechaVto2 := 0D;
                recCustLedgerEntry.RESET;
                recCustLedgerEntry.SETRANGE("Document No.","No.");
                recCustLedgerEntry.SETRANGE("Document Type",recCustLedgerEntry."Document Type"::Bill);
                recCustLedgerEntry.SETRANGE("Customer No.","Bill-to Customer No.");
                IF recCustLedgerEntry.FINDFIRST THEN
                  BEGIN
                     dFechaVto1 := recCustLedgerEntry."Due Date";
                     IF recCustLedgerEntry.NEXT <> 0 THEN
                        dFechaVto2 := recCustLedgerEntry."Due Date";
                  END
                ELSE dFechaVto1:= "Sales Cr.Memo Header"."Due Date";

                cNombreBanco:='';
                cIBANBanco:='';
                cCodSWIFT:='';
                recCustBankAccount.RESET;
                IF recCustBankAccount.GET("Bill-to Customer No.","Cust. Bank Acc. Code") THEN BEGIN
                  cNombreBanco := recCustBankAccount.Name;
                  cIBANBanco := recCustBankAccount.IBAN;
                  cCodSWIFT  := recCustBankAccount."SWIFT Code";
                END;

                //-HEB.999
                CLEAR(comentarios);
                vueltas:=0;
                WITH SalesCommentLine DO BEGIN
                 RESET;
                 SETRANGE("Document Type","Document Type"::"Posted Credit Memo");
                 SETRANGE("No.","Sales Cr.Memo Header"."No.");
                 IF FINDFIRST THEN
                    REPEAT
                      vueltas+=1;
                      comentarios[vueltas]:= SalesCommentLine.Comment;
                    UNTIL (NEXT=0) OR (vueltas=4);
                END;
                //+HEB.999


                //-HEB.109
                  IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    cMoneda:=GLSetup."LCY Code";
                  END ELSE BEGIN
                    cMoneda:= "Currency Code";
                  END;
                //+HEB.109

                ShowCashAccountingCriteria("Sales Cr.Memo Header");

                IF LogInteraction THEN
                  IF NOT CurrReport.PREVIEW THEN
                    IF "Bill-to Contact No." <> '' THEN
                      SegManagement.LogDocument(
                        6,"No.",0,0,DATABASE::Contact,"Bill-to Contact No.","Salesperson Code",
                        "Campaign No.","Posting Description",'')
                    ELSE
                      SegManagement.LogDocument(
                        6,"No.",0,0,DATABASE::Customer,"Sell-to Customer No.","Salesperson Code",
                        "Campaign No.","Posting Description",'');
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
                    field(ShowInternalInfo;ShowInternalInfo)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage();
        begin
            LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
        DateLbl = 'Date';InvoiceNoLbl = 'Invoice No.';CustomerLbl = 'Customer';PageLbl = 'Page';TelLbl = 'Tel.';FaxLbl = 'Fax';DocumentTypeLbl = 'CREDIT MEMO';
        ReferencesLbl = 'References';DeliveryAddressLbl = 'Delivery Address';PaymentConditionsLbl = 'Payment Conditions';DueDateLbl = 'Due Date';LineNoLbl = 'No.';LineDescriptionLbl = 'Description';LineQuantityLbl = 'Quantity';LineUnitPriceLbl = 'Unit Price';LineAmountLbl = 'Amount';RemarksLbl = 'Remarks';IncotermsLbl = 'Incoterms 2010';TotalAmountLbl = 'Total Amount';DiscountsLbl = 'Discounts';TotalVATExcLbl = 'Total (VAT Excl.)';VATpercentLbl = 'VAT %';VATAmountLbl = 'VAT Amount';TotalInvoiceLbl = 'Total Credit Note';CondicionesVentaLbl = 'Para ver las condiciones de venta acceder a';}

    trigger OnInitReport();
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents",CompanyInfo1,CompanyInfo2,CompanyInfo3);

        //-HEB.109
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture,CompanyInfo."Imagen adic. 1");
        //+HEB.109
    end;

    trigger OnPreReport();
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
          InitLogInteraction;
    end;

    var
        Text003 : Label '(Applies to %1 %2)';
        PageCaptionCap : Label 'Page %1 of %2';
        GLSetup : Record "General Ledger Setup";
        RespCenter : Record "Responsibility Center";
        SalesSetup : Record "Sales & Receivables Setup";
        SalesPurchPerson : Record "Salesperson/Purchaser";
        CompanyInfo : Record "Company Information";
        CompanyInfo1 : Record "Company Information";
        CompanyInfo2 : Record "Company Information";
        CompanyInfo3 : Record "Company Information";
        VATAmountLine : Record "VAT Amount Line" temporary;
        VATClause : Record "VAT Clause";
        DimSetEntry1 : Record "Dimension Set Entry";
        DimSetEntry2 : Record "Dimension Set Entry";
        Language : Record "Language";
        CurrExchRate : Record "Currency Exchange Rate";
        FormatAddr : Codeunit "Format Address";
        FormatDocument : Codeunit "Format Document";
        SegManagement : Codeunit "SegManagement";
        CustAddr : array [8] of Text[50];
        ShipToAddr : array [8] of Text[50];
        CompanyAddr : array [8] of Text[50];
        ReturnOrderNoText : Text[80];
        SalesPersonText : Text[30];
        VATNoText : Text[80];
        ReferenceText : Text[80];
        AppliedToText : Text;
        TotalText : Text[50];
        TotalExclVATText : Text[50];
        TotalInclVATText : Text[50];
        MoreLines : Boolean;
        NoOfCopies : Integer;
        NoOfLoops : Integer;
        CopyText : Text[30];
        ShowShippingAddr : Boolean;
        DimText : Text[120];
        OldDimText : Text[75];
        ShowInternalInfo : Boolean;
        Continue : Boolean;
        LogInteraction : Boolean;
        VALVATBaseLCY : Decimal;
        VALVATAmountLCY : Decimal;
        Text008 : Label 'VAT Amount Specification in ';
        Text009 : Label 'Local Currency';
        Text010 : Label 'Exchange rate: %1/%2';
        VALSpecLCYHeader : Text[80];
        VALExchRate : Text[50];
        CalculatedExchRate : Decimal;
        OutputNo : Integer;
        NNC_TotalLineAmount : Decimal;
        NNC_TotalAmountInclVat : Decimal;
        NNC_TotalInvDiscAmount : Decimal;
        NNC_TotalAmount : Decimal;
        VATPostingSetup : Record "VAT Posting Setup";
        Text1100001 : Label 'Sales - Corrective invoice %1';
        [InDataSet]
        LogInteractionEnable : Boolean;
        CompanyInfoPhoneNoCaptionLbl : Label 'Phone No.';
        CompanyInfoHomePageCaptionLbl : Label 'Home Page';
        CompanyInfoEMailCaptionLbl : Label 'Email';
        CompanyInfoVATRegistrationNoCaptionLbl : Label 'VAT Reg. No.';
        CompanyInfoGiroNoCaptionLbl : Label 'Giro No.';
        CompanyInfoBankNameCaptionLbl : Label 'Bank';
        CompanyInfoBankAccountNoCaptionLbl : Label 'Account No.';
        SalesCrMemoHeaderNoCaptionLbl : Label 'Credit Memo No.';
        SalesCrMemoHeaderPostingDateCaptionLbl : Label 'Posting Date';
        CorrectedInvoiceNoCaptionLbl : Label 'Corrected Invoice No.';
        DocumentDateCaptionLbl : Label 'Document Date';
        HeaderDimensionsCaptionLbl : Label 'Header Dimensions';
        UnitPriceCaptionLbl : Label 'Unit Price';
        SalesCrMemoLineLineDiscountCaptionLbl : Label 'Discount %';
        AmountCaptionLbl : Label 'Amount';
        PostedReceiptDateCaptionLbl : Label 'Posted Return Receipt Date';
        InvDiscountAmountCaptionLbl : Label 'Invoice Discount Amount';
        SubtotalCaptionLbl : Label 'Subtotal';
        PmtDiscGivenAmountCaptionLbl : Label 'Payment Discount Received Amount';
        VATClausesCap : Label 'VAT Clause';
        LineDimensionsCaptionLbl : Label 'Line Dimensions';
        VATAmountLineVATCaptionLbl : Label 'VAT %';
        VATAmountLineVATECBaseControl105CaptionLbl : Label 'VAT Base';
        VATAmountLineVATAmountControl106CaptionLbl : Label 'VAT Amount';
        VATAmountSpecificationCaptionLbl : Label 'VAT Amount Specification';
        VATAmountLineVATIdentifierCaptionLbl : Label 'VAT Identifier';
        VATAmountLineInvDiscBaseAmountControl130CaptionLbl : Label 'Invoice Discount Base Amount';
        VATAmountLineLineAmountControl135CaptionLbl : Label 'Line Amount';
        InvandPmtDiscountsCaptionLbl : Label 'Invoice and Payment Discounts';
        ECCaptionLbl : Label 'EC %';
        ECAmountCaptionLbl : Label 'EC Amount';
        VATAmountLineVATECBaseControl113CaptionLbl : Label 'Total';
        ShiptoAddressCaptionLbl : Label 'Ship-to Address';
        CACCaptionLbl : Text;
        CACTxt : Label 'RÚgimen especial del criterio de caja';
        recCustomer : Record "Customer";
        recLanguage : Record "Language";
        RegistroMercantil : Text[250];
        TextTipoDoc : Label 'CREDIT NOTE';
        txtMercantil : Label '%1 Registro Mercantil de Barcelona, Hoja %2, Folio %3, Tomo %4 - NIF/VAT: ES-%5';
        CustPayment : Record "Customer Pmt. Address";
        dFechaVto1 : Date;
        dFechaVto2 : Date;
        recCustLedgerEntry : Record "Cust. Ledger Entry";
        cIBANBanco : Code[50];
        recCustBankAccount : Record "Customer Bank Account";
        cCodSWIFT : Text[100];
        comentarios : array [4] of Text[80];
        vueltas : Integer;
        SalesCommentLine : Record "Sales Comment Line";
        cMoneda : Code[10];
        Descripcion : Text[50];
        Descripcion2 : Text[50];
        cCodeRefCr : Code[20];
        RefCruzArt : Record "Item Cross Reference";
        ItemTrans : Record "Item Translation";
        cLanguage : Code[10];
        PaymentTerms : Record "Payment Terms";
        PaymentMethod : Record "Payment Method";
        BillToContact : Text[50];
        FiscalAddr : array [8] of Text[50];
        VATLinesCount : Integer;
        texto : Text[30];
        abono : Boolean;
        cNombreBanco : Text[100];
        cDirBanco : Text[100];

    procedure InitLogInteraction();
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
    end;

    procedure ShowCashAccountingCriteria(SalesCrMemoHeader : Record "Sales Cr.Memo Header") : Text;
    var
        VATEntry : Record "VAT Entry";
    begin
        GLSetup.GET;
        IF NOT GLSetup."Unrealized VAT" THEN
          EXIT;
        CACCaptionLbl := '';
        VATEntry.SETRANGE("Document No.",SalesCrMemoHeader."No.");
        VATEntry.SETRANGE("Document Type",VATEntry."Document Type"::"Credit Memo");
        IF VATEntry.FINDSET THEN
          REPEAT
            IF VATEntry."VAT Cash Regime" THEN
              CACCaptionLbl := CACTxt;
          UNTIL (VATEntry.NEXT = 0) OR (CACCaptionLbl <> '');
        EXIT(CACCaptionLbl);
    end;

    procedure InitializeRequest(NewNoOfCopies : Integer;NewShowInternalInfo : Boolean;NewLogInteraction : Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;

    local procedure FormatAddressFields(var SalesCrMemoHeader : Record "Sales Cr.Memo Header");
    begin
        FormatAddr.GetCompanyAddr(SalesCrMemoHeader."Responsibility Center",RespCenter,CompanyInfo,CompanyAddr);
        FormatAddr.SalesCrMemoBillTo(CustAddr,SalesCrMemoHeader);
        ShowShippingAddr := FormatAddr.SalesCrMemoShipTo(ShipToAddr,CustAddr,SalesCrMemoHeader);
    end;

    local procedure FormatDocumentFields(SalesCrMemoHeader : Record "Sales Cr.Memo Header");
    begin
        WITH SalesCrMemoHeader DO BEGIN
          FormatDocument.SetTotalLabels("Currency Code",TotalText,TotalInclVATText,TotalExclVATText);
          FormatDocument.SetSalesPerson(SalesPurchPerson,"Salesperson Code",SalesPersonText);

          ReturnOrderNoText := FormatDocument.SetText("Return Order No." <> '',FIELDCAPTION("Return Order No."));
          ReferenceText := FormatDocument.SetText("Your Reference" <> '',FIELDCAPTION("Your Reference"));
          VATNoText := FormatDocument.SetText("VAT Registration No." <> '',FIELDCAPTION("VAT Registration No."));
          AppliedToText :=
            FormatDocument.SetText(
              "Applies-to Doc. No." <> '',FORMAT(STRSUBSTNO(Text003,FORMAT("Applies-to Doc. Type"),"Applies-to Doc. No.")));
        END;
    end;
}