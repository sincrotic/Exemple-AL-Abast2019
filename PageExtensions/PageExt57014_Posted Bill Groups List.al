pageextension 57014 PostedBillGroupsListExt extends "Posted Bill Groups List" //MyTargetPageId
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
                    PostedBillGr : Record "Posted Bill Group";
                begin
                    if Find then begin
                        PostedBillGr.Copy(Rec);
                        PostedBillGr.SetRecFilter;
                        Report.run(Report::"Posted Bill Group Listing Ext",true,false,PostedBillGr)
                    end;
                end;
            }
        }
        //+HEB.181
    }
}