//-144

pageextension 50029 VendorLedgerEntriesExt extends "Vendor Ledger Entries"
{
    layout
    {
        //-144
        modify(Description)
        {
            Visible = false;
        }
        addafter("Vendor No.")
        {
            field(DescriptionExt;Description)
            {
                Editable = true;
            }
        }
        //+144
    }
    
    actions
    {
    }
}