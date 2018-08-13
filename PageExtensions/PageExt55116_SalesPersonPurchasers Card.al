pageextension 55116 "Salesperson/Purchaser CardExt" extends "Salesperson/Purchaser Card"
{
    //VersionList NAVW15.00,PI0010
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    //-243 xtrullols 23/07/2015 Fitxa Vendedor/Comprador crear camp Option i bloqueado
    layout
    {
        addbefore("Global Dimension 1 Code")
        {
            //-HEB.114
            field("Cód. Grupo comisión";"Cód. Grupo comisión")
            {
                ApplicationArea = All;
            }
            //+HEB.114
            //-HEB.243
            field("Salesperson Type";"Salesperson Type")
            {
                ApplicationArea = All;
            }
            //+HEB.243
            //-HEB.243
            field(Blocked;Blocked)
            {
                ApplicationArea = All;
            }
            //+HEB.243
        }
    }
}