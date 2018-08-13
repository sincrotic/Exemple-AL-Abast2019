//HEB.244 MR 11062018. Camps relacionats venedor a fitxa client i traspassar a documents
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
//HEB.510 MT 03072018. Ordenación de campos extendidos
pageextension 50044 SalesCreditMemoExt extends "Sales Credit Memo"
{
    layout
    {
        //-HEB.244
        addafter("Salesperson Code")    //-HEB.510
        {
            field("Distributor Code";"Distributor Code") { }
            field("Salesperson/Resp. Code";"Salesperson/Resp. Code") { }
            field("Administr/Resp. Code";"Administr/Resp. Code") { }
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