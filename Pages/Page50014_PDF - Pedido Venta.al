page 50014 "PDF - Pedido Venta"
{
    // version AITANA,PI0023,245
    // -155 OGA  07/04/09 PI0023_7064 Modificada la funcion DirectPrintSalesOrder
    // -245 apicazo   04/02/2016 Ajustos enviament documents per PDF.

    PageType = Card;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field("SalesHeader.No.";SalesHeader."No.")
                {
                    Caption = 'Order No.';
                    Editable = false;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(vCopias;vCopias)
                {
                    Caption = 'No. of Copies';
                }
                field(vTipo;vTipo)
                {
                    Caption = 'Tipo Documento';

                    trigger OnValidate();
                    begin
                        CASE vTipo OF
                           vTipo::" ":
                              BEGIN
                                blnValorado := FALSE;
                                blnLotes := FALSE;
                                blnArchivo := FALSE;
                                ctrlValoradoEditable := TRUE;
                                ctrlLotesEditable := TRUE;
                                ctrlLanguageEditable := FALSE; //-245
                                blnOrderLang := FALSE; //-245
                                MESSAGE('Debe elegir una opción');
                              END;

                           vTipo::"CONFIRMACIÓN PEDIDO":
                              BEGIN
                                blnValorado := TRUE;
                                blnLotes := FALSE;
                                blnArchivo := TRUE;
                                ctrlValoradoEditable := TRUE;
                                ctrlLotesEditable := TRUE;
                                ctrlLanguageEditable := FALSE; //-245
                                blnOrderLang := TRUE; //-245
                              END;
                           vTipo::"FACTURA EXPORTACIÓN":
                              BEGIN
                                blnValorado := TRUE;
                                blnLotes := FALSE;
                                blnArchivo := FALSE;
                                ctrlValoradoEditable := TRUE;
                                ctrlLotesEditable := TRUE;
                                ctrlLanguageEditable := FALSE; //-245
                                blnOrderLang := TRUE; //-245
                              END;
                           vTipo::"PREPARACIÓN PEDIDO":
                              BEGIN
                                blnValorado := FALSE;
                                blnLotes := TRUE;
                                blnArchivo := FALSE;
                                ctrlValoradoEditable := FALSE;
                                ctrlLotesEditable := TRUE;
                                ctrlLanguageEditable := TRUE; //-245
                                blnOrderLang := FALSE; //-245
                              END;
                        END;
                    end;
                }
                field(ctrlLanguage;blnOrderLang)
                {
                    Caption = 'Order Language';
                    Editable = ctrlLanguageEditable;
                }
                field(ctrlValorado;blnValorado)
                {
                    Caption = 'Valorado';
                    Editable = ctrlValoradoEditable;
                }
                field(ctrlLotes;blnLotes)
                {
                    Caption = 'Ver Lotes';
                    Editable = ctrlLotesEditable;
                }
                field(ArchiveDocument;blnArchivo)
                {
                    Caption = 'Archive Document';
                    Enabled = ArchiveDocumentEnable;

                    trigger OnValidate();
                    begin
                        IF NOT blnArchivo THEN
                          blnLog := FALSE;
                    end;
                }
                field(LogInteraction;blnLog)
                {
                    Caption = 'Log Interaction';
                    Enabled = LogInteractionEnable;

                    trigger OnValidate();
                    begin
                        IF blnLog THEN
                            blnArchivo := ArchiveDocumentEnable;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Enviar en PDF")
            {
                Caption = 'Enviar en PDF';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    recSalesHeader : Record "Sales Header";
                begin
                    IF vTipo =  vTipo::" " THEN
                       ERROR('Debe elegir una opción');

                    DirectPrintSalesOrder();
                    CurrPage.CLOSE();
                end;
            }
        }
    }

    trigger OnInit();
    begin
        LogInteractionEnable := TRUE;
        ArchiveDocumentEnable := TRUE;
        ctrlLanguageEditable := TRUE;
        ctrlLotesEditable := TRUE;
        ctrlValoradoEditable := TRUE;
    end;

    trigger OnOpenPage();
    begin
        IF (SalesHeader."Document Type" <> SalesHeader."Document Type"::Order) OR
           (SalesHeader."No." = '') THEN CurrPage.CLOSE;


        blnArchivo := ArchiveManagement.SalesDocArchiveGranule;
        blnLog    := SegManagement.FindInteractTmplCode(3) <> '';

        ArchiveDocumentEnable := blnArchivo;
        LogInteractionEnable := blnLog;
        ctrlLanguageEditable := FALSE; //-245


        vTipo := 0;
        blnValorado := FALSE;
        blnLotes := FALSE;
        blnArchivo := FALSE;
    end;

    var
        vCopias : Integer;
        blnValorado : Boolean;
        blnLotes : Boolean;
        vTipo : Option " ","CONFIRMACIÓN PEDIDO","FACTURA EXPORTACIÓN","PREPARACIÓN PEDIDO";
        blnArchivo : Boolean;
        blnLog : Boolean;
        ArchiveManagement : Codeunit ArchiveManagement;
        SegManagement : Codeunit SegManagement;
        SalesHeader : Record "Sales Header";
        blnOrderLang : Boolean;
        [InDataSet]
        ArchiveDocumentEnable : Boolean;
        [InDataSet]
        ctrlValoradoEditable : Boolean;
        [InDataSet]
        ctrlLotesEditable : Boolean;
        [InDataSet]
        ctrlLanguageEditable : Boolean;
        [InDataSet]
        LogInteractionEnable : Boolean;

    procedure setValores(pSalesHeader : Record "Sales Header");
    begin
        SalesHeader := pSalesHeader;
    end;

    local procedure DirectPrintSalesOrder();
    var
        Customer : Record Customer;
        SalesSetup : Record "Sales & Receivables Setup";
        SalesLine : Record "Sales Line";
        SalesCalcDisc : Codeunit "Sales - Calc Discount By Type";
        Utilidades : Codeunit "General Abast Library";
        rptOrder : Report 3;
        UserPrinter : Text[250];
        SystemPrinter : Text[250];
        DocType : Text[50];
        SubjectText : Text[250];
        NombreFichero : Text[250];
        ExtDoc : Text[50];
        ReportOutStream : OutStream;
        TempBlob : Record TempBlob temporary;
        TipoDocumento : Option " ",Quote,Order,Shipment,Invoice,"Posted Invoice","Credit Memo","Return Order","Posted Credit Memo","Posted Return Order";
    begin
        SalesHeader.SETRANGE("No.",SalesHeader."No.");
        SalesSetup.GET;
        IF SalesSetup."Calc. Inv. Discount" THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.",SalesHeader."No.");
            SalesLine.FIND('-');
            SalesCalcDisc.RUN(SalesLine);
            SalesHeader.GET(SalesHeader."Document Type",SalesHeader."No.");
            COMMIT;
        END;

        //NombreFichero := Utilidades.GenerarPDFPedido(SalesHeader, vCopias, blnValorado, blnLotes, vTipo, blnArchivo, blnLog, blnOrderLang);
        NombreFichero := Utilidades.GenerarPDF(SalesHeader, SalesHeader."No.", SalesHeader."Document Type"::Order, 18);
        Customer.GET(SalesHeader."Sell-to Customer No.");
        IF Customer."Language Code" = 'ESP' THEN BEGIN
            DocType := FORMAT(vTipo);
            ExtDoc := 'Nº REFERENCIA CLIENTE';
        END ELSE BEGIN
            ExtDoc := 'CUSTOMER REFERENCE No.';
            CASE vTipo OF
                vTipo::"CONFIRMACIÓN PEDIDO": DocType := 'ORDER CONFIRMATION';
                vTipo::"FACTURA EXPORTACIÓN": DocType := 'EXPORT INVOICE';
                vTipo::"PREPARACIÓN PEDIDO": 
                    BEGIN
                        IF (NOT blnOrderLang) THEN BEGIN
                            DocType := FORMAT(vTipo);
                            ExtDoc := 'Nº REFERENCIA CLIENTE';
                        END ELSE
                            DocType := 'DELIVERY PREPARATION';
                    END;
            END;
        END;

        IF SalesHeader."External Document No." <> '' THEN
            SubjectText := STRSUBSTNO('%1 %2 %3 %4',DocType,SalesHeader."No.",ExtDoc,SalesHeader."External Document No.")
        ELSE
            SubjectText := STRSUBSTNO('%1 %2',DocType,SalesHeader."No.");

        Utilidades.EnvioDocCorreoPDF(0,TipoDocumento::Order,vTipo,SalesHeader."Sell-to Customer No.",SubjectText,NombreFichero,TRUE,(NOT blnOrderLang));
    end;
}

