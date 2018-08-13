//HEB.512 MT 12072018. Publicación de campos
pageextension 51328 PurchOrderFromSalesOrderExt extends "Purch. Order From Sales Order"
{
    layout
    {
        addafter(Quantity)
        {
            field("Direct Unit Cost";"Direct Unit Cost")
            {
                Editable = true;
            }
            field(CustomerNo; SalesOrder."Sell-to Customer No.")
            {
                Caption = 'Sell-to Customer No.';
            }
            field(CustomerName; SalesOrder."Sell-to Customer Name")
            {
                Caption = 'Sell-to Customer Name';
            }
            field(ShipToCity; SalesOrder."Ship-to City")
            {
                Caption = 'Ship-to City';
            }
            field(ShipToCountryRegionCode; SalesOrder."Ship-to Country/Region Code")
            {
                Caption = 'Ship-to Country/Region Code';
            }
        }
    }

    var
        SalesOrder: Record "Sales Header";

    trigger OnOpenPage();
    begin
        SalesOrder.Get(SalesOrder."Document Type"::Order, "Demand Order No.");
    end;
}