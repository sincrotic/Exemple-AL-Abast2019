//HEB.122 MT 25052018. Publicación de campo "Shipment Method Code Ext.".
//                     Ocultación de campo "Shipment Method Code".
pageextension 55740 TransferOrderExt extends "Transfer Order"
{
    layout
    {
        //-HEB.122
        addafter("Shipment Method Code")
        {
            field("Shipment Method Code Ext."; "Shipment Method Code")
            {
                Caption = 'Code';
                Visible = true;
                Lookup = true;
                LookupPageId = ShipmentMethodsNew;
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