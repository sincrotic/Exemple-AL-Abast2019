//HEB.108 MT 25072018. Añadido campo "Nº Contenedor" (50000).
pageextension 56505 LotNoInformationCardExt extends "Lot No. Information Card"
{
    layout
    {
        //-HEB.108
        addafter("Lot No.")
        {
            field("Nº Contenedor";"Nº Contenedor")
            {
                ShowMandatory = true;
            }
        }
        //+HEB.108
    }
}