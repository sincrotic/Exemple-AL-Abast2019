//HEB.123 MT 04072018. Muestra el campo "Cantidad total Lote".
pageextension 60006 ProductionBOMLinesExt extends "Production BOM Lines"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Cantidad total Lote";"Cantidad total Lote")
            {
            }
        }
    }
}