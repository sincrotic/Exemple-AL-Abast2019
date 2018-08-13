pageextension 57011 BillGroupListExt extends "Bill Groups List" //MyTargetPageId
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
        addafter(Action24)
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