//HEB.136 MT 09072018. Añadidas funciones de cálculo de coste de componentes
codeunit 50002 "Manufacturing Abast Libary"
{
    //-HEB.136
    procedure CalcProdOrderComponentActCost(ProdOrderComponent : Record "Prod. Order Component"; var ActMatCost : Decimal; var ActMatCostCostACY : Decimal; var ActQty : Decimal )
    var
        ItemLedgEntry : Record "Item Ledger Entry";
        ActMatCost2 : Decimal;
        ActMatCostCostACY2 : Decimal;
        ActQty2 : Decimal;
    begin  
        WITH ProdOrderComponent DO BEGIN
        IF Status < Status::Released THEN BEGIN
            ActMatCost := 0;
            ActQty     := 0;
            EXIT;
        END;

        ItemLedgEntry.SETCURRENTKEY("Order No.","Order Line No.","Entry Type","Prod. Order Comp. Line No.");
        ItemLedgEntry.SETRANGE("Order No.","Prod. Order No.");
        ItemLedgEntry.SETRANGE("Order Line No.","Prod. Order Line No.");
        ItemLedgEntry.SETRANGE("Entry Type",ItemLedgEntry."Entry Type"::Consumption);
        ItemLedgEntry.SETRANGE("Prod. Order Comp. Line No.","Line No.");
        IF ItemLedgEntry.FIND('-') THEN
            REPEAT
            ItemLedgEntry.CALCFIELDS("Cost Amount (Actual)","Cost Amount (Actual) (ACY)");
            ActMatCost2 -= ItemLedgEntry."Cost Amount (Actual)";
            ActMatCostCostACY2 -= ItemLedgEntry."Cost Amount (Actual) (ACY)";
            ActQty2     -= ItemLedgEntry.Quantity;
            UNTIL ItemLedgEntry.NEXT = 0;

        ActMatCost += ActMatCost2;
        ActMatCostCostACY += ActMatCostCostACY2;
        ActQty     += ActQty2;
        END;
    end;
    
    procedure CalcProdOrderLineOvhdCost(ProdOrderLine : Record "Prod. Order Line";ShareOfTotalCapCost : Decimal;RndgPrecLCY : Decimal;RndgPrecACY : Decimal;ActMatCost : Decimal;ActMatCostACY : Decimal;VAR ActMfgOvhdCost : Decimal;VAR ActMfgOvhdCostACY : Decimal);
    var
        CapLedgEntry : Record "Capacity Ledger Entry";
        ActCapDirCost2 : Decimal;
        ActSubDirCost2 : Decimal;
        ActCapOvhdCost2 : Decimal;
        ActMfgOvhdCost2 : Decimal;
        ActCapDirCostACY2 : Decimal;
        ActSubDirCostACY2 : Decimal;
        ActCapOvhdCostACY2 : Decimal;
        ActMfgOvhdCostACY2 : Decimal;

    begin
        WITH ProdOrderLine DO BEGIN
        IF Status < Status::Released THEN BEGIN
            ActMfgOvhdCost := 0;
            ActMfgOvhdCostACY := 0;
            EXIT;
        END;

        CapLedgEntry.SETCURRENTKEY("Order No.","Order Line No.","Routing No.","Routing Reference No.");
        CapLedgEntry.SETRANGE("Order No.",ProdOrderLine."Prod. Order No.");
        CapLedgEntry.SETRANGE("Routing No.",ProdOrderLine."Routing No.");
        CapLedgEntry.SETRANGE("Routing Reference No.",ProdOrderLine."Routing Reference No.");
        IF CapLedgEntry.FIND('-') THEN
            REPEAT
            CapLedgEntry.CALCFIELDS("Direct Cost","Direct Cost (ACY)","Overhead Cost","Overhead Cost (ACY)");
            IF CapLedgEntry.Subcontracting THEN BEGIN
                ActSubDirCost2 += CapLedgEntry."Direct Cost";
                ActSubDirCostACY2 += CapLedgEntry."Direct Cost (ACY)";
            END ELSE BEGIN
                ActCapDirCost2 += CapLedgEntry."Direct Cost";
                ActCapDirCostACY2 += CapLedgEntry."Direct Cost (ACY)";
            END;
            ActCapOvhdCost2 += CapLedgEntry."Overhead Cost";
            ActCapOvhdCostACY2 += CapLedgEntry."Overhead Cost (ACY)";
            UNTIL CapLedgEntry.NEXT = 0;

        ActCapDirCost2 := ROUND(ActCapDirCost2 * ShareOfTotalCapCost,RndgPrecLCY);
        ActSubDirCost2 := ROUND(ActSubDirCost2 * ShareOfTotalCapCost,RndgPrecLCY);
        ActCapOvhdCost2 := ROUND(ActCapOvhdCost2 * ShareOfTotalCapCost,RndgPrecLCY);
        ActMfgOvhdCost2 :=
            ROUND(
            CalcOvhdCost(
                ActMatCost + ActCapDirCost2 + ActSubDirCost2 + ActCapOvhdCost2,
                "Indirect Cost %","Overhead Rate","Finished Qty. (Base)"),
            RndgPrecLCY);

        ActCapDirCostACY2 := ROUND(ActCapDirCostACY2 * ShareOfTotalCapCost,RndgPrecACY);
        ActSubDirCostACY2 := ROUND(ActSubDirCostACY2 * ShareOfTotalCapCost,RndgPrecACY);
        ActCapOvhdCostACY2 := ROUND(ActCapOvhdCostACY2 * ShareOfTotalCapCost,RndgPrecACY);
        ActMfgOvhdCostACY2 :=
            ROUND(
            CalcOvhdCost(
                ActMatCostACY + ActCapDirCostACY2 + ActSubDirCostACY2 + ActCapOvhdCostACY2,
                "Indirect Cost %","Overhead Rate","Finished Qty. (Base)"),
            RndgPrecACY);

        ActMfgOvhdCost += ActMfgOvhdCost2;
        ActMfgOvhdCostACY += ActMfgOvhdCostACY2;
        END;
    end;

    procedure CalcProdOrderLineActOutputQty(ProdOrderLine : Record "Prod. Order Line";VAR ActQty : Decimal)
    var
        ItemLedgEntry : Record "Item Ledger Entry";

    begin
        WITH ProdOrderLine DO BEGIN
        IF Status < Status::Released THEN BEGIN
            ActQty := 0;
            EXIT;
        END;

        ItemLedgEntry.SETCURRENTKEY("Order No.","Order Line No.","Entry Type");
        ItemLedgEntry.SETRANGE("Order No.","Prod. Order No.");
        ItemLedgEntry.SETRANGE("Order Line No.","Line No.");
        ItemLedgEntry.SETRANGE("Entry Type",ItemLedgEntry."Entry Type"::Output);
        IF ItemLedgEntry.FIND('-') THEN
            REPEAT
            ActQty += ItemLedgEntry.Quantity;
            UNTIL ItemLedgEntry.NEXT = 0;
        END;
    end;

    PROCEDURE CalcOvhdCost(DirCost : Decimal;IndirCostPct : Decimal;OvhdRate : Decimal;QtyBase : Decimal) : Decimal;
    BEGIN
      EXIT(DirCost * IndirCostPct / 100 + OvhdRate * QtyBase);
    END;


    procedure CalcProdOrderLineOvhdCostNCF(ProdOrderLine : Record "Prod. Order Line"; ShareOfTotalCapCost : Decimal; RndgPrecLCY : Decimal; RndgPrecACY : Decimal; ActMatCost : Decimal; ActMatCostACY : Decimal; var ActMfgOvhdCost : Decimal; ActMfgOvhdCostACY : Decimal)
    var
      CapLedgEntry : Record "Capacity Ledger Entry";
      ActCapDirCost2 : Decimal;
      ActSubDirCost2 : Decimal;
      ActCapOvhdCost2 : Decimal;
      ActMfgOvhdCost2 : Decimal;
      ActCapDirCostACY2 : Decimal;
      ActSubDirCostACY2 : Decimal;
      ActCapOvhdCostACY2 : Decimal;
      ActMfgOvhdCostACY2 : Decimal;
      CostCalcManagement : Codeunit "Cost Calculation Management";
    begin    
        WITH ProdOrderLine DO BEGIN
            IF Status < Status::Released THEN BEGIN
                ActMfgOvhdCost := 0;
                ActMfgOvhdCostACY := 0;
                EXIT;
            END;

            CapLedgEntry.SETCURRENTKEY("Order No.","Order Line No.","Routing No.","Routing Reference No.");
            CapLedgEntry.SETRANGE("Order No.",ProdOrderLine."Prod. Order No.");
            CapLedgEntry.SETRANGE("Routing No.",ProdOrderLine."Routing No.");
            CapLedgEntry.SETRANGE("Routing Reference No.",ProdOrderLine."Routing Reference No.");
            IF CapLedgEntry.FIND('-') THEN
            REPEAT
                CapLedgEntry.CALCFIELDS("Direct Cost","Direct Cost (ACY)","Overhead Cost","Overhead Cost (ACY)");
                IF CapLedgEntry.Subcontracting THEN BEGIN
                    ActSubDirCost2 += CapLedgEntry."Direct Cost";
                    ActSubDirCostACY2 += CapLedgEntry."Direct Cost (ACY)";
                END ELSE BEGIN
                    ActCapDirCost2 += CapLedgEntry."Direct Cost";
                    ActCapDirCostACY2 += CapLedgEntry."Direct Cost (ACY)";
                END;
                ActCapOvhdCost2 += CapLedgEntry."Overhead Cost";
                ActCapOvhdCostACY2 += CapLedgEntry."Overhead Cost (ACY)";
            UNTIL CapLedgEntry.NEXT = 0;

            ActCapDirCost2 := ROUND(ActCapDirCost2 * ShareOfTotalCapCost,RndgPrecLCY);
            ActSubDirCost2 := ROUND(ActSubDirCost2 * ShareOfTotalCapCost,RndgPrecLCY);
            ActCapOvhdCost2 := ROUND(ActCapOvhdCost2 * ShareOfTotalCapCost,RndgPrecLCY);
            ActMfgOvhdCost2 := ROUND(CostCalcManagement.CalcOvhdCost(ActMatCost + ActCapDirCost2 + ActSubDirCost2 + ActCapOvhdCost2,"Indirect Cost %","Overhead Rate","Finished Qty. (Base)"),RndgPrecLCY);

            ActCapDirCostACY2 := ROUND(ActCapDirCostACY2 * ShareOfTotalCapCost,RndgPrecACY);
            ActSubDirCostACY2 := ROUND(ActSubDirCostACY2 * ShareOfTotalCapCost,RndgPrecACY);
            ActCapOvhdCostACY2 := ROUND(ActCapOvhdCostACY2 * ShareOfTotalCapCost,RndgPrecACY);
            ActMfgOvhdCostACY2 := ROUND(CostCalcManagement.CalcOvhdCost(ActMatCostACY + ActCapDirCostACY2 + ActSubDirCostACY2 + ActCapOvhdCostACY2,"Indirect Cost %","Overhead Rate","Finished Qty. (Base)"),RndgPrecACY);

            ActMfgOvhdCost += ActMfgOvhdCost2;
            ActMfgOvhdCostACY += ActMfgOvhdCostACY2;
        END;
    end;
    //+HEB.136
}