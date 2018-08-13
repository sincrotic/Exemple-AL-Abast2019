report 50045 "Sales - ProForma"
{
    // version NAVW111.00.00.20783,NAVES11.00.00.20783

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Sales - ProForma.rdlc';
    Caption = 'Sales - ProForma';
    EnableHyperlinks = true;
    Permissions = TableData 7190=rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header";"Sales Header")
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Document Type"=CONST(Quote));
            RequestFilterFields = "No.","Sell-to Customer No.","No. Printed";
            RequestFilterHeading = 'Sales ProForma (Quotes)';
            column(No_SalesInvHdr;"No.")
            {
            }
            column(DocDate_SalesInvHdr;FORMAT("Document Date",0,'<Day,2>/<Month,2>/<Year,2>'))
            {
            }
            column(BillToCustomerNo_SalesInvHdr;"Bill-to Customer No.")
            {
            }
            column(ExtDocNo_SalesInvHdr;"External Document No.")
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
            column(CompanyInfoCounty;CompanyInfo.County + ' - Spain')
            {
            }
            column(CompanyInfoTel;CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoFax;CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfoHomePage;CompanyInfo."Home Page")
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
            column(cNombreBanco;cNombreBanco)
            {
            }
            column(cDirBanco;cDirBanco)
            {
            }
            column(cCodSWIFT;cCodSWIFT)
            {
            }
            column(cIBANBanco;cIBANBanco)
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
            column(cDatosTransporte;cDatosTransporte)
            {
            }
            column(cCustomsTariff;cCustomsTariff)
            {
            }
            column(txtIncoterms;txtIncoterms)
            {
            }
            column(RegistroMercantil;RegistroMercantil)
            {
            }
            column(PaymentTermsDescription;PaymentTerms.Description)
            {
            }
            column(ShipmentMethodDescription;ShipmentMethod.Description)
            {
            }
            column(PaymentMethodDescription;PaymentMethod.Description)
            {
            }
            column(PmtTermsDescCaption;PmtTermsDescCaptionLbl)
            {
            }
            column(ShpMethodDescCaption;ShpMethodDescCaptionLbl)
            {
            }
            column(PmtMethodDescCaption;PmtMethodDescCaptionLbl)
            {
            }
            column(DocDateCaption;DocDateCaptionLbl)
            {
            }
            column(HomePageCaption;HomePageCaptionLbl)
            {
            }
            column(EmailCaption;EmailCaptionLbl)
            {
            }
            column(DisplayAdditionalFeeNote;DisplayAdditionalFeeNote)
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
                    column(CompanyInfo1Picture;CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo2Picture;CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo3Picture;CompanyInfo."Imagen adic. 1")
                    {
                    }
                    column(CondicionesVentaURL;CompanyInfo."Sales URL Terms")
                    {
                    }
                    column(CondicionesMercancia;CompanyInfo."Condiciones Mercancía")
                    {
                    }
                    column(ResponsabilidadMercancia;CompanyInfo."Responsabilidad Mercancía")
                    {
                    }
                    column(EntregaBienes;CompanyInfo."Entrega Bienes")
                    {
                    }
                    column(ModificacionDatos;CompanyInfo."Modificación Datos")
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
                    column(CompanyInfoVATRegistrationNo;CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoEmail;CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoGiroNo;CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName;CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo;CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesInvHdr;"Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr;FORMAT("Sales Header"."Posting Date",0,4))
                    {
                    }
                    column(VATNoText;VATNoText)
                    {
                    }
                    column(VATRegNo_SalesHeader;"Sales Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvHeader;FORMAT("Sales Header"."Due Date",0,4))
                    {
                    }
                    column(SalesPersonText;SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName;SalesPurchPerson.Name)
                    {
                    }
                    column(No_SalesInvoiceHeader1;"Sales Header"."No.")
                    {
                    }
                    column(ReferenceText;ReferenceText)
                    {
                    }
                    column(YourReference_SalesInvHdr;"Sales Header"."Your Reference")
                    {
                    }
                    column(OrderNoText;OrderNoText)
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
                    column(DocDate_SalesInvoiceHdr;FORMAT("Sales Header"."Document Date",0,4))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr;"Sales Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo;OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo;FORMAT("Sales Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption;PageCaptionCap)
                    {
                    }
                    column(PhoneNoCaption;PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption;VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption;GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption;BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption;BankAccNoCaptionLbl)
                    {
                    }
                    column(DueDateCaption;DueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption;InvoiceNoCaptionLbl)
                    {
                    }
                    column(PostingDateCaption;PostingDateCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesInvHdrCaption;"Sales Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdrCaption;"Sales Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(CACCaption;CACCaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1;Integer)
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=FILTER(1..));
                        column(DimText;DimText)
                        {
                        }
                        column(Number_DimensionLoop1;Number)
                        {
                        }
                        column(HdrDimsCaption;HdrDimsCaptionLbl)
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
                    dataitem("Sales Line";"Sales Line")
                    {
                        DataItemLink = "Document Type"=FIELD("Document Type"),
                                       "Document No."=FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document No.","Line No.");
                        column(Descripcion;Descripcion)
                        {
                        }
                        column(cCodeRefCr;cCodeRefCr)
                        {
                        }
                        column(Description;Description)
                        {
                        }
                        column(Quantity;Quantity)
                        {
                        }
                        column(cMoneda;cMoneda)
                        {
                        }
                        column(cMonedaLinea;cMonedaLinea)
                        {
                        }
                        column(Descripcion2;Descripcion2)
                        {
                        }
                        column(Description2;"Description 2")
                        {
                        }
                        column(albaran;albaran)
                        {
                        }
                        column(VATLinesCount;VATLinesCount)
                        {
                        }
                        column(Unit_Of_Measure_Code;"Sales Line"."Unit of Measure Code")
                        {
                        }
                        column(LineAmt_SalesInvoiceLine;"Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Description_SalesInvLine;Description)
                        {
                        }
                        column(No_SalesInvoiceLine;"No.")
                        {
                        }
                        column(Quantity_SalesInvoiceLine;Quantity)
                        {
                        }
                        column(UOM_SalesInvoiceLine;"Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine;"Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDisc_SalesInvoiceLine;"Line Discount %")
                        {
                        }
                        column(VATIdent_SalesInvLine;"VAT Identifier")
                        {
                        }
                        column(PostedShipmentDate;FORMAT("Shipment Date"))
                        {
                        }
                        column(Type_SalesInvoiceLine;FORMAT(Type))
                        {
                        }
                        column(InvDiscountAmount;-"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal;TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount;TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount;TotalAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalGivenAmount;TotalGivenAmount)
                        {
                        }
                        column(SalesInvoiceLineAmount;Amount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVATAmount;"Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Amount_SalesInvoiceLineIncludingVAT;"Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText;VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText;TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText;TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT;TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountVAT;TotalAmountVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDisc_SalesInvHdr;"Sales Header"."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscountOnVAT;TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATCalcType;VATAmountLine."VAT Calculation Type")
                        {
                        }
                        column(LineNo_SalesInvoiceLine;"Line No.")
                        {
                        }
                        column(PmtinvfromdebtpaidtoFactCompCaption;PmtinvfromdebtpaidtoFactCompCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption;UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscountCaption;DiscountCaptionLbl)
                        {
                        }
                        column(AmtCaption;AmtCaptionLbl)
                        {
                        }
                        column(PostedShpDateCaption;PostedShpDateCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption;InvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption;SubtotalCaptionLbl)
                        {
                        }
                        column(PmtDiscGivenAmtCaption;PmtDiscGivenAmtCaptionLbl)
                        {
                        }
                        column(PmtDiscVATCaption;PmtDiscVATCaptionLbl)
                        {
                        }
                        column(Description_SalesInvLineCaption;FIELDCAPTION(Description))
                        {
                        }
                        column(No_SalesInvoiceLineCaption;FIELDCAPTION("No."))
                        {
                        }
                        column(Quantity_SalesInvoiceLineCaption;FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesInvoiceLineCaption;FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdent_SalesInvLineCaption;FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(IsLineWithTotals;LineNoWithTotal = "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            IF (Type<>Type::" ") AND (Quantity=0) THEN
                              CurrReport.SKIP;

                            PostedShipmentDate := WORKDATE;

                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                              "No." := '';

                            IF VATPostingSetup.GET("Sales Line"."VAT Bus. Posting Group","Sales Line"."VAT Prod. Posting Group") THEN BEGIN
                              VATAmountLine.INIT;
                              VATAmountLine."VAT Identifier" := "VAT Identifier";
                              VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                              VATAmountLine."Tax Group Code" := "Tax Group Code";
                              VATAmountLine."VAT %" := VATPostingSetup."VAT %";
                              VATAmountLine."EC %" := VATPostingSetup."EC %";
                              VATAmountLine."VAT Base" := "Sales Line".Amount;
                              VATAmountLine."Amount Including VAT" := "Sales Line"."Amount Including VAT";
                              VATAmountLine."Line Amount" := "Line Amount";
                              VATAmountLine."Pmt. Disc. Given Amount" := "Pmt. Disc. Given Amount";
                              IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                              //Toni//VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                              VATAmountLine."Invoice Discount Amount" := VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code","Sales Header"."Prices Including VAT");
                              VATAmountLine.SetCurrencyCode("Sales Header"."Currency Code");
                              VATAmountLine."VAT Difference" := "VAT Difference";
                              VATAmountLine."EC Difference" := "EC Difference";
                              IF "Sales Header"."Prices Including VAT" THEN
                                VATAmountLine."Prices Including VAT" := TRUE;
                              VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                              VATAmountLine.InsertLine;
                              CalcVATAmountLineLCY("Sales Header",VATAmountLine,TempVATAmountLineLCY,VATBaseRemainderAfterRoundingLCY,AmtInclVATRemainderAfterRoundingLCY);

                              TotalSubTotal += "Line Amount";
                              TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                              TotalAmount += Amount;
                              TotalAmountVAT += "Amount Including VAT" - Amount;
                              TotalAmountInclVAT += "Amount Including VAT";
                              TotalGivenAmount -= "Pmt. Disc. Given Amount";
                              TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Pmt. Disc. Given Amount" - "Amount Including VAT");
                            END;

                             //-107
                              Descripcion := '';
                              Descripcion2 := '';
                              cCodeRefCr := '';

                              RefCruzArt.RESET;
                              RefCruzArt.SETRANGE("Cross-Reference Type",RefCruzArt."Cross-Reference Type"::Customer);
                              //999- La referencia cruzada tiene que ser la misma que la del envio.
                              //RefCruzArt.SETRANGE("Cross-Reference Type No.","Sales Invoice Header"."Bill-to Customer No.");
                              RefCruzArt.SETRANGE("Cross-Reference Type No.","Sales Header"."Sell-to Customer No.");
                              RefCruzArt.SETRANGE("Item No.","Sales Line"."No.");
                              IF RefCruzArt.FINDFIRST THEN BEGIN
                                cCodeRefCr := RefCruzArt."Cross-Reference No.";
                                Descripcion := RefCruzArt.Description;
                                Descripcion2 := RefCruzArt."Descripción 2";
                              END ELSE BEGIN
                                IF "Sales Header"."Language Code" <> '' THEN BEGIN
                                    recCustomer.RESET;
                                    IF recCustomer.GET("Sales Header"."Bill-to Customer No.") THEN
                                      IF recCustomer."Language Code" <> '' THEN
                                        cLanguage := recCustomer."Language Code";
                              END;

                              IF cLanguage <> '' THEN BEGIN
                                  ItemTrans.RESET;
                                  ItemTrans.SETRANGE("Item No.","Sales Line"."No.");
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
                              Descripcion := "Sales Line".Description;
                              Descripcion2 := "Sales Line"."Description 2";
                              END;
                              //+107

                              IF "Unit Price" = 0 THEN cMonedaLinea:='' ELSE cMonedaLinea:=cMoneda;


                              //-HEB.107
                              texto := COPYSTR(Description,1,2);
                              IF texto = 'Nº' THEN
                                  albaran := TRUE;
                              //+HEB.107
                        end;

                        trigger OnPostDataItem();
                        begin
                            VATLinesCount := VATAmountLine.COUNT;
                        end;

                        trigger OnPreDataItem();
                        begin
                            VATAmountLine.DELETEALL;
                            TempVATAmountLineLCY.DELETEALL;
                            VATBaseRemainderAfterRoundingLCY := 0;
                            AmtInclVATRemainderAfterRoundingLCY := 0;
                            SalesShipmentBuffer.RESET;
                            SalesShipmentBuffer.DELETEALL;
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                              MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            LineNoWithTotal := "Line No.";
                            SETRANGE("Line No.",0,"Line No.");
                            //CurrReport.CREATETOTALS("Line Amount",Amount,"Amount Including VAT","Inv. Discount Amount","Pmt. Disc. Given Amount");
                        end;
                    }
                    dataitem(VATCounter;Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(InvoiceDiscountAmount;VATAmountLine."Invoice Discount Amount")
                        {
                        }
                        column(PmtDiscGivenAmount;VATAmountLine."Pmt. Disc. Given Amount")
                        {
                        }
                        column(VATAmountLineVATBase;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount;VATAmountLine."VAT Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineLineAmount;VATAmountLine."Line Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscountAmt;VATAmountLine."Invoice Discount Amount" + VATAmountLine."Pmt. Disc. Given Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineECAmount;VATAmountLine."EC Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLineEC;VATAmountLine."EC %")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATCaption;VATAmtLineVATCaptionLbl)
                        {
                        }
                        column(VATECBaseCaption;VATECBaseCaptionLbl)
                        {
                        }
                        column(VATAmountCaption;VATAmountCaptionLbl)
                        {
                        }
                        column(VATAmtSpecCaption;VATAmtSpecCaptionLbl)
                        {
                        }
                        column(VATIdentCaption;VATIdentCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption;InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption1;LineAmtCaption1Lbl)
                        {
                        }
                        column(InvPmtDiscCaption;InvPmtDiscCaptionLbl)
                        {
                        }
                        column(ECAmtCaption;ECAmtCaptionLbl)
                        {
                        }
                        column(ECCaption;ECCaptionLbl)
                        {
                        }
                        column(TotalCaption;TotalCaptionLbl)
                        {
                        }
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
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATClausesCaption;VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption;VATIdentifierCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption;VATAmtCaptionLbl)
                        {
                        }
                        column(VALSpecLCYHeader;VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate;VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT1;TempVATAmountLineLCY."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier1;TempVATAmountLineLCY."VAT Identifier")
                        {
                        }
                        column(VALVATBaseLCYCaption1;VALVATBaseLCYCaption1Lbl)
                        {
                        }
                        column(SelltoCustNo_SalesInvHdr;"Sales Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShiptoAddressCaption;ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesInvHdrCaption;"Sales Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                            IF VATAmountLine."VAT Amount" = 0 THEN
                              VATAmountLine."VAT %" := 0;
                            IF VATAmountLine."EC Amount" = 0 THEN
                              VATAmountLine."EC %" := 0;
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
                }

                trigger OnAfterGetRecord();
                begin
                    IF Number > 1 THEN BEGIN
                      CopyText := FormatDocument.GetCOPYText;
                      OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalGivenAmount := 0;
                    TotalPaymentDiscountOnVAT := 0;
                end;

                trigger OnPostDataItem();
                begin
                    IF NOT CurrReport.PREVIEW THEN
                      CODEUNIT.RUN(CODEUNIT::"Sales-Printed","Sales Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    IF NoOfLoops <= 0 THEN
                      NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number,1,NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord();
            var
                CustPayment : Record "Customer Pmt. Address";
                SalesCommentLine : Record "Sales Comment Line";
                vueltas : Integer;
                blnEncontrado : Boolean;
                recAlmacenSalida : Record Location;
            begin
                 //-HEB.107
                 CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                 recCustomer.RESET;
                 IF recCustomer.GET("Bill-to Customer No.") THEN BEGIN
                    IF recCustomer."Language Code" <> '' THEN BEGIN
                        IF recLanguage.GET(recCustomer."Language Code") THEN
                            CurrReport.LANGUAGE(recLanguage."Windows Language ID");
                    END;
                 END;

                 RegistroMercantil := CompanyInfo."Registro Mercantil";
                 //+HEB.107

                 //-HEB.001
                 IF recCustomer."Usar Registro Merc. Sueco" THEN BEGIN
                    RegistroMercantil := STRSUBSTNO(txtMercantilSuecia,CompanyInfo.Name,CompanyInfo."Swedish VAT Registration No.");
                 END;
                 //+HEB.001

                FormatAddressFields("Sales Header");
                FormatDocumentFields("Sales Header");


                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                END;

                IF NOT Cust.GET("Bill-to Customer No.") THEN
                  CLEAR(Cust);

                DimSetEntry1.SETRANGE("Dimension Set ID","Dimension Set ID");


                //-HEB.107
                BillToContact := "Sales Header"."Bill-to Contact";
                FormatAddr.SalesHeaderBillTo(FiscalAddr,"Sales Header");
                FiscalAddr[8] := "Sales Header"."VAT Registration No.";
                COMPRESSARRAY(FiscalAddr);

                IF "Pay-at Code" = '' THEN
                    FormatAddr.SalesHeaderBillTo(CustAddr,"Sales Header")
                ELSE BEGIN
                    IF CustPmtAddress.GET("Bill-to Customer No.", "Pay-at Code") THEN
                        FormatAddr.FormatAddr(CustAddr,CustPmtAddress.Name,CustPmtAddress."Name 2",'',CustPmtAddress.Address,CustPmtAddress."Address 2",CustPmtAddress.City,CustPmtAddress."Post Code",CustPmtAddress.County,CustPmtAddress."Country/Region Code")
                    ELSE
                        FormatAddr.SalesHeaderBillTo(CustAddr,"Sales Header");
                END;


                recSlsLine.RESET;
                recSlsLine.SETRANGE("Document No.","No.");
                IF recSlsLine.FINDFIRST THEN
                    REPEAT
                        recItem.RESET;
                        IF recItem.GET(recSlsLine."No.") THEN
                        BEGIN
                            nPos := STRPOS(cCustomsTariff,recItem."Tariff No.");
                            IF nPos = 0 THEN
                                cCustomsTariff := cCustomsTariff + '      ' + recItem."Tariff No.";
                        END
                    UNTIL recSlsLine.NEXT = 0;


                txtIncoterms:='';
                cPoblacionDeliveryAddr:='';
                cCodPaisDeliveryAddr:='';

                recSalesLine.RESET;
                recSalesLine.SETRANGE("Document No.", "Sales Header"."No.");
                recSalesLine.SETFILTER("Shipment No.", '<>%1', '');
                IF recSalesLine.FINDFIRST THEN BEGIN
                    recAlbaranVta.RESET;
                    recAlbaranVta.SETRANGE("No.", recSalesLine."Shipment No.");
                    IF recAlbaranVta.FINDFIRST THEN BEGIN
                        cPoblacionDeliveryAddr := recAlbaranVta."Ship-to City";
                        cCodPaisDeliveryAddr := recAlbaranVta."Ship-to Country/Region Code";
                        WITH recAlbaranVta DO
                        BEGIN
                            FormatAddress.FormatAddr(
                            ShipToAddr, "Ship-to Name", "Ship-to Name 2", '', "Ship-to Address", "Ship-to Address 2",
                            "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code");
                            CalculaIncoterms("Exit Point", "Shipment Method Code");
                        END
                    END
                    ELSE BEGIN
                        cPoblacionDeliveryAddr := "Ship-to City";
                        cCodPaisDeliveryAddr := "Ship-to Country/Region Code";
                        FormatAddress.FormatAddr(
                        ShipToAddr, "Ship-to Name", "Ship-to Name 2", '', "Ship-to Address", "Ship-to Address 2",
                        "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code");
                        CalculaIncoterms("Exit Point", "Shipment Method Code");
                    END
                END
                ELSE BEGIN
                    cPoblacionDeliveryAddr := "Ship-to City";
                    cCodPaisDeliveryAddr := "Ship-to Country/Region Code";

                    FormatAddress.FormatAddr(
                    ShipToAddr, "Ship-to Name", "Ship-to Name 2", '', "Ship-to Address", "Ship-to Address 2",
                    "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code");

                    CalculaIncoterms("Exit Point", "Shipment Method Code");
                END;

                dFechaVto1 := 0D;
                dFechaVto1 := "Sales Header"."Due Date";

                cNombreBanco:='';
                cIBANBanco:='';
                cCodSWIFT:='';
                 IF CompanyInfo."Código F.Pago asociada" = "Payment Method Code" THEN BEGIN
                    recCustBankAccount.RESET;
                 IF recCustBankAccount.GET("Bill-to Customer No.","Cust. Bank Acc. Code") THEN BEGIN
                    cNombreBanco := recCustBankAccount.Name+ ' Acc. Number: ' + recCustBankAccount."Bank Branch No." + ' ' +
                                    recCustBankAccount."Bank Account No.";
                    cDirBanco  := recCustBankAccount.Address + recCustBankAccount."Address 2" + ' ' + recCustBankAccount."Post Code" +
                                ' ' + recCustBankAccount.City + ' (' +recCustBankAccount.County + ') ' + 'SPAIN';
                    cIBANBanco := 'IBAN No.: ' + recCustBankAccount.IBAN;
                    cCodSWIFT  := 'Bank Swift Code: ' + recCustBankAccount."SWIFT Code";
                 END;
                  END ELSE BEGIN
                     recCustBankAccount.RESET;
                     IF recCustBankAccount.GET("Bill-to Customer No.","Cust. Bank Acc. Code") THEN BEGIN
                         cNombreBanco := recCustBankAccount.Name;
                         cIBANBanco := recCustBankAccount.IBAN;
                         cCodSWIFT  := recCustBankAccount."SWIFT Code";
                     END;
                  END;

                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    cMoneda:=GLSetup."LCY Code";
                END ELSE BEGIN
                    cMoneda := "Currency Code";
                END;

                //-998
                recTransportMethod.RESET;
                cTransportMethodDesc := '';
                IF recTransportMethod.GET("Transport Method") THEN
                    cTransportMethodDesc := recTransportMethod.Description;

                recCountry.RESET;
                CLEAR(recCountry);
                CLEAR(recAlmacenSalida);
                cPaisNombreOrigen := '';
                cPaisNombreDestino:= '';
                blnEncontrado:=FALSE;

                recSalesLine.RESET;
                recSalesLine.SETRANGE("Document No.","Sales Header"."No.");
                recSalesLine.SETRANGE(Type,recSalesLine.Type::Item);
                IF recSalesLine.FINDFIRST THEN
                REPEAT
                    IF recAlmacenSalida.GET(recSalesLine."Location Code") THEN blnEncontrado:=TRUE;
                UNTIL (recSalesLine.NEXT=0) OR (blnEncontrado);

                IF blnEncontrado THEN
                    IF recCountry.GET(recAlmacenSalida."Country/Region Code") THEN cPaisNombreOrigen := recCountry.Name;
                IF recCountry.GET(cCodPaisDeliveryAddr) THEN  cPaisNombreDestino := recCountry.Name;

                cDatosTransporte:=STRSUBSTNO(txtDatosTransporte, cTransportMethodDesc,
                                            recAlmacenSalida.City, cPaisNombreOrigen,
                                            cPoblacionDeliveryAddr,cPaisNombreDestino);


                //+998

                cCustomsTariff := '';
                nPos := 0;
                recSlsLine.RESET;
                recSlsLine.SETRANGE("Document No.","No.");
                IF recSlsLine.FINDFIRST THEN
                    REPEAT
                        recItem.RESET;
                        IF recItem.GET(recSlsLine."No.") THEN
                            BEGIN
                                nPos := STRPOS(cCustomsTariff,recItem."Tariff No.");
                                IF nPos = 0 THEN
                                    cCustomsTariff := cCustomsTariff + '      ' + recItem."Tariff No.";
                        END
                UNTIL recSlsLine.NEXT = 0;
                //+HEB.107

                //-999
                CLEAR(comentarios);
                vueltas:=0;
                WITH SalesCommentLine DO BEGIN
                    RESET;
                    SETRANGE("Document Type","Document Type"::Quote);
                    SETRANGE("No.","Sales Header"."No.");
                    IF FINDFIRST THEN
                        REPEAT
                            vueltas+=1;
                            comentarios[vueltas]:= SalesCommentLine.Comment;
                        //UNTIL (NEXT=0) OR (vueltas=3); //-236
                        UNTIL (NEXT=0) OR (vueltas=4);   //-236
                END;
                //+999

                GetLineFeeNoteOnReportHist("No.");

                IF LogInteraction THEN
                  IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF "Bill-to Contact No." <> '' THEN
                      SegManagement.LogDocument(
                        SegManagement.SalesInvoiceInterDocType,"No.",0,0,DATABASE::Contact,"Bill-to Contact No.","Salesperson Code",
                        "Campaign No.","Posting Description",'')
                    ELSE
                      SegManagement.LogDocument(
                        SegManagement.SalesInvoiceInterDocType,"No.",0,0,DATABASE::Customer,"Bill-to Customer No.","Salesperson Code",
                        "Campaign No.","Posting Description",'');
                  END;

                OnAfterGetRecordSalesHeader("Sales Header");
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
                    Caption ='Options';
                    field(NoOfCopies;NoOfCopies)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'No. of Copies';
                        ToolTip ='Specifies how many copies of the document to print.';
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
                    field(DisplayAsmInformation;DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption ='Show Assembly Components';
                        ToolTip ='Specifies if you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold.';
                    }
                    field(DisplayAdditionalFeeNote;DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Additional Fee Note';
                        ToolTip = 'Specifies that any notes about additional fees are included on the document.';
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
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
        DateLbl = 'Date';
        InvoiceNoLbl = 'ProForma No.';
        CustomerLbl = 'Customer';
        PageLbl = 'Page';
        TelLbl = 'Tel.';
        FaxLbl = 'Fax';
        DocumentTypeLbl = 'PRO-FORMA';
        ReferencesLbl = 'References';
        DeliveryAddressLbl = 'Delivery Address';
        PaymentConditionsLbl = 'Payment Conditions';
        DueDateLbl = 'Due Date';
        LineNoLbl = 'No.';LineDescriptionLbl = 'Description';
        LineQuantityLbl = 'Quantity';
        LineUnitPriceLbl = 'Unit Price';
        LineAmountLbl = 'Amount';
        RemarksLbl = 'Remarks';
        TransportLbl = 'Transport';
        CustomsTariffLbl = 'Customs Tariff';
        IncotermsLbl = 'Incoterms 2010';
        TotalAmountLbl = 'Total Amount';
        DiscountsLbl = 'Discounts';
        TotalVATExcLbl = 'Total (VAT Excl.)';
        VATpercentLbl = 'VAT %';
        VATAmountLbl = 'VAT Amount';
        TotalInvoiceLbl = 'Total Invoice';
        CondicionesVentaLbl = 'Para ver las condiciones de venta acceder a';
        }

    trigger OnInitReport();
    begin
        GLSetup.GET;
        SalesSetup.GET;
        CompanyInfo.GET;
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents",CompanyInfo1,CompanyInfo2,CompanyInfo3);

        //-105
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
        //+105

        //-HEB.509
        CompanyInfo.CALCFIELDS(CompanyInfo."Imagen adic. 1");
        //+HEB.509
    end;

    trigger OnPreReport();
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
          InitLogInteraction;
    end;

    var
        PageCaptionCap : Label 'Page %1 of %2';
        GLSetup : Record "General Ledger Setup";
        ShipmentMethod : Record "Shipment Method";
        PaymentTerms : Record "Payment Terms";
        PrepmtPaymentTerms : Record "Payment Terms";
        SalesPurchPerson : Record "Salesperson/Purchaser";
        CompanyInfo : Record "Company Information";
        CompanyInfo1 : Record "Company Information";
        CompanyInfo2 : Record "Company Information";
        CompanyInfo3 : Record "Company Information";
        SalesSetup : Record "Sales & Receivables Setup";
        SalesShipmentBuffer : Record "Sales Shipment Buffer" temporary;
        Cust : Record Customer;
        VATAmountLine : Record "VAT Amount Line" temporary;
        TempVATAmountLineLCY : Record "VAT Amount Line" temporary;
        DimSetEntry1 : Record "Dimension Set Entry";
        DimSetEntry2 : Record "Dimension Set Entry";
        RespCenter : Record "Responsibility Center";
        Language : Record Language;
        CurrExchRate : Record "Currency Exchange Rate";
        TempPostedAsmLine : Record "Posted Assembly Line" temporary;
        VATClause : Record "VAT Clause";
        TempLineFeeNoteOnReportHist : Record "Line Fee Note on Report Hist." temporary;
        FormatAddr : Codeunit "Format Address";
        FormatDocument : Codeunit "Format Document";
        SegManagement : Codeunit SegManagement;
        CustAddr : array [8] of Text[50];
        ShipToAddr : array [8] of Text[50];
        CompanyAddr : array [8] of Text[50];
        OrderNoText : Text[80];
        SalesPersonText : Text[30];
        VATNoText : Text[80];
        ReferenceText : Text[80];
        TotalText : Text[50];
        TotalExclVATText : Text[50];
        TotalInclVATText : Text[50];
        MoreLines : Boolean;
        NoOfCopies : Integer;
        NoOfLoops : Integer;
        CopyText : Text[30];
        ShowShippingAddr : Boolean;
        NextEntryNo : Integer;
        FirstValueEntryNo : Integer;
        DimText : Text[120];
        OldDimText : Text[75];
        ShowInternalInfo : Boolean;
        Continue : Boolean;
        LogInteraction : Boolean;
        VALVATBaseLCY : Decimal;
        VALVATAmountLCY : Decimal;
        VALSpecLCYHeader : Text[80];
        Text007 : Label 'VAT Amount Specification in ';
        Text008 : Label 'Local Currency';
        VALExchRate : Text[50];
        Text009 : Label 'Exchange rate: %1/%2';
        CalculatedExchRate : Decimal;
        Text010 : Label 'Sales - Prepayment Invoice %1';
        OutputNo : Integer;
        TotalSubTotal : Decimal;
        TotalAmount : Decimal;
        TotalAmountInclVAT : Decimal;
        TotalAmountVAT : Decimal;
        TotalInvoiceDiscountAmount : Decimal;
        TotalPaymentDiscountOnVAT : Decimal;
        VATPostingSetup : Record "VAT Posting Setup";
        PaymentMethod : Record "Payment Method";
        TotalGivenAmount : Decimal;
        [InDataSet]
        LogInteractionEnable : Boolean;
        DisplayAssemblyInformation : Boolean;
        PhoneNoCaptionLbl : Label 'Phone No.';
        VATRegNoCaptionLbl : Label 'VAT Registration No.';
        GiroNoCaptionLbl : Label 'Giro No.';
        BankNameCaptionLbl : Label 'Bank';
        BankAccNoCaptionLbl : Label 'Account No.';
        DueDateCaptionLbl : Label 'Due Date';
        InvoiceNoCaptionLbl : Label 'Invoice No.';
        PostingDateCaptionLbl : Label 'Posting Date';
        HdrDimsCaptionLbl : Label 'Header Dimensions',;
        PmtinvfromdebtpaidtoFactCompCaptionLbl : Label 'The payment of this invoice, in order to be released from the debt, has to be paid to the Factoring Company.';
        UnitPriceCaptionLbl : Label 'Unit Price';
        DiscountCaptionLbl : Label 'Discount %';
        AmtCaptionLbl : Label 'Amount';
        VATClausesCap : Label 'VAT Clause';
        PostedShpDateCaptionLbl : Label 'Posted Shipment Date';
        InvDiscAmtCaptionLbl : Label 'Invoice Discount Amount';
        SubtotalCaptionLbl : Label 'Subtotal';
        PmtDiscGivenAmtCaptionLbl : Label 'Payment Disc Given Amount';
        PmtDiscVATCaptionLbl : Label 'Payment Discount on VAT';
        ShpCaptionLbl : Label 'Shipment';
        LineDimsCaptionLbl : Label 'Line Dimensions';
        VATAmtLineVATCaptionLbl : Label 'VAT %';
        VATECBaseCaptionLbl : Label 'VAT+EC Base';
        VATAmountCaptionLbl : Label 'VAT Amount';
        VATAmtSpecCaptionLbl : Label 'VAT Amount Specification';
        VATIdentCaptionLbl : Label 'VAT Identifier';
        InvDiscBaseAmtCaptionLbl : Label 'Invoice Discount Base Amount';
        LineAmtCaption1Lbl : Label 'Line Amount';
        InvPmtDiscCaptionLbl : Label 'Invoice and Payment Discounts';
        ECAmtCaptionLbl : Label 'EC Amount';
        ECCaptionLbl : Label 'EC %';
        TotalCaptionLbl : Label 'Total';
        VALVATBaseLCYCaption1Lbl : Label 'VAT Base';
        VATAmtCaptionLbl : Label 'VAT Amount';
        VATIdentifierCaptionLbl : Label 'VAT Identifier';
        ShiptoAddressCaptionLbl : Label 'Ship-to Address';
        PmtTermsDescCaptionLbl : Label 'Payment Terms';
        ShpMethodDescCaptionLbl : Label 'Shipment Method';
        PmtMethodDescCaptionLbl : Label 'Payment Method';
        DocDateCaptionLbl : Label 'Document Date';
        HomePageCaptionLbl : Label 'Home Page';
        EmailCaptionLbl : Label 'Email';
        CACCaptionLbl : Text;
        CACTxt : Label 'Régimen especial del criterio de caja';
        DisplayAdditionalFeeNote : Boolean;
        LineNoWithTotal : Integer;
        VATBaseRemainderAfterRoundingLCY : Decimal;
        AmtInclVATRemainderAfterRoundingLCY : Decimal;
        FiscalAddr : array [8] of Text[50];
        recSlsLine : Record "Sales Line";
        recCustomer : Record Customer;
        recLanguage : Record Language;
        recCountry : Record "Country/Region";
        CustPmtAddress : Record "Customer Pmt. Address";
        recCustLedgerEntry : Record "Cust. Ledger Entry";
        RefCruzArt : Record "Item Cross Reference";
        ItemTrans : Record "Item Translation";
        RegistroMercantil : Text[200];
        BillToContact : Text[50];
        txtIncoterms : Text[250];
        cCodPaisDeliveryAddr : Code[10];
        cPoblacionDeliveryAddr : Text[30];
        cCustomsTariff : Text[100];
        nPos : Integer;
        PostedShipmentDate : Date;
        Descripcion : Text[50];
        Descripcion2 : Text[50];
        cCodeRefCr : Code[20];
        cLanguage : Code[10];
        cMoneda : Code[10];
        cMonedaLinea : Code[10];
        recItem : Record Item;
        albaran : Boolean;
        texto : Text[30];
        cCodSWIFT : Text[100];
        dFechaVto1 : Date;
        dFechaVto2 : Date;
        cNombreBanco : Text[100];
        cDirBanco : Text[100];
        cIBANBanco : Code[100];
        comentarios : array [4] of Text[80];
        recTransportMethod : Record "Transport Method";
        cTransportMethodDesc : Text[50];
        cPaisNombreOrigen : Text[50];
        cPaisNombreDestino : Text[50];
        cDatosTransporte : Text[250];
        recSalesLine : Record "Sales Line";
        FormatAddress : Codeunit "Format Address";
        VATLinesCount : Integer;
        "----" : Label '----';
        Text000 : Label 'Salesperson';
        Text001 : Label 'Total %1';
        Text002 : Label 'Total %1 Incl. VAT';
        Text003 : Label '- COPY';
        Text005 : Label 'Page %1';
        Text006 : Label 'Total %1 Excl. VAT';
        Text1100000 : Label 'Total %1 Incl. VAT+EC';
        Text1100001 : Label 'Total %1 Excl. VAT+EC';
        txtDatosTransporte : Label '%1 from %2, %3 to %4, %5';
        recAlbaranVta : Record "Sales Shipment Header";
        recCustBankAccount : Record "Customer Bank Account";
        txtMercantilSuecia : Text[20];

    procedure InitLogInteraction();
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    local procedure GenerateBufferFromValueEntry(SalesInvoiceLine2 : Record "Sales Invoice Line");
    var
        ValueEntry : Record "Value Entry";
        ItemLedgerEntry : Record "Item Ledger Entry";
        TotalQuantity : Decimal;
        Quantity : Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.",SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date","Sales Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.",'');
        ValueEntry.SETFILTER("Entry No.",'%1..',FirstValueEntryNo);
        IF ValueEntry.FIND('-') THEN
          REPEAT
            IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
              IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN
                Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
              ELSE
                Quantity := ValueEntry."Invoiced Quantity";
              AddBufferEntry(SalesInvoiceLine2,-Quantity,ItemLedgerEntry."Posting Date");
              TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
            END;
            FirstValueEntryNo := ValueEntry."Entry No." + 1;
          UNTIL (ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
    end;

    local procedure CorrectShipment(var SalesShipmentLine : Record "Sales Shipment Line");
    var
        SalesInvoiceLine : Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.","Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.",SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.",SalesShipmentLine."Line No.");
        IF SalesInvoiceLine.FIND('-') THEN
          REPEAT
            SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
          UNTIL SalesInvoiceLine.NEXT = 0;
    end;

    local procedure AddBufferEntry(SalesInvoiceLine : Record "Sales Invoice Line";QtyOnShipment : Decimal;PostingDate : Date);
    begin
        SalesShipmentBuffer.SETRANGE("Document No.",SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.",SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date",PostingDate);
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
          SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
          SalesShipmentBuffer.MODIFY;
          EXIT;
        END;

        WITH SalesShipmentBuffer DO BEGIN
          "Document No." := SalesInvoiceLine."Document No.";
          "Line No." := SalesInvoiceLine."Line No.";
          "Entry No." := NextEntryNo;
          Type := SalesInvoiceLine.Type;
          "No." := SalesInvoiceLine."No.";
          Quantity := QtyOnShipment;
          "Posting Date" := PostingDate;
          INSERT;
          NextEntryNo := NextEntryNo + 1
        END;
    end;

    procedure ShowCashAccountingCriteria(SalesInvoiceHeader : Record "Sales Invoice Header") : Text;
    var
        VATEntry : Record "VAT Entry";
    begin
        GLSetup.GET;
        IF NOT GLSetup."Unrealized VAT" THEN
          EXIT;
        CACCaptionLbl := '';
        VATEntry.SETRANGE("Document No.",SalesInvoiceHeader."No.");
        VATEntry.SETRANGE("Document Type",VATEntry."Document Type"::Invoice);
        IF VATEntry.FINDSET THEN
          REPEAT
            IF VATEntry."VAT Cash Regime" THEN
              CACCaptionLbl := CACTxt;
          UNTIL (VATEntry.NEXT = 0) OR (CACCaptionLbl <> '');
        EXIT(CACCaptionLbl);
    end;

    procedure InitializeRequest(NewNoOfCopies : Integer;NewShowInternalInfo : Boolean;NewLogInteraction : Boolean;DisplayAsmInfo : Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure FormatDocumentFields(SalesHeader : Record "Sales Header");
    begin
        WITH SalesHeader DO BEGIN
          FormatDocument.SetTotalLabels("Currency Code",TotalText,TotalInclVATText,TotalExclVATText);
          FormatDocument.SetSalesPerson(SalesPurchPerson,"Salesperson Code",SalesPersonText);
          FormatDocument.SetPaymentTerms(PaymentTerms,"Payment Terms Code","Language Code");
          FormatDocument.SetPaymentTerms(PrepmtPaymentTerms,"Prepmt. Payment Terms Code","Language Code");
          FormatDocument.SetShipmentMethod(ShipmentMethod,"Shipment Method Code","Language Code");
          FormatDocument.SetPaymentMethod(PaymentMethod,"Payment Method Code");

          VATNoText := FormatDocument.SetText("VAT Registration No." <> '',FIELDCAPTION("VAT Registration No."));
        END;
    end;

    local procedure FormatAddressFields(SalesHeader : Record "Sales Header");
    begin
        FormatAddr.GetCompanyAddr(SalesHeader."Responsibility Center",RespCenter,CompanyInfo,CompanyAddr);
        FormatAddr.SalesHeaderBillTo(CustAddr,SalesHeader);
        ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr,CustAddr,SalesHeader);
    end;

    local procedure CollectAsmInformation();
    var
        ValueEntry : Record "Value Entry";
        ItemLedgerEntry : Record "Item Ledger Entry";
        PostedAsmHeader : Record "Posted Assembly Header";
        PostedAsmLine : Record "Posted Assembly Line";
        SalesShipmentLine : Record "Sales Shipment Line";
    begin
        TempPostedAsmLine.DELETEALL;
        IF "Sales Line".Type <> "Sales Line".Type::Item THEN
          EXIT;
        WITH ValueEntry DO BEGIN
          SETCURRENTKEY("Document No.");
          SETRANGE("Document No.","Sales Line"."Document No.");
          SETRANGE("Document Type","Document Type"::"Sales Invoice");
          SETRANGE("Document Line No.","Sales Line"."Line No.");
          SETRANGE(Adjustment,FALSE);
          IF NOT FINDSET THEN
            EXIT;
        END;
        REPEAT
          IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN
            IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
              SalesShipmentLine.GET(ItemLedgerEntry."Document No.",ItemLedgerEntry."Document Line No.");
              IF SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) THEN BEGIN
                PostedAsmLine.SETRANGE("Document No.",PostedAsmHeader."No.");
                IF PostedAsmLine.FINDSET THEN
                  REPEAT
                    TreatAsmLineBuffer(PostedAsmLine);
                  UNTIL PostedAsmLine.NEXT = 0;
              END;
            END;
        UNTIL ValueEntry.NEXT = 0;
    end;

    local procedure TreatAsmLineBuffer(PostedAsmLine : Record "Posted Assembly Line");
    begin
        CLEAR(TempPostedAsmLine);
        TempPostedAsmLine.SETRANGE(Type,PostedAsmLine.Type);
        TempPostedAsmLine.SETRANGE("No.",PostedAsmLine."No.");
        TempPostedAsmLine.SETRANGE("Variant Code",PostedAsmLine."Variant Code");
        TempPostedAsmLine.SETRANGE(Description,PostedAsmLine.Description);
        TempPostedAsmLine.SETRANGE("Unit of Measure Code",PostedAsmLine."Unit of Measure Code");
        IF TempPostedAsmLine.FINDFIRST THEN BEGIN
          TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
          TempPostedAsmLine.MODIFY;
        END ELSE BEGIN
          CLEAR(TempPostedAsmLine);
          TempPostedAsmLine := PostedAsmLine;
          TempPostedAsmLine.INSERT;
        END;
    end;

    local procedure GetUOMText(UOMCode : Code[10]) : Text[10];
    var
        UnitOfMeasure : Record "Unit of Measure";
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
          EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent() : Text[10];
    begin
        EXIT(PADSTR('',2,' '));
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo : Code[20]);
    var
        LineFeeNoteOnReportHist : Record "Line Fee Note on Report Hist.";
        CustLedgerEntry : Record "Cust. Ledger Entry";
        Customer : Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DELETEALL;
        CustLedgerEntry.SETRANGE("Document Type",CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Document No.",SalesInvoiceHeaderNo);
        IF NOT CustLedgerEntry.FINDFIRST THEN
          EXIT;

        IF NOT Customer.GET(CustLedgerEntry."Customer No.") THEN
          EXIT;

        LineFeeNoteOnReportHist.SETRANGE("Cust. Ledger Entry No",CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SETRANGE("Language Code",Customer."Language Code");
        IF LineFeeNoteOnReportHist.FINDSET THEN BEGIN
          REPEAT
            TempLineFeeNoteOnReportHist.INIT;
            TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
            TempLineFeeNoteOnReportHist.INSERT;
          UNTIL LineFeeNoteOnReportHist.NEXT = 0;
        END ELSE BEGIN
          LineFeeNoteOnReportHist.SETRANGE("Language Code",Language.GetUserLanguage);
          IF LineFeeNoteOnReportHist.FINDSET THEN
            REPEAT
              TempLineFeeNoteOnReportHist.INIT;
              TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
              TempLineFeeNoteOnReportHist.INSERT;
            UNTIL LineFeeNoteOnReportHist.NEXT = 0;
        END;
    end;

    local procedure CalcVATAmountLineLCY(SalesHeader : Record "Sales Header";TempVATAmountLine2 : Record "VAT Amount Line" temporary;var TempVATAmountLineLCY2 : Record "VAT Amount Line" temporary;var VATBaseRemainderAfterRoundingLCY2 : Decimal;var AmtInclVATRemainderAfterRoundingLCY2 : Decimal);
    var
        VATBaseLCY : Decimal;
        AmtInclVATLCY : Decimal;
    begin
        IF (NOT GLSetup."Print VAT specification in LCY") OR
           (SalesHeader."Currency Code" = '')
        THEN
          EXIT;

        TempVATAmountLineLCY2.INIT;
        TempVATAmountLineLCY2 := TempVATAmountLine2;
        WITH SalesHeader DO BEGIN
          VATBaseLCY :=
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Posting Date","Currency Code",TempVATAmountLine2."VAT Base","Currency Factor") +
            VATBaseRemainderAfterRoundingLCY2;
          AmtInclVATLCY :=
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Posting Date","Currency Code",TempVATAmountLine2."Amount Including VAT","Currency Factor") +
            AmtInclVATRemainderAfterRoundingLCY2;
        END;
        TempVATAmountLineLCY2."VAT Base" := ROUND(VATBaseLCY);
        TempVATAmountLineLCY2."Amount Including VAT" := ROUND(AmtInclVATLCY);
        TempVATAmountLineLCY2.InsertLine;

        VATBaseRemainderAfterRoundingLCY2 := VATBaseLCY - TempVATAmountLineLCY2."VAT Base";
        AmtInclVATRemainderAfterRoundingLCY2 := AmtInclVATLCY - TempVATAmountLineLCY2."Amount Including VAT";
    end;

    [IntegrationEvent(false, TRUE)]
    procedure OnAfterGetRecordSalesHeader(SalesHeader : Record "Sales Header");
    begin
    end;

    procedure GetPuertoIncoterms(codPuerto : Code[20];metodoEnvio : Code[20]);
    var
        recPuerto : Record "Entry/Exit Point";
    begin
        CLEAR(recPuerto);
        WITH recPuerto DO BEGIN
          IF GET(codPuerto) THEN
             txtIncoterms:=STRSUBSTNO('%1 %2',metodoEnvio, Description);
        END;
    end;

    procedure GetHebronIncoterms(metodoEnvio : Code[20]);
    var
        recLocationHebron : Record Location;
        nomPais : Text[100];
    begin
        recCountry.RESET;
        CLEAR(recCountry);
        CLEAR(recLocationHebron);
        WITH recLocationHebron DO BEGIN
            IF GET(CompanyInfo."Location Code") THEN BEGIN
               IF recCountry.GET("Country/Region Code") THEN nomPais := recCountry.Name;
               txtIncoterms:=STRSUBSTNO('%1 %2 %3',metodoEnvio, City, nomPais);
            END;
        END;
    end;

    procedure CalculaIncoterms(codPuerto : Code[20];metodoEnvio : Code[20]);
    var
        recShipmentMethod : Record "Shipment Method";
        nomPais : Text[100];
    begin
        txtIncoterms:='';
        CLEAR(recShipmentMethod);

        IF metodoEnvio = '' THEN EXIT;

        IF NOT recShipmentMethod.GET(metodoEnvio) THEN
           ERROR('No se encuentra el metodo de envio %1 en la tabla %2',metodoEnvio,recShipmentMethod.TABLECAPTION);

         WITH recShipmentMethod DO BEGIN
          IF "INCOTERM Almacén Hebron" THEN GetHebronIncoterms(metodoEnvio)
             ELSE BEGIN
                IF codPuerto <> '' THEN GetPuertoIncoterms(codPuerto,metodoEnvio)
                   ELSE BEGIN
                     recCountry.RESET;
                     CLEAR(recCountry);
                     IF recCountry.GET(cCodPaisDeliveryAddr) THEN nomPais := recCountry.Name;
                     txtIncoterms:=STRSUBSTNO('%1 %2 %3',metodoEnvio, cPoblacionDeliveryAddr, nomPais);
                   END;
             END;
         END;
    end;
}

