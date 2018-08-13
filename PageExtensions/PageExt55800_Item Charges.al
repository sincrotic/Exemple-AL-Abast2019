//HEB.215 MR 21062018 Exp. 9205: Control Dim. FAMILIA al asociar carrecs producte (CDU 5805)
pageextension 55800 ItemChargesExt extends "Item Charges"
{
    layout
    {
        addafter(Description)
        {
            //-HEB.215
            field("Check FAMILY Dimension";"Check FAMILY Dimension") { }
            //+HEB.215
        }
    }
}