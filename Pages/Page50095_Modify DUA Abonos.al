page 50095 "Modify DUA Abonos"
{
    PageType = List;
    Caption = 'Modify DUA Abonos';
    SourceTable = "Purch. Cr. Memo Hdr.";
    Permissions = TableData "Purch. Cr. Memo Hdr."=rm;
    ApplicationArea = All;
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            group(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Cr. Memo No."; "Vendor Cr. Memo No.")
                {
                    ApplicationArea = All;
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