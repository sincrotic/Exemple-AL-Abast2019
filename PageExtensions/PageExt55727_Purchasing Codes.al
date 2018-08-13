pageextension 55727 PurchasingCodesExt extends "Purchasing Codes" //MyTargetPageId
{
    layout
    {
        //-HEB.124
        addafter("Special Order")
        {
            field("Default Location Code";"Default Location Code") { }
        }
        //+HEB.124
    }
}