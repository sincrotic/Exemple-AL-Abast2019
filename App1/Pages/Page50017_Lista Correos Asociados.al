page 50017 "Lista Correos Asociados"
{
    // version AITANA,245

    // -153 ogarcia 31/03/2009 PI0023_7064
    // -245 apicazo   04/02/2016 Ajustos enviament documents per PDF.
    Caption = 'Lista Correos Asociados';
    ApplicationArea = All;
    UsageCategory = Lists;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Correos Clientes/Proveedor";
    SourceTableView = SORTING(Type,"Source No.","Document Type","Document SubType","Send Type",Email);

    layout
    {
        area(content)
        {
            repeater(Repeater1)
            {
                field(Type;Type)
                {
                    Visible = false;
                }
                field("Source No.";"Source No.")
                {
                    Visible = false;
                }
                field("Document Type";"Document Type")
                {

                    trigger OnValidate();
                    begin
                        //-245
                        IF (Type = Type::Customer) AND ("Document Type" = "Document Type"::Order) THEN
                            "Document SubTypeEditable" := TRUE
                        ELSE 
                            "Document SubTypeEditable" := FALSE;
                        //+0245
                    end;
                }
                field("Document SubType";"Document SubType")
                {
                    Editable = "Document SubTypeEditable";
                }
                field("Send Type";"Send Type") { }
                field(Email;Email) { }
                field(Code;Code) { }
                field(SourceName;SourceName)
                {
                    Caption = 'Name';
                    Editable = false;

                    trigger OnLookup(Text : Text) : Boolean;
                    var
                        Customer : Record Customer;
                        Vendor : Record Vendor;
                    begin
                        CASE Type OF
                            Type::Customer: BEGIN
                                Customer.GET("Source No.");
                                Customer.SETRECFILTER;
                                Page.RUNMODAL(0,Customer);
                            END;
                            Type::Vendor: BEGIN
                                Vendor.GET("Source No.");
                                Vendor.SETRECFILTER;
                                Page.RUNMODAL(0,Vendor);
                            END;
                        END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        //-245
        IF (Type = Type::Customer) AND ("Document Type" = "Document Type"::Order) THEN
            "Document SubTypeEditable" := TRUE
        ELSE
            "Document SubTypeEditable" := FALSE;

        CALCFIELDS("Customer Name","Vendor Name");
        SourceName := '';
        CASE Type OF
            Type::Customer: SourceName := "Customer Name";
            Type::Vendor:   SourceName := "Vendor Name";
        END;
        //+0245
    end;

    trigger OnInit();
    begin
        "Document SubTypeEditable" := TRUE;
    end;

    var
        SourceName : Text[50];
        [InDataSet]
        "Document SubTypeEditable" : Boolean;
}

