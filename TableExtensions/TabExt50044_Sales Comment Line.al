//HEB.233 MR 07062018 Permetre copiar comentaris de client/proveidor a comanda de venda/compra
tableextension 50044 SalesCommentLine extends "Sales Comment Line" //MyTargetTableId
{
    fields
    {
        // Ja ho fa l'standard
        // Field(50000; "Document Line No."; Integer) //101
        // {
        //     Caption = 'Document Line No.';
        // }
        //-HEB.233
        Field(50001; "Area Code"; Code[10]) //-233
        {
            Caption = 'Area Code';
            TableRelation = "Corporate Area";
        }
        Field(50002; "Comment Code"; Code[10]) //-233
        {
            Caption = '';
            TableRelation = "Comment Area-Code"."Comment Code" WHERE ("Area Code"=FIELD("Area Code"));
        }
        //+HEB.233
    }
}