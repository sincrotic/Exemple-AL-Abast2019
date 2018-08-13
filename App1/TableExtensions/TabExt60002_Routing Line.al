//HEB.123 MT 25052018. Añadido campo "Tiempo total ejecución Lote".
tableextension 60002 RoutingLineExt extends "Routing Line"
{
    fields
    {
        //-HEB.123
        field(50000; "Tiempo total ejecución Lote"; Decimal)
        {
            Caption = 'Tiempo total ejecución Lote';
            Editable = false;
            Description = '-123';
        }
        //+HEB.123
    }
    
}