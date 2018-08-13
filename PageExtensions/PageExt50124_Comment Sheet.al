//HEB.231 MR 07062018 Campos nuevos en tabla Comment Line
pageextension 50124 CommentSheetExt extends "Comment Sheet"
{
    layout
    {
        addafter(Comment)
        {
            field("Area Code";"Area Code")
            {
                trigger OnValidate();
                begin
                    //-231
                    IF ("Area Code" <> '') AND ("Comment Code" <> '') THEN
                    BEGIN
                        recComentArea.GET("Area Code", "Comment Code");
                        Descripción := recComentArea."Comment Description";
                    END;
                    //+231
                end;
            }
            field("Comment Code";"Comment Code")
            {
                trigger OnValidate();
                begin
                    //-231
                    IF ("Area Code" <> '') AND ("Comment Code" <> '') THEN
                    BEGIN
                    recComentArea.GET("Area Code", "Comment Code");
                    Descripción := recComentArea."Comment Description";
                    END;
                    //+231
                end;
            }
            field("Descripción";"Descripción")
            {
                Caption = 'Description';
            }
        }
    }
    trigger OnAfterGetRecord();
    begin
        //-231
        Descripción := '';
        IF ("Area Code"<>'') AND ("Comment Code"<>'') THEN
        BEGIN
            recComentArea.GET("Area Code", "Comment Code");
            Descripción := recComentArea."Comment Description";
        END;
        //+231
    end;
    var
        recComentArea : Record "Comment Area-Code";
        Descripción : Text[30];
}