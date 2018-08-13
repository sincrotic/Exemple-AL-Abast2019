//HEB.502 MR 27062018 Nombre proveedor en lista productos proveedor.
tableextension 50099 ItemVendorExt extends "Item Vendor"
{
    fields
    {
        //-HEB.502
        field(50000; "Vendor Name"; Text[50])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE ("No."=FIELD("Vendor No.")));
            Editable = false;
        }
        //+HEB.502
    }
}