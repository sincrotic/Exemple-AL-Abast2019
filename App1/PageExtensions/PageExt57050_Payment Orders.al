pageextension 57050 PaymentOrdersExt extends "Payment Orders" //MyTargetPageId
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
                    PmtOrd : Record "Payment Order";
                begin
                    if Find then begin
                        PmtOrd.Copy(Rec);
                        PmtOrd.SetRecFilter;
                        Report.run(Report::"Payment Order Listing Ext",true,false,PmtOrd)
                    end;
                end;
            }
        }
        //+HEB.181
    }
}