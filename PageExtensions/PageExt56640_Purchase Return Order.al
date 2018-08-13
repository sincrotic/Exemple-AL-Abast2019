//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 56640 PurchaseReturnOrderExt extends "Purchase Return Order"
{
    layout
    {
        //-HEB.508
        addfirst("SII Information")
        {
            field("SII Exclude";"SII Exclude") { }
        }
        //+HEB.508
    }
}