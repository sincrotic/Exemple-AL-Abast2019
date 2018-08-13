pageextension 55824 "Sales Shipment Lines Ext" extends "Sales Shipment Lines" //MyTargetPageId
{
    layout
    {
        //-HEB.157
        addafter("Sell-to Customer No.")
        {
            field("Sell-to Customer Name";"Sell-to Customer Name")
            {

            }
            
        }

        addafter("Bill-to Customer No.")
        {
            field("Bill-to Customer Name";"Bill-to Customer Name")
            {
                Visible = false;
            }
        }
        //+HEB.157
    }
    
    actions
    {
    }
}