pageextension 50017 GLAccountCardExt extends "G/L Account Card"
{
    layout
    {
        addafter("Direct Posting")
        {
            //-HEB.506
            field(INTRASTAT;INTRASTAT)
            {

            }
            //+HEB.506
        }
    }
    actions
    {
        addlast(Reporting)
        {
            action("G/L Register Ext")
            {
                Caption = 'G/L Register';
                ToolTip = 'View posted G/L entries.';
                ApplicationArea = Suite;
                Image = GLRegisters;
                Promoted = true;
                PromotedCategory = Report;
                //PromotedOnly = true;
                RunObject = Report "G/L Register Ext";
            }
        }
        
        
        modify(Action1900210206)
        {
            Enabled = false;
            Visible = false;
            ApplicationArea = HebronDisabled;
            Promoted = false;
        }
    }
}