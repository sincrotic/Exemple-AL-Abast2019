report 50033 "Inventario - Detalle Lotes"
{
    // -183 ogarcia   17/11/2009 Nuevo report 50033 -> Inventario detallado por lotes
    // -230 xtrullols 04/11/2014 Al report 50033 afegir columna nova de cost unitari.
    // -232 xtrullols 24/03/2015 Modificació del report 533 per incloure el cost mig, costos a lin. lot.
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Inventario - Detalle Lotes.rdlc';


    dataset
    {
        dataitem(Item;Item)
        {
            CalcFields = Inventory;
            RequestFilterFields = "No.","Location Filter",Inventory;
            column(filtrosTxt;ItemFilters)
            {
            }
            column(CompanyName;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(UnitCostNotInvToShow;UnitCostNotInvToShow)
            {
            }
            column(UnitCostToShow;UnitCostToShow)
            {
            }
            column(AverageCostToShow;AverageCostToShow)
            {
            }
            dataitem("Value Entry";"Value Entry")
            {
                DataItemTableView = SORTING("Item No.","Posting Date","Item Ledger Entry Type");

                trigger OnAfterGetRecord();
                begin
                    QtyOnHand := 0;
                    RcdIncreases := 0;
                    ShipDecreases := 0;
                    ValueOfQtyOnHand := 0;
                    ValueOfInvoicedQty := 0;
                    InvoicedQty := 0;

                    ValueOfRcdIncreases := 0;
                    ValueOfInvIncreases := 0;
                    InvIncreases := 0;

                    CostOfShipDecreases := 0;
                    CostOfInvDecreases := 0;
                    InvDecreases := 0;

                    IsPositive := GetSign;
                    IF "Item Ledger Entry Quantity" <> 0 THEN BEGIN
                      IF "Posting Date" < StartDate THEN
                        QtyOnHand := "Item Ledger Entry Quantity"
                      ELSE BEGIN
                        IF IsPositive THEN
                          RcdIncreases := "Item Ledger Entry Quantity"
                        ELSE
                          ShipDecreases := -"Item Ledger Entry Quantity";
                      END;
                    END;

                    IF "Posting Date" < StartDate THEN
                      SetAmount(ValueOfQtyOnHand,ValueOfInvoicedQty,InvoicedQty,1)
                    ELSE BEGIN
                      IF IsPositive THEN
                        SetAmount(ValueOfRcdIncreases,ValueOfInvIncreases,InvIncreases,1)
                      ELSE
                        SetAmount(CostOfShipDecreases,CostOfInvDecreases,InvDecreases,-1);
                    END;

                    ValueOfQtyOnHand := ValueOfQtyOnHand + ValueOfInvoicedQty;
                    ValueOfRcdIncreases := ValueOfRcdIncreases + ValueOfInvIncreases;
                    CostOfShipDecreases := CostOfShipDecreases + CostOfInvDecreases;

                    ExpCostPostedToGL := "Expected Cost Posted to G/L";
                    InvCostPostedToGL := "Cost Posted to G/L";
                    CostPostedToGL := ExpCostPostedToGL + InvCostPostedToGL;
                end;

                trigger OnPostDataItem();
                begin
                    valor2:=(ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases);
                    IF "Item Ledger Entry Quantity" <> 0 THEN
                        AverageCost:=(valor2/"Item Ledger Entry Quantity");
                end;

                trigger OnPreDataItem();
                begin
                    IF NOT(ShowAllUnitCost) THEN
                      CurrReport.BREAK;
                    SETRANGE("Item No.",Item."No.");
                    SETFILTER("Variant Code",Item.GETFILTER("Variant Filter"));
                    SETFILTER("Location Code",Item.GETFILTER("Location Filter"));
                    SETFILTER("Global Dimension 1 Code",Item.GETFILTER("Global Dimension 1 Filter"));
                    SETFILTER("Global Dimension 2 Code",Item.GETFILTER("Global Dimension 2 Filter"));
                    IF EndDate <> 0D THEN
                      SETRANGE("Posting Date",0D,EndDate);

                    CurrReport.CREATETOTALS(QtyOnHand,RcdIncreases,ShipDecreases,"Item Ledger Entry Quantity",InvoicedQty,InvIncreases,
                      InvDecreases,"Value Entry"."Invoiced Quantity");
                    CurrReport.CREATETOTALS(
                      ValueOfQtyOnHand,ValueOfRcdIncreases,CostOfShipDecreases,CostPostedToGL,ExpCostPostedToGL,
                      ValueOfInvoicedQty,ValueOfInvIncreases,CostOfInvDecreases,"Value Entry"."Cost Amount (Actual)",
                      InvCostPostedToGL);
                end;
            }
            dataitem(Integer;Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));
                column(No_Item;Item."No.")
                {
                }
                column(Description_Item;Item.Description + ' ' + Item."Description 2")
                {
                }
                column(Inventory_Item;Item.Inventory)
                {
                }
                column(UnitCost_Item;UnitCost)
                {
                }
                column(UnitCostNotInvent_Item;UnitCostNotInvent)
                {
                }
                column(AverageCost_Item;AverageCost)
                {
                }
                dataitem("Item Ledger Entry";"Item Ledger Entry")
                {
                    DataItemLink = "Item No."=FIELD("No.");
                    DataItemLinkReference = Item;
                    DataItemTableView = SORTING("Location Code","Lot No.");
                    column(LocationCode__ItemLedgerEntry;"Item Ledger Entry"."Location Code")
                    {
                    }
                    column(LotNo_ItemLedgerEntry;"Item Ledger Entry"."Lot No.")
                    {
                    }
                    column(ExpirationDate_ItemLedgerEntry;"Item Ledger Entry"."Expiration Date")
                    {
                    }
                    column(RemainingQuantity_ItemLedgerEntry;"Item Ledger Entry"."Remaining Quantity")
                    {
                    }
                    column(UnitCost_ItemLedgerEntry;UnitCost)
                    {
                    }
                    column(UnitCostNotInvent_ItemLedgerEntry;UnitCostNotInvent)
                    {
                    }

                    trigger OnPreDataItem();
                    begin
                        SETRANGE(Open,TRUE);

                        IF LocItemFilter <> '' THEN
                           SETFILTER("Location Code",LocItemFilter);
                    end;
                }
            }

            trigger OnAfterGetRecord();
            begin
                //-230
                TotalUnitCost := 0;
                TotalUnitCostNotInvent := 0;
                TotalAverageCost := 0;
                TotalQuantity := 0;
                UnitCost := 0;
                UnitCostNotInvent := 0;
                AverageCost := 0;
                CLEAR(ItemLedgerEntry);
                ItemLedgerEntry.SETCURRENTKEY("Item No.",Open,"Variant Code",Positive,"Location Code","Posting Date");
                ItemLedgerEntry.SETRANGE("Item No.",Item."No.");
                ItemLedgerEntry.SETRANGE(Open,TRUE);
                IF ItemLedgerEntry.FINDSET THEN BEGIN
                  REPEAT
                    IF ShowAllUnitCost THEN BEGIN
                      ItemLedgerEntry.CALCFIELDS("Cost Amount (Expected)","Cost Amount (Actual)","Cost Amount (Non-Invtbl.)");
                      TotalUnitCostNotInvent += ItemLedgerEntry."Cost Amount (Expected)" + ItemLedgerEntry."Cost Amount (Actual)" +
                                                ItemLedgerEntry."Cost Amount (Non-Invtbl.)";
                      TotalUnitCost += ItemLedgerEntry."Cost Amount (Expected)"+ItemLedgerEntry."Cost Amount (Actual)";
                    END;
                    TotalQuantity += ItemLedgerEntry.Quantity;
                  UNTIL ItemLedgerEntry.NEXT=0;
                  IF (TotalQuantity <> 0) THEN BEGIN
                    UnitCost := ROUND(TotalUnitCost / TotalQuantity,0.001);
                    UnitCostNotInvent := ROUND(TotalUnitCostNotInvent / TotalQuantity,0.001);
                  END;
                END;
                //+230
            end;

            trigger OnPreDataItem();
            begin
                CurrReport.CREATETOTALS(QtyOnHand,RcdIncreases,ShipDecreases,"Value Entry"."Item Ledger Entry Quantity");
                CurrReport.CREATETOTALS(InvoicedQty,InvIncreases,InvDecreases);
                CurrReport.CREATETOTALS(
                  ValueOfQtyOnHand,ValueOfRcdIncreases,CostOfShipDecreases,CostPostedToGL,ExpCostPostedToGL);
                CurrReport.CREATETOTALS(
                  ValueOfInvoicedQty,ValueOfInvIncreases,CostOfInvDecreases,
                  "Value Entry"."Cost Amount (Actual)",InvCostPostedToGL);


                LocItemFilter:=Item.GETFILTER("Location Filter");
                ItemFilters:=Item.GETFILTERS();

                IF ItemFilters <> '' THEN
                   ItemFilters := STRSUBSTNO('Filtros: %1',ItemFilters);

                //-230
                IF ShowAllUnitCost THEN BEGIN
                  UnitCostNotInvToShow := UnitCostNotInventText;
                  UnitCostToShow := UnitCostText;
                  AverageCostToShow := AverageCostText;
                END
                ELSE BEGIN
                  UnitCostNotInvToShow := '';
                  UnitCostToShow := '';
                  AverageCostToShow := '';
                END;
                //+230
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Group1)
                {
                    field(ShowAllUnitCost;ShowAllUnitCost)
                    {
                        Caption = 'Show Cost columns';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        NoLbl = 'No.';
        DescriptionLbl = 'Description';
        InvntoryLbl = 'Inventory';
        TituloLbl = 'Inventario - Detalle Lotes';
        PaginaLbl = 'Page';
    }

    trigger OnPreReport();
    begin
        IF (StartDate = 0D) AND (EndDate = 0D) THEN
          EndDate := WORKDATE;

        IF StartDate IN [0D,00000101D] THEN
          StartDateText := ''
        ELSE
          StartDateText := FORMAT(StartDate - 1);

        ItemFilter := Item.GETFILTERS
    end;

    var
        LocItemFilter : Text[100];
        ItemFilters : Text[1024];
        UnitCost : Decimal;
        UnitCostNotInvent : Decimal;
        ItemLedgerEntry : Record "Item Ledger Entry";
        TotalQuantity : Decimal;
        TotalUnitCost : Decimal;
        TotalUnitCostNotInvent : Decimal;
        UnitCostNotInvToShow : Text[30];
        UnitCostToShow : Text[30];
        ShowAllUnitCost : Boolean;
        AverageCostToShow : Text[30];
        AverageCost : Decimal;
        TotalAverageCost : Decimal;
        StartDate : Date;
        EndDate : Date;
        ShowExpected : Boolean;
        ItemFilter : Text[250];
        StartDateText : Text[10];
        ValueOfInvoicedQty : Decimal;
        ValueOfQtyOnHand : Decimal;
        ValueOfInvIncreases : Decimal;
        ValueOfRcdIncreases : Decimal;
        CostOfInvDecreases : Decimal;
        CostOfShipDecreases : Decimal;
        InvCostPostedToGL : Decimal;
        CostPostedToGL : Decimal;
        InvoicedQty : Decimal;
        QtyOnHand : Decimal;
        InvIncreases : Decimal;
        RcdIncreases : Decimal;
        InvDecreases : Decimal;
        ShipDecreases : Decimal;
        ExpCostPostedToGL : Decimal;
        InvandShipDiffer : Boolean;
        IsPositive : Boolean;
        costeMed : Decimal;
        ExcelBuffer : Record "Excel Buffer" temporary;
        fila : Integer;
        valor2 : Decimal;
        crearExcel : Boolean;
        UnitCostNotInventText : Label 'Not Invent. Unit Cost';
        UnitCostText : Label 'Coste Unitario';
        AverageCostText : Label 'Coste medio';

    procedure InvAndShipDiffers() : Boolean;
    begin
        EXIT(
          (QtyOnHand + RcdIncreases - ShipDecreases) <>
          (InvoicedQty + InvIncreases - InvDecreases));
    end;

    procedure GetSign() : Boolean;
    begin
        WITH "Value Entry" DO
          CASE "Item Ledger Entry Type" OF
            "Item Ledger Entry Type"::Purchase,
            "Item Ledger Entry Type"::"Positive Adjmt.",
            "Item Ledger Entry Type"::Output:
              EXIT(TRUE);
            "Item Ledger Entry Type"::Transfer:
              BEGIN
                IF "Valued Quantity" < 0 THEN
                  EXIT(FALSE)
                ELSE
                  EXIT(GetOutboundItemEntry("Item Ledger Entry No."));
              END;
            ELSE
              EXIT(FALSE)
          END;
    end;

    procedure SetAmount(var CostAmtExp : Decimal;var CostAmtActual : Decimal;var InvQty : Decimal;Sign : Integer);
    begin
        WITH "Value Entry" DO BEGIN
          CostAmtExp := "Cost Amount (Expected)" * Sign;
          CostAmtActual := "Cost Amount (Actual)" * Sign;
          InvQty := "Invoiced Quantity" * Sign;
        END;
    end;

    local procedure GetOutboundItemEntry(ItemLedgerEntryNo : Integer) : Boolean;
    var
        ItemApplnEntry : Record "Item Application Entry";
        ItemLedgEntry : Record "Item Ledger Entry";
    begin
        ItemApplnEntry.SETCURRENTKEY("Item Ledger Entry No.");
        ItemApplnEntry.SETRANGE("Item Ledger Entry No.",ItemLedgerEntryNo);
        IF NOT ItemApplnEntry.FIND('-') THEN
          EXIT(TRUE);

        ItemLedgEntry.SETRANGE("Item No.",Item."No.");
        ItemLedgEntry.SETFILTER("Variant Code",Item.GETFILTER("Variant Filter"));
        ItemLedgEntry.SETFILTER("Location Code",Item.GETFILTER("Location Filter"));
        ItemLedgEntry.SETFILTER("Global Dimension 1 Code",Item.GETFILTER("Global Dimension 1 Filter"));
        ItemLedgEntry.SETFILTER("Global Dimension 2 Code",Item.GETFILTER("Global Dimension 2 Filter"));
        ItemLedgEntry."Entry No." := ItemApplnEntry."Outbound Item Entry No.";
        EXIT(NOT ItemLedgEntry.FIND);
    end;
}

