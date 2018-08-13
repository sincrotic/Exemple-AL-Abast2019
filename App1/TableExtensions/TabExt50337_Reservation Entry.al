//HEB.108 MT 13062018. Añadido campo "Nº Contenedor". 25/07/18 OBSOLETO
tableextension 50337 ReservationEntryExt extends "Reservation Entry"
{
    fields
    {
        //-HEB.108
        field(50000;"Nº Contenedor";Code[50])
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'Cambio de funcionalidad';
        }
        //+HEB.108
    }
}