pageextension 50142 PostedSalesShipmentsExt extends "Posted Sales Shipments"
{
    actions
    {
        addafter("&Print")
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
                    GeneralAbastLibrary.GenerarPDF(Rec,Rec."Bill-to Customer No.", 2, 18)
                end;
            }
        }
    }
}