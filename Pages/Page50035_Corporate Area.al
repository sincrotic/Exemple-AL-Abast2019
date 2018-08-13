//HEB.231 MR 07062018 Campos nuevos en tabla Comment Line
page 50035 "Corporate Area"
{
    // version AITANA

    Caption = 'Area Corporativa';
    PageType = List;
    SourceTable = "Corporate Area";
    layout
    {
        area(content)
        {
            repeater(Repeater1)
            {
                field("Area Code";"Area Code")
                {
                }
                field(Description;Description)
                {
                }
            }
        }
    }
}

