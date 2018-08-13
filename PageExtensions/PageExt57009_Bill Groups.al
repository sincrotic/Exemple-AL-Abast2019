pageextension 57009 BillGroupsExt extends "Bill Groups" //MyTargetPageId
{
    layout
    {
        
    }
    
    actions
    {
        //-HEB.181
        modify(Listing)
        {
            Visible = false;
            Enabled = false;
        }
        addafter(Action33)
        {
            action(Listado)
            {
                Caption = 'Listing';
                Image = List;
                Promoted = true;
                PromotedCategory = Report;
                Ellipsis = true;
                trigger OnAction()
                var 
                    BillGrouplist : Report "Bill Group Listing Ext";
                begin
                    BillGrouplist.SetRec("No.");
                    BillGrouplist.RunModal;
                end;
            }
        }
        //+HEB.181
    }
}