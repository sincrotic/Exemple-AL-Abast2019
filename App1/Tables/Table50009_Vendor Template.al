//HEB.166 MR 11062018 Exp. 7064 Asociar Nº serie cliente en plantilla contactos
table 50009 "Vendor Template"
{
    Caption = 'Vendor Template';
    DrillDownPageID = "Vendor Template List";
    LookupPageID = "Vendor Template List";

    fields
    {
        field(1;"Code";Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2;Description;Text[30])
        {
            Caption = 'Description';
        }
        field(15;"Territory Code";Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(16;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(17;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(21;"Vendor Posting Group";Code[10])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(22;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(23;"Vendor Price Group";Code[10])
        {
            Caption = 'Vendor Price Group';
            TableRelation = "Customer Price Group";
        }
        field(27;"Payment Terms Code";Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(30;"Shipment Method Code";Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(33;"Invoice Disc. Code";Code[20])
        {
            Caption = 'Invoice Disc. Code';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                Cust : Record Customer;
            begin
                IF Page.RUNMODAL(0,Cust) = ACTION::LookupOK THEN
                  "Invoice Disc. Code" := Cust."Invoice Disc. Code";
            end;
        }
        field(35;"Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(47;"Payment Method Code";Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(88;"Gen. Bus. Posting Group";Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate();
            begin
                IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
                  IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
                    VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(110;"VAT Bus. Posting Group";Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(7001;"Allow Line Disc.";Boolean)
        {
            Caption = 'Allow Line Disc.';
        }
        field(50000;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Description = '-165 Exp. 7064';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        DimMgt.DeleteDefaultDim(DATABASE::"Customer Template",Code);
    end;

    trigger OnInsert();
    begin
        DimMgt.UpdateDefaultDim(
          DATABASE::"Customer Template",Code,
          "Global Dimension 1 Code","Global Dimension 2 Code");

        "Invoice Disc. Code" := Code;
    end;

    var
        GenBusPostingGrp : Record "Gen. Business Posting Group";
        DimMgt : Codeunit DimensionManagement;

    procedure ValidateShortcutDimCode(FieldNumber : Integer;var ShortcutDimCode : Code[20]);
    begin
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Customer Template",Code,FieldNumber,ShortcutDimCode);
        MODIFY;
    end;
}

