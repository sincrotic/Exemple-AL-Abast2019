pageextension 50014 "SalesPersons/PurchasersExt" extends "SalesPersons/Purchasers"
{
    //VersionList NAVW15.00,PI0010
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    //-243 xtrullols 23/07/2015 Fitxa Vendedor/Comprador crear camp Option i bloqueado
    layout
    {
        addafter(Code)
        {
            //-HEB.243
            field("Salesperson Type";"Salesperson Type")
            {
                ApplicationArea = All;
            }
            //+HEB.243
        }
        addafter(Name)
        {
            //-HEB.114
            field("Cód. Grupo comisión";"Cód. Grupo comisión")
            {
                ApplicationArea = All;
            }
            //+HEB.114
        }
        addafter("Phone No.")
        {
            field("E-Mail";"E-Mail")
            {
                ApplicationArea = All;
            }
            field("Job Title";"Job Title")
            {
                ApplicationArea = All;
            }
            field("Next Task Date";"Next Task Date")
            {
                ApplicationArea = All;
            }
            //-HEB.243
            field(Blocked;Blocked)
            {
                ApplicationArea = All;
            }
            //+HEB.243
        }
    }
}