//HEB.156 MR 12062018 PI0025_7064 - Tabla 36, 37, 5107, 5108 Añadir Campos
//HEB.244 MR 08062018 Camps relacionats venedor a fitxa client i traspassar a documents
tableextension 55107 SalesHeaderArchiveExt extends "Sales Header Archive"
{
    fields
    {
        Field(50000; "Price Validity Date"; Date) //-156: PI0025
        {
            Caption = 'Price Validity Date';
        }
        Field(50001; "Days Validity"; Integer) //-156: PI0025
        {
            Caption = 'Days Validity';
        }
        Field(50002; "Product Availability (value)"; Integer) //-156:PI0025
        {
            Caption = 'Product Availability (value)';
            BlankZero = true;
        }
        Field(50003; "Product Availability (period)"; Option) //-156:PI0025
        {
            Caption = 'Product Availability (period)';
            OptionMembers = " ",Days,Weeks;
            OptionCaption = ' ,days,weeks';
        }
        Field(50004; "Non Accepted"; Boolean)
        {
            Caption = 'Non Accepted';
            trigger OnValidate();
            begin
                //-999
                VALIDATE("Cause NA", "Cause NA"::" ");
                //+999
            end;
        }
        Field(50005; "Cause NA"; Option) //-999
        {
            Caption = 'Cause NA';
            OptionMembers = " ",Expiration,Price,Volume,Availability,"Financial Terms","Reference Price";
            OptionCaption = ' ,Expiration,Price,Volume,Availability,Financial Terms,Reference Price';
            trigger OnValidate();
            begin
                //-999
                IF "Cause NA" <> "Cause NA"::" " THEN BEGIN
                    "Date NA" := WORKDATE;
                END ELSE BEGIN
                    "Date NA" := 0D;
                END;
                //+999
            end;
        }
        Field(50006; "Date NA"; Date) //-999
        {
            Caption = 'Date NA';
        }
        Field(50007; "Quote No."; Code[20]) //-999
        {
            Caption = 'Quote No.';
        }
        Field(50008; "ProForma No."; Code[20]) //-218
        {
            Caption = 'ProForma No.';
        }
        Field(50009; "No. Series ProForma"; Code[10]) //-218
        {
            Caption = 'No. Series Proforma';
            Editable = false;
            TableRelation = "No. Series";
        }
        //-HEB.244
        Field(50010; "Distributor Code"; Code[10]) //-244
        {
            Caption = 'Distributor Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST(Distribuidor),Blocked=CONST(false));
        }
        Field(50011; "Salesperson/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Salesperson/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Cial."),Blocked=CONST(false));
        }
        Field(50012; "Administr/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Administr/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Administr."),Blocked=CONST(false));
        }
        //+HEB.244
        //-HEB.242
        field(50015; "Customer Quote No."; Code[20])
        {
            Caption = 'Customer Quote No.';
        }
        field(50016; "Customer Order No."; Code[20])
        {
            Caption = 'Customer Order No.';
        }
        //+HEB.242
    }
}