//HEB.001 MR 30052018. Excluir de 340
//HEB.184 MR 30052018. Nuevo Check Grupos de aduana
tableextension 50323 VATBusinessPostingGroupExt extends "VAT Business Posting Group" //MyTargetTableId
{
    fields
    {
        field(50000; "Requiere DUA"; Boolean) //-184
        {
            Caption = 'Requieres DUA';
        }
        field(50001; "Excluir de 340"; Boolean) //HEB.001
        {
            Caption = 'Excluir de 340';
        }
    }
}