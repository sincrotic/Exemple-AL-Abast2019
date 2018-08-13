tableextension 50032 ItemLedgeEntryExt extends "Item Ledger Entry"
{
    fields
    {
        //-HEB.108
        field(50000; "Nº Contenedor"; Code[50]) //-108 PI0004
        {
            Caption = 'Container No.';
            Description = '108 PI0004';
            FieldClass = FlowField;
            CalcFormula = lookup("Lot No. Information"."Nº Contenedor" where ("Lot No."=field("Lot No."),"Item No."=field("Item No."),"Variant Code"=field("Variant Code")));
        }
        //+HEB.108
        //-HEB.134
        field(50003; "Descripción Producto"; Text[50]) //-134
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where ("No."=field("Item No.")));
            Caption = 'Item Description';
            Editable = false;
        }
        //+HEB.134
        //-HEB.151
        field(50001; "Contact No"; Code[20])
        {
            Caption = 'Contact No';
            TableRelation = Contact;
        }
        field(50002; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            FieldClass = FlowField;
            CalcFormula = Lookup("Value Entry"."Reason Code" WHERE ("Item Ledger Entry No."=FIELD("Entry No.")));
            Editable = false;
            TableRelation = "Reason Code";
        }
        //+HEB.151
    }
    keys
    {
        // key(PK; "Order No.","Order Line No.","Entry Type","Prod. Order Comp. Line No.");
    }
    
}