//HEB.238 MT 04062018.
page 50027 "Techical Families"
{
    // version AITANA
    //-185 mmartinez 08/06/2010 Nuevas tablas de familia y usos aplicaciones.

    Caption = 'Techical Families';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Technical Family";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Code;Code)
                {
                }
                field(Description;Description)
                {
                }
                field(Division;Division)
                {
                }
            }
        }
    }

    actions
    {
    }
}

