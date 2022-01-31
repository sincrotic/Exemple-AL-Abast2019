//HEB.173 MT 31052018. Mostrar campo "Cód. Tunel" (ADR).
//HEB.187 MT 01062018. Mostrar campo "REACH No."
//HEB.232 MR 06052018. Fer el modificar producte igual que està fet amb clients i proveidors.

pageextension 50030 ItemCardExt extends "Item Card"
{
    layout
    {
        modify(Blocked)
        {
            Visible = false;
            Enabled = false;
        }
        modify(Type)
        {
            Visible = false;
        }
        //moveafter("Base Unit of Measure";"Assembly BOM")
        //moveafter("Assembly BOM"; "Shelf No.")
        moveafter("Shelf No."; "Automatic Ext. Texts")
        moveafter("Automatic Ext. Texts"; "Created From Nonstock Item")
        moveafter("Created From Nonstock Item"; "Item Category Code")
        modify("Item Category Code")
        {
            trigger OnAfterValidate();
            var
                recItemCategory: Record "Item Category";
                //recItemGroup : Record "Product Group";
                recItemFamily: Record "Technical Family";
            begin
                IF recItemCategory.GET("Item Category Code") THEN
                    txtItemCategory := recItemCategory.Description
                ELSE
                    CLEAR(txtItemCategory);
                IF recItemGroup.GET("Item Category Code", "Product Group Code") THEN
                    txtItemGroup := recItemGroup.Description
                ELSE
                    CLEAR(txtItemGroup);
                IF recItemFamily.GET("Technical Family Code") THEN
                    txtItemFamily := recItemFamily.Description
                ELSE
                    CLEAR(txtItemFamily);
            end;
        }
        modify("Product Group Code")
        {
            trigger OnAfterValidate();
            var
                recItemCategory: Record "Item Category";
                recItemGroup: Record "Product Group";
                recItemFamily: Record "Technical Family";
            begin
                IF recItemCategory.GET("Item Category Code") THEN
                    txtItemCategory := recItemCategory.Description
                ELSE
                    CLEAR(txtItemCategory);
                IF recItemGroup.GET("Item Category Code", "Product Group Code") THEN
                    txtItemGroup := recItemGroup.Description
                ELSE
                    CLEAR(txtItemGroup);
                IF recItemFamily.GET("Technical Family Code") THEN
                    txtItemFamily := recItemFamily.Description
                ELSE
                    CLEAR(txtItemFamily);
            end;
        }
        addafter("Item Category Code")
        {
            field(txtItemCategory; txtItemCategory)
            {

            }
        }
        moveafter(txtItemCategory; "Product Group Code")
        addafter("Product Group Code")
        {
            field(txtItemGroup; txtItemGroup)
            {

            }
            field("Technical Family Code"; "Technical Family Code")
            {
                trigger OnValidate();
                var
                    recItemCategory: Record "Item Category";
                    recItemGroup: Record "Product Group";
                    recItemFamily: Record "Technical Family";
                begin
                    IF recItemCategory.GET("Item Category Code") THEN
                        txtItemCategory := recItemCategory.Description
                    ELSE
                        CLEAR(txtItemCategory);
                    IF recItemGroup.GET("Item Category Code", "Product Group Code") THEN
                        txtItemGroup := recItemGroup.Description
                    ELSE
                        CLEAR(txtItemGroup);
                    IF recItemFamily.GET("Technical Family Code") THEN
                        txtItemFamily := recItemFamily.Description
                    ELSE
                        CLEAR(txtItemFamily);
                end;
            }
            field(TxtItemFamily; TxtItemFamily) { }
            field("Clasificación LOC"; "Clasificación LOC") { }
        }
        addafter("Service Item Group")
        {
            field(BlockedExt; Blocked)
            {
                Editable = BlockedEditable;
            }
        }
        moveafter(BlockedExt; "Last Date Modified")
        addafter("Last Date Modified")
        {
            //-HEB.187
            field("REACH No."; "REACH No.") { }
            //+HEB.187
        }
        moveafter("Purch. Unit of Measure"; "Lead Time Calculation")
        moveafter("Costing Method"; "Cost is Adjusted")
        moveafter("Cost is Adjusted"; "Cost is Posted to G/L")
        moveafter("Unit Cost"; "Overhead Rate")
        moveafter("Indirect Cost %"; "Last Direct Cost")
        moveafter("Last Direct Cost"; "Price/Profit Calculation")
        moveafter("Price/Profit Calculation"; "Profit %")
        moveafter("Profit %"; "Unit Price")
        moveafter("Unit Price"; "Gen. Prod. Posting Group")
        moveafter("Gen. Prod. Posting Group"; "VAT Prod. Posting Group")
        moveafter("VAT Prod. Posting Group"; "Inventory Posting Group")
        moveafter("Inventory Posting Group"; "Net Invoiced Qty.")
        moveafter("Net Invoiced Qty."; "Allow Invoice Disc.")
        addafter("Allow Invoice Disc.")
        {
            field(BlockedExtInv; Blocked)
            {
                Editable = BlockedEditable;
            }
        }
        moveafter(BlockedExtInv; "Item Disc. Group")
        moveafter("Item Disc. Group"; "Sales Unit of Measure")
        addafter("Sales Unit of Measure")
        {
            field("Unit List Price Inv"; "Unit List Price") { }
            field("Unit List Price 2 Inv"; "Unit List Price 2") { }
        }
        addafter(Purchase)
        {
            field("Unit List Price"; "Unit List Price") { }
            field("Unit List Price 2"; "Unit List Price 2") { }
        }
        movebefore("Item Tracking"; ForeignTrade)
        movelast(ForeignTrade; "Net Weight")
        moveafter("Net Weight"; "Gross Weight")
        //-HEB.232
        addlast("Item Tracking")
        {
            field("Skip Adjust Cost Item Entries"; "Skip Adjust Cost Item Entries") { }
            field("Product Out-Dated"; "Product Out-Dated")
            {
                Editable = ProductOutdatedEditable;
            }
        }
        //+HEB.232
        addafter(Warehouse)
        {
            group(ADR)
            {
                Caption = 'ADR';
                field("UN No."; "UN No.") { }
                field("Nombre del Producto"; "Nombre del Producto") { }
                field("Descripción ADR (Carta Portes)"; "Descripción ADR (Carta Portes)") { }
                field(Estado; Estado) { }
                field("Packaging Group"; "Packaging Group") { }
                field(Etiqueta; Etiqueta) { }
                //-HEB.173
                field("Cód. Tunel"; "Cód. Tunel") { }
                //+HEB.173
            }
        }
        modify("Unit Cost")
        {
            Visible = ItemCostFieldsVisible;
            Importance = Standard;
        }
        modify("Overhead Rate")
        {
            Visible = ItemCostFieldsVisible;
            Importance = Standard;
        }
    }
    actions
    {
        addfirst(Availability)
        {
            action(Lotes)
            {
                ApplicationArea = All;
                Caption = 'Disponibilidad x lotes';
                Image = ItemAvailability;
                trigger OnAction();
                var
                    f50013: Page "Stock Prod. x Almacen y Lote";
                begin
                    f50013.setSource("No.");
                    f50013.RUN;
                end;
            }
        }
    }
    var
        ItemCostFieldsVisible: Boolean;
        //-HEB.201
        BlockedEditable: Boolean;
        ProductOutdatedEditable: Boolean;
        //+HEB.201
        txtItemCategory: Text[50];
        txtItemGroup: Text[50];
        txtItemFamily: Text[50];

    trigger OnOpenPage();
    var
        ConfUsu: Record "User Setup";
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

    trigger OnAfterGetRecord();
    var
        recItemCategory: Record "Item Category";
        recItemGroup: Record "Product Group";
        recItemFamily: Record "Technical Family";

    begin
        IF recItemCategory.GET("Item Category Code") THEN
            txtItemCategory := recItemCategory.Description
        ELSE
            CLEAR(txtItemCategory);
        IF recItemGroup.GET("Item Category Code", "Product Group Code") THEN
            txtItemGroup := recItemGroup.Description
        ELSE
            CLEAR(txtItemGroup);
        IF recItemFamily.GET("Technical Family Code") THEN
            txtItemFamily := recItemFamily.Description
        ELSE
            CLEAR(txtItemFamily);
    end;
}