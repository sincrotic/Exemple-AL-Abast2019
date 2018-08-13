page 50098 "Comisiones Fra. Cabecera"
{
    // version AITANA

    PageType = List;
    Permissions = TableData "Sales Invoice Header"=rm;
    SourceTable = "Sales Invoice Header";
    Caption = 'Comisiones Fra. Cabecera';
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(repeater1)
            {
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    Editable = false;
                }
                field("No.";"No.")
                {
                    Editable = false;
                }
                field("Bill-to Customer No.";"Bill-to Customer No.")
                {
                    Editable = false;
                }
                field("Bill-to Name";"Bill-to Name")
                {
                    Editable = false;
                }
                field("Salesperson Code";"Salesperson Code")
                {
                    Editable = true;
                }
            }
        }
    }
}

