//HEB.204 MT 30052018. Muestra el campo "Cliente Vivo".
//HEB.238 MT 04062018. Muestra el campo "Customer Out-Dated".
//HEB.239 xtrullols 03/06/2015 Report 50043 amb albarans i copiar a proveidor. SP20150603_HEB
//HEB.244 MR 08062018 Camps relacionats venedor a fitxa client i traspassar a documents
//HEB.137 MT 18072018. Campos "Blocked" y "Credit Limit (LCY)" editables según rol de usuario
pageextension 50021 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addafter(County)
        {
            field("Territory Code"; "Territory Code") { }
        }

        addafter("Primary Contact No.")
        {
            field(Contact; Contact) { }
        }

        addafter("Balance (LCY)")
        {
            field("Balance ALL"; Balance) { }
        }

        modify("Salesperson Code")
        {
            Caption = 'Cód. Comisionista';
        }
        addafter("Prepayment %")
        {
            field("Special Conditions"; "Special Conditions") { }
            field("Variable Payment Conditions"; "Variable Payment Conditions") { }
        }
        //-HEB.244
        addafter("Salesperson Code")
        {
            field("Distributor Code"; "Distributor Code") { }
            field("Salesperson/Resp. Code"; "Salesperson/Resp. Code") { }
            field("Administr/Resp. Code"; "Administr/Resp. Code") { }

            //-HEB.001
            field("No. Serie Fra. Reg."; "No. Serie Fra. Reg.") { }
            field("No. Serie Abono Reg."; "No. Serie Abono Reg.") { }
            //+HEB.001
        }
        //+HEB.244
        addafter("Service Zone Code")
        {
            //-HEB.002
            field("Usar Registro Merc. Sueco"; "Usar Registro Merc. Sueco") { }
            //+HEB.002
        }
        addafter(Reserve)
        {
            field("Exit Point"; "Exit Point") { }//-101
            field("Shipping Instruccions"; "Shipping Instruccions") { }//-101
        }

        addafter("Payment Method Code")
        {
            field("Cód. dirección pago genérico"; "Cód. dirección pago genérico")
            {
                ApplicationArea = All;
            }
        }

        moveafter("VAT Registration No."; "Responsibility Center")
        moveafter("Responsibility Center"; "Service Zone Code")

        addafter(Blocked)
        {
            //-HEB.137
            field(BlockedExt; Blocked)
            {
                Editable = EditableBlocked;
            }
            //+HEB.137
            //-HEB.204
            field("Cliente Vivo"; "Cliente Vivo")
            {
                //-204 ogarcia   12/04/2011 Allow modify cust. alive
                Editable = EditableClienteVivo;
                Description = '-204';
            }
            //+HEB.204

            //-HEB.238
            field("Baja"; "Customer Out-Dated")
            {
                Description = '-238';
            }
            //+HEB.238
        }

        //-HEB.137
        addafter("Credit Limit (LCY)")
        {
            field("Credit Limit (LCY) Ext"; "Credit Limit (LCY)")
            {
                Editable = EditableCreditLimitLCY;
            }
        }

        modify(Blocked)
        {
            Visible = false;
        }

        modify("Credit Limit (LCY)")
        {
            Visible = false;
        }
        //+HEB.137

    }

    actions
    {
        addafter(Contact)
        {
            action(EmailDocumentos)
            {
                Caption = 'Documents E-mail';
                RunObject = page "Lista Correos Asociados";
                RunPageLink = Type = const(Customer), "Source No."= field("No.");
                Image = Email;
            }
        }
    }

    trigger OnOpenPage();
    var
        MapMgt: Codeunit "Online Map Management";
        confUser: Record "User Setup";
    begin
        ActivateFields;
        IF NOT MapMgt.TestSetup THEN
            VisibleMapPoint := false;

        //-HEB.137
        IF NOT confUser.GET(USERID) THEN BEGIN
            EditableCreditLimitLCY := false;
            EditableBlocked := false;
            EditableClienteVivo := false;
            EnabledBtnEditar := false;
        END ELSE BEGIN
            EditableCreditLimitLCY := confUser."Allow modify cust. credit";
            EditableBlocked := confUser."Allow modify cust. blocked";
            EditableClienteVivo := confUser."Allow modify cust. alive";
        END;
        //+HEB.137
    end;

    //-HEB.137
    local procedure ActivateFields();
    var
    begin
        EditableContact := ("Primary Contact No." = '');
    end;
    //+HEB.137

    var
        //-HEB.137
        VisibleMapPoint: Boolean;
        EditableCreditLimitLCY: Boolean;
        EditableBlocked: Boolean;
        EditableClienteVivo: Boolean;
        EnabledBtnEditar: Boolean;
        EditableContact: boolean;
        //+HEB.137
}