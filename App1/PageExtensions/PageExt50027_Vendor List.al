//HEB.239 MT 30052018. Muestra el campo "Proveedor Vivo".
//HEB.238 MT 04062018. Muestra el campo "Vendor Out-Dated".
pageextension 50027 VendorListExt extends "Vendor List"
{
    //-238 xtrullols 03/06/2015 Creació camp baja a client i proveidor. SP20150603_HEB
    //-239 xtrullols 03/06/2015 Report 50043 amb albarans i copiar a proveidor. SP20150603_HEB

    layout
    {
        addafter("No.")
        {
            //-HEB.238
            field("Vendor Out-Dated";"Vendor Out-Dated")
            {
            }
            //+HEB.238

            //+HEB.239
            field("Proveedor Vivo";"Proveedor Vivo")
            {
            }
            //+HEB.239
        }
    }
    
    actions
    {
        addfirst(Processing)
        {
            action("Update Alive Vendors")
            {
                Caption = 'Update Alive Vendors';
                RunObject = report "Actualizar proveedores vivos";
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Process;
            }
        }
        addafter("C&ontact")
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
    
    //-HEB.202
    trigger OnOpenPage();
    var 
        ConfUsu : Record "User Setup";
    begin
        //-HEB.202
        IF ConfUsu.GET(USERID) AND (ConfUsu."Default Vendor Filter" <> '') THEN
            SETFILTER("Vendor Posting Group",ConfUsu."Default Vendor Filter");
        //+HEB.202
    end;
    //+HEB.202

}