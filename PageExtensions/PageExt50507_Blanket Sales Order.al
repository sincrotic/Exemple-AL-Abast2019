//HEB.122 MT 25052018. Publicación de campo "Shipment Method Code Ext.".
//                     Ocultación de campo "Shipment Method Code".
pageextension 50507 BlanketSalesOrderExt extends "Blanket Sales Order"
{
    layout
    {
        //-HEB.122
        addafter("Shipment Method Code")
        {
            field("Shipment Method Code Ext."; "Shipment Method Code")
            {
                Caption = 'Code';
                Visible = true;
                Lookup = true;
                LookupPageId = ShipmentMethodsNew;
            }
        }
        addafter("Assigned User ID")
        {
            field("Quote No.";"Quote No.")
            {
                Editable = false;
            }
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        //+HEB.122
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate();
            begin
                VisibleFields;
                CurrPage.Update;
            end;
        }
    }

    var
        EspecialesVisible : Boolean;
        VariablesVisible : Boolean;

    trigger OnAfterGetCurrRecord();
    begin
        VisibleFields;
    end;

    local procedure VisibleFields()
    var
        recCust : Record Customer;
    begin
        IF NOT recCust.GET("Sell-to Customer No.") THEN
            recCust.INIT;

        EspecialesVisible := recCust."Special Conditions";
        VariablesVisible := recCust."Variable Payment Conditions";
    end;
}