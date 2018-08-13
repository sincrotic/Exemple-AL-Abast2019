//Creada para desarrollo 164
table 65002 "TMP Informe Bfo. Bruto"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }
    
    keys
    {
        key(PK; "Table ID","Document No.","Line No.")
        {
        }
    }
    
}