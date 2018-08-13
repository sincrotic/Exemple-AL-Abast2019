//HEB.122 MT 24052018. Publicación de campo "Shipment Method Code Ext.".
//                     Ocultación de campo "Shipment Method Code".
//HEB.184 MR 30052018. Nuevos campos cabecera compra para DUA
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 50051 PurchaseInvoiceExt extends "Purchase Invoice"
{
    layout
    {
        //-HEB.122
        addafter("Pmt. Discount Date")
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
        addafter("Foreign Trade")
        {
            group(Aduanas)
            {
                Caption = 'Aduanas';
                field("Nº DUA";"Nº DUA"){}
                field("Fecha DUA";"Fecha DUA"){}
                field("Proveedor Origen";"Proveedor Origen"){}
            }
        } 
        addafter(Status)
        {
            field("Posting No. Series";"Posting No. Series") { }
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
        addlast("P&osting")
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
}