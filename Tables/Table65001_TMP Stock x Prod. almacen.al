table 65001 "TMP Stock x Prod. almacen"
{
    // version AITANA
    // -143 ogarcia 26/01/2009

    Caption = 'TMP Stock x Prod. almacen';

    fields
    {
        field(10;"Nº producto";Code[20])
        {
            Caption = 'Item No.';
        }
        field(11;"Cód. Almacen";Code[20])
        {
            Caption = 'Location Code';
        }
        field(12;"Nº Lote";Code[20])
        {
            Caption = 'Lot No.';
        }
        field(13;"Descripción";Text[50])
        {
            Caption = 'Description';
        }
        field(14;Cantidad;Decimal)
        {
            Caption = 'Quantity';
        }
    }

    keys
    {
        key(Key1;"Nº producto","Cód. Almacen","Nº Lote")
        {
        }
    }
}

