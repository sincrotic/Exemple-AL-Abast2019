pageextension 50470 VATBusinessPostingGroupsExt extends "VAT Business Posting Groups" //MyTargetPageId
{
    layout
    {
        addlast(Control1)
        {
            field("Requiere DUA";"Requiere DUA")
            {
                ApplicationArea = All;
            }
        }
    }
}