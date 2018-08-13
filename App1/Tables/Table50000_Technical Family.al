//HEB.238 MT 04062018.
table 50000 "Technical Family"
{
    // version AITANA
    //-185 mmartinez 08/06/2010 Nuevas tablas de familia y usos aplicaciones.

    Caption = 'Technical Family';
    LookupPageId = "Techical Families";

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
        }
        field(2;Description;Text[30])
        {
            Caption = 'Description';
        }
        field(3;Division;Option)
        {
            Caption = 'Division';
            OptionCaption = ' ,AZ Div,OP Div,OCC Div';
            OptionMembers = " ","AZ Div","OP Div","OCC Div";
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }
}

