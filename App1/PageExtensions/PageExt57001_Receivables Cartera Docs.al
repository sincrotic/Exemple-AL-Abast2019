pageextension 57001 ReceivablesCarteraDocsExt extends "Receivables Cartera Docs" //MyTargetPageId
{
    layout
    {
        //-HEB.131
        addafter("Account No.")
        {
            field("Nombre cliente";"Nombre cliente")
            {
                ApplicationArea = All;
            }
        }
        addafter("Nombre cliente")
        {
            field("Bill-to Customer No.";"Bill-to Customer No.")
            {
                ApplicationArea = All;
            }
        }
        //+HEB.131
    }
    
    actions
    {
    }
}