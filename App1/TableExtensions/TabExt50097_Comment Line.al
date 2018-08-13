//HEB.231 MR 07062018 Campos nuevos en tabla Comment Line
//HEB.233 MR 07062018 Permetre copiar comentaris de client/proveidor a comanda de venda/compra
//HEB.240 xtrullols 03/06/2015 Formulari amb filtres per llistar clients/proveïdors/productes. SP20150603_HEB. Clau nova:
//                           "Table Name,No.,Area Code,Comment Code"
tableextension 50097 CommentLine extends "Comment Line"
{
    fields
    {
        //-HEB.233
        Field(50000; "Document Line No."; Integer) //101
        {
            Caption = 'Document Line No.';
        }
        //+HEB.233
        //-HEB.231
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
        //+HEB.231
    }
    // keys
    // {
    //     key(PK; "Table Name", "No.", "Document Line No.", "Line No.");
    //     key(ExtKey; "Table Name", "No.", "Area Code", "Comment Code");
    // }
}