tableextension 50263 IntrastatJnlLineExt extends "Intrastat Jnl. Line" //MyTargetTableId
{
    fields
    {
        //-HEB.506
        field(50001;"Partner No."; Code[20])
        {
            Caption = 'Partner No.';
        }
        field(50002;"Partner VAT Registration No.";Text[20])
        {
            Caption = 'Partner VAT Registration No.';
        }
        //+HEB.506
        
    }
    
}