pageextension 55806 "Purch. Receipt Lines Ext" extends "Purch. Receipt Lines" //MyTargetPageId
{
    layout
    {
        addbefore("Document No.")
        {
            //-HEB.154
            field("Fecha Registro";"Fecha Registro")
            {

            }
            //+HEB.154
        }
        //-HEB.157
        addafter("Buy-from Vendor No.")
        {

            field("Buy-from Vendor Name";"Buy-from Vendor Name")
            {

            }
        }
        addafter(Quantity)
        {
            field("Sales Order No.";"Sales Order No.")
            {

            }
        }
        addafter("Sales Order No.")
        {
            field("Sales Order Line No.";"Sales Order Line No.")
            {

            }
        }
        addbefore("Unit of Measure")
        {
            field("Order Date";"Order Date")
            {

            }
        }
        //+HEB.157       
    }
    
    actions
    {
    }
}