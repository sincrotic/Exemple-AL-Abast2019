pageextension 57002 PayablesCarteraDocsExt extends "Payables Cartera Docs" //MyTargetPageId
{
    layout
    {
        //-HEB.131
        addafter("Account No.")
        {
            field("Nombre proveedor";"Nombre proveedor")
            {
                ApplicationArea = All;
            }
        }
        addafter("Nombre proveedor")
        {
            field("Pay-to Vendor No.";"Pay-to Vendor No.")
            {
                ApplicationArea = All;
            }
        }
        //+HEB.131
    }
    
    actions
    {
    }
    
}