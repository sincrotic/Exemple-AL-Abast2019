//HEB.001 MR 14062018. Añadidos campos de códigos de responsable.
//HEB.237 MT 18072018. Control de permisos para editar/eliminar contacto.
//HEB.241 MR 13062018. Control de permisos para crear contacto como cliente/proveedor.

pageextension 55050 ContactCardExt extends "Contact Card"
{
    layout
    {
        addafter("Search Name")
        {
            //-HEB.001
            field("Administr/Resp. Code"; "Administr/Resp. Code") { }
            field("Distributor Code"; "Distributor Code") { }
            field("Salesperson/Resp. Code"; "Salesperson/Resp. Code") { }
            //+HEB.001
        }
    }

    actions
    {
        modify(CreateAsCustomer)
        {
            Visible = false;
            Enabled = false;
        }
        modify(CreateCustomer)
        {
            Visible = false;
            Enabled = false;
        }
        modify(CreateAsVendor)
        {
            Visible = false;
            Enabled = false;
        }
        modify(CreateVendor)
        {
            Visible = false;
            Enabled = false;
        }
        addfirst("Create as")
        {
            action(CreateAsCustomerExt)
            {
                ApplicationArea = All;
                Caption = 'Customer';
                ToolTip = 'Create the contact as a customer';
                Image = Customer;

                trigger OnAction()
                begin
                    //-HEB.241
                    if HasEditCustVendorPermissions then
                        CreateCustomerExt(ChooseCustomerTemplate)
                    else
                        Message(Text50000);
                    //+HEB.241
                end;
            }
            action(CreateAsVendorExt)
            {
                ApplicationArea = All;
                Caption = 'Vendor';
                ToolTip = 'Create the contact as a vendor';
                Image = Vendor;

                trigger OnAction()
                begin
                    //-HEB.241
                    if HasEditCustVendorPermissions then
                        CreateVendorExt(ChooseVendorTemplate)
                    ELSE
                        MESSAGE(Text50004);
                    //+HEB.241
                end;
            }
        }
        addafter("Apply Template")
        {
            action(CreateCustomerExt)
            {
                ApplicationArea = All;
                Caption = 'Create as Customer';
                ToolTip = 'Create a new customer based on this contact.';
                Promoted = true;
                PromotedCategory = Process;
                Image = Customer;

                trigger OnAction()
                begin
                    //-HEB.241
                    if HasEditCustVendorPermissions then
                        CreateCustomerExt(ChooseCustomerTemplate)
                    ELSE
                        Message(Text50000);
                    //+HEB.241
                end;
            }
            action(CreateVendorExt)
            {
                ApplicationArea = All;
                Caption = 'Create as Vendor';
                ToolTip = 'Create a new vendor based on this contact.';
                Promoted = true;
                PromotedCategory = Process;
                Image = Vendor;

                trigger OnAction()
                begin
                    //-HEB.241
                    if HasEditCustVendorPermissions then
                        CreateVendorExt(ChooseVendorTemplate)
                    else
                        Message(Text50004);
                    //+HEB.241
                end;
            }
        }
    }

    //-HEB.237
    var
        UserSetup: Record "User Setup";
        ContactBusRelation: Record "Contact Business Relation";
        HasEditContactPermissions: Boolean;
        HasEditCustVendorPermissions: Boolean;
        Text50000: Label 'You don''t have the permissions to create the customer.';
        Text50001: Label 'You don''t have the permissions to edit the contact.';
        Text50002: Label 'You don''t have the permissions to delete the contact.';
        Text50003: Label 'Contact %1 has a related customer %2, you can''t edit the contact.';
        Text50004: Label 'You don''t have the permissions to create the vendor.';
        Text50005: Label 'Contact %1 has a related customer %2, you can''t delete the contact.';


    trigger OnOpenPage();
    begin
        HasEditContactPermissions := false;
        HasEditCustVendorPermissions := false;

        if UserSetup.Get(UserId) then begin
            if UserSetup."Allow Edit Contact" then
                HasEditContactPermissions := true;
            if UserSetup."Allow Edit Customer/Vendor" then
                HasEditCustVendorPermissions := true;
        end;
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        if HasEditContactPermissions and not HasEditCustVendorPermissions then begin
            Clear(ContactBusRelation);
            ContactBusRelation.SetRange("Contact No.", "Company No.");
            ContactBusRelation.SetFilter("Link to Table", '%1|%2', ContactBusRelation."Link to Table"::Customer, ContactBusRelation."Link to Table"::Vendor);

            if not ContactBusRelation.IsEmpty then
                Error(Text50003, "No.", ContactBusRelation."No.");
        end else
            Error(Text50001);
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        if HasEditContactPermissions and not HasEditCustVendorPermissions then begin
            Clear(ContactBusRelation);
            ContactBusRelation.SetRange("Contact No.", "Company No.");
            ContactBusRelation.SetFilter("Link to Table", '%1|%2', ContactBusRelation."Link to Table"::Customer, ContactBusRelation."Link to Table"::Vendor);

            if not ContactBusRelation.IsEmpty then
                Error(Text50005, "No.", ContactBusRelation."No.");
        end else
            Error(Text50002);
    end;
    //+HEB.237
}