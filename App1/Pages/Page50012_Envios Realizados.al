page 50012 "Envios Realizados"
{
    // version AITANA
    Caption = 'Envios Realizados';
    Editable = false;
    PageType = List;
    SourceTable = "Sales Shipment Line";
    SourceTableView = SORTING("Sell-to Customer No.","Shipment Date",Type,"No.")
                      WHERE(Type=FILTER(<>' '),
                            "No."=FILTER(<>''));
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1100000)
            {
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                    ApplicationArea = All;
                }
                field("venta a-Nombre";"venta a-Nombre")
                {
                    Caption = 'Sell-to Name';
                    ApplicationArea = All;
                }
                field("Shipment Date";"Shipment Date")
                {
                    Caption = 'Shipment Date';
                    ApplicationArea = All;
                }
                field("envío a-Nombre";"envío a-Nombre")
                {
                    Caption = 'Ship-to Name';
                    ApplicationArea = All;
                }
                field("Order No.";"Order No.")
                {
                    Caption = 'Order No.';
                    ApplicationArea = All;
                }
                field("Order Line No.";"Order Line No.")
                {
                    Caption = 'Order Line No.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document No.";"Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
                field("Line No.";"Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;
                }
                field(Type;Type)
                {
                    Caption = 'Typ';
                    ApplicationArea = All;
                    OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
                }
                field("No.";"No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field(Description;Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field("Description 2";"Description 2")
                {
                    Caption = 'Description 2';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code";"Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = All;
                }
                field(Quantity;Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
                field("Quantity Invoiced";"Quantity Invoiced")
                {
                    Caption = 'Quantity Invoiced';
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invoiced";"Qty. Shipped Not Invoiced")
                {
                    Caption = 'Qty. Shipped Not Invoiced';
                    ApplicationArea = All;
                }
                field("Unit of Measure";"Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                    ApplicationArea = All;
                }
                field("Unit Price";"Unit Price")
                {
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                    Caption = 'Unit Cost (LCY)';
                    ApplicationArea = All;
                }
                field("VAT %";"VAT %")
                {
                    Caption = 'VAT %';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Discount %";"Line Discount %")
                {
                    Caption = 'Line Discount %';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Drop Shipment";"Drop Shipment")
                {
                    Caption = 'Drop Shipment';
                    ApplicationArea = All;
                }
                field("Requested Delivery Date";"Requested Delivery Date")
                {
                    Caption = 'Requested Delivery Date';
                    ApplicationArea = All;
                }
                field("Promised Delivery Date";"Promised Delivery Date")
                {
                    Caption = 'Promised Delivery Date';
                    ApplicationArea = All;
                }
                field("Planned Delivery Date";"Planned Delivery Date")
                {
                    Caption = 'Planned Delivery Date';
                    ApplicationArea = All;
                }
                field("Planned Shipment Date";"Planned Shipment Date")
                {
                    Caption = 'Planned Shipment Date';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        rec110 : Record "Sales Shipment Header";
    begin
        rec110.GET("Document No.");
        "venta a-Nombre":=rec110."Sell-to Customer Name";
        "envío a-Nombre":=rec110."Ship-to Name";
    end;

    var
        "venta a-Nombre" : Text[50];
        "envío a-Nombre" : Text[50];
}

