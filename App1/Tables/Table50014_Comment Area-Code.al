//HEB.231 MR 07062018 Campos nuevos en tabla Comment Line
table 50014 "Comment Area-Code"
{
    Caption = 'Comment Area-Code';
    LookupPageId = "Comment Area-Code";
    DrillDownPageId = "Comment Area-Code";
    
    fields
    {
        field(1;"Area Code"; Code[10])
        {
            Caption = 'Area Code';
            TableRelation = "Corporate Area";
        }
        field(2;"Comment Code"; Code[10])
        {
            Caption = 'Comment Code';
        }
        field(3;"Comment Description"; Text[30])
        {
            Caption = 'Comment Description';
        }
    }
    
    keys
    {
        key(PK; "Area Code","Comment Code")
        {
            Clustered = true;
        }
    }
    
}