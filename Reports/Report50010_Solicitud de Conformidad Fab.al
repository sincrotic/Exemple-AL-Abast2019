//HEB.XXX MT 05062018. Migración Report 50010.
//HEB.174 MT 05062018. Más de 5 lotes por línea.
report 50010 "Solicitud de Conformidad Fab."
{
    //-119 ogarcia 09/10/2008 Generar solicitud conformidad desde OP
    //-174 ogarcia 09/11/2009 Permitir mostrar + de 5 lotes por linea

    DefaultLayout = RDLC;
    RDLCLayout = '.\Reports\Layouts\Solicitud de Conformidad Fab.rdl';
    Caption = 'Solicitud de Conformidad Fab.';
    UsageCategory = ReportsAndAnalysis;
    

    dataset
    {
        dataitem(ProdOrderLine; "Prod. Order Line")
        {
            DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.");
            RequestFilterFields = "Prod. Order No.", "Line No.";

            dataitem(PageLoop;"Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number=CONST(1));
                DataItemLinkReference = ProdOrderLine;

                column(ProdOrderNo; ProdOrderLine."Prod. Order No."){}
                column(ItemDescription; ProdOrderLine.Description){}
                column(WorkDate; FORMAT(WorkDate)){}
                column(CompanyLogo; recCompanyInfo.Picture){}
                //-HEB.174
                column(pageNo;pageNo){}
                //+HEB.174

                dataitem(ItemLedgerEntry;"Item Ledger Entry")
                {
                    DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Entry Type"=CONST(Output), "Order Type"=CONST(Production));
                    DataItemLinkReference = "ProdOrderLine";
                    DataItemLink = "Order No."=FIELD("Prod. Order No."), "Order Line No."=FIELD("Line No.");
                    
                    column(Lot_No_; "Lot No."){}
                    column(Quantity; Quantity){}

                    trigger OnAfterGetRecord();
                    begin
                        lineasBody+=1;
                        IF lineasBody=6 THEN BEGIN
                            //-HEB.174
                            pageNo+=1;
                            //+HEB.174
                            lineasBody:=1;
                        END;
                        InsertSolConfirmLog();
                        InsertSolConfirm();
                    end;
                }
            }

            trigger OnPreDataItem();
            begin
                oldOP := '';
                //-HEB.174
                pageNo:=0;
                //+HEB.174
            end;

            trigger OnAfterGetRecord();
            var
                Item : Record Item;
                ItemTracking : Record "Item Tracking Code";
            begin
                lineasBody := 0;
                IF oldOP <> "Prod. Order No." THEN BEGIN
                    recProdOrderHeader.GET(Status, "Prod. Order No.");
                    oldOP := "Prod. Order No.";
                END;
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
        recProdOrderHeader : Record "Production Order";
        lineasBody : Integer;
        oldOP : Code[20];
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
        recSolConfirmLog."Tipo Documento" := recSolConfirmLog."Tipo Documento"::Fabricación;
        recSolConfirmLog."Nº Documento" := ItemLedgerEntry."Order No.";
        recSolConfirmLog."Nº Linea" := ItemLedgerEntry."Order Line No.";
        recSolConfirmLog."Nº Lote" := ItemLedgerEntry."Lot No.";
        recSolConfirmLog.Usuario:= USERID;
        recSolConfirmLog.Fecha:= TODAY;
        recSolConfirmLog.Hora:= TIME;
        recSolConfirmLog.INSERT(TRUE);
    end;

    procedure InsertSolConfirm();
    var
        recSolConfirm : Record "Solicitud Conformidad";
        recSolConfirm2 : Record "Solicitud Conformidad";
    begin        
        recSolConfirm.RESET;
        recSolConfirm.SETRANGE("Tipo Documento", recSolConfirm."Tipo Documento"::Fabricación);
        recSolConfirm.SETRANGE("Nº Documento", ItemLedgerEntry."Order No.");
        recSolConfirm.SETRANGE("Nº Linea", ItemLedgerEntry."Order Line No.");
        recSolConfirm.SETRANGE("Nº Lote", ItemLedgerEntry."Lot No.");

        IF NOT recSolConfirm.FINDFIRST THEN BEGIN
            recSolConfirm2.INIT;
            recSolConfirm2."Tipo Documento" := recSolConfirm2."Tipo Documento"::Fabricación;
            recSolConfirm2."Nº Documento" := ItemLedgerEntry."Order No.";
            recSolConfirm2."Nº Linea" := ItemLedgerEntry."Order Line No.";
            recSolConfirm2."Nº Lote" := ItemLedgerEntry."Lot No.";
            recSolConfirm2."Cód. Almacen" := ItemLedgerEntry."Location Code";
            ItemLedgerEntry.CalcFields("Nº Contenedor");
            recSolConfirm2."Nº Contenedor" := ItemLedgerEntry."Nº Contenedor";
            recSolConfirm2."Nº Producto" := ItemLedgerEntry."Item No.";
            recSolConfirm2.Descripción:= ItemLedgerEntry.Description;
            recSolConfirm2."Fecha Pedido" := recProdOrderHeader."Creation Date";
            recSolConfirm2."Fecha Documento" := recProdOrderHeader."Finished Date";
            recSolConfirm2."Nº Proveedor" := '';
            recSolConfirm2.Nombre := '';
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