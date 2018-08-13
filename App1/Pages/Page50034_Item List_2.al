//HEB.173 MT 01062018. Muestra campo "Cód. Tunel" (ADR).
//HEB.187 MT 01062018. Muestra campo "REACH NO.".
page 50034 "Item List_2"
{
    // version NAVW15.00,NAVES4.00.02
    // -173 ogarcia 09/11/2009 Mostrar "Cód. Tunel" (ADR)
    // -187 ogarcia   02/11/2010 Nuevo campo "REACH No." en tabla Item
    Caption = 'Item List';
    Editable = false;
    PageType = List;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            repeater(Item)
            {
                field("No.";"No.")
                {
                }
                field(Description;Description)
                {
                }
                field("Overhead Rate";"Overhead Rate")
                {
                }
                field(Blocked;Blocked)
                {
                }
                // field("Nombre del Producto";"Nombre del Producto")
                // {
                // }
                field("Item Category Code";"Item Category Code")
                {
                }
                field("Allow Invoice Disc.";"Allow Invoice Disc.")
                {
                }
                // field("Product Group Code";"Product Group Code")
                // {
                // }
                // field("Descripción ADR (Carta Portes)";"Descripción ADR (Carta Portes)")
                // {
                // }
                // field(Estado;Estado)
                // {
                // }
                // field(Clase;Clase)
                // {
                // }
                // field("Packaging Group";"Packaging Group")
                // {
                // }
                // field("Technical Family Code";"Technical Family Code")
                // {
                // }
                field("Unit List Price";"Unit List Price")
                {
                    Caption = 'Precio referencia 1S';
                    DecimalPlaces = 2:2;
                }
                // field("Unit List Price 2";"Unit List Price 2")
                // {
                //     Caption = 'Precio referencia 2S';
                // }
                
                //-HEB.187
                field("REACH No.";"REACH No.")
                {
                    Visible = false;
                }
                //+HEB.187
                field("Item Tracking Code";"Item Tracking Code")
                {
                }
                // field("UN No.";"UN No.")
                // {
                // }
                field("Clasificación LOC";"Clasificación LOC")
                {
                }
                // field(Etiqueta;Etiqueta)
                // {
                // }
                //-HEB.173
                field("Cód. Tunel";"Cód. Tunel")
                {
                }
                //+HEB.173
                field("Created From Nonstock Item";"Created From Nonstock Item")
                {
                    Visible = false;
                }
                // field("Product Group Code";"Product Group Code")
                // {
                // }
                field("Substitutes Exist";"Substitutes Exist")
                {
                }
                field("Qty. on Purch. Order";"Qty. on Purch. Order")
                {
                }
                field("Qty. on Sales Order";"Qty. on Sales Order")
                {
                }
                field("Maximum Inventory";"Maximum Inventory")
                {
                }
                field(Inventory;Inventory)
                {
                }
                field("Reserved Qty. on Sales Orders";"Reserved Qty. on Sales Orders")
                {
                }
                field("Safety Stock Quantity";"Safety Stock Quantity")
                {
                }
                field("Safety Lead Time";"Safety Lead Time")
                {
                }
                field("Stockkeeping Unit Exists";"Stockkeeping Unit Exists")
                {
                    Visible = false;
                }
                // field("Bill of Materials";"Bill of Materials")
                // {
                // }
                field("Production BOM No.";"Production BOM No.")
                {
                }
                field("Routing No.";"Routing No.")
                {
                }
                field("Base Unit of Measure";"Base Unit of Measure")
                {
                }
                // field("Shelf/Bin No.";"Shelf/Bin No.")
                // {
                //     Visible = false;
                // }
                field("Costing Method";"Costing Method")
                {
                    Visible = false;
                }
                field("Cost is Adjusted";"Cost is Adjusted")
                {
                }
                field("Standard Cost";"Standard Cost")
                {
                    Visible = false;
                }
                field("Unit Cost";"Unit Cost")
                {
                }
                field("Last Direct Cost";"Last Direct Cost")
                {
                    Visible = false;
                }
                field("Price/Profit Calculation";"Price/Profit Calculation")
                {
                    Visible = false;
                }
                field("Profit %";"Profit %")
                {
                    Visible = false;
                }
                field("Unit Price";"Unit Price")
                {
                }
                field("Inventory Posting Group";"Inventory Posting Group")
                {
                    Visible = false;
                }
                field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
                {
                    Visible = false;
                }
                field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Item Disc. Group";"Item Disc. Group")
                {
                    Visible = false;
                }
                field("Vendor No.";"Vendor No.")
                {
                }
                field("Vendor Item No.";"Vendor Item No.")
                {
                    Visible = false;
                }
                field("Tariff No.";"Tariff No.")
                {
                    Visible = false;
                }
                field("Search Description";"Search Description")
                {
                }
                field("Indirect Cost %";"Indirect Cost %")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Item")
            {
                Caption = '&Item';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    //RunFormLink = "No."=FIELD("No."),Date Filter=FIELD("Date Filter"),Global Dimension 1 Filter=FIELD("Global Dimension 1 Filter"),"Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter"),"Location Filter"=FIELD("Location Filter"),"Drop Shipment Filter"=FIELD("Drop Shipment Filter");
                    RunObject = Page "Item Card";
                    ShortCutKey = 'Mayús+F5';
                }
                action("Stockkeepin&g Units")
                {
                    Caption = 'Stockkeepin&g Units';
                    //RunFormLink = "Item No."=FIELD("No.");
                    //RunFormView = SORTING("Item No.");
                    RunObject = Page "Stockkeeping Unit List";
                }
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    action("Ledger E&ntries")
                    {
                        Caption = 'Ledger E&ntries';
                        // RunFormLink = "Item No."=FIELD("No.");
                        // RunFormView = SORTING("Item No.");
                        RunObject = Page "Item Ledger Entries";
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("&Reservation Entries")
                    {
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        // RunFormLink = Reservation Status=CONST(Reservation),Item No.=FIELD(No.);
                        // RunFormView = SORTING(Item No.,Variant Code,Location Code,Reservation Status);
                        RunObject = Page "Reservation Entries";
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        // RunFormLink = Item No.=FIELD(No.);
                        // RunFormView = SORTING(Item No.);
                        RunObject = Page "Phys. Inventory Ledger Entries";
                    }
                    action("&Value Entries")
                    {
                        Caption = '&Value Entries';
                        Image = ValueLedger;
                        // RunFormLink = Item No.=FIELD(No.);
                        // RunFormView = SORTING(Item No.);
                        RunObject = Page "Value Entries";
                    }
                    action("Item &Tracking Entries")
                    {
                        Caption = 'Item &Tracking Entries';
                        Image = ItemTrackingLedger;

                        trigger OnAction();
                        var
                            ItemTrackingMgt : Codeunit "Item Tracking Management";
                        begin
                            // TODO: Extender función en Codeunit 6500 - "Item Tracking Management"
                            // ItemTrackingMgt.CallItemTrackingEntryForm(3,'';"No.",'';'';'';'');
                        end;
                    }
                }
                group(StatisticsGroup)
                {
                    Caption = 'Statistics';
                    action(Statistics)
                    {
                        Caption = 'Statistics';
                        Image = Statistics;
                        Promoted = true;
                        PromotedCategory = Process;
                        ShortCutKey = 'F7';

                        trigger OnAction();
                        var
                            ItemStatistics : Page "Item Statistics";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RUNMODAL;
                        end;
                    }
                    action("Entry Statistics")
                    {
                        Caption = 'Entry Statistics';
                        // RunFormLink = No.=FIELD(No.),Date Filter=FIELD(Date Filter),Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),Location Filter=FIELD(Location Filter),Drop Shipment Filter=FIELD(Drop Shipment Filter),Variant Filter=FIELD(Variant Filter);
                        RunObject = Page "Item Entry Statistics";
                    }
                    action("T&urnover")
                    {
                        Caption = 'T&urnover';
                        // RunFormLink = No.=FIELD(No.),Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),Location Filter=FIELD(Location Filter),Drop Shipment Filter=FIELD(Drop Shipment Filter),Variant Filter=FIELD(Variant Filter);
                        RunObject = Page "Item Turnover";
                    }
                }
                action("Items b&y Location")
                {
                    Caption = 'Items b&y Location';
                    Image = ItemAvailbyLoc;

                    trigger OnAction();
                    var
                        ItemsByLocation : Page "Items by Location";
                    begin
                        ItemsByLocation.SETRECORD(Rec);
                        ItemsByLocation.RUN;
                    end;
                }
                group("&Item Availability by")
                {
                    Caption = '&Item Availability by';
                    action(Period)
                    {
                        Caption = 'Period';
                        // RunFormLink = No.=FIELD(No.),Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),Location Filter=FIELD(Location Filter),Drop Shipment Filter=FIELD(Drop Shipment Filter),Variant Filter=FIELD(Variant Filter);
                        RunObject = Page "Item Availability by Periods";
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        // RunFormLink = No.=FIELD(No.),Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),Location Filter=FIELD(Location Filter),Drop Shipment Filter=FIELD(Drop Shipment Filter),Variant Filter=FIELD(Variant Filter);
                        RunObject = Page "Item Availability by Variant";
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        // RunFormLink = No.=FIELD(No.),Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),Location Filter=FIELD(Location Filter),Drop Shipment Filter=FIELD(Drop Shipment Filter),Variant Filter=FIELD(Variant Filter);
                        RunObject = Page "Item Availability by Location";
                    }
                }
                action("&Bin Contents")
                {
                    Caption = '&Bin Contents';
                    Image = BinContent;
                    // RunFormLink = Item No.=FIELD(No.),Unit of Measure Code=FIELD(Base Unit of Measure);
                    // RunFormView = SORTING(Item No.);
                    RunObject = Page "Item Bin Contents";
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    // RunFormLink = Table Name=CONST(Item),No.=FIELD(No.);
                    RunObject = Page "Comment Sheet";
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    action("Dimensions-Single")
                    {
                        Caption = 'Dimensions-Single';
                        // RunFormLink = Table ID=CONST(27),No.=FIELD(No.);
                        RunObject = Page "Default Dimensions";
                        ShortCutKey = 'Mayús+Ctrl+D';
                    }
                    action("Dimensions-&Multiple")
                    {
                        Caption = 'Dimensions-&Multiple';

                        trigger OnAction();
                        var
                            Item : Record Item;
                            DefaultDimMultiple : page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(Item);
                            DefaultDimMultiple.SetMultiItem(Item);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    // RunFormLink = No.=FIELD(No.),Date Filter=FIELD(Date Filter),Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),Location Filter=FIELD(Location Filter),Drop Shipment Filter=FIELD(Drop Shipment Filter),Variant Filter=FIELD(Variant Filter);
                    RunObject = Page "Item Picture";
                }
                separator("Separator1")
                {
                }
                action("&Units of Measure")
                {
                    Caption = '&Units of Measure';
                    // RunFormLink = Item No.=FIELD(No.);
                    RunObject = Page "Item Units of Measure";
                }
                action("Va&riants")
                {
                    Caption = 'Va&riants';
                    // RunFormLink = Item No.=FIELD(No.);
                    RunObject = Page "Item Variants";
                }
                action("Cross Re&ferences")
                {
                    Caption = 'Cross Re&ferences';
                    // RunFormLink = Item No.=FIELD(No.);
                    RunObject = Page "Item Cross Reference Entries";
                }
                action("Substituti&ons")
                {
                    Caption = 'Substituti&ons';
                    // RunFormLink = Type=CONST(Item),No.=FIELD(No.);
                    RunObject = Page "Item Substitution Entry";
                }
                action("Nonstoc&k Items")
                {
                    Caption = 'Nonstoc&k Items';
                    RunObject = Page "Item Substitution Entry";
                }
                separator("Separator2")
                {
                }
                action(Translations)
                {
                    Caption = 'Translations';
                    // RunFormLink = Item No.=FIELD(No.),Variant Code=CONST();
                    RunObject = Page "Item Translations";
                }
                action("E&xtended Texts")
                {
                    Caption = 'E&xtended Texts';
                    // RunFormLink = Table Name=CONST(Item),No.=FIELD(No.);
                    // RunFormView = SORTING(Table Name,No.,Language Code,All Language Codes,Starting Date,Ending Date);
                    RunObject = Page "Extended Text";
                }
                separator("Separator3")
                {
                }
                group("Assembly &List")
                {
                    Caption = 'Assembly &List';
                    action("Bill of MaterialsAction")
                    {
                        Caption = 'Bill of Materials';
                        // RunFormLink = Parent Item No.=FIELD(No.);
                        RunObject = Page "Assembly BOM";
                    }
                    action("Where-Used List")
                    {
                        Caption = 'Where-Used List';
                        // RunFormLink = Type=CONST(Item),No.=FIELD(No.);
                        // RunFormView = SORTING(Type,No.);
                        RunObject = Page "Where-Used List";
                    }
                }
                group("Manuf&acturing")
                {
                    Caption = 'Manuf&acturing';
                    action("Where-Used")
                    {
                        Caption = 'Where-Used';

                        trigger OnAction();
                        var
                            ProdBOMWhereUsed : Page "Prod. BOM Where-Used";
                        begin
                            ProdBOMWhereUsed.SetItem(Rec,WORKDATE);
                            ProdBOMWhereUsed.RUNMODAL;
                        end;
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        Caption = 'Calc. Stan&dard Cost';

                        trigger OnAction();
                        begin
                            CalculateStdCost.CalcItem("No.",FALSE);
                        end;
                    }
                }
                separator("Separator4")
                {
                    Caption = '';
                }
                action("Ser&vice Items")
                {
                    Caption = 'Ser&vice Items';
                    // RunFormLink = Item No.=FIELD(No.);
                    // RunFormView = SORTING(Item No.);
                    RunObject = Page "Service Items";
                }
                group("Troubles&hootingGroup")
                {
                    Caption = 'Troubles&hooting';
                    action("Troubleshooting &Setup")
                    {
                        Caption = 'Troubleshooting &Setup';
                        Image = Troubleshoot;
                        // RunFormLink = Type=CONST(Item),No.=FIELD(No.);
                        RunObject = Page "Troubleshooting Setup";
                    }
                    action("Troubles&hooting")
                    {
                        Caption = 'Troubles&hooting';

                        trigger OnAction();
                        begin
                            TblshtgHeader.ShowForItem(Rec);
                        end;
                    }
                }
                group("R&esource")
                {
                    Caption = 'R&esource';
                    action("Resource &Skills")
                    {
                        Caption = 'Resource &Skills';
                        // RunFormLink = Type=CONST(Item),No.=FIELD(No.);
                        RunObject = Page "Resource Skills";
                    }
                    action("Skilled R&esources")
                    {
                        Caption = 'Skilled R&esources';

                        trigger OnAction();
                        var
                            ResourceSkill : Record "Resource Skill";
                        begin
                            CLEAR(SkilledResourceList);
                            SkilledResourceList.Initialize(ResourceSkill.Type::Item,"No.",Description);
                            SkilledResourceList.RUNMODAL;
                        end;
                    }
                }
                separator("Separator5")
                {
                }
                action(Identifiers)
                {
                    Caption = 'Identifiers';
                    // RunFormLink = Item No.=FIELD(No.);
                    // RunFormView = SORTING(Item No.,Variant Code,Unit of Measure Code);
                    RunObject = Page "Item Identifiers";
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = ResourcePrice;
                    // RunFormLink = Item No.=FIELD(No.);
                    // RunFormView = SORTING(Item No.);
                    RunObject = Page "Sales Prices";
                }
                action("Line Discounts Sales")
                {
                    Caption = 'Line Discounts';
                    // RunFormLink = Type=CONST(Item),Code=FIELD(No.);
                    // RunFormView = SORTING(Type,Code);
                    RunObject = Page "Sales Line Discounts";
                }
                action("Prepa&yment Percentages Sales")
                {
                    Caption = 'Prepa&yment Percentages';
                    // RunFormLink = Item No.=FIELD(No.);
                    RunObject = Page "Sales Prepayment Percentages";
                }
                action("Orders Sales")
                {
                    Caption = 'Orders';
                    Image = Document;
                    // RunFormLink = Type=CONST(Item),No.=FIELD(No.);
                    // RunFormView = SORTING(Document Type,Type,No.);
                    RunObject = Page "Sales Orders";
                }
                action("Returns Orders")
                {
                    Caption = 'Returns Orders';
                    // RunFormLink = Type=CONST(Item),No.=FIELD(No.);
                    // RunFormView = SORTING(Document Type,Type,No.);
                    RunObject = Page "Sales Return Orders";
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                action("Ven&dors")
                {
                    Caption = 'Ven&dors';
                    // RunFormLink = Item No.=FIELD(No.);
                    // RunFormView = SORTING(Item No.);
                    RunObject = Page "Item Vendor Catalog";
                }
                action(PricesPurchases)
                {
                    Caption = 'Prices';
                    Image = ResourcePrice;
                    // RunFormLink = Item No.=FIELD(No.);
                    // RunFormView = SORTING(Item No.);
                    RunObject = Page "Purchase Prices";
                }
                action("Line Discounts Purchases")
                {
                    Caption = 'Line Discounts';
                    // RunFormLink = Item No.=FIELD(No.);
                    // RunFormView = SORTING(Item No.);
                    RunObject = Page "Purchase Line Discounts";
                }
                action("Prepa&yment Percentages Purchases")
                {
                    Caption = 'Prepa&yment Percentages';
                    // RunFormLink = Item No.=FIELD(No.);
                    RunObject = Page "Purchase Prepmt. Percentages";
                }
                separator("Separator6")
                {
                }
                action("Orders Purchases")
                {
                    Caption = 'Orders';
                    Image = Document;
                    // RunFormLink = Type=CONST(Item),No.=FIELD(No.);
                    // RunFormView = SORTING(Document Type,Type,No.);
                    RunObject = Page "Purchase Orders";
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    // RunFormLink = Type=CONST(Item),No.=FIELD(No.);
                    // RunFormView = SORTING(Document Type,Type,No.);
                    RunObject = Page "Purchase Return Orders";
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Create Stockkeeping Unit")
                {
                    Caption = '&Create Stockkeeping Unit';

                    trigger OnAction();
                    var
                        Item : Record Item;
                    begin
                        Item.SETRANGE("No.","No.");
                        REPORT.RUNMODAL(REPORT::"Create Stockkeeping Unit",TRUE,FALSE,Item);
                    end;
                }
                action("C&alculate Counting Period")
                {
                    Caption = 'C&alculate Counting Period';

                    trigger OnAction();
                    var
                        PhysInvtCountMgt : Codeunit "Phys. Invt. Count.-Management";
                    begin
                        PhysInvtCountMgt.UpdateItemPhysInvtCount(Rec);
                    end;
                }
            }
        }
    }

    var
        TblshtgHeader : Record "Troubleshooting Header";
        SkilledResourceList : Page "Skilled Resource List";
        CalculateStdCost : Codeunit "Calculate Standard Cost";

    procedure GetSelectionFilter() : Code[80];
    var
        Item : Record Item;
        FirstItem : Code[30];
        LastItem : Code[30];
        SelectionFilter : Code[250];
        ItemCount : Integer;
        More : Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(Item);
        ItemCount := Item.COUNT;
        IF ItemCount > 0 THEN BEGIN
          Item.FIND('-');
          WHILE ItemCount > 0 DO BEGIN
            ItemCount := ItemCount - 1;
            Item.MARKEDONLY(FALSE);
            FirstItem := Item."No.";
            LastItem := FirstItem;
            More := (ItemCount > 0);
            WHILE More DO
              IF Item.NEXT = 0 THEN
                More := FALSE
              ELSE
                IF NOT Item.MARK THEN
                  More := FALSE
                ELSE BEGIN
                  LastItem := Item."No.";
                  ItemCount := ItemCount - 1;
                  IF ItemCount = 0 THEN
                    More := FALSE;
                END;
            IF SelectionFilter <> '' THEN
              SelectionFilter := SelectionFilter + '|';
            IF FirstItem = LastItem THEN
              SelectionFilter := SelectionFilter + FirstItem
            ELSE
              SelectionFilter := SelectionFilter + FirstItem + '..' + LastItem;
            IF ItemCount > 0 THEN BEGIN
              Item.MARKEDONLY(TRUE);
              Item.NEXT;
            END;
          END;
        END;
        EXIT(SelectionFilter);
    end;

    procedure SetSelection(var Item : Record Item);
    begin
        CurrPage.SETSELECTIONFILTER(Item);
    end;
}

