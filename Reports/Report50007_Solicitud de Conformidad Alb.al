//HEB.113 MT 05062018. Migración Report 50007.
//HEB.174 MT 05062018. Más de 5 lotes por línea.
report 50007 "Solicitud de Conformidad Alb."
{
    //-113 jperez 08/04/2008 PI0006_9999: Report 50007 Solicitud de Conformidad
    //-174 ogarcia 09/11/2009 permitir mostras + de 5 lotes por linea

    DefaultLayout = RDLC;
    RDLCLayout = '.\Reports\Layouts\Solicitud de Conformidad Alb.rdl';
    Caption = 'Solicitud de Conformidad Alb.';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(PurchRcptLine; "Purch. Rcpt. Line")
        {
            DataItemTableView = SORTING("Document No.","Line No.") WHERE(Type=CONST(Item),Quantity=FILTER(<>0));
            RequestFilterFields = "Document No.","Line No.";

            dataitem(PageLoop;"Integer")
            {
                DataItemTableView = sorting(Number) where(Number=const(1));
                DataItemLinkReference = "PurchRcptLine";

                column(DocumentNo; PurchRcptLine."Document No."){}
                column(LineNo; FORMAT(PurchRcptLine."Line No.")){}
                column(PurchRcptNo; PurchRcptLine."Document No." + ' / ' + FORMAT(PurchRcptLine."Line No.")){}
                column(ItemDescription; recItem.Description){}
                column(PayToName; recPurchRcptHeader."Pay-to Name"){}
                column(WorkDate; FORMAT(WorkDate)){}
                column(CompanyLogo; recCompanyInfo.Picture){}
                //-HEB.174
                column(pageNo;pageNo){}
                //+HEB.174

                dataitem(ItemLedgerEntry;"Item Ledger Entry")
                {
                    DataItemTableView = sorting("Entry No.") order(ascending);
                    DataItemLinkReference = "PurchRcptLine";
                    DataItemLink = "Document No."=field("Document No."),"Document Line No."=field("Line No.");

                    column(Lot_No_; "Lot No."){}
                    column(Quantity; FORMAT(Quantity)){}

                    trigger OnAfterGetRecord();
                    begin
                        lineasBody+=1;
                        IF lineasBody=6 THEN BEGIN
                            //-HEB.174
                            pageNo+=1;
                            //+HEB.174
                            lineasBody := 1;
                        END;
                        InsertSolConfirmLog();
                        InsertSolConfirm();
                    end;      
                }
            }

            trigger OnPreDataItem();
            begin
                oldRcpt := '';
            end;

            trigger OnAfterGetRecord();
            var
                Item : Record Item;
                ItemTracking : Record "Item Tracking Code";
            begin
                //-HEB.174
                pageNo := 0;
                //+HEB.174
                lineasBody := 0;
                IF oldRcpt <> "Document No." THEN BEGIN
                    recPurchRcptHeader.GET("Document No.");
                    oldRcpt := "Document No.";
                END;

                recItem.GET(PurchRcptLine."No.");
            end;
        }
    }

    labels
    {
        SolicitudConformidadLbl = 'SOLICITUD DE CONFORMIDAD';
        RecepcionProductosLbl = 'RECEPCIÓN DE PRODUCTOS';
        NumeroLbl = 'Nº';
        ProductoLbl = 'PRODCUTO:';
        FechaLbl = 'FECHA';
        ProveedorLbl = 'PROVEEDOR:';
        LotesKgLbl = 'LOTES / KG:';
        FirmaAlmacenLbl = 'FIRMA ALMACÉN';
        MuestraLbl = 'MUESTRA:';
        SiLbl = 'SÍ';
        NoLbl = 'NO';
        DictamenLaboratorioLbl = 'DICTAMEN LABORATORIO:';
        FirmaLaboratorioLbl = 'FIRMA LABORATORIO';
    }

    var
        recCompanyInfo : Record "Company Information";
        recPurchRcptHeader : Record "Purch. Rcpt. Header";
        recItem : Record Item;
        lineasBody : Integer;
        oldRcpt : Code[20];
        //-HEB.174
        pageNo : Integer;
        //+HEB.174

    trigger OnInitReport();
    begin
        recCompanyInfo.GET;
        recCompanyInfo.CALCFIELDS(recCompanyInfo.Picture);
    end;

    procedure InsertSolConfirmLog();
    var
        recSolConfirmLog : Record "Solicitud conformidad Log";
    begin
        recSolConfirmLog.INIT;
        recSolConfirmLog."Tipo movimiento" := 0;
        recSolConfirmLog."Tipo Documento" := recSolConfirmLog."Tipo Documento"::Albarán;
        recSolConfirmLog."Nº Documento" := ItemLedgerEntry."Document No.";
        recSolConfirmLog."Nº Linea" := ItemLedgerEntry."Document Line No.";
        recSolConfirmLog."Nº Lote" := ItemLedgerEntry."Lot No.";
        recSolConfirmLog.Usuario := USERID;
        recSolConfirmLog.Fecha := TODAY;
        recSolConfirmLog.Hora := TIME;
        recSolConfirmLog.INSERT(TRUE);
    end;

    procedure InsertSolConfirm();
    var
        recSolConfirm : Record "Solicitud Conformidad";
        recSolConfirm2 : Record"Solicitud Conformidad";
    begin        
        recSolConfirm.RESET;
        recSolConfirm.SETRANGE("Tipo Documento",recSolConfirm."Tipo Documento"::Albarán);
        recSolConfirm.SETRANGE("Nº Documento",ItemLedgerEntry."Document No.");
        recSolConfirm.SETRANGE("Nº Linea",ItemLedgerEntry."Document Line No.");
        recSolConfirm.SETRANGE("Nº Lote",ItemLedgerEntry."Lot No.");

        IF NOT recSolConfirm.FINDFIRST THEN BEGIN
            recSolConfirm2.INIT;
            recSolConfirm2."Tipo Documento" := recSolConfirm."Tipo Documento"::Albarán;
            recSolConfirm2."Nº Documento" := ItemLedgerEntry."Document No.";
            recSolConfirm2."Nº Linea" := ItemLedgerEntry."Document Line No.";
            recSolConfirm2."Nº Lote" := ItemLedgerEntry."Lot No.";
            recSolConfirm2."Cód. Almacen" := ItemLedgerEntry."Location Code";
            ItemLedgerEntry.calcfields("Nº Contenedor");
            recSolConfirm2."Nº Contenedor" := ItemLedgerEntry."Nº Contenedor";
            recSolConfirm2."Nº Producto" := ItemLedgerEntry."Item No.";
            recSolConfirm2.Descripción := ItemLedgerEntry.Description;
            recSolConfirm2."Fecha Pedido" := recPurchRcptHeader."Order Date";
            recSolConfirm2."Fecha Documento" := recPurchRcptHeader."Posting Date";
            recSolConfirm2."Nº Proveedor" := recPurchRcptHeader."Buy-from Vendor No.";
            recSolConfirm2.Nombre := recPurchRcptHeader."Buy-from Vendor Name";
            recSolConfirm2."Fecha Solicitud" := TODAY;
            IF ItemLedgerEntry."Lot No." = '' THEN
                recSolConfirm2."Calidad Lote" := 1;
            recSolConfirm2.INSERT(TRUE);
            END ELSE BEGIN
            IF NOT recSolConfirm.Procesado THEN BEGIN
                recSolConfirm."Fecha Solicitud" := TODAY;
                recSolConfirm.MODIFY(TRUE);
            END;
        END;
    end;
}