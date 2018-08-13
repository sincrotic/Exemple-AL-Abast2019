tableextension 55802 ValueEntryExt extends "Value Entry"
{
    fields
    {
        //-HEB.223
        field(50000; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Ledger Entry"."Lot No." WHERE ("Entry No."=FIELD("Item Ledger Entry No.")));
        }
        //+HEB.223
    }
    
}