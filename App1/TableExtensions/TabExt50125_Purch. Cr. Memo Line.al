tableextension 50125 PurchCrMemoLineExt extends "Purch. Cr. Memo Line"
{
    fields
    {
        //-HEB.247
        Field(50020; "Sell-to Name"; Text[50]) //-247
        {
            Caption = 'Sell-to Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Cr. Memo Hdr."."Buy-from Vendor Name" WHERE ("No."=FIELD("Document No.")));
        }
        //+HEB.247
        //-HEB.247
        Field(50021; "Sell-to Country/Region Code"; Code[10]) //-247
        {
            Caption = 'Sell-to Country/Region Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Cr. Memo Hdr."."Buy-from Country/Region Code" WHERE ("No."=FIELD("Document No.")));            
        }
        //+HEB.247
        //-HEB.247
        Field(50022; "Bill-to Name"; Text[50]) //-247
        {
            Caption = 'Bill-to Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Cr. Memo Hdr."."Pay-to Name" WHERE ("No."=FIELD("Document No.")));            
        }
        //+HEB.247
        //-HEB.247
        Field(50023; "Bill-to Country/Region Code"; Code[10]) //-247
        {
            Caption = 'Bill-to Country/Region Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Cr. Memo Hdr."."Pay-to Country/Region Code" WHERE ("No."=FIELD("Document No.")));            
        }
        //+HEB.247
        //-HEB.247
        Field(50024; "Clasificación LOC"; Option)//-247
        {
            Caption = 'Clasificación LOC';
            OptionMembers = " ","H-TYPE Small","H-TYPE Normal","H-TYPE Improved","L-TYPE";
            OptionCaption = ' ,H-TYPE Small,H-TYPE Normal,H-TYPE Improved,L-TYPE';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Clasificación LOC" WHERE ("No."=FIELD("No.")));
            Editable = false;
        }
        //+HEB.247
        //-HEB.247
        Field(50025; Incoterm; Code[20]) //-247
        {
            Caption = 'Incoterm';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Cr. Memo Hdr."."Shipment Method Code" WHERE ("No."=FIELD("Document No.")));   
        }
        //+HEB.247
    }
}