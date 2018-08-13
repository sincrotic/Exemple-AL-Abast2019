page 50096 "Modify DUA Facturas"
{
    PageType = List;
    Caption = 'Modify DUA Facturas';
    SourceTable = "Purch. Inv. Header";
    Permissions = TableData "Purch. Inv. Header"=rm;
    ApplicationArea = All;
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            group(GroupName)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Invoice No."; "Vendor Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Nº DUA"; "Nº DUA")
                {
                    ApplicationArea = All;
                }
                field("Fecha DUA"; "Fecha DUA")
                {
                    ApplicationArea = All;
                }
                field("Proveedor Origen"; "Proveedor Origen")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}