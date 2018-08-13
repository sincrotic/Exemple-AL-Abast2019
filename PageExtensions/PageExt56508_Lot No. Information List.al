//HEB.108 MT 25072018. Añadido campo "Nº Contenedor" (50000).
pageextension 56508 LotNoInformationListExt extends "Lot No. Information List"
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