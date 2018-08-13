//HEB.123 MT 25052018. Añadido campo "Cantidad total Lote".
//                     Cálculo de Cantidad * Tamaño Lote.
tableextension 60004 ProductionBOMLineExt extends "Production BOM Line"
{
    fields
    {
        //-HEB.123
        field(50000; "Cantidad total Lote"; Decimal)
        {
            Caption = 'Cantidad total Lote';
            Editable = false;
            Description = '-123';
        }
        //+HEB.123
    }
    
    //-HEB.123
    procedure UpdateCantidadTotal(cdadLote : Decimal)
    begin
        
        "Cantidad total Lote":= Quantity * cdadLote;
    end;
    //+HEB.123
}