//HEB.108 MT 25072018. Añadido campo "Nº Contenedor" (50000).
tableextension 56505 LotNoInformationExt extends "Lot No. Information"
{
    fields
    {
        //-HEB.108
        field(50000;"Nº Contenedor";Code[50])
        {
            Description = '-108 PI0004';
            Caption = 'Container Nº';
        }
        //+HEB.108
    }
}