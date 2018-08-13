//HEB.244 MR 11062018  -166 ogarcia   15/09/2009 Exp. 7064 Asociar Nº serie cliente en plantilla contactos
tableextension 55105 CustomerTemplateExt extends "Customer Template"
{
    fields
    {
        //-HEB.166
        Field(50000; "No. Series"; Code[10]) //--165 Exp. 7064
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        //+HEB.166
    }
}