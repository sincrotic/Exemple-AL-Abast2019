pageextension 50015 LocationListExt extends "Location List"
{
    layout
    {
        //-HEB.500
        addafter(Name)
        {
            field("Código Cliente";"Código Cliente")
            {
                ApplicationArea = All;
            }
        }
        //+HEB.500
        //-HEB.108
        addafter("Código Cliente")
        {
            field("Use As In-Transit";"Use As In-Transit"){}
            field(Logistico;Logistico){}
            field("Require Receive";"Require Receive"){}
            field(Address;Address){}
        }
        //+HEB.108
    }
    
    actions
    {
    }
}