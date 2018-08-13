pageextension 50251 GeneralJournalBatchesExt extends "General Journal Batches"
{
    layout
    {
        addafter(Name)
        {
            field("Sección Salarios";"Sección Salarios") { }
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
                //Promoted = true;
                //PromotedCategory = Report;
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