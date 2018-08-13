//HEB.231 MR 07062018 Campos nuevos en tabla Comment Line
pageextension 50125 CommentListExt extends "Comment List"
{
    layout
    {
        addafter(Comment)
        {
            field("Area Code";"Area Code")
            {
                trigger OnValidate();
                begin
                    //-HEB.231
                    IF ("Area Code"<>'') AND ("Comment Code"<>'') THEN
                    BEGIN
                        recComentArea.GET("Area Code","Comment Code");
                        Descripción:=recComentArea."Comment Description";
                    END;
                    //+HEB.231
                end;
            }
            field("Comment Code";"Comment Code")
            {
                trigger OnValidate();
                begin
                    //-HEB.231
                    IF ("Area Code"<>'') AND ("Comment Code"<>'') THEN
                    BEGIN
                    recComentArea.GET("Area Code","Comment Code");
                    Descripción:=recComentArea."Comment Description";
                    END;
                    //+HEB.231
                end;
            }
            field("Descripción";"Descripción")
            {
                Caption = 'Description';
            }
        }
    }
    var
        recComentArea : Record "Comment Area-Code";
        Descripción : Text[30];

    trigger OnAfterGetRecord();
    begin
        //-HEB.231
        Descripción := '';
        IF ("Area Code"<>'') AND ("Comment Code"<>'') THEN BEGIN
            recComentArea.GET("Area Code", "Comment Code");
            Descripción := recComentArea."Comment Description";
        END;
        //+HEB.231
    end;
}