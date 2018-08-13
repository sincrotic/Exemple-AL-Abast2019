//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 50134 PostedSalesCreditMemoExt extends "Posted Sales Credit Memo"
{
    layout
    {
        //-HEB.508
        addfirst("SII Information")
        {
            field("SII Exclude";"SII Exclude")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        //+HEB.508
    }
    actions
    {
        addafter("Send by &Email")
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
                    GeneralAbastLibrary.GenerarPDF(Rec,Rec."Bill-to Customer No.", 5, 18)
                end;
            }
        }
        modify("Send by &Email")
        {
            Visible = false;
            Enabled = false;
        }
    }
}