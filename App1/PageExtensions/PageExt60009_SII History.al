//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 60009 SIIHistoryExt extends "SII History"
{
    layout
    {
        //-HEB.508
        addlast(Group)
        {
            field(Excluded;Excluded) { }
        }
        //+HEB.508
    }
}