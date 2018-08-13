//HEB.244 MR 11062018 Camps relacionats venedor a fitxa client i traspassar a documents
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 56630 SalesReturnOrderExt extends "Sales Return Order"
{
    layout
    {
        //-HEB.244
        addafter("Salesperson Code")
        {
            field("Distributor Code";"Distributor Code") { }
            field("Salesperson/Resp. Code";"Salesperson/Resp. Code") { }
            field("Administr/Resp. Code";"Administr/Resp. Code") { }
        }
        addafter("Corrected Invoice No.")
        {
            field("Posting No. Series";"Posting No. Series") { }
        }
        //+HEB.244
        //-HEB.508
        addfirst("SII Information")
        {
            field("SII Exclude";"SII Exclude") { }
        }
        //+HEB.508
    }
}