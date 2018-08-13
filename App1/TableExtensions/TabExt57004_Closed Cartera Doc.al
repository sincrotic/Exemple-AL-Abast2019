tableextension 57004 ClosedCarteraDocExt extends "Closed Cartera Doc." //MyTargetTableId
{
    fields
    {
         //-HEB.131
        field (50000; Nombre; Text[100])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(50002; "Nombre cliente"; Text[50])
        {
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No."=field("Account No.")));
        }

        field(50001; "Nombre proveedor"; Text[50])
        {
            Caption = 'Vendor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No."=field("Account No.")));
        }
        //+HEB.131
    }
    
}