//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 55972 PostedServiceCreditMemoExt extends "Posted Service Credit Memo"
{
    layout
    {
        //-HEB.508
        addfirst("SII Information")
        {
            field("SII Exclude";"SII Exclude")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        //+HEB.508
    }
}