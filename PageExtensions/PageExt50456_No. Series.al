//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 50456 NoSeriesExt extends "No. Series"
{
    layout
    {
        //-HEB.508
        addafter("Date Order")
        {
            field("SII Exclude";"SII Exclude") { }
        }
        //+HEB.508
    }
}