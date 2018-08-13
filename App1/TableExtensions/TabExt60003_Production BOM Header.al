//HEB.123 MT 25052018. Añadido campo "Tamaño Lote".
tableextension 60003 ProductionBOMHeaderExt extends "Production BOM Header"
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
                ProdBOMLine: Record "Production BOM Line";
            
            begin
                if xRec."Tamaño Lote" <> "Tamaño Lote" then
                begin
                    ProdBOMLine.Reset;
                    ProdBOMLine.SetRange("Production BOM No.", "No.");
                    if ProdBOMLine.FindFirst then
                    repeat
                        ProdBOMLine.UpdateCantidadTotal("Tamaño Lote");
                        ProdBOMLine.Modify(true);
                    until ProdBOMLine.NEXT=0;
                end;
            end;
        }
        //+HEB.123
    }
    
}