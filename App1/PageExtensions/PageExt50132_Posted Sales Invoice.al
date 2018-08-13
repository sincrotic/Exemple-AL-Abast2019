//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 50132 PostedSalesInvoiceExt extends "Posted Sales Invoice"
{
    //VersionList NAVW15.00,NAVES4.00.02
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    layout
    {
        addafter("Payment Terms Code")
        {
            //-HEB.114
            field("Importe Comisiones";"Importe Comisiones")
            {
                ApplicationArea = All;
            }
            //+HEB.114
        }
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