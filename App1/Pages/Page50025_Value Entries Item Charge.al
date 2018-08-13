//HEB.159 MR 26062018 PI0027_7064 - Consulta Documentos asociados a Cargos Productos
page 50025 "Value Entries Item Charge"
{
    Caption = 'Documentos Asociados Cargo Producto';
    Editable = false;
    PageType = Card;
    SourceTable = "Value Entry";

    layout
    {
        area(content)
        {
            repeater(repeater1)
            {
                field("Posting Date";"Posting Date") { }
                field("Valuation Date";"Valuation Date")
                {
                    Visible = false;
                }
                field("Entry Type";"Entry Type") { }
                field("Source Type";"Source Type") { }
                field("Source No.";"Source No.") { }
                field("Document Type";"Document Type") { }
                field("Document No.";"Document No.") { }
                field("Document Line No.";"Document Line No.") { }
                field("Item No.";"Item No.") { }
                field(Description;Description) { }
                field("Location Code";"Location Code")
                {
                    Visible = false;
                }
                field("Reason Code";"Reason Code") { }
                field("User ID";"User ID")
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Entry No.";"Entry No.") { }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Mayús+Ctrl+D';
                    trigger OnAction();
                    begin
                        ShowDimensions;
                    end;
                }
                action("General Ledger")
                {
                    Caption = 'General Ledger';
                    Image = GLRegisters;

                    trigger OnAction();
                    begin
                        ShowGL;
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    Navigate.SetDoc("Posting Date","Document No.");
                    Navigate.RUN;
                end;
            }
        }
    }

    var
        Navigate : Page Navigate;
}

