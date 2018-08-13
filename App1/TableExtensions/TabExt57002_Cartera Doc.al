tableextension 57002 CarteraDocExt extends "Cartera Doc." //MyTargetTableId
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
        
        field(50005; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer."Bill-to Customer No." WHERE ("No."=FIELD("Account No.")));
            Editable = false;
        }
        field(50006; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor."Pay-to Vendor No." WHERE ("No."=FIELD("Account No.")));
            Editable = false;
        }
        //+HEB.131


        modify("Account No.")
        {
            trigger OnAfterValidate();
            var
                recCustomer :Record Customer;
                recVendor :Record Vendor;

            begin
                //-HEB.131
                CASE Type OF
                    Type::Receivable: 
                        IF recCustomer.GET("Account No.") THEN 
                            "Nombre cliente" := recCustomer.Name + recCustomer."Name 2";
                    Type::Payable : 
                        IF recVendor.GET("Account No.") THEN 
                            "Nombre proveedor" := recVendor.Name + recVendor."Name 2";
                END;
                //+HEB.131
            end;
        }
    }
    trigger OnAfterInsert();
    var
        recCustomer :Record Customer;
        recVendor :Record Vendor;
    begin 
        //-HEB.149
        CASE Type OF
            Type::Receivable: 
                IF recCustomer.GET("Account No.") THEN 
                    "Nombre cliente" := recCustomer.Name + recCustomer."Name 2";
            Type::Payable : 
                IF recVendor.GET("Account No.") THEN 
                    "Nombre proveedor" := recVendor.Name + recVendor."Name 2";
                END;
        //+HEB.149
    end;
}