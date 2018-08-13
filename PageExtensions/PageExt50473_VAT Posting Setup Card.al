//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 50473 VATPostingSetupCardExt extends "VAT Posting Setup Card"
{
    layout
    {
        //-HEB.508
        addafter("No Taxable Type")
        {
            field("SII Exclude";"SII Exclude") { }
        }
        //+HEB.508
    }
}