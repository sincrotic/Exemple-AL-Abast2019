tableextension 55721 PurchasingExt extends Purchasing //MyTargetTableId
{
    fields
    {
        //-HEB.124
        field(50000;"Default Location Code";Code [20])
        {
            Caption = 'Default Location Code';
            TableRelation = Location;
        }
        //+HEB.124
    }
}