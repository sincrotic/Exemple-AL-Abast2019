pageextension 57054 PostedPaymentOrdersExt extends "Posted Payment Orders" //MyTargetPageId
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
        addafter(Action58)
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
                    PostedPmtOrd : Record "Posted Payment Order";
                begin
                    if Find then begin
                        PostedPmtOrd.Copy(Rec);
                        PostedPmtOrd.SetRecFilter;
                        Report.run(Report::"Posted Payment Order ListingEx",true,false,PostedPmtOrd)
                    end;
                end;
            }
        }
        //+HEB.181
    }
}