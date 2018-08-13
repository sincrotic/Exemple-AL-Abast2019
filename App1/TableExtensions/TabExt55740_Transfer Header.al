//HEB.122 MT 25052018. Añadido campo "Shipment Method Code Ext" que valida contra "Shipment Method Code" porque no puede editarse la propiedad TableRelation de éste.
tableextension 55740 TransferHeaderExt extends "Transfer Header"
{
    fields
    {
        //-HEB.122
        field(50037; "Shipment Method Code Ext."; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method" WHERE (Bloqueado=CONST(FALSE));
            trigger OnValidate();
            begin
                Validate("Shipment Method Code");
            end;
        }
        //+HEB.122
    }
    
}