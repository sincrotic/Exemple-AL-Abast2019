//HEB.122 MT 22052018. Publica los campos "Bloqueado" e "INCOTERM Almacén Hebron" en el orden que estaban en la versión 2009
pageextension 50011 ShipmentMethodsExt extends "Shipment Methods"
{
    layout
    {
        addafter(Code)
        {
            //-HEB.122
            field(Bloqueado;Bloqueado)
            {

            }
            //+HEB.122
        }

        addafter(Description)
        {
            //-HEB.122
            field("INCOTERM Almacén Hebron";"INCOTERM Almacén Hebron")
            {

            }
            //+HEB.122
        }
    }
}