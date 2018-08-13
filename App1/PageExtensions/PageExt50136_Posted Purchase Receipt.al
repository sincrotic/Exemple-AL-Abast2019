pageextension 50136 PostedPurchaseReceiptExt extends "Posted Purchase Receipt"
{ 
    actions
    {
        addafter("&Navigate")
        {
            group(Conformidad)
            {
                Caption = 'Conformidad';
                action(ImprimirSolicitud)
                {
                    Caption = 'Imprimir Solicitud Conformidad';
                    Image = Confirm;
                    trigger OnAction();
                    var
                        PurchRcptHeader : Record "Purch. Rcpt. Header";
                    begin
                        CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
                        PurchRcptHeader.PrintRecordsSolConfirm(TRUE);
                    end;
                }
            }
        }
    }
}