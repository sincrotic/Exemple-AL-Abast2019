//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
tableextension 55994 ServiceCrMemoHeaderExt extends "Service Cr.Memo Header"
{
    fields
    {
        //-HEB.508
        field(50017; "SII Exclude"; Boolean)
        {
            Caption = 'SII Exclude';
        }
        //+HEB.508
    }
}