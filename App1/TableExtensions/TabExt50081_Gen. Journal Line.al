//HEB.244 MR 08062018 Camps relacionats venedor a fitxa client i traspassar a documents
tableextension 50081 GenJournalLineExt extends "Gen. Journal Line"
{
    fields
    {
        //-HEB.244
        Field(50010; "Distributor Code"; Code[10]) //-244
        {
            Caption = 'Distributor Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST(Distribuidor),Blocked=CONST(false));
        }
        Field(50011; "Salesperson/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Salesperson/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Cial."),Blocked=CONST(false));
        }
        Field(50012; "Administr/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Administr/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Administr."),Blocked=CONST(false));
        }
        //+HEB.244
    }
}