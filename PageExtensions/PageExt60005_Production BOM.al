//HEB.123 MT 04072018. Muestra el campo "Tamaño Lote".
pageextension 60005 ProductionBOMExt extends "Production BOM"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Tamaño Lote";"Tamaño Lote")
            {
            }
        }
    }
}