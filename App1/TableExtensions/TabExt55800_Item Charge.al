//HEB.215 MR 21062018 Exp. 9205: Control Dim. FAMILIA al asociar carrecs producte (CDU 5805)
tableextension 55800 ItemChargeExt extends "Item Charge"
{
    fields
    {
        //-HEB.215
        field(50000; "Check FAMILY Dimension"; Boolean)
        {
            Caption = 'Check FAMILY Dimension';
        }
        //+HEB.215
    }
}