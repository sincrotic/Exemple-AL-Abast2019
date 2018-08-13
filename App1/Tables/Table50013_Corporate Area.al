//HEB.231 MR 07062018 Campos nuevos en tabla Comment Line
table 50013 "Corporate Area"
{
    Caption = 'Corporate Area';
    LookupPageId = "Corporate Area";
    DrillDownPageId = "Corporate Area";
    DataCaptionFields = "Area Code","Description";
    fields
    {
        field(1;"Area Code"; Code[10])
        {
            Caption = 'Area Code';
        }
        field(2;"Description"; Text[20])
        {
            Caption = 'Description';
        }
    }
    
    keys
    {
        key(PK; "Area Code")
        {
            Clustered = true;
        }
    }
    
}