//HEB.122 MT 22052018. Añadidos campos "Bloqueado" e "INCOTERM Almacén Hebron"
tableextension 50010 ShipmentMethodExt extends "Shipment Method"
{
    fields
    {
        //-HEB.122
        field(50000;"Bloqueado";Boolean)
        {
            Caption = 'Bloqueado';
        }
        field(50001;"INCOTERM Almacén Hebron";Boolean)
        {
            Caption = 'INCOTERM Almacén Hebron';
        }
        //+HEB.122
    }
    
}