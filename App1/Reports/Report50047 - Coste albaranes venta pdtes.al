report 50047 "Coste albaranes venta pdtes."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Coste albaranes venta pdtes..rdlc';
    Caption = 'Cost Shipment Sales Pending';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Description = 'HEB.211';

    dataset
    {
        dataitem("Sales Shipment Header";"Sales Shipment Header")
        {
            RequestFilterFields = "Posting Date","No.";
            column(DocDate_SalesShipmentHeader;FORMAT(TODAY,0,4))
            {
            }
            column(CompanyName;CompanyInfo.Name)
            {
            }
            column(textFilter1;textFilter1)
            {
            }
            column(textFilter2;textFilter2)
            {
            }
            column(textFilter3;textFilter3)
            {
            }
            column(No_SalesShipmentHeader;"No.")
            {
            }
            column(SelltoCustomer_SalesShipmentHeader;"Sell-to Customer No.")
            {
            }
            column(Customer_Name;recCust.Name)
            {
            }
            column(blnShowDetail;blnShowDetail)
            {
            }
            dataitem("Sales Shipment Line";"Sales Shipment Line")
            {
                DataItemLink = "Document No."=FIELD("No.");
                DataItemTableView = SORTING("Document No.","Line No.")
                                    WHERE(Type=CONST(Item),
                                          Quantity=FILTER(<>0));
                RequestFilterFields = "Location Code","Posting Group","Qty. Shipped Not Invoiced";
                column(LineNo_SalesShipmentLine;"Line No.")
                {
                }
                column(No_SalesShipmentLine;"No.")
                {
                }
                column(Description_SalesShipmentLine;Description)
                {
                }
                column(Quantity_SalesShipmentLine;Quantity)
                {
                }
                dataitem("Item Ledger Entry";"Item Ledger Entry")
                {
                    DataItemLink = "Document No."=FIELD("Document No."),
                                   "Item No."=FIELD("No."),
                                   "Location Code"=FIELD("Location Code"),
                                   "Variant Code"=FIELD("Variant Code"),
                                   "Document Line No."=FIELD("Line No.");
                    DataItemTableView = SORTING("Entry No.")
                                        WHERE("Entry Type"=CONST(Sale),
                                              "Document Type"=CONST("Sales Shipment"));
                    column(LotNo_ItemLedgerEntry;"Item Ledger Entry"."Lot No.")
                    {
                    }
                    column(EntryNo_ItemLedgerEntry;"Item Ledger Entry"."Entry No.")
                    {
                    }
                    column(Quantity_ItemLedgerEntry;"Item Ledger Entry".Quantity)
                    {
                    }
                    column(decQtyInbound;decQtyInbound)
                    {
                    }
                    column(decCostInbound;decCostInbound)
                    {
                    }
                    column(decCostOutbound;decCostOutbound)
                    {
                    }
                    column(decShipmentCostOutbound;decShipmentCostOutbound)
                    {
                    }
                    column(decTotalCostOutbound;decTotalCostOutbound)
                    {
                    }
                    column(decTotalQuantity;decTotalQuantity)
                    {
                    }
                    column(LineNo_SalesShipmentLine_ILE;"Sales Shipment Line"."Line No.")
                    {
                    }
                    column(No_SalesShipmentLine_ILE;"Sales Shipment Line"."No.")
                    {
                    }
                    column(Des_SalesShipmentLine_ILE;"Sales Shipment Line".Description)
                    {
                    }
                    column(Qty__SalesShipmentLine_ILE;"Sales Shipment Line".Quantity)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        decQtyInbound:=0;
                        decCostInbound:=0;
                        recItemApplEntry.RESET;
                        recItemApplEntry.SETRANGE("Outbound Item Entry No.","Entry No.");
                        IF recItemApplEntry.FINDSET(FALSE,FALSE) THEN BEGIN
                          REPEAT
                            IF recItemLedgEntry.GET(recItemApplEntry."Inbound Item Entry No.") THEN BEGIN
                              recItemLedgEntry.CALCFIELDS("Cost Amount (Expected)","Cost Amount (Actual)");
                              decQtyInbound+=(recItemLedgEntry.Quantity);
                              decCostInbound+=(recItemLedgEntry."Cost Amount (Expected)"+recItemLedgEntry."Cost Amount (Actual)")*-1;
                            END;
                          UNTIL recItemApplEntry.NEXT=0;
                        END;

                        IF decQtyInbound<>0 THEN
                          decCostOutbound:=Quantity*(decCostInbound/decQtyInbound);
                        decShipmentCostOutbound+=decCostOutbound;
                        decTotalCostOutbound+=decCostOutbound;
                        decTotalQuantity+=-Quantity;
                    end;

                    trigger OnPreDataItem();
                    begin
                        SETRANGE("Posting Date","Sales Shipment Header"."Posting Date");
                        CurrReport.CREATETOTALS(decCostOutbound,Quantity);
                    end;
                }

                trigger OnPreDataItem();
                begin
                    CurrReport.CREATETOTALS(Quantity);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                recCust.GET("Sell-to Customer No.");
                decShipmentCostOutbound:=0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Show Detail";blnShowDetail)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        TitolLbl = 'Shipments not Invoiced Cost';ShipmentNo = 'Shipment No.';CustomerNo = 'Customer No.';CustomerName = 'Customer Name';LineNo = 'Line No.';ItemNo = 'Item No.';Description = 'Description';Qty = 'Quantity';EntryNo = 'Entry No.';LotNo = 'Lot No.';UnitCost = 'Unit Cost';CostAmount = 'Cost Amount';TotalCost = 'Total Cost';LineTotal = 'Line Total';ShipmentTotal = 'Shipment Total';ReportTotal = 'Report Total';Pag = 'Página';}

    trigger OnInitReport();
    begin
        CompanyInfo.GET;
    end;

    trigger OnPreReport();
    begin
        textFilter1 := "Sales Shipment Header".GETFILTERS();
        textFilter2 := "Sales Shipment Line".GETFILTERS();
        textFilter3 := STRSUBSTNO('Mostrar Detalle: %1',blnShowDetail);
    end;

    var
        recCust : Record "Customer";
        recItemApplEntry : Record "Item Application Entry";
        recItemLedgEntry : Record "Item Ledger Entry";
        CompanyInfo : Record "Company Information";
        decQtyInbound : Decimal;
        decCostInbound : Decimal;
        decCostOutbound : Decimal;
        decShipmentCostOutbound : Decimal;
        decTotalCostOutbound : Decimal;
        decTotalQuantity : Decimal;
        blnShowDetail : Boolean;
        textFilter1 : Text[1024];
        textFilter2 : Text[1024];
        textFilter3 : Text[1024];
}

