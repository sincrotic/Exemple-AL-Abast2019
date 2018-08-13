pageextension 50144 PostedSalesCreditMemos extends "Posted Sales Credit Memos" //MyTargetPageId
{
    layout
    {
        
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
                    GeneralAbastLibrary.GenerarPDF(Rec,Rec."Bill-to Customer No.", 4, 18)
                end;
            }
        }
        modify("Send by &Email")
        {
            Visible = false;
            Enabled = false;
        }
        //-HEB.109
        modify("&Print")
        {
            Visible = false;
            Enabled = false;
        }
        addafter("Send by &Email")
        {
            action(Prints)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = report "Sales - Credit Memo HEB";
            }

        }
        //+HEB.109
    }
}