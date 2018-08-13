//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
tableextension 50308 NoSeriesExt extends "No. Series"
{
    fields
    {
        //-HEB.508
        field(50000; "SII Exclude"; Boolean)
        {
            Caption = 'SII Exclude';
        }
        //+HEB.508
    }
}