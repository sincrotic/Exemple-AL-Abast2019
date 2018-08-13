//HEB.122 MT 24052018. Publicación de campo "Shipment Method Code Ext.".
//                     Ocultación de campo "Shipment Method Code".
//HEB.244 MR 11062018 Camps relacionats venedor a fitxa client i traspassar a documents
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 50043 SalesInvoiceExt extends "Sales Invoice"
{
    layout
    {
        //-HEB.122
        addfirst("Shipment Method")
        {
            field("Shipment Method Code Ext."; "Shipment Method Code Ext.")
            {
                Caption = 'Code';
                Visible = true;
                // Lookup = true;
                // LookupPageId = ShipmentMethodsNew;
            }
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        //+HEB.122
        //-HEB.244
        addafter("Posting No.")
        {
            field("Distributor Code";"Distributor Code") { }
            field("Salesperson/Resp. Code";"Salesperson/Resp. Code") { }
            field("Administr/Resp. Code";"Administr/Resp. Code") { }
        }
        //+HEB.244
        //-HEB.508
        addfirst("SII Information")
        {
            field("SII Exclude";"SII Exclude") { }
        }
        //+HEB.508
    }
}