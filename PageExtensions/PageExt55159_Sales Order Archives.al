pageextension 55159 SalesOrderArchicesExt extends "Sales Order Archive" //MyTargetPageId
{
    layout
    {
        addafter("Sell-to Contact No.")
        {
            field("Distributor Code";"Distributor Code") { }
            field("Salesperson/Resp. Code";"Salesperson/Resp. Code") { }
            field("Administr/Resp. Code";"Administr/Resp. Code") { }
        }
    }
    
    actions
    {
        addlast(Processing)
        {
            //+HEB.171
            action(Facturas)
            {
                ApplicationArea = All;
                Caption = 'Invoices';
                Image = Invoice;
                trigger OnAction();
                var
                    Search :Codeunit "Sales Abast Library";
                begin
                    Search.SearchInvoice(Rec);
                end;
            }
            //-HEB.171
        }
    }   
}