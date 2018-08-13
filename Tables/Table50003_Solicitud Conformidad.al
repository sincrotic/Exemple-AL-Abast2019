//HEB.XXX MT 05062018. Migración Tabla 50003.
table 50003 "Solicitud Conformidad"
{
    // version PI0008,PI0009
    LookupPageId = "Solicitud Conformidad Pdte.";

    fields
    {
        field(1;"Nº Documento";Code[20])
        {
            Caption = 'Nº Documento';
        }
        field(2;"Nº Linea";Integer)
        {
            Caption = 'Nº Linea';
        }
        field(3;"Nº Lote";Code[20])
        {
            Caption = 'Nº Lote';
        }
        field(4;"Cód. Almacen";Code[20])
        {
            Caption = 'Cód. Almacen';
            TableRelation = Location;
        }
        field(5;"Fecha Pedido";Date)
        {
            Caption = 'Fecha Pedido';
        }
        field(6;"Fecha Documento";Date)
        {
            Caption = 'Fecha Documento';
        }
        field(7;"Fecha Solicitud";Date)
        {
            Caption = 'Fecha Solicitud';
        }
        field(8;"Nº Proveedor";Code[20])
        {
            Caption = 'Nº Proveedor';            
            TableRelation = Vendor;
        }
        field(9;Nombre;Text[100])
        {
            Caption = 'Nombre';            
        }
        field(10;"Nº Producto";Code[20])
        {
            Caption = 'Nº Producto';            
            TableRelation = Item;
        }
        field(11;"Descripción";Text[60])
        {
            Caption = 'Descripción';            
        }
        field(12;"Calidad Lote";Option)
        {
            Caption = 'Calidad Lote';            
            OptionMembers = " ",Apto,Reprocesado,"No Apto";
            OptionCaption = ' ,Apto,Reprocesado,No Apto';   
            trigger OnValidate();
            begin
                creaLog(2);
            end;
        }
        field(13;"Cód. Almacen destino";Code[20])
        {
            Caption = 'Cód. Almacén destino';            
            TableRelation = Location;

            trigger OnValidate();
            begin
                creaLog(3);
            end;
        }
        field(14;Procesado;Boolean)
        {
            Caption = 'Procesado';
        }
        field(15;"Nº Contenedor";Code[50])
        {
            Caption = 'Nº Contenedor';
        }
        field(16;"Nº Transferencia";Code[20])
        {
            Caption = 'Nº Transferencia';            
            Editable = false;
        }
        field(17;"Nº Linea Transferencia";Integer)
        {
            Caption = 'Nº Linea Transferencia';            
            BlankZero = true;
            Editable = false;
        }
        field(18;"Tipo Documento";Option)
        {
            Caption = 'Tipo Documento';            
            OptionCaption = 'Albarán,Fabricación';
            OptionMembers = "Albarán","Fabricación";
        }
    }

    keys
    {
        key(Key1;"Tipo Documento","Nº Documento","Nº Linea","Nº Lote") { }
        key(Key2;"Cód. Almacen","Fecha Pedido","Fecha Documento","Fecha Solicitud","Nº Proveedor","Nº Producto") { }
        key(Key3;Procesado,"Calidad Lote","Cód. Almacen","Cód. Almacen destino") { }
        key(Key4;"Nº Transferencia","Nº Linea Transferencia") { }
    }

    procedure creaLog(tipo : Option "Impresión",Proceso,Calidad,Destino);
    var
        solConfirmLog : Record "Solicitud conformidad Log";
    begin
        solConfirmLog.INIT;
        solConfirmLog."Tipo movimiento":=tipo;
        solConfirmLog."Nº Documento":="Nº Documento";
        solConfirmLog."Nº Linea":="Nº Linea";
        solConfirmLog."Nº Lote":="Nº Lote";
        solConfirmLog.Usuario:=USERID;
        solConfirmLog.Fecha:=TODAY;
        solConfirmLog.Hora:=TIME;
        solConfirmLog."Calidad Lote" := xRec."Calidad Lote";
        solConfirmLog."New Calidad Lote":= "Calidad Lote";
        solConfirmLog.Destino := xRec."Cód. Almacen destino";
        solConfirmLog."New Destino" := "Cód. Almacen destino";
        solConfirmLog.INSERT(TRUE);
    end;
}

