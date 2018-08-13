//HEB.204 MT 30052018. Muestra el campo "Cliente Vivo".
//HEB.238 MT 04062018. Muestra el campo "Customer Out-Dated"
//HEB.244 MR 11062018 Camps relacionats venedor a fitxa client i traspassar a documents
pageextension 50022 CustomerListExt extends "Customer List"
{
    //-238 xtrullols 03/06/2015 Creació camp baja a client i proveidor. SP20150603_HEB
    //-239 xtrullols 03/06/2015 Report 50043 amb albarans i copiar a proveidor. SP20150603_HEB

    layout
    {
        addfirst(Control1)
        {
            //-HEB.204
            field("Cliente Vivo";"Cliente Vivo")
            {
            }
            //+HEB.204

            //-HEB.238
            field("Customer Out-Dated";"Customer Out-Dated")
            {
            }
            //+HEB.238
            
        }
        //-HEB.244
        addafter("Salesperson Code")
        {
            field("Distributor Code";"Distributor Code") { }
            field("Salesperson/Resp. Code";"Salesperson/Resp. Code") { }
            field("Administr/Resp. Code";"Administr/Resp. Code") { }
        }
        //+HEB.244
    }
    
    actions
    {
        addfirst(Processing)
        {
            action("Update Alive Customers")
            {
                Caption = 'Update Alive Customers';
                RunObject = report "Actualizar clientes vivos";
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
                RunPageLink = Type = const(Customer), "Source No."= field("No.");
                Image = Email;
            }
        }
    }
}