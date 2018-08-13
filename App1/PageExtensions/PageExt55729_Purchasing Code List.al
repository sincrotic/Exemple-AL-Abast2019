pageextension 55729 PurchasingCodeListExt extends "Purchasing Code List" //MyTargetPageId
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