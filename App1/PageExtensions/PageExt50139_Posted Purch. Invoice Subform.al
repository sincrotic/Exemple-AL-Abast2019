//HEB.159 MR 26062018 PI0027_7064 - Consulta Documentos asociados a Cargos Productos
pageextension 50139 PostedPurchInvoiceSubformExt extends "Posted Purch. Invoice Subform"
{
    actions
    {
        //-HEB.159
        addafter(ItemReceiptLines)
        {
            action(LineasAsociadasCargoProducto)
            {
                trigger OnAction();
                begin
                    ShowItemReceiptLines;
                end;
            }
        }
        //+HEB.159
    }
    //-HEB.159
    procedure ShowItemChargeLines()
    begin
        IF NOT (Type IN [Type::"Charge (Item)"]) THEN
            FIELDERROR(Type,'Debe ser Cargo (Prod.)');

        Rec.ShowItemChargeLines;
    end;
    //+HEB.159
}