//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 50571 NoSeriesListExt extends "No. Series List"
{
    layout
    {
        //-HEB.508
        addlast(Control1)
        {
            field("SII Exclude";"SII Exclude") { }
        }
        //-HEB.508
    }
}