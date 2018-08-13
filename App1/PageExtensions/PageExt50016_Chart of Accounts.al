pageextension 50016 ChartOfAccountsExt extends "Chart of Accounts"
{
    actions
    {
        addlast(Reporting)
        {
            action("G/L Register Ext")
            {
                Caption = 'G/L Register';
                ToolTip = 'View posted G/L entries.';
                ApplicationArea = Basic, Suite;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;
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