//HEB.108 MT 13062018. Añadido campo "Nº Contenedor" (50000). 25/07/18 OBSOLETO
tableextension 50336 TrackingSpecificationExt extends "Tracking Specification"
{
    fields
    {
        //-HEB.108
        field(50000;"No. Contenedor";Code[50])
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'Cambio de funcionalidad';
        }
        //+HEB.108
    }
}