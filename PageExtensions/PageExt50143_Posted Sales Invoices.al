pageextension 50143 PostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        moveafter("No.";"Shipment Method Code")
        addafter("Shipment Method Code")
        {
            field("Order No.";"Order No."){ }
            //field("customer order no.")
        }
        moveafter("Order No.";"Document Date")
        addafter("Document Date")
        {
            field("VAT Bus. Posting Group";"VAT Bus. Posting Group"){ }
            field("VAT Country/Region Code";"VAT Country/Region Code"){ }
            field("VAT Registration No.";"VAT Registration No."){ }            
        }
        moveafter("VAT Registration No.";"Posting Date")
        addafter("Posting Date")
        {
            field("Order Date";"Order Date"){ } 
        }            
        moveafter("Order Date";"Currency Code")
        moveafter("Currency Code";"External Document No.")
        addafter("External Document No.")
        { 
            field("VAT Base Discount %";"VAT Base Discount %"){ }
            field("Currency Factor";"Currency Factor"){ }            
        }       
    }
    actions
    {
        addafter(Email)
        {
            action(MailPDF)
            {
                Caption = 'Enviar por Mail en PDF';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction();
                var
                    GeneralAbastLibrary : Codeunit "General Abast Library";
                begin
                    GeneralAbastLibrary.GenerarPDF(Rec,Rec."Bill-to Customer No.", 4, 18)
                end;
            }
        }
        modify(Email)
        {
            Visible = false;
            Enabled = false;
        }
    }
}