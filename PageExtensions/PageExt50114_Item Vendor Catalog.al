
//HEB.502 MR 27062018 Nombre proveedor en lista productos proveedor.
pageextension 50114 ItemVendorCatalogExt extends "Item Vendor Catalog"
{
    layout
    {
        //-HEB.502
        addafter("Vendor No.")
        {
            field("Vendor Name";"Vendor Name") { }
        }
        //+HEB.502
    }
}