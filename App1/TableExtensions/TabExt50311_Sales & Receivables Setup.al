tableextension 50311 SalesReceivablesSetupExt extends "Sales & Receivables Setup"
{
    fields
    {
        //-HEB.155
        Field(50001; "Archivo Body Pedidos (ES)"; Text[250]) //-155
        {
            Caption = 'Archivo Body Pedidos (ES)';
            ExtendedDatatype = URL;
        }
        //+HEB.155
        //-HEB.155
        Field(50002; "Archivo Body Pedidos (ENU)"; Text[250]) //-155
        {
            Caption = 'Archivo Body Pedidos (ENU)';
            ExtendedDatatype = URL;
        }
        //+HEB.155
        //-HEB.218
        field(50004; "ProForma Nos."; code[10])
        {
            Caption = 'ProForma Nos.';
            TableRelation = "No. Series";
        }
        //+HEB.218
    }
}