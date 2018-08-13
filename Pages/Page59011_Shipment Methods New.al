//HEB.122 MT 23052018.
page 59011 ShipmentMethodsNew
{
    PageType = List;
    SourceTable = "Shipment Method";
    Caption = 'Shipment Methods';
    RefreshOnActivate = true;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {

                }
                field(Description; Description)
                {

                }
                field("INCOTERM Almacén Hebron"; "INCOTERM Almacén Hebron")
                {

                }
            }
        }
    }

    actions
    {
 
        area(processing)
        {
            action(Edit)
            {
                Promoted = true;
                PromotedCategory = Process;
                Image = Edit;

                trigger OnAction()
                begin
                    Page.Run(11);
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.FilterGroup(9);
        Rec.SetRange(Bloqueado, false);
        Rec.FilterGroup(0);
    end;
    
}