pageextension 57003 CarteraDocumentsExt extends "Cartera Documents" //MyTargetPageId
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
        //+HEB.131
    }
    
    actions
    {
    }
}