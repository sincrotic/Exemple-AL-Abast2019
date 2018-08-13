report 50002 "Ped. transf. entre alm.- Envío"
{
    // version NAVW111.00.00.20783,NAVES11.00.00.20783

    // -103 jperez  25/03/2008 PI0007_9999: Impreso de Pedido Transf. entre almacenes (Envío)
    //                                      Creación report 50002
    // -173 ogarcia 09/11/2009 Añadir "Cód. Tunel" en (ADR)
    // -235 xtrullols 09/04/2015 Correcions al report de Albarà de transferències Report 50053 i 50002.
    // -TONIMIGRA 20/07/2018 Codigo no standard detectado en la migración no etiquetado
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Ped. transf. entre alm.- Envío.rdlc';
    Caption = 'Transfer Shipment';

    dataset
    {
        dataitem("Transfer Shipment Header";"Transfer Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.","Transfer-from Code","Transfer-to Code";
            RequestFilterHeading = 'Posted Transfer Shipment';
            column(No_TransShptHeader;"No.")
            {
            }
            column(CompanyInfoName;recCompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress;recCompanyInfo.Address)
            {
            }
            column(CompanyInfoPostCode;recCompanyInfo."Post Code")
            {
            }
            column(CompanyInfoCity;recCompanyInfo.City)
            {
            }
            column(CompanyInfoCounty;recCompanyInfo.County + ' - Spain')
            {
            }
            column(CompanyInfoTel;recCompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoFax;recCompanyInfo."Fax No.")
            {
            }
            column(CompanyInfoHomePage;recCompanyInfo."Home Page")
            {
            }
            column(CompanyInfoPicture;recCompanyInfo.Picture)
            {
            }
            column(TelephonLbl;TelephoneCaptionLbl)
            {
            }
            column(FaxLbl;FaxCaptionLbl)
            {
            }
            column(ComentariosCaption;ComentariosCaptionLbl)
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
            column(comentarios5;comentarios[5])
            {
            }
            column(ShippingAgentService;STRSUBSTNO('%1 - %2',"Transfer Shipment Header"."Shipping Agent Service Code",cDescServTransportista))
            {
            }
            column(ShippingAgent;cNomTransportista)
            {
            }
            column(Desc_ShptMethod;ShipmentMethod.Description)
            {
            }
            column(ShipmentMethodCaption;ShipmentMethodLbl)
            {
            }
            column(ShippingAgentCaption;ShippingAgentLbl)
            {
            }
            column(ShippingAgentServiceCaption;ShippingAgentServiceLbl)
            {
            }
            dataitem(CopyLoop;Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop;Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number=CONST(1));
                    column(AlmacenSalidaCaption;AlmacenSalidaCaptionLbl)
                    {
                    }
                    column(CopyTextCaption;STRSUBSTNO(Text001,CopyText))
                    {
                    }
                    column(TransferToAddr1;TransferToAddr[1])
                    {
                    }
                    column(TransferFromAddr1;TransferFromAddr[1])
                    {
                    }
                    column(TransferToAddr2;TransferToAddr[2])
                    {
                    }
                    column(TransferFromAddr2;TransferFromAddr[2])
                    {
                    }
                    column(TransferToAddr3;TransferToAddr[3])
                    {
                    }
                    column(TransferFromAddr3;TransferFromAddr[3])
                    {
                    }
                    column(TransferToAddr4;TransferToAddr[4])
                    {
                    }
                    column(TransferFromAddr4;TransferFromAddr[4])
                    {
                    }
                    column(TransferToAddr5;TransferToAddr[5])
                    {
                    }
                    column(TransferToAddr6;TransferToAddr[6])
                    {
                    }
                    column(InTransit_TransShptHeader;"Transfer Shipment Header"."In-Transit Code")
                    {
                    }
                    column(PostDate_TransShptHeader;FORMAT("Transfer Shipment Header"."Posting Date"))
                    {
                    }
                    column(No2_TransShptHeader;"Transfer Shipment Header"."No.")
                    {
                    }
                    column(TransferToAddr7;TransferToAddr[7])
                    {
                    }
                    column(TransferToAddr8;TransferToAddr[8])
                    {
                    }
                    column(TransferFromAddr5;TransferFromAddr[5])
                    {
                    }
                    column(TransferFromAddr6;TransferFromAddr[6])
                    {
                    }
                    column(ShiptDate_TransShptHeader;FORMAT("Transfer Shipment Header"."Shipment Date"))
                    {
                    }
                    column(ReceiptDate_TransShptHeader;FORMAT("Transfer Shipment Header"."Receipt Date"))
                    {
                    }
                    column(TransferFromAddr7;TransferFromAddr[7])
                    {
                    }
                    column(TransferFromAddr8;TransferFromAddr[8])
                    {
                    }
                    column(PageCaption;Text002)
                    {
                    }
                    column(OutputNo;OutputNo)
                    {
                    }
                    column(TransShptHdrNoCaption;TransShptHdrNoCaptionLbl)
                    {
                    }
                    column(TransShptShptDateCaption;TransShptShptDateCaptionLbl)
                    {
                    }
                    column(vMercantil;vMercantil)
                    {
                    }
                    dataitem(DimensionLoop1;Integer)
                    {
                        DataItemLinkReference = "Transfer Shipment Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=FILTER(1..));
                        column(DimText;DimText)
                        {
                        }
                        column(Number_DimensionLoop1;Number)
                        {
                        }
                        column(HdrDimCaption;HdrDimCaptionLbl)
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
                                DimText := STRSUBSTNO('%1 - %2',DimSetEntry1."Dimension Code",DimSetEntry1."Dimension Value Code")
                              ELSE
                                DimText :=
                                  STRSUBSTNO(
                                    '%1; %2 - %3',DimText,
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
                    dataitem("Transfer Shipment Line";"Transfer Shipment Line")
                    {
                        DataItemLink = "Document No."=FIELD("No.");
                        DataItemLinkReference = "Transfer Shipment Header";
                        DataItemTableView = SORTING("Document No.","Line No.");
                        column(ShowInternalInfo;ShowInternalInfo)
                        {
                        }
                        column(NoOfCopies;NoOfCopies)
                        {
                        }
                        column(ItemNo_TransShptLine;"Item No.")
                        {
                        }
                        column(Desc_TransShptLine;STRSUBSTNO('%1 %2',Descripcion,Descripcion2))
                        {
                        }
                        column(SudDesc_TransShptLine;STRSUBSTNO(ADR,recProd."UN No.",recProd."Descripción ADR (Carta Portes)",recProd.Clase,recProd."Packaging Group",recProd."Cód. Tunel"))
                        {
                        }
                        column(Qty_TransShptLine;Quantity)
                        {
                        }
                        column(UOM_TransShptLine;"Transfer Shipment Line"."Unit of Measure Code")
                        {
                        }
                        column(LineNo_TransShptLine;"Line No.")
                        {
                        }
                        column(DocNo_TransShptLine;"Document No.")
                        {
                        }
                        column(UNNo_TransShptLine;recProd."UN No.")
                        {
                        }
                        column(DescriptionCaption;DescriptionCaptionLbl)
                        {
                        }
                        column(ExpectedShipmentDateCaption;ExpectedShipmentDateLbl)
                        {
                        }
                        column(ExpectedReceiptDateCaption;ExpectedReceiptLbl)
                        {
                        }
                        dataitem(DimensionLoop2;Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number=FILTER(1..));
                            column(DimText4;DimText)
                            {
                            }
                            column(Number_DimensionLoop2;Number)
                            {
                            }
                            column(LineDimCaption;LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                IF Number = 1 THEN BEGIN
                                  IF NOT DimSetEntry2.FINDSET THEN
                                    CurrReport.BREAK;
                                END ELSE
                                  IF NOT Continue THEN
                                    CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                  OldDimText := DimText;
                                  IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 - %2',DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code")
                                  ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3',DimText,
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
                            end;
                        }
                        dataitem("Item Ledger Entry";"Item Ledger Entry")
                        {
                            DataItemLink = "Document No."=FIELD("Document No."),
                                           "Document Line No."=FIELD("Line No."),
                                           "Item No."=FIELD("Item No."),
                                           "Order No."=FIELD("Transfer Order No."),
                                           "Location Code"=FIELD("Transfer-from Code");
                            DataItemTableView = SORTING("Entry No.")
                                                ORDER(Ascending)
                                                WHERE("Entry Type"=CONST(Transfer),
                                                      "Document Type"=CONST("Transfer Shipment"));
                            column(EntryNo_ItemLedgerEntry;"Entry No.")
                            {
                            }
                            column(LotNo_ItemLedgerEntry;"Lot No.")
                            {
                            }
                            column(Quantity_ItemLedgerEntry;(-1)*"Item Ledger Entry".Quantity)
                            {
                            }
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //-TONIMIGRA (OnPreSection)
                            recProd.RESET;
                            recProd.GET("Item No.");

                            //+TONIMIGRA (OnPreSection)

                            DimSetEntry2.SETRANGE("Dimension Set ID","Dimension Set ID");

                            //-103
                            recLocation.RESET;
                            recLocation.SETRANGE(Code,"Transfer Shipment Header"."Transfer-from Code");
                            IF recLocation.FINDFIRST THEN BEGIN
                              RefCruzArt.RESET;
                              RefCruzArt.SETRANGE("Cross-Reference Type",RefCruzArt."Cross-Reference Type"::Customer);
                              RefCruzArt.SETRANGE("Cross-Reference Type No.",recLocation."Código Cliente");
                              RefCruzArt.SETRANGE("Item No.","Transfer Shipment Line"."Item No.");
                              IF RefCruzArt.FINDFIRST THEN BEGIN
                                Descripcion := RefCruzArt.Description;
                                Descripcion2 := RefCruzArt."Descripción 2";
                              END ELSE BEGIN
                                IF recLocation."Código Cliente" <> '' THEN BEGIN
                                  recCustomer.RESET;
                                  IF recCustomer.GET(recLocation."Código Cliente") THEN
                                    cLanguage := recCustomer."Language Code";
                                END ELSE BEGIN
                                  cLanguage := recLocation."Código Idioma";
                                END;
                                IF cLanguage <> '' THEN BEGIN
                                  ItemTrans.RESET;
                                  ItemTrans.SETRANGE("Item No.","Transfer Shipment Line"."Item No.");
                                  ItemTrans.SETRANGE("Language Code",cLanguage);
                                  IF ItemTrans.FINDFIRST THEN BEGIN
                                    Descripcion := ItemTrans.Description;
                                    Descripcion2 := ItemTrans."Description 2";
                                  END ELSE BEGIN
                                    Descripcion := "Transfer Shipment Line".Description;
                                    Descripcion2 := '';
                                  END;
                                END ELSE BEGIN
                                  Descripcion := "Transfer Shipment Line".Description;
                                  Descripcion2 := '';
                                END;
                              END;
                            END;
                            //+103
                        end;

                        trigger OnPreDataItem();
                        begin
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("Item No." = '') AND (Quantity = 0) DO
                              MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            SETRANGE("Line No.",0,"Line No.");
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    IF Number > 1 THEN BEGIN
                      CopyText := Text000;
                      OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    CopyText := '';
                    SETRANGE(Number,1,NoOfLoops);
                    OutputNo := 1;

                    //-103
                    cNomTransportista:='';
                    IF "Transfer Shipment Header"."Shipping Agent Code" <> '' THEN BEGIN
                      recShippingAgent.RESET;
                      IF recShippingAgent.GET("Transfer Shipment Header"."Shipping Agent Code") THEN
                         cNomTransportista:=recShippingAgent.Name;
                    END;
                    cDescServTransportista:='';
                    IF "Transfer Shipment Header"."Shipping Agent Service Code" <> '' THEN BEGIN
                      recShippingAgentServices.RESET;
                      recShippingAgentServices.SETRANGE("Shipping Agent Code","Transfer Shipment Header"."Shipping Agent Code");
                      recShippingAgentServices.SETRANGE(Code,"Transfer Shipment Header"."Shipping Agent Service Code");
                      IF recShippingAgentServices.FINDFIRST THEN
                         cDescServTransportista:=recShippingAgentServices.Description;
                    END;
                    //+103
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //-103
                recLocation.RESET;
                recLocation.SETRANGE(Code,"Transfer Shipment Header"."Transfer-from Code");
                IF recLocation.FINDFIRST THEN BEGIN
                  IF recLocation."Código Cliente" <> '' THEN BEGIN
                    recCustomer.RESET;
                    IF recCustomer.GET(recLocation."Código Cliente") THEN BEGIN
                      IF recCustomer."Language Code" <> '' THEN BEGIN
                         IF recLanguage.GET(recCustomer."Language Code") THEN
                            CurrReport.LANGUAGE(recLanguage."Windows Language ID");
                      END;
                    END;
                  END ELSE BEGIN
                    IF recLocation."Código Idioma" <> '' THEN
                      IF recLanguage.GET(recLocation."Código Idioma") THEN
                        CurrReport.LANGUAGE(recLanguage."Windows Language ID");
                  END;
                END;
                //+103

                //-TONIMIGRA
                IF "External Document No."<>'' THEN
                  txtRefPedido:='Referencia pedido'
                ELSE
                  txtRefPedido:='';

                CLEAR(comentarios);
                recComment.RESET;
                recComment.SETRANGE("Document Type",recComment."Document Type"::"Posted Transfer Shipment");
                recComment.SETRANGE("No.","No.");
                IF recComment.FINDSET THEN BEGIN
                  intCont:=1;
                  REPEAT
                    comentarios[intCont]:=recComment.Comment;
                    intCont+=1;
                  UNTIL (recComment.NEXT=0) OR (intCont>5);
                END;
                //+TONIMIGRA

                DimSetEntry1.SETRANGE("Dimension Set ID","Dimension Set ID");

                FormatAddr.TransferShptTransferFrom(TransferFromAddr,"Transfer Shipment Header");
                FormatAddr.TransferShptTransferTo(TransferToAddr,"Transfer Shipment Header");

                //-TONIMIGRA
                // IF NOT ShipmentMethod.GET("Shipment Method Code") THEN
                //  ShipmentMethod.INIT;

                txtIncoterms:='';
                cPoblacionDeliveryAddr:='';
                cCodPaisDeliveryAddr:='';

                cPoblacionDeliveryAddr:= "Transfer-to City";
                cCodPaisDeliveryAddr  := "Trsf.-to Country/Region Code";
                CalculaIncoterms("Entry/Exit Point","Shipment Method Code");
                //+TONIMIGRA
            end;

            trigger OnPreDataItem();
            begin
                //-103
                recCompanyInfo.GET();
                recCompanyInfo.CALCFIELDS(recCompanyInfo.Picture);
                //-TONIMIGRA
                // vMercantil := STRSUBSTNO(txtMercantil, recCompanyInfo.Name,
                //                                         recCompanyInfo."Hoja número",
                //                                         recCompanyInfo.Folio,
                //                                         recCompanyInfo.Tomo,
                //                                         recCompanyInfo."VAT Registration No.");
                vMercantil := recCompanyInfo."Registro Mercantil";
                //+TONIMIGRA
                //+103
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
                    CaptionML = ENU='Options',
                                ESP='Opciones';
                    field(NoOfCopies;NoOfCopies)
                    {
                        ApplicationArea = Location;
                        CaptionML = ENU='No. of Copies',
                                    ESP='Nº copias';
                        ToolTipML = ENU='Specifies how many copies of the document to print.',
                                    ESP='Especifica cuántas copias del documento se van a imprimir.';
                    }
                    field(ShowInternalInfo;ShowInternalInfo)
                    {
                        ApplicationArea = Location;
                        CaptionML = ENU='Show Internal Information',
                                    ESP='Mostrar información interna';
                        ToolTipML = ENU='Specifies if you want all dimensions assigned to the line to be shown.',
                                    ESP='Especifica si desea que todas las dimensiones se asignen a la línea a mostrar.';
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
        Puntos = '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .';}

    var
        Text000 : Label 'COPY';
        Text001 : Label 'Transfer Shipment %1';
        Text002 : Label 'Page';
        ShipmentMethod : Record "Shipment Method";
        DimSetEntry1 : Record "Dimension Set Entry";
        DimSetEntry2 : Record "Dimension Set Entry";
        FormatAddr : codeunit "Format Address";
        TransferFromAddr : array [8] of Text[50];
        TransferToAddr : array [8] of Text[50];
        MoreLines : Boolean;
        NoOfCopies : Integer;
        NoOfLoops : Integer;
        CopyText : Text[30];
        DimText : Text[120];
        OldDimText : Text[75];
        ShowInternalInfo : Boolean;
        Continue : Boolean;
        OutputNo : Integer;
        TelephoneCaptionLbl : Label 'Tel.';
        FaxCaptionLbl : Label 'Fax';
        TransShptHdrNoCaptionLbl : Label 'Shipment Nº';
        TransShptShptDateCaptionLbl : Label 'Date';
        HdrDimCaptionLbl : Label 'Header Dimensions';
        LineDimCaptionLbl : Label 'Line Dimensions';
        vMercantil : Text[250];
        vIncoterms : Text[250];
        cNomTransportista : Text[50];
        cLanguage : Code[10];
        cDescServTransportista : Text[50];
        txtRefPedido : Text[30];
        txtIncoterms : Text[1024];
        cCodPaisDeliveryAddr : Code[10];
        cPoblacionDeliveryAddr : Text[30];
        comentarios : array [5] of Text[250];
        intCont : Integer;
        Descripcion : Text[30];
        Descripcion2 : Text[30];
        recCompanyInfo : Record "Company Information";
        recShippingAgent : Record "Shipping Agent";
        recShippingAgentServices : Record "Shipping Agent Services";
        recCountry : Record "Country/Region";
        txtMercantil : Label '%1 Registro Mercantil de Barcelona, Hoja %2, Folio %3, Tomo %4 - NIF/VAT: ES-%5';
        ADR : Label 'UN %1, %2, %3, %4, %5';
        recLocation : Record "Location";
        recCustomer : Record "Customer";
        recLanguage : Record "Language";
        recComment : Record "Inventory Comment Line";
        RefCruzArt : Record "Item Cross Reference";
        ItemTrans : Record "Item Translation";
        AlmacenSalidaCaptionLbl : Label 'Warehouse Output';
        ComentariosCaptionLbl : Label 'Remarks';
        DescriptionCaptionLbl : Label 'Description';
        recProd : Record "Item";
        Item : Record "Item";
        ExpectedShipmentDateLbl : Label 'Expected Shipment';
        ExpectedReceiptLbl : Label 'Expected Receipt';
        ShipmentMethodLbl : Label 'Shipment Method';
        ShippingAgentLbl : Label 'Shipping Agent';
        ShippingAgentServiceLbl : Label 'Shipping Agent Service';

    procedure GetPuertoIncoterms(codPuerto : Code[20];metodoEnvio : Code[20]);
    var
        recPuerto : Record "Entry/Exit Point";
    begin
        vIncoterms := '';
        CLEAR(recPuerto);
        WITH recPuerto DO BEGIN
          IF GET(codPuerto) THEN
             vIncoterms:=STRSUBSTNO('%1 %2',metodoEnvio, Description);
        END;
    end;

    procedure GetHebronIncoterms(metodoEnvio : Code[20]);
    var
        recLocationHebron : Record "Location";
        nomPais : Text[100];
    begin
        vIncoterms:='';
        nomPais:='';
        CLEAR(recLocationHebron);
        WITH recLocationHebron DO BEGIN
            IF GET(recCompanyInfo."Location Code") THEN BEGIN
               IF recCountry.GET("Country/Region Code") THEN nomPais := recCountry.Name;
               vIncoterms:=STRSUBSTNO('%1 %2 %3',metodoEnvio, City, nomPais);
            END;
        END;
    end;

    procedure CalculaIncoterms(codPuerto : Code[20];metodoEnvio : Code[20]);
    var
        recShipmentMethod : Record "Shipment Method";
        nomPais : Text[100];
    begin
        txtIncoterms:='';
        CLEAR(ShipmentMethod);

        IF metodoEnvio = '' THEN EXIT;

        IF NOT ShipmentMethod.GET(metodoEnvio) THEN
           ERROR('No se encuentra el metodo de envio %1 en la tabla %2',metodoEnvio,ShipmentMethod.TABLECAPTION);

        WITH ShipmentMethod DO BEGIN
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

