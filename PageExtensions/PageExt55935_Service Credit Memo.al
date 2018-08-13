//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 55935 ServiceCreditMemoExt extends "Service Credit Memo"
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