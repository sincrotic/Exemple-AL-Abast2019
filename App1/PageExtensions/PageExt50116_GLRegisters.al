pageextension 50116 GLRegistersExt extends "G/L Registers"
{
    actions
    {
        addlast(Reporting)
        {
            action("G/L Register Ext")
            {
                Caption = 'G/L Register';
                ToolTip = 'View posted G/L entries.';
                ApplicationArea = Suite;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                //PromotedOnly = true;
                RunObject = Report "G/L Register Ext";
            }
        }
        
        modify("G/L Register")
        {
            Enabled = false;
            Visible = false;
            ApplicationArea = HebronDisabled;
            Promoted = false;
        }
    }
}