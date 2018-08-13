//HEB.156 MR 12062018 PI0025_7064 - Formularios relacionados Añadir Campos
pageextension 55162 SalesQuoteArchive extends "Sales Quote Archive"
{
    layout
    {
        addafter("Sell-to City")
        {
            field("Cause NA";"Cause NA") { }
            field("Date NA";"Date NA") { }
            field("Distributor Code";"Distributor Code") { }
            field("Salesperson/Resp. Code";"Salesperson/Resp. Code") { }
            field("Administr/Resp. Code";"Administr/Resp. Code") { }
        }
    }
}