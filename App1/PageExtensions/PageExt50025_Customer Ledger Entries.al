//HEB.244 MR 08062018 Camps relacionats venedor a fitxa client i traspassar a documents
pageextension 50023 CustomerLedgerEntriesExt extends "Customer Ledger Entries" //MyTargetPageId
{
    layout
    {
        modify(Description)
        {
            Visible = false;
        }
        addafter("Message to Recipient")
        {
            field(DescriptionExt;Description)
            {
                Editable = true;
            }
        }
        addafter("Document Status")
        {
            field(Accepted;Accepted)
            {
                
            }
        }

        addafter("Bill No.")
        {
            field("Order No.";"Order No.")
            {
                
            }
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
}