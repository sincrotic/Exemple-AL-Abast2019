//HEB.233 MR 07062018 Permetre copiar comentaris de client/proveidor a comanda de venda/compra
pageextension 50067 SalesCommentSheetExt extends "Sales Comment Sheet" //MyTargetPageId
{
    layout
    {
        addafter(Code)
        {
            //-HEB.233
            field("Area Code";"Area Code")
            {
                Visible = false;
            }
            field("Comment Code";"Comment Code")
            {
                Visible = false;
            }
            //+HEB.233
        }        
    }
}