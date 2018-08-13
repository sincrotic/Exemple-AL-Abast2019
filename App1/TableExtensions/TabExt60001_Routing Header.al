//HEB.123 MT 25052018. Añadido campo "Tamaño Lote".
tableextension 60001 RoutingHeaderExt extends "Routing Header"
{
    fields
    {
        //-HEB.123
        field(50000; "Tamaño Lote"; Decimal)
        {
            Caption = 'Tamaño Lote';
            Description = '-123';
            
            trigger OnValidate();
            
            var
                RoutingLine: Record "Routing Line";
            
            begin
                if xRec."Tamaño Lote" <> "Tamaño Lote" then
                begin
                    RoutingLine.RESET;
                    RoutingLine.SETRANGE("Routing No.", "No.");
                    if RoutingLine.FINDFIRST then
                    repeat
                        RoutingLine."Tiempo total ejecución Lote":=RoutingLine."Run Time" * "Tamaño Lote";
                        RoutingLine.Modify(TRUE);
                    until RoutingLine.NEXT=0;
                end;
            end;
        }
        //+HEB.123
    }
    
}