//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
tableextension 60005 SIIHistoryExt extends "SII History"
{
    fields
    {
        //-HEB.508
        field(50000; Excluded; Boolean)
        {
            Caption = 'Excluded';
            InitValue = false;
        }
        //+HEB.508
    }
}