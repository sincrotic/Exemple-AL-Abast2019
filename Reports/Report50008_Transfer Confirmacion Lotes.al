//HEB.111 MT 13062018. Nuevo Report .
//HEB.117 MT 13062018. Elimina transferencias pendientes de envío sin lotes.
report 50008 "Transfer Confirmacion Lotes"
{
    //-111 ogarcia 08/04/2008 Proceso que genera los ped. transferencia segun lo indicado en la tabla 50003: Solicitud de confirmación.
    //-117 ogarcia 10/10/2008 Comprobar si existen tranferencias pdtes. de envio sin lotes para eliminarlas

    //UsageCategory = Administration;
    //ApplicationArea = All;
    Caption = 'Transfer. Confirmación Lotes';
    ProcessingOnly = true;
    UseRequestPage = false;
    
    dataset
    {
        dataitem(Origen; Location)
        {
            RequestFilterFields = Code;

            dataitem(Destino; Location)
            {
                DataItemTableView = sorting(Code);

                dataitem("Solicitud Conformidad"; "Solicitud Conformidad")
                {
                    DataItemTableView = SORTING(Procesado,"Calidad Lote","Cód. Almacen","Cód. Almacen destino") WHERE(Procesado=CONST(false),"Calidad Lote"=FILTER(<>" "));
                    DataItemLinkReference = Destino;

                    trigger OnPreDataItem();
                    begin
                        SETRANGE("Cód. Almacen", Origen.Code);
                        SETRANGE("Cód. Almacen destino", Destino.Code);
                        existeCabecera := FALSE;
                        LineNo := 0;
                    end;

                    trigger OnAfterGetRecord();
                    var
                        movProducto : Record "Item Ledger Entry";
                        SolConfirm: Record "Solicitud Conformidad";	
                        SolConfirmLog : Record	"Solicitud conformidad Log";	
                        LotInfo : Record "Lot No. Information";	
                    begin
                        BuscaMovProducto("Tipo Documento", movProducto);

                        IF (Destino.Code <> Origen.Code) THEN BEGIN
                            IF NOT existeCabecera THEN
                                CreateCabecera;
                            LineNo+=10000;
                            LinTrans.INIT;
                            LinTrans.VALIDATE("Document No.",CabTrans."No.");
                            LinTrans.VALIDATE("Line No.",LineNo);
                            LinTrans.VALIDATE("Item No.", "Nº Producto");
                            LinTrans.VALIDATE(Quantity,movProducto.Quantity);
                            LinTrans.VALIDATE("Qty. to Ship",movProducto.Quantity);
                            LinTrans.INSERT(TRUE);
                            IF movProducto."Lot No." <> '' THEN
                                CreaLinSeguimiento(movProducto."Lot No.");
                            //-117
                            CompruebaTransferencias(movProducto);
                            //+117
                        END;

                        //Modificar Lot. Info
                        IF movProducto."Lot No." <> '' THEN BEGIN
                            IF LotInfo.GET("Nº Producto",movProducto."Variant Code",movProducto."Lot No.") THEN BEGIN
                                LotInfo."Test Quality":="Solicitud Conformidad"."Calidad Lote";
                                LotInfo.MODIFY(TRUE);
                            END;
                        END;

                        SolConfirm.GET("Tipo Documento","Nº Documento","Nº Linea","Nº Lote");
                        SolConfirm."Nº Transferencia" := LinTrans."Document No.";
                        SolConfirm."Nº Linea Transferencia" := LinTrans."Line No.";
                        SolConfirm.Procesado := TRUE;
                        SolConfirm.MODIFY;

                        //Actualizar tabla de log
                        SolConfirmLog.INIT;
                        SolConfirmLog."Tipo movimiento" := 1;
                        SolConfirmLog."Tipo Documento" := "Solicitud Conformidad"."Tipo Documento";
                        SolConfirmLog."Nº Documento" := "Solicitud Conformidad"."Nº Documento";
                        SolConfirmLog."Nº Linea" := "Solicitud Conformidad"."Nº Linea";
                        SolConfirmLog."Nº Lote" := "Solicitud Conformidad"."Nº Lote";
                        SolConfirmLog.Usuario := USERID;
                        SolConfirmLog.Fecha := TODAY;
                        SolConfirmLog.Hora := TIME;
                        SolConfirm."Calidad Lote" := "Solicitud Conformidad"."Calidad Lote";
                        SolConfirm."Cód. Almacen destino" := "Solicitud Conformidad"."Cód. Almacen destino";
                        SolConfirmLog.INSERT(TRUE);
                    end;

                    trigger OnPostDataItem();
                    begin
                        //Regsitrar Ped. Transferencia --> Envio
                        //Si el Almacén destino Requiere recepcion generar el Recibo Almacén
                        IF existeCabecera THEN BEGIN
                            TransferPostShipment.RUN(CabTrans);
                            IF Destino."Require Receive" THEN
                                GetSourceDocInbound.CreateFromInbndTransferOrder(CabTrans)
                            END;
                    end;
                }
            }
        }
    }
    
    var
        CabTrans : Record "Transfer Header";
        LinTrans : Record "Transfer Line";
        InvtSetup : Record "Inventory Setup";
        TransferPostShipment : Codeunit "TransferOrder-Post Shipment";
        GetSourceDocInbound : Codeunit "Get Source Doc. Inbound";
        existeCabecera : Boolean;
        HasInventorySetup : Boolean;
        LineNo : Integer;
        Text001 : Label 'No se encuentra en %1: %2 %3 %4 Lote: %';

    procedure CreateCabecera()
    var
        NoSeriesMgt : Codeunit NoSeriesManagement;
    begin
        CLEAR(CabTrans);
        WITH CabTrans DO BEGIN
            INIT;
            GetInventorySetup;
            NoSeriesMgt.InitSeries(InvtSetup."Transfer Order Nos.",'',"Posting Date","No.","No. Series");
            VALIDATE("Shipment Date",WORKDATE);
            VALIDATE("Posting Date",WORKDATE);
            INSERT;
            VALIDATE("Transfer-from Code",Origen.Code);
            VALIDATE("Transfer-to Code",Destino.Code);
            MODIFY;
        END;

        existeCabecera:=TRUE;
    end;

    local procedure GetInventorySetup()
    begin
        IF NOT HasInventorySetup THEN BEGIN
            InvtSetup.GET;
            InvtSetup.TESTFIELD("Transfer Order Nos.");
            HasInventorySetup := TRUE;
        END;
    end;

    procedure BuscaMovProducto(TipoMov : Option Albarán,Fabricación;var movProducto : Record "Item Ledger Entry")
    begin
        CLEAR(movProducto);
        CASE TipoMov OF
        TipoMov::Albarán:
            BEGIN
                WITH movProducto DO BEGIN
                    RESET;
                    SETCURRENTKEY("Document No.","Document Type","Document Line No.");
                    SETRANGE("Document No.","Solicitud Conformidad"."Nº Documento");
                    SETRANGE("Document Type","Document Type"::"Purchase Receipt");
                    SETRANGE("Document Line No.","Solicitud Conformidad"."Nº Linea");
                    SETRANGE("Lot No.","Solicitud Conformidad"."Nº Lote");
                    IF NOT FINDFIRST THEN
                        ERROR(Text001,TABLECAPTION,
                            "Document Type"::"Purchase Receipt",
                            "Solicitud Conformidad"."Nº Documento",
                            "Solicitud Conformidad"."Nº Linea",
                            "Solicitud Conformidad"."Nº Lote");
                END;
            END;
        TipoMov::Fabricación:
            BEGIN
                WITH movProducto DO BEGIN
                    RESET;
                    SETCURRENTKEY("Order No.","Order Line No.","Entry Type","Prod. Order Comp. Line No.");
                    SETRANGE("Order No.","Solicitud Conformidad"."Nº Documento");
                    SETRANGE("Order Line No.","Solicitud Conformidad"."Nº Linea");
                    SETRANGE("Entry Type","Entry Type"::Output);
                    SETRANGE("Lot No.","Solicitud Conformidad"."Nº Lote");
                    IF NOT FINDFIRST THEN
                        ERROR(Text001,TABLECAPTION,
                            TipoMov::Fabricación,
                            "Solicitud Conformidad"."Nº Documento",
                            "Solicitud Conformidad"."Nº Linea",
                            "Solicitud Conformidad"."Nº Lote");
                END;
            END;
        END;
    end;

    procedure CreaLinSeguimiento(LotNo : Code[20])
    var
        SourceSpecification	: Record "Tracking Specification";
        TempTrackingSpecificationLines	: Record "Tracking Specification" temporary;
        ItemTrackingMgt	: Codeunit "Item Tracking Management";
    begin
        //Linea de transferencia
        SourceSpecification.INIT;
        SourceSpecification.VALIDATE("Item No.",LinTrans."Item No.");
        SourceSpecification.VALIDATE("Location Code",LinTrans."Transfer-from Code");
        SourceSpecification.VALIDATE("Quantity (Base)",LinTrans.Quantity);
        SourceSpecification.VALIDATE("Source Type",DATABASE::"Transfer Line");
        SourceSpecification.VALIDATE("Source Subtype",0);
        SourceSpecification.VALIDATE("Source ID",LinTrans."Document No.");
        SourceSpecification.VALIDATE("Source Batch Name",'');
        SourceSpecification.VALIDATE("Source Ref. No.",LinTrans."Line No.");
        SourceSpecification.VALIDATE(Correction,FALSE);

        //Lote Asociado
        TempTrackingSpecificationLines.INIT;
        TempTrackingSpecificationLines."Serial No.":='';
        TempTrackingSpecificationLines."Lot No.":= LotNo;
        TempTrackingSpecificationLines.VALIDATE("Quantity (Base)",LinTrans.Quantity);
        TempTrackingSpecificationLines.INSERT(TRUE);

        //Generar Movimientos
        ItemTrackingMgt.SetGlobalParameters(SourceSpecification,
                                            TempTrackingSpecificationLines,
                                            CabTrans."Shipment Date");
        ItemTrackingMgt.RUN;
    end;

    procedure CompruebaTransferencias(mprod : Record "Item Ledger Entry")
    var
        TransHeader	: Record "Transfer Header";
        TransLine : Record "Transfer Line";
        t337 : Record "Reservation Entry";
        ctad : Decimal;
        tipoCaso : Integer;
        ctadARegularizar : Decimal;		
    begin
        ctadARegularizar:=mprod.Quantity;

        TransHeader.RESET;
        TransHeader.SETCURRENTKEY("Transfer-from Code","Transfer-to Code");
        TransHeader.SETRANGE("Transfer-from Code",Origen.Code);
        TransHeader.SETRANGE("Transfer-to Code",Destino.Code);
        TransHeader.SETRANGE(Status,TransHeader.Status::Open);
        IF TransHeader.FINDFIRST THEN
            REPEAT
                TransLine.RESET;
                TransLine.SETCURRENTKEY("Document No.","Item No.","Outstanding Quantity");
                TransLine.SETRANGE("Document No.",TransHeader."No.");
                TransLine.SETRANGE("Item No.","Solicitud Conformidad"."Nº Producto");
                TransLine.SETFILTER("Outstanding Quantity",'<>0');
                IF TransLine.FINDFIRST THEN
                    REPEAT
                        t337.RESET;
                        t337.SETCURRENTKEY("Source Type","Source Subtype","Source ID","Source Ref. No.","Item No.");
                        t337.SETRANGE("Source Type",DATABASE::"Transfer Line");
                        t337.SETRANGE("Source Subtype",0);
                        t337.SETRANGE("Source ID",TransLine."Document No.");
                        t337.SETRANGE("Source Ref. No.",TransLine."Line No.");
                        t337.SETRANGE("Item No.",TransLine."Item No.");
                        IF NOT t337.FINDFIRST THEN
                            BEGIN
                                IF TransLine."Outstanding Quantity" > ctadARegularizar THEN
                                    tipoCaso:=1
                                ELSE
                                    tipoCaso:=2;

                                CASE tipoCaso OF
                                1: BEGIN
                                    ctad:= TransLine."Outstanding Quantity" - ctadARegularizar;
                                    TransLine.VALIDATE(Quantity, ctad);
                                    TransLine.MODIFY(TRUE);
                                    ctadARegularizar:=0;
                                    END;
                                2: BEGIN
                                    ctad:= TransLine.Quantity - TransLine."Outstanding Quantity";
                                    ctadARegularizar-=TransLine."Outstanding Quantity";
                                    IF ctad = 0 THEN
                                        TransLine.DELETE(TRUE)
                                    ELSE BEGIN
                                        TransLine.VALIDATE(Quantity, ctad);
                                        TransLine.MODIFY(TRUE);
                                    END;
                                END;
                            END;
                        END;
                    UNTIL (TransLine.NEXT=0) OR (ctadARegularizar = 0);
                IF TransLine.COUNT = 0 THEN
                    TransHeader.DELETE(TRUE);
            UNTIL (TransHeader.NEXT = 0) OR (ctadARegularizar = 0);
    end;
}