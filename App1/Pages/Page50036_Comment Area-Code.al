//HEB.231 MR 07062018 Campos nuevos en tabla Comment Line
page 50036 "Comment Area-Code"
{
    // version AITANA

    Caption = 'Comentario por Area';
    PageType = List;
    SourceTable = "Comment Area-Code";
    layout
    {
        area(content)
        {
            repeater(Repeater1)
            {
                field("Area Code";"Area Code")
                {
                }
                field("Comment Code";"Comment Code")
                {
                }
                field("Comment Description";"Comment Description")
                {
                }
            }
        }
    }
}

