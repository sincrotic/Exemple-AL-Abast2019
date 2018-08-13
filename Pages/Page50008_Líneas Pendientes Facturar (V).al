page 50008 "Líneas Pendientes Facturar (V)"
{
    //VersionList AITANA
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    //-227 cnicolas  16/01/2014 Mostrar Fecha Pedido i Fecha Registro a F50007 i F50008
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Document Type","Shipment Date","Document No.","Line No.")ORDER(Ascending)WHERE("Document Type"=CONST(Order),"Qty. Shipped Not Invoiced"=FILTER(>0));
    Caption = 'Líneas Pendientes Facturar';
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(GroupName)
            {
                //-HEB.227
                Field("Order Date";"Order Date") //-227
                {
                    Caption = 'Order Date';
                    ApplicationArea = All;
                }
                //+HEB.227
                //-HEB.227
                Field("Posting Date";"Posting Date") //-227
                {
                    Caption = 'Posting Date';
                    ApplicationArea = All;
                }
                //+HEB.227
                Field("Shipment Date";"Shipment Date")
                {
                    Caption = 'Shipment Date';
                    ApplicationArea = All;
                }
                Field("Document Type";"Document Type")
                {
                    Caption = 'Document Type';
                    ApplicationArea = All;
                    OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
                }
                Field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                    ApplicationArea = All;
                }
                Field("Sell-to Customer Name";"Sell-to Customer Name")
                {
                    Caption = 'Sell-to Customer Name';
                    ApplicationArea = All;
                }
                Field("Bill-to Customer No.";"Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No';
                    ApplicationArea = All;
                }
                Field("Bill-to Customer Name";"Bill-to Customer Name")
                {
                    Caption = 'Bill-to Customer Name';
                    ApplicationArea = All;
                }
                Field("Document No.";"Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
                Field("Shipped Not Invoiced (LCY)";"Shipped Not Invoiced (LCY)")
                {
                    Caption = 'Shipped Not Invoiced (LCY';
                    ApplicationArea = All;
                }
                Field("Line No.";"Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;
                }
                Field(Type;Type)
                {
                    Caption = 'Type';
                    ApplicationArea = All;
                    OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
                }
                Field("No.";"No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                Field("Location Code";"Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = All;
                }
                Field("Posting Group";"Posting Group")
                {
                    Caption = 'Posting Group';
                    ApplicationArea = All;
                }
                Field(Description;Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                Field("Description 2";"Description 2")
                {
                    Caption = 'Description 2';
                    ApplicationArea = All;
                }
                Field(Quantity;Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Unit of Measure";"Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                    ApplicationArea = All;
                }
                Field("Outstanding Quantity";"Outstanding Quantity")
                {
                    Caption = 'Outstanding Quantity';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Qty. to Invoice";"Qty. to Invoice")
                {
                    Caption = 'Qty. to Invoice';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Qty. to Ship";"Qty. to Ship")
                {
                    Caption = 'Qty. to Ship';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Unit Price";"Unit Price")
                {
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                }
                Field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                    Caption = 'Unit Cost (LCY)';
                    ApplicationArea = All;
                }
                Field("VAT %";"VAT %")
                {
                    Caption = 'VAT %';
                    ApplicationArea = All;
                    DecimalPlaces = 0:6;
                }
                Field("Line Discount %";"Line Discount %")
                {
                    Caption = 'Line Discount %';
                    ApplicationArea = All;
                    DecimalPlaces = 0:6;
                }
                Field("Line Discount Amount";"Line Discount Amount")
                {
                    Caption = 'Line Discount Amount"';
                    ApplicationArea = All;
                }
                Field(Amount;Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }
                Field("Amount Including VAT";"Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                    ApplicationArea = All;
                }
                Field("Allow Invoice Disc.";"Allow Invoice Disc.")
                {
                    Caption = 'Allow Invoice Disc.';
                    ApplicationArea = All;
                }
                Field("Gross Weight";"Gross Weight")
                {
                    Caption = 'Gross Weight';
                    ApplicationArea = All;
                    DecimalPlaces = 0:6;
                }
                Field("Net Weight";"Net Weight")
                {
                    Caption = 'Net Weight';
                    ApplicationArea = All;
                    DecimalPlaces = 0:6;
                }
                Field("Units per Parcel";"Units per Parcel")
                {
                    Caption = 'Units per Parcel';
                    ApplicationArea = All;
                    DecimalPlaces = 0:6;
                }
                Field("Unit Volume";"Unit Volume")
                {
                    Caption = 'Unit Volume';
                    ApplicationArea = All;
                    DecimalPlaces = 0:6;
                }
                Field("Customer Price Group";"Customer Price Group")
                {
                    Caption = 'Customer Price Group';
                    ApplicationArea = All;
                }
                Field("Qty. Shipped Not Invoiced";"Qty. Shipped Not Invoiced")
                {
                    Caption = 'Qty. Shipped Not Invoiced';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Shipped Not Invoiced";"Shipped Not Invoiced")
                {
                    Caption = 'Shipped Not Invoiced';
                    ApplicationArea = All;
                }
                Field("Quantity Shipped";"Quantity Shipped")
                {
                    Caption = 'Quantity Shipped';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Quantity Invoiced";"Quantity Invoiced")
                {
                    Caption = 'Quantity Invoiced';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Shipment No.";"Shipment No.")
                {
                    Caption = 'Shipment No.';
                    ApplicationArea = All;
                }
                Field("Shipment Line No.";"Shipment Line No.")
                {
                    Caption = 'Shipment Line No.';
                    ApplicationArea = All;
                }
                Field("Bill-to Customer No.2";"Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.';
                    ApplicationArea = All;
                }
                Field("Inv. Discount Amount";"Inv. Discount Amount")
                {
                    Caption = 'Inv. Discount Amount';
                    ApplicationArea = All;
                }
                Field("Purchase Order No.";"Purchase Order No.")
                {
                    Caption = 'Purchase Order No.';
                    ApplicationArea = All;
                }
                Field("Purch. Order Line No.";"Purch. Order Line No.")
                {
                    Caption = 'Purch. Order Line No.';
                    ApplicationArea = All;
                }
                Field("Drop Shipment";"Drop Shipment")
                {
                    Caption = 'Drop Shipment';
                    ApplicationArea = All;
                }
                Field("VAT Calculation Type";"VAT Calculation Type")
                {
                    Caption = 'VAT Calculation Type';
                    ApplicationArea = All;
                    OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax,No Taxable VAT';
                }
                Field("Transaction Type";"Transaction Type")
                {
                    Caption = 'Transaction Type';
                    ApplicationArea = All;
                }
                Field("Transport Method";"Transport Method")
                {
                    Caption = 'Transport Method';
                    ApplicationArea = All;
                }
                Field("Attached to Line No.";"Attached to Line No.")
                {
                    Caption = 'Attached to Line No.';
                    ApplicationArea = All;
                }
                Field("Exit Point";"Exit Point")
                {
                    Caption = 'Exit Point';
                    ApplicationArea = All;
                }
                Field("Area";"Area")
                {
                    Caption = 'Area';
                    ApplicationArea = All;
                }
                Field("Transaction Specification";"Transaction Specification")
                {
                    Caption = 'Transaction Specification';
                    ApplicationArea = All;
                }
                Field("Tax Area Code";"Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                    ApplicationArea = All;
                }
                Field("Tax Liable";"Tax Liable")
                {
                    Caption = 'Tax Liable';
                    ApplicationArea = All;
                }
                Field("Tax Group Code";"Tax Group Code")
                {
                    Caption = 'Tax Group Code';
                    ApplicationArea = All;
                }
                Field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                    ApplicationArea = All;
                }
                Field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                    ApplicationArea = All;
                }
                Field("Currency Code";"Currency Code")
                {
                    Caption = 'Currency Code';
                    ApplicationArea = All;
                }
                Field("Outstanding Amount (LCY)";"Outstanding Amount (LCY)")
                {
                    Caption = 'Outstanding Amount (LCY)';
                    ApplicationArea = All;
                }
                Field("Shipped Not Invoiced (LCY)2";"Shipped Not Invoiced (LCY)")
                {
                    Caption = 'Shipped Not Invoiced (LCY)';
                    ApplicationArea = All;
                }
                Field("Reserved Quantity";"Reserved Quantity")
                {
                    Caption = 'Reserved Quantity';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field(Reserve;Reserve)
                {
                    Caption = 'Reserve';
                    ApplicationArea = All;
                }
                Field("Blanket Order No.";"Blanket Order No.")
                {
                    Caption = 'Blanket Order No.';
                    ApplicationArea = All;
                }
                Field("Blanket Order Line No.";"Blanket Order Line No.")
                {
                    Caption = 'Blanket Order Line No.';
                    ApplicationArea = All;
                }
                Field("VAT Base Amount";"VAT Base Amount")
                {
                    Caption = 'VAT Base Amount';
                    ApplicationArea = All;
                }
                Field("VAT Difference";"VAT Difference")
                {
                    Caption = 'VAT Difference';
                    ApplicationArea = All;
                }
                Field("Inv. Disc. Amount to Invoice";"Inv. Disc. Amount to Invoice")
                {
                    Caption = 'Inv. Disc. Amount to Invoice';
                    ApplicationArea = All;
                }
                Field("VAT Identifier";"VAT Identifier")
                {
                    Caption = 'VAT Identifier';
                    ApplicationArea = All;
                }
                Field("IC Partner Ref. Type";"IC Partner Ref. Type")
                {
                    Caption = 'IC Partner Ref. Type';
                    ApplicationArea = All;
                    OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.';
                }
                Field("Prepayment %";"Prepayment %")
                {
                    Caption = 'Prepayment %';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Prepmt. Line Amount";"Prepmt. Line Amount")
                {
                    Caption = 'Prepmt. Line Amount';
                    ApplicationArea = All;
                }
                Field("Prepmt. Amt. Inv.";"Prepmt. Amt. Inv.")
                {
                    Caption = 'Prepmt. Amt. Inv.';
                    ApplicationArea = All;
                }
                Field("Prepmt. Amt. Incl. VAT";"Prepmt. Amt. Incl. VAT")
                {
                    Caption = 'Prepmt. Amt. Incl. VAT';
                    ApplicationArea = All;
                }
                Field("Prepayment Amount";"Prepayment Amount")
                {
                    Caption = 'Prepayment Amount';
                    ApplicationArea = All;
                }
                Field("Prepmt. VAT Base Amt.";"Prepmt. VAT Base Amt.")
                {
                    Caption = 'Prepmt. VAT Base Amt.';
                    ApplicationArea = All;
                }
                Field("Prepayment VAT %";"Prepayment VAT %")
                {
                    Caption = 'Prepayment VAT %';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Prepmt. VAT Calc. Type";"Prepmt. VAT Calc. Type")
                {
                    Caption = 'Prepmt. VAT Calc. Type';
                    ApplicationArea = All;
                    OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
                }
                Field("Prepayment VAT Identifier";"Prepayment VAT Identifier")
                {
                    Caption = 'Prepayment VAT Identifier';
                    ApplicationArea = All;
                }
                Field("Prepayment Tax Area Code";"Prepayment Tax Area Code")
                {
                    Caption = 'Prepayment Tax Area Code';
                    ApplicationArea = All;
                }
                Field("Prepayment Line";"Prepayment Line")
                {
                    Caption = 'Prepayment Line';
                    ApplicationArea = All;
                }
                Field("Prepmt. Amount Inv. Incl. VAT";"Prepmt. Amount Inv. Incl. VAT")
                {
                    Caption = 'Prepmt. Amount Inv. Incl. VAT';
                    ApplicationArea = All;
                }
                Field("Item Category Code";"Item Category Code")
                {
                    Caption = 'Item Category Code';
                    ApplicationArea = All;
                }
                Field("Purchasing Code";"Purchasing Code")
                {
                    Caption = 'Purchasing Code';
                    ApplicationArea = All;
                }
                Field("Product Group Code";"Product Group Code")
                {
                    Caption = 'Product Group Code';
                    ApplicationArea = All;
                }
                Field("Special Order";"Special Order")
                {
                    Caption = 'Special Order';
                    ApplicationArea = All;
                }
                Field("Special Order Purchase No.";"Special Order Purchase No.")
                {
                    Caption = 'Special Order Purchase No.';
                    ApplicationArea = All;
                }
                Field("Special Order Purch. Line No.";"Special Order Purch. Line No.")
                {
                    Caption = 'Special Order Purch. Line No.';
                    ApplicationArea = All;
                }
                Field("Completely Shipped";"Completely Shipped")
                {
                    Caption = 'Completely Shipped';
                    ApplicationArea = All;
                }
                Field("Requested Delivery Date";"Requested Delivery Date")
                {
                    Caption = 'Requested Delivery Date';
                    ApplicationArea = All;
                }
                Field("Promised Delivery Date";"Promised Delivery Date")
                {
                    Caption = 'Promised Delivery Date';
                    ApplicationArea = All;
                }
                Field("Shipping Time";"Shipping Time")
                {
                    Caption = 'Shipping Time';
                    ApplicationArea = All;
                }
                Field("Outbound Whse. Handling Time";"Outbound Whse. Handling Time")
                {
                    Caption = 'Outbound Whse. Handling Time';
                    ApplicationArea = All;
                }
                Field("Planned Delivery Date";"Planned Delivery Date")
                {
                    Caption = 'Planned Delivery Date';
                    ApplicationArea = All;
                }
                Field("Planned Shipment Date";"Planned Shipment Date")
                {
                    Caption = 'Planned Shipment Date';
                    ApplicationArea = All;
                }
                Field("Shipping Agent Code";"Shipping Agent Code")
                {
                    Caption = 'Shipping Agent Code';
                    ApplicationArea = All;
                }
                Field("Shipping Agent Service Code";"Shipping Agent Service Code")
                {
                    Caption = 'Shipping Agent Service Code';
                    ApplicationArea = All;
                }
                Field("Allow Item Charge Assignment";"Allow Item Charge Assignment")
                {
                    Caption = 'Allow Item Charge Assignment';
                    ApplicationArea = All;
                }
                Field("Qty. to Assign";"Qty. to Assign")
                {
                    Caption = 'Qty. to Assign';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Qty. Assigned";"Qty. Assigned")
                {
                    Caption = 'Qty. Assigned';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Return Qty. to Receive";"Return Qty. to Receive")
                {
                    Caption = 'Return Qty. to Receive';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Return Qty. to Receive (Base)";"Return Qty. to Receive (Base)")
                {
                    Caption = 'Return Qty. to Receive (Base)';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Return Qty. Rcd. Not Invd.";"Return Qty. Rcd. Not Invd.")
                {
                    Caption = 'Return Qty. Rcd. Not Invd.';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Ret. Qty. Rcd. Not Invd.(Base)";"Ret. Qty. Rcd. Not Invd.(Base)")
                {
                    Caption = 'Ret. Qty. Rcd. Not Invd.(Base)';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Return Rcd. Not Invd.";"Return Rcd. Not Invd.")
                {
                    Caption = 'Return Rcd. Not Invd.';
                    ApplicationArea = All;
                }
                Field("Return Rcd. Not Invd. (LCY)";"Return Rcd. Not Invd. (LCY)")
                {
                    Caption = 'Return Rcd. Not Invd. (LCY)';
                    ApplicationArea = All;
                }
                Field("Return Qty. Received";"Return Qty. Received")
                {
                    Caption = 'Return Qty. Received';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Return Qty. Received (Base)";"Return Qty. Received (Base)")
                {
                    Caption = 'Return Qty. Received (Base)';
                    ApplicationArea = All;
                    DecimalPlaces = 0:5;
                }
                Field("Return Receipt No.";"Return Receipt No.")
                {
                    Caption = 'Return Receipt No.';
                    ApplicationArea = All;
                }
                Field("Return Receipt Line No.";"Return Receipt Line No.")
                {
                    Caption = 'Return Receipt Line No.';
                    ApplicationArea = All;
                }
                Field("Return Reason Code";"Return Reason Code")
                {
                    Caption = 'Return Reason Code';
                    ApplicationArea = All;
                }
                Field("Allow Line Disc.";"Allow Line Disc.")
                {
                    Caption = 'Allow Line Disc.';
                    ApplicationArea = All;
                }
                Field("Customer Disc. Group";"Customer Disc. Group")
                {
                    Caption = 'Customer Disc. Group';
                    ApplicationArea = All;
                }
                Field("EC %";"EC %")
                {
                    Caption = 'EC %';
                    ApplicationArea = All;
                }
                //-HEB.114
                Field("Grupo Comision";"Grupo Comision") //-114: PI0010
                {
                    Caption = 'Grupo Comision';
                    ApplicationArea = All;
                }
                //+HEB.114
                //-HEB.114
                Field("% Comisión";"% Comisión") //-114: PI0010
                {
                    Caption = '% Comisión';
                    ApplicationArea = All;
                    DecimalPlaces = 0:3;
                }
                //+HEB.114
                //-HEB.114
                Field("Importe Comisión";"Importe Comisión") //-114: PI0010
                {
                    Caption = 'Importe Comisión';
                    ApplicationArea = All;
                }
                //+HEB.114
            }
        }
    }
}