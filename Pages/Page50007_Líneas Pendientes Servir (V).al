page 50007 "Líneas Pendientes Servir (V)"
{
    // version AITANA

    // -142 ogarcia 26/01/2009 Activar nova Key ordenación
    // -227 cnicolas  16/01/2014 Mostrar Fecha Pedido i Fecha Registro a F50007 i F50008
   
    Caption = 'Líneas Pendientes Servir';
    Editable = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Document Type","Completely Shipped","Planned Shipment Date",Type,"No.","Sell-to Customer No.")
                      ORDER(Ascending)
                      WHERE("Document Type"=CONST(Order),
                            "Completely Shipped"=CONST(false));
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Order Date";"Order Date")
                {
                }
                field("Posting Date";"Posting Date")
                {
                }
                field("Planned Shipment Date";"Planned Shipment Date")
                {
                }
                field("Document Type";"Document Type")
                {
                }
                field("Document No.";"Document No.")
                {
                }
                field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                {
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                }
                field("Sell-to Customer Name";"Sell-to Customer Name")
                {
                }
                field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
                {
                }
                field("Bill-to Customer No.";"Bill-to Customer No.")
                {
                }
                field("Purchasing Code";"Purchasing Code")
                {
                }
                field("Purchase Order No.";"Purchase Order No.")
                {
                }
                field("Outstanding Amount (LCY)";"Outstanding Amount (LCY)")
                {
                }
                field("Bill-to Customer Name";"Bill-to Customer Name")
                {
                }
                field("Requested Delivery Date";"Requested Delivery Date")
                {
                }
                field("Planned Delivery Date";"Planned Delivery Date")
                {
                }
                field("Planned Shipment Date 2";"Planned Shipment Date")
                {
                }
                field("Line No.";"Line No.")
                {
                    Visible = false;
                }
                field("Shipping Agent Code";"Shipping Agent Code")
                {
                }
                field(Type;Type)
                {
                }
                field("No.";"No.")
                {
                }
                field("Unit Price";"Unit Price")
                {
                }
                field(Description;Description)
                {
                }
                field("Location Code";"Location Code")
                {
                    Visible = true;
                }
                field(Quantity;Quantity)
                {
                }
                field("Outstanding Quantity";"Outstanding Quantity")
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                    Visible = true;
                }
                field("Line Amount";"Line Amount")
                {
                    BlankZero = true;
                }
                field("Job No.";"Job No.")
                {
                    Visible = false;
                }
                field("Work Type Code";"Work Type Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                
                field("ShortcutDimCode 3";ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(Text : Text) : Boolean;
                    begin
                        LookupShortcutDimCode(3,ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode 4";ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(Text : Text) : Boolean;
                    begin
                        LookupShortcutDimCode(4,ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode 5";ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(Text : Text) : Boolean;
                    begin
                        LookupShortcutDimCode(5,ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode 6";ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(Text : Text) : Boolean;
                    begin
                        LookupShortcutDimCode(6,ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode 7";ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(Text : Text) : Boolean;
                    begin
                        LookupShortcutDimCode(7,ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode 8";ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(Text : Text) : Boolean;
                    begin
                        LookupShortcutDimCode(8,ShortcutDimCode[8]);
                    end;
                }
                field("Shipment Date";"Shipment Date")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("Show Document")
                {
                    Caption = 'Show Document';
                    Image = View;
                    ShortCutKey = 'Shift+F5';

                    trigger OnAction();
                    begin
                        SalesHeader.GET("Document Type","Document No.");
                        CASE "Document Type" OF
                          "Document Type"::Quote:
                            PAGE.RUN(PAGE::"Sales Quote",SalesHeader);
                          "Document Type"::Order:
                            PAGE.RUN(PAGE::"Sales Order",SalesHeader);
                          "Document Type"::Invoice:
                            PAGE.RUN(PAGE::"Sales Invoice",SalesHeader);
                          "Document Type"::"Return Order":
                            PAGE.RUN(PAGE::"Sales Return Order",SalesHeader);
                          "Document Type"::"Credit Memo":
                            PAGE.RUN(PAGE::"Sales Credit Memo",SalesHeader);
                          "Document Type"::"Blanket Order":
                            PAGE.RUN(PAGE::"Blanket Sales Order",SalesHeader);
                        END;
                    end;
                }
                action("Reservation Entries")
                {
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;

                    trigger OnAction();
                    begin
                        ShowReservationEntries(TRUE);
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;

                    trigger OnAction();
                    begin
                        OpenItemTrackingLines;
                    end;
                }
            }
        }
    }

    var
        SalesHeader : Record "Sales Header";
        ShortcutDimCode : array [8] of Code[20];

    trigger OnAfterGetRecord();
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec : Boolean);
    begin
        CLEAR(ShortcutDimCode);
    end;
}

