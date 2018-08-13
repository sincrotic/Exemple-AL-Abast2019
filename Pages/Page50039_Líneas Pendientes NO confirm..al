page 50039 "Líneas Pendientes NO confirm."
{
    // version AITANA

    // //-142 ogarcia 26/01/2008 Activar Key ordenacion
    // -217 ogarcia 30/05/2013 Exp. 9205: Visualitzar Nous camps "FLOWFIELD" dades enviament
    // -242 xtrullols 04/06/2015 Formularis vendes i compres no confirmades i pedido cliente. SP20150603_HEB

    Caption = 'Líneas Pendientes NO confirm.';
    Editable = false;
    PageType = Card;
    SourceTable = "Purchase Line";
    SourceTableView = SORTING("Document Type","Completely Received","Planned Receipt Date",Type,"No.","Buy-from Vendor No.")
                      ORDER(Ascending)
                      WHERE("Document Type"=CONST(Order),
                            "Completely Received"=CONST(false),
                            "NOT Confirmed"=CONST(True));

    layout
    {
        area(content)
        {
            repeater(Repeater1)
            {
                field("Indirect Cost %";"Indirect Cost %") { }
                field("Requested Receipt Date";"Requested Receipt Date") { }
                field("VAT Prod. Posting Group";"VAT Prod. Posting Group") { }
                field("Planned Receipt Date";"Planned Receipt Date") { }
                field("Order Date";"Order Date") { }
                field("Expected Receipt Date";"Expected Receipt Date") { }
                field("Promised Receipt Date";"Promised Receipt Date") { }
                field("Document No.";"Document No.") { }
                field("Buy-from Vendor No.";"Buy-from Vendor No.") { }
                field("Line No.";"Line No.") { }
                field("Buy-from Vendor Name";"Buy-from Vendor Name") { }
                field("Pay-to Vendor No.";"Pay-to Vendor No.") { }
                field("Pay-to Name";"Pay-to Name") { }
                field("Posting Group";"Posting Group") { }
                field(Type;Type) { }
                field("Location Code";"Location Code") { }
                field("No.";"No.") { }
                field(Description;Description) { }
                field("Unit of Measure";"Unit of Measure") { }
                field(Quantity;Quantity) { }
                field("Outstanding Quantity";"Outstanding Quantity") { }
                field("Direct Unit Cost";"Direct Unit Cost") { }
                field("Unit Cost (LCY)";"Unit Cost (LCY)") { }
                field(Amount;Amount) { }
                field("Quantity Received";"Quantity Received") { }
                field("Quantity Invoiced";"Quantity Invoiced") { }
                field("Pay-to Vendor No.2";"Pay-to Vendor No.") { }
                field("Purchasing Code";"Purchasing Code") { }
                field("Completely Received";"Completely Received") { }
                field("Shipment Method Code";"Shipment Method Code") { }
                field("Ship-to Post Code";"Ship-to Post Code") { }
                field("Ship-to City";"Ship-to City") { }
                field("Ship-to County";"Ship-to County") { }
                field("Ship-to Country/Region Code";"Ship-to Country/Region Code") { }
                field("NOT Confirmed";"NOT Confirmed") { }
            }
        }
    }
}

