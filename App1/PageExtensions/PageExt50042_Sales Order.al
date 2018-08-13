//HEB.122 MT 22052018. Publicación de campo "Shipment Method Code Ext.".
//                     Ocultación de campo "Shipment Method Code".
//HEB.244 MR 11062018. Camps relacionats venedor a fitxa client i traspassar a documents
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
//HEB.510 MT 03072018. Ordenación de campos extendidos
pageextension 50042 SalesOrderExt extends "Sales Order"
{
    layout
    {
        //-HEB.122
        addfirst("Shipment Method")
        {
            field("Shipment Method Code Ext."; "Shipment Method Code Ext.")
            {
                Caption = 'Code';
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
        //-HEB.510
        addfirst("Foreign Trade")
        {
            field("Shipment Method Code Ext.2"; "Shipment Method Code Ext.")
            {
                Caption = 'Code';
                Visible = true;
            }
        }
        //+HEB.510
        //-HEB.242
        addafter("External Document No.")       //-HEB.510
        {
            field("Customer Order No.";"Customer Order No.")
            {
                trigger OnValidate();
                begin
                    CurrPage.Update;
                end;
            }
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate();
            begin
                VisibleFields;
                CurrPage.Update;
            end;
        }
        //+HEB.242
        //-HEB.244
        addafter("Salesperson Code")        //-HEB.510
        {
            field("Distributor Code";"Distributor Code") { }
            field("Salesperson/Resp. Code";"Salesperson/Resp. Code") { }
            field("Administr/Resp. Code";"Administr/Resp. Code") { }
        }
        //+HEB.244
        //-HEB.508
        addfirst("SII Information")
        {
            field("SII Exclude";"SII Exclude") { }
        }
        //+HEB.508
    }
    actions
    {
        addafter(SendEmailConfirmation)
        {
            action(MailPDF)
            {
                Caption = 'Enviar por Mail en PDF';
                Image = SendMail;
                trigger OnAction();
                var
                    SalesHeader : Record "Sales Header";
                    PagePdf : Page "PDF - Pedido Venta";
                    SalesAbastLibrary : Codeunit "Sales Abast Library";
                    DocType : Option Quote,Order,Shipment,Invoice,"Posted Invoice","Credit Memo","Return Order","Posted Credit Memo","Posted Return Order";
                    Path : Text;
                begin
                    CurrPage.UPDATE;
                    SalesHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesHeader);
                    PagePdf.setValores(SalesHeader);
                    PagePdf.RunModal;
                end;
            }
        }
        modify(SendEmailConfirmation)
        {
            Visible = false;
            Enabled = false;
        }
    }
    var
        EspecialesVisible : Boolean;
        NoConfirmado : Boolean;
        DifferSellToBillTo : Boolean;

    trigger OnAfterGetCurrRecord();
    begin
        VisibleFields;
        //UpdateInfoPanel;
    end;

    // local procedure UpdateInfoPanel()
    // begin
    //     DifferSellToBillTo := "Sell-to Customer No." <> "Bill-to Customer No.";
    //     CurrPage.SalesHistoryBtn.VISIBLE := DifferSellToBillTo;
    //     CurrPage.BillToCommentPict.VISIBLE := DifferSellToBillTo;
    //     CurrPage.BillToCommentBtn.VISIBLE := DifferSellToBillTo;
    //     CurrPage.SalesHistoryStn.VISIBLE := SalesInfoPaneMgt.DocExist(Rec,"Sell-to Customer No.");
    //     IF DifferSellToBillTo THEN
    //         CurrPage.SalesHistoryBtn.VISIBLE := SalesInfoPaneMgt.DocExist(Rec,"Bill-to Customer No.")
    // end;

    local procedure VisibleFields()
    var
        recCust : Record Customer;
    begin
        IF NOT recCust.GET("Sell-to Customer No.") THEN
            recCust.INIT;

        EspecialesVisible := recCust."Special Conditions";

        IF "Customer Order No." = '' THEN
            NoConfirmado := TRUE
        ELSE
            NoConfirmado := FALSE;
    end;
}