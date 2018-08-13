//HEB.XXX MT 05062018. Migración Tabla 50002.
table 50002 "Solicitud conformidad Log"
{
    // version PI0008,PI0009
    LookupPageId = "Solicitud Conformidad Log";
    
    fields
    {
        field(1;"Nº mov.";Integer)
        {
            Caption = 'Nº movimiento';            
            AutoIncrement = true;
        }
        field(2;"Tipo movimiento";Option)
        {
            Caption = 'Tipo movimiento';            
            OptionCaption = 'Impresión,Proceso,Calidad,Destino';
            OptionMembers = "Impresión",Proceso,Calidad,Destino;
        }
        field(3;"Nº Documento";Code[20])
        {
            Caption = 'Nº Documento';
        }
        field(4;"Nº Linea";Integer)
        {
            Caption = 'Linea';
        }
        field(5;"Nº Lote";Code[20])
        {
            Caption = 'Nº Lote';
        }
        field(6;Usuario;Code[20])
        {
            Caption = 'Usuario';            
            TableRelation = User;
            ValidateTableRelation = false;
        }
        field(7;Fecha;Date)
        {
            Caption = 'Fecha';
        }
        field(8;Hora;Time)
        {
            Caption = 'Hora';
        }
        field(9;"Calidad Lote";Option)
        {
            Caption = 'Calidad Lote';            
            OptionCaption = '" ,Apto,Reproceso,No Apto"';
            OptionMembers = " ",Apto,Reproceso,"No Apto";
        }
        field(10;"New Calidad Lote";Option)
        {
            Caption = 'New Calidad Lote';            
            OptionCaption = '" ,Apto,Reproceso,No Apto"';
            OptionMembers = " ",Apto,Reproceso,"No Apto";
        }
        field(11;Destino;Code[20])
        {
            Caption = 'Destino';
        }
        field(12;"New Destino";Code[20])
        {
            Caption = 'New Destino';
        }
        field(13;"Tipo Documento";Option)
        {
            Caption = 'Tipo Documento';            
            OptionCaption = 'Albarán,Fabricación';
            OptionMembers = "Albarán","Fabricación";
        }
    }

    keys
    {
        key(Key1;"Nº mov.") { }
    }
}

