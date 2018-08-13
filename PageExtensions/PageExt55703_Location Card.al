//HEB.108 MT 16072018. Muestra el campo "Logísitco" (50000).
pageextension 55703 LocationCardExt extends "Location Card"
{
    layout
    {
        //-HEB.500
        addafter("Home Page")
        {
            field("Código Cliente";"Código Cliente")
            {
                ApplicationArea = All;
            }

            field("Nombre Cliente";"Nombre Cliente")
            {
                ApplicationArea = All;
            }

            field("Código Idioma";"Código Idioma")
            {
                ApplicationArea = All;
            }
        }
        //+HEB.500
        //-HEB.108
        addafter("Use As In-Transit")
        {
            field(Logistico;Logistico){}
        }
        //+HEB.108
    }
    
    actions
    {
    }
}