tableextension 50025 VendorLedgerEntryExt extends "Vendor Ledger Entry" //MyTargetTableId
{
    fields
    {
        //-HEB.102
        modify(Description)
        {
            trigger OnAfterValidate();
            var
                PurchAbastLib : Codeunit "Purchases Abast Library";
            begin
                PurchAbastLib.UpdVendLedgerEntryDescription(Rec);
            end;
        }
        //+HEB.102
    }
}