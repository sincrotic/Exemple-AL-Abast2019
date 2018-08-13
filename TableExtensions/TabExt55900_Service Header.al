//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
tableextension 55900 ServiceHeaderExt extends "Service Header"
{
    fields
    {
        //-HEB.508
        field(50017; "SII Exclude"; Boolean)
        {
            Caption = 'SII Exclude';
        }
        //+HEB.508
        modify("Bill-to Customer No.")
        {
            trigger OnAfterValidate();
            var 
                NoSeries : Record "No. Series";
            begin       
                //-HEB.508
                IF ("Posting No. Series" <> '') THEN BEGIN
                    NoSeries.GET("Posting No. Series");
                    "SII Exclude" := NoSeries."SII Exclude";
                END;
                //+HEB.508
            end;
        }
    }
}