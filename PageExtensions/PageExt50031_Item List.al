//HEB.123 MT 29052018. La acción "Quantity Explosion of BOM" ejecuta el Report 50062 "Quantity Explosion of BOM Ext" en vez del estandar NAV.
//HEB.173 MT 31052018. Mostrar campo "Cód. Tunel" (ADR).
//HEB.187 MT 01062018. Mostrar campo "REACH No."
//HEB.232 MR 05062018. Fer el modificar producte igual que està fet amb clients i proveidors.
pageextension 50031 ItemListExt extends "Item List"
{
    layout
    {
        //-HEB.232
        addafter(Description)
        {
            field(BlockedExt; Blocked)
            {
                Editable = BlockedEditable;
            }
            field("Product Out-Dated"; "Product Out-Dated")
            {
                Editable = ProductOutdatedEditable;
            }
        }
        moveafter("Product Out-Dated"; "Overhead Rate")
        modify("Overhead Rate")
        {
            Visible = ItemCostFieldsVisible;
            Importance = Standard;
        }
        modify("Unit Cost")
        {
            Visible = ItemCostFieldsVisible;
            Importance = Standard;
        }
        //+HEB.232
        addafter("Overhead Rate")
        {
            //-HEB.187
            field("REACH No."; "REACH No.") { }
            //+HEB.187
            field("Nombre del Producto"; "Nombre del Producto") { }
        }
        moveafter("Nombre del Producto"; "Item Category Code")
        moveafter("Item Category Code"; "Replenishment System")
        addafter("Replenishment System")
        {
            field("Minimum Order Quantity"; "Minimum Order Quantity") { }
            field("Reordering Policy"; "Reordering Policy") { }
            field("Maximum Order Quantity"; "Maximum Order Quantity") { }
            field("Order Multiple"; "Order Multiple") { }
        }
        moveafter("Order Multiple"; "Product Group Code")
        addafter("Product Group Code")
        {
            field("Descripción ADR (Carta Portes)"; "Descripción ADR (Carta Portes)") { }
            field(Estado; Estado) { }
            field(Clase; Clase) { }
            field("Packaging Group"; "Packaging Group") { }
            field("Technical Family Code"; "Technical Family Code") { }
            field("Unit List Price"; "Unit List Price") { }
            field("Unit List Price 2"; "Unit List Price 2") { }
        }
        moveafter("Unit List Price 2"; "Item Tracking Code")
        addafter("Item Tracking Code")
        {
            field("UN No."; "UN No.") { }
            field("Clasificación LOC"; "Clasificación LOC") { }
            field(Etiqueta; Etiqueta) { }
            //-HEB.173
            field("Cód. Tunel"; "Cód. Tunel") { }
            //+HEB.173
        }
        moveafter("Cód. Tunel"; "Created From Nonstock Item")
        moveafter("Created From Nonstock Item"; "Product Group Code")
        moveafter("Product Group Code"; "Substitutes Exist")
        addafter("Substitutes Exist")
        {
            field("Qty. on Purch. Order"; "Qty. on Purch. Order") { }
            field("Qty. on Sales Order"; "Qty. on Sales Order") { }
            field("Maximum Inventory"; "Maximum Inventory") { }
        }
        moveafter("Maximum Inventory"; Inventory)
        addafter(Inventory)
        {
            field("Reserved Qty. on Sales Orders"; "Reserved Qty. on Sales Orders") { }
            field("Safety Stock Quantity"; "Safety Stock Quantity") { }
        }
        moveafter("Safety Stock Quantity"; "Item Category Code")
        moveafter("Item Category Code"; "Tariff No.")
        addafter("Tariff No.")
        {
            field("Safety Lead Time"; "Safety Lead Time") { }
        }
        moveafter("Safety Lead Time"; "Stockkeeping Unit Exists")
        moveafter("Stockkeeping Unit Exists"; "Assembly BOM")
        moveafter("Assembly BOM"; "Production BOM No.")
        moveafter("Production BOM No."; "Routing No.")
        moveafter("Routing No."; "Base Unit of Measure")
        moveafter("Base Unit of Measure"; "Shelf No.")
        moveafter("Shelf No."; "Costing Method")
        moveafter("Costing Method"; "Cost is Adjusted")
        moveafter("Cost is Adjusted"; "Standard Cost")
        moveafter("Standard Cost"; "Unit Price")
        moveafter("Unit Price"; "Inventory Posting Group")
        moveafter("Inventory Posting Group"; "Gen. Prod. Posting Group")
        moveafter("Gen. Prod. Posting Group"; "VAT Prod. Posting Group")
        moveafter("VAT Prod. Posting Group"; "Item Disc. Group")
        moveafter("Item Disc. Group"; "Vendor No.")
        moveafter("Vendor No."; "Vendor Item No.")
        moveafter("Vendor No."; "Search Description")
    }
    
    actions
    {
        //-HEB.123
        addafter("Quantity Explosion of BOM")
        {
            action("Quantity Explosion of BOM Ext.")
            {
                Caption = 'Quantity Explosion of BOM';
                ToolTip = 'View an indented BOM listing for the item or items that you specify in the filters. The production BOM is completely exploded for all levels.';
                RunObject = report "Quantity Explosion of BOM Ext";
                Image = Report;
                ApplicationArea = Assembly;
            }
        }

        modify("Quantity Explosion of BOM"){
            Visible = false;
        }
        //+HEB.123
    }
    var
        ItemCostFieldsVisible : Boolean;
        //-HEB.201
        BlockedEditable : Boolean;
        ProductOutdatedEditable : Boolean;
        //+HEB.201

    trigger OnOpenPage();
    var
        ConfUsu : Record "User Setup";
    begin
        ItemCostFieldsVisible := false;
        BlockedEditable := false;
        if ConfUsu.Get(UserId) then begin
            ItemCostFieldsVisible := ConfUsu."Allow view item cost fields";
            //-HEB.201
            BlockedEditable := ConfUsu."Allow unBlock Item";
            ProductOutdatedEditable := ConfUsu."Allow unBlock Item";
            //+HEB.201
        end;
    end;
}