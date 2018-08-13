pageextension 55052 ContactListExt extends "Contact List" //MyTargetPageId
{
    actions
    {
        modify(Customer)
        {
            Visible = false;
            Enabled = false;
        }
        modify(Vendor)
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
                var
                    UserSetup : Record "User Setup";
                    Text50000 : Label 'No tiene permisos para crear el cliente';
                begin
                    //-241
                    //CreateCustomer(ChooseCustomerTemplate);
                    IF UserSetup.GET(USERID) AND UserSetup."Allow Edit Customer/Vendor" THEN
                        CreateCustomerExt(ChooseCustomerTemplate)
                    ELSE
                        MESSAGE(Text50000);
                    //+241
                end;
            }
            action(CreateAsVendorExt)
            {
                ApplicationArea = All;
                Caption = 'Vendor';
                ToolTip = 'Create the contact as a vendor';
                Image = Vendor;
                trigger OnAction()
                var
                    UserSetup : Record "User Setup";
                    Text50004 : Label 'No tiene permisos para crear el proveedor';
                begin
                    //-241
                    //CreateVendor(ChooseVendorTemplate);
                    IF UserSetup.GET(USERID) AND UserSetup."Allow Edit Customer/Vendor" THEN
                        CreateVendorExt(ChooseVendorTemplate)
                    ELSE
                        MESSAGE(Text50004);
                    //+241
                end;
            }
        }
    }
}