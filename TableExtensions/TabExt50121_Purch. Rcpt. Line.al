tableextension 50121 "Purch. Rcpt. Line" extends "Purch. Rcpt. Line" //MyTargetTableId
{
    fields
    {
        field(50000; "Fecha Registro"; Date) //PI0023
        {
            Caption = 'Fecha Registro';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Rcpt. Header"."Posting Date" WHERE ("No."=FIELD("Document No.")));
            Editable = false;
        }
        field(50001; "Buy-from vendor Name"; Text [50]) //-157: PI0021
        {
            Caption = 'Buy-from vendor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Rcpt. Header"."Buy-from Vendor Name" WHERE ("No."=FIELD("Document No.")));
            Editable = false;
        }
        //-HEB.247
        Field(50020; "Sell-to Name"; Text[50]) //-247
        {
            Caption = 'Sell-to Name';
            Editable = false;
            Enabled = false;
        }
        //+HEB.247
        //-HEB.247
        Field(50021; "Sell-to Country/Region Code"; Code[10]) //-247
        {
            Caption = 'Sell-to Country/Region Code';
            Editable = false;
            Enabled = false;
        }
        //+HEB.247
        //-HEB.247
        Field(50022; "Bill-to Name"; Text[50]) //-247
        {
            Caption = 'Bill-to Name';
            Editable = false;
            Enabled = false;
        }
        //+HEB.247
        //-HEB.247
        Field(50023; "Bill-to Country/Region Code"; Code[10]) //-247
        {
            Caption = 'Bill-to Country/Region Code';
            Editable = false;
            Enabled = false;
        }
        //+HEB.247
        //-HEB.247
        Field(50024; "Clasificación LOC"; Option)//-247
        {
            Caption = 'Clasificación LOC';
            Editable = false;
            Enabled = false;
            OptionMembers = " ","H-TYPE Small","H-TYPE Normal","H-TYPE Improved","L-TYPE";
            OptionCaption = ' ,H-TYPE Small,H-TYPE Normal,H-TYPE Improved,L-TYPE';
        }
        //+HEB.247
        //-HEB.247
        Field(50025; Incoterm; Code[20]) //-247
        {
            Caption = 'Incoterm';
            Editable = false;
            Enabled = false;
        }
        //+HEB.247
    }
}