//HEB.122 MT 23052018. Publicación de campo "Shipment Method Code Ext.".
//                     Ocultación de campo "Shipment Method Code".
//HEB.243 MR 11062018. Fitxa Vendedor/Comprador crear camp Option i bloqueado
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
//HEB.510 MT 03072018. Ordenación de campos extendidos
pageextension 50050 PurchaseOrderExt extends "Purchase Order"
{
    layout
    {
        //-HEB.122
        addafter("Shipment Method Code")        //-HEB.510
        {
            field("Shipment Method Code Ext."; "Shipment Method Code Ext.")
            {
                Caption = 'Shipment Method Code';
                Visible = true;
                // Lookup = true;
                // LookupPageId = ShipmentMethodsNew;
            }
        }

        modify("Shipment Method Code")
        {
            Visible = false;
        }
        //+HEB.122     
        //-HEB.242
        addafter("No. of Archived Versions")        //-HEB.510
        {
            field("NOT Confirmed";"NOT Confirmed")
            {
                Visible = NoConfirmadoVisibleBool;
                trigger OnValidate();
                begin
                    CurrPage.Update;
                end;
            }
        }
        //+HEB.242
        addafter("Area")        //-HEB.510
        {
            field("No.Doc.Previsión";"No.Doc.Previsión") { }
        }
        //-HEB.508
        addfirst("SII Information")
        {
            field("SII Exclude";"SII Exclude") { }
        }
        //+HEB.508
    }
    actions
    {
        addlast(Print)
        {
            action(EmailPDF)
            {
                Caption = 'Enviar por Mail en PDF';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction();
                var
                    PurchasesAbastLibrary : Codeunit "Purchases Abast Library";
                begin
                    PurchasesAbastLibrary.DirectPrintPurchaseHeader(Rec, true);
                end;
            }
        }
    }

    var
        NoConfirmadoVisibleBool : Boolean;

    trigger OnOpenPage();
    var
        UserMgt : Codeunit "User Setup Management";
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
            FILTERGROUP(0);
            SetNotConfirmed;
        END;
    end;
    trigger OnAfterGetRecord();
    begin
        SetNotConfirmed;
        VisibleFields;
    end;
    local procedure VisibleFields()
    begin
        IF "NOT Confirmed" then
            NoConfirmadoVisibleBool := true
        else
            NoConfirmadoVisibleBool := false;
    end;
    local procedure SetNotConfirmed()
    var
        SalesHeader : Record "Sales Header";
        PurchLine : Record "Purchase Line";
    begin
        //-HEB.243
        CLEAR(PurchLine);
        PurchLine.SETRANGE(PurchLine."Document Type","Document Type");
        PurchLine.SETRANGE(PurchLine."Document No.","No.");
        IF PurchLine.FINDFIRST THEN BEGIN
            IF (PurchLine."Sales Order No." <> '') AND (PurchLine."Sales Order Line No." <> 0) THEN BEGIN
                CLEAR(SalesHeader);
                IF SalesHeader.GET(SalesHeader."Document Type"::Order,PurchLine."Sales Order No.") THEN BEGIN
                    IF (SalesHeader."Customer Order No." = '') THEN
                        "NOT Confirmed" := TRUE
                    ELSE
                        "NOT Confirmed" := FALSE;
                    COMMIT;
                END;
            END;
        END;
        //+HEB.243
    end;
}