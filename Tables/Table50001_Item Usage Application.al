table 50001 "Item Usage/Application"
{
    // version AITANA

    // -185 mmartinez 08/06/2010 Nuevas tablas de familia y usos aplicaciones.

    Caption = 'Item  Usage/Application';

    fields
    {
        field(1;"Item No.";Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(2;"Usage Code";Code[20])
        {
            Caption = 'Usage Code';
            TableRelation = "Customer Discount Group";

            trigger OnValidate();
            begin
                IF recCustDiscGroup.GET("Usage Code") THEN
                  Description:=recCustDiscGroup.Description
                ELSE
                  Description:='';
            end;
        }
        field(3;"Line No.";Integer)
        {
            Caption = 'Line No.';
        }
        field(5;Description;Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1;"Item No.","Usage Code","Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        recCustDiscGroup : Record "Customer Discount Group";
}

