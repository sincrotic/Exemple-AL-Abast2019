//HEB.239 MT 30052018. Muestra el campo "Proveedor Vivo".
//HEB.210 MR 31052018 Exp. 9006: Control per usuari "Permite mod. bloqueo proveedor"
//HEB.238 MT 04062018. Muestra el campo "Vendor Out-Dated".
pageextension 50026 VendorCardExt extends "Vendor Card"
{
    //-238 xtrullols 03/06/2015 Creació camp baja a client i proveidor. SP20150603_HEB
    //-239 xtrullols 03/06/2015 Report 50043 amb albarans i copiar a proveidor. SP20150603_HEB

    layout
    {
        //-HEB.239
        addafter("Responsibility Center")
        {
            field(BlockedExt;Blocked)
            {
                Editable = BlockedEditable;
                OptionCaption = ' ,Payment,All';
            }
        }
        addafter(Blocked)
        {
            //-HEB.238
            field("Vendor Out-Dated";"Vendor Out-Dated")
            {            
                Editable = false;
                Description = '-238';
            }
            //+HEB.238

            //-HEB.239
            field("Proveedor Vivo";"Proveedor Vivo")
            {            
                Editable = false;
                Description = '-239';
            }
            //+HEB.239
        }
        //+HEB.239
        //-HEB.244
        addafter("Prepayment %")
        {
            //-HEB.001
            field("No. Serie Fra. Reg.";"No. Serie Fra. Reg.") { }
            field("No. Serie Abono Reg.";"No. Serie Abono Reg.") { }
            //+HEB.001
        }
        //+HEB.244
        addafter("VAT Registration No.")
        {
            //-HEB.002
            field("Usar Registro Merc. Sueco";"Usar Registro Merc. Sueco") { }
            //+HEB.002
        }
        //-HEB.210
        modify(Blocked)
        {
            Visible = false;
            Enabled = false;
        }
        //+HEB.210
    }

    actions
    {
        addafter(ContactBtn)
        {
            action(EmailDocumentos)
            {
                Caption = 'Documents E-mail';
                RunObject = page "Lista Correos Asociados";
                RunPageLink = Type = const(Vendor), "Source No."= field("No.");
                Image = Email;
            }
        }
    }

    var
        BlockedEditable : Boolean;

    trigger OnOpenPage();
    var
        ConfUsu : Record "User Setup";
    begin
        //-HEB.210 
        BlockedEditable := false;
        IF ConfUsu.GET(USERID) THEN BEGIN
            BlockedEditable := ConfUsu."Allow modify vendor blocked";
            IF (ConfUsu."Default Vendor Filter" <> '') THEN
                SETFILTER("Vendor Posting Group",ConfUsu."Default Vendor Filter");
        END;
        //+HEB.210       
    end;
}