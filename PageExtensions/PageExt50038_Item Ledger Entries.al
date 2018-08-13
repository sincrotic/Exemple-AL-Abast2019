//HEB.230 MR 11062018 Al formulari de mov. producto afegir el cost unitari
pageextension 50038 ItemLedgerEntriesExt extends "Item Ledger Entries"
{
    
    layout
    {
        //+HEB.134
        addafter("Variant Code")
        {
            field("Descripción Producto";"Descripción Producto")
            {
                ApplicationArea = All;
            }
        }
        addafter("Prod. Order Comp. Line No.")
        {
            field(Nombre;Nombre)
            {
                Caption = 'Name';
                ApplicationArea = All;
            }
        }
        //-HEB.134
        //-HEB.230
        addafter("Sales Amount (Actual)")
        {
            field(UnitCostCalculated;UnitCostCalculated)
            {
                Editable = false;
                Caption = 'Unit Cost';
            }
            field(UnitCostCalculatedNoInvent;UnitCostCalculatedNoInvent)
            {
                Editable = false;
                Caption = 'No Invent. Unit Cost';
            }
        }
        //+HEB.230
        //-HEB.108
        addafter("Lot No.")
        {
            field("Nº Contenedor";"Nº Contenedor") { }
        }
        //+HEB.108
    }
    trigger OnAfterGetRecord();
    var
        recVendor :Record Vendor;
        recCustomer :Record Customer;
    begin 
        CASE "Source Type" OF
            "Source Type"::Vendor: 
                IF recVendor.GET("Source No.") THEN
                    Nombre := recVendor.Name + recVendor."Name 2";
            "Source Type"::Customer:
                IF recCustomer.GET("Source No.") THEN
                    Nombre := recCustomer.Name + recCustomer."Name 2";
            ELSE
                Nombre:='';
        END;
        //-HEB.230
        UnitCostCalculated := 0;
        CALCFIELDS("Cost Amount (Expected)","Cost Amount (Actual)","Cost Amount (Non-Invtbl.)");
        IF (Quantity <> 0) THEN BEGIN
            UnitCostCalculated := ROUND(("Cost Amount (Expected)" + "Cost Amount (Actual)") / Quantity, 0.001);
            UnitCostCalculatedNoInvent := ROUND(("Cost Amount (Expected)" + "Cost Amount (Actual)" + "Cost Amount (Non-Invtbl.)") / Quantity, 0.001);
        END;
        //+HEB.230
    end;
    var 
        Nombre :Text[100];
        UnitCostCalculated : Decimal;		
        UnitCostCalculatedNoInvent : Decimal;		
}