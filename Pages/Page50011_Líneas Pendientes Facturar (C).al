page 50011 "Líneas Pendientes Facturar (C)"
{
    // version AITANA

    Caption = 'Líneas Pendientes Facturar';
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = SORTING("Document Type","Expected Receipt Date","Document No.","Line No.")
                      ORDER(Ascending)
                      WHERE("Document Type"=CONST(Order),
                            "Qty. Rcd. Not Invoiced"=FILTER(>0));

    layout
    {
        area(content)
        {
            repeater(Control1100000)
            {
                field("Indirect Cost %";"Indirect Cost %")
                {
                }
                field("Planned Receipt Date";"Planned Receipt Date")
                {
                }
                field("Order Date";"Order Date")
                {
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                }
                field("Buy-from Vendor Name";"Buy-from Vendor Name")
                {
                }
                field("Pay-to Vendor No.";"Pay-to Vendor No.")
                {
                }
                field("Pay-to Name";"Pay-to Name")
                {
                }
                field("Document No.";"Document No.")
                {
                }
                field("Line No.";"Line No.")
                {
                }
                field(Type;Type)
                {
                }
                field("No.";"No.")
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field("Expected Receipt Date";"Expected Receipt Date")
                {
                }
                field(Description;Description)
                {
                }
                field("Unit of Measure";"Unit of Measure")
                {
                }
                field(Quantity;Quantity)
                {
                }
                field("Outstanding Quantity";"Outstanding Quantity")
                {
                }
                field("Direct Unit Cost";"Direct Unit Cost")
                {
                }
                field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                }
                field(Amount;Amount)
                {
                }
                field("Quantity Received";"Quantity Received")
                {
                }
                field("Quantity Invoiced";"Quantity Invoiced")
                {
                }
                field("Purchasing Code";"Purchasing Code")
                {
                }
                field("Completely Received";"Completely Received")
                {
                }
            }
        }
    }

    actions
    {
    }
}

