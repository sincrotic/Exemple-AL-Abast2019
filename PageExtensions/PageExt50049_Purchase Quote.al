//HEB.122 MT 24052018. Publicación de campo "Shipment Method Code Ext.".
//                     Ocultación de campo "Shipment Method Code".
pageextension 50049 PurchaseQuoteExt extends "Purchase Quote"
{
    layout
    {
        //-HEB.122
        addafter("Pmt. Discount Date")
        {
            field("Shipment Method Code Ext."; "Shipment Method Code Ext.")
            {
                Caption = 'Shipment Method Code';
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
    }
    
    actions
    {
    }
}