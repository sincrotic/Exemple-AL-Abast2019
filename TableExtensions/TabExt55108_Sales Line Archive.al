tableextension 55108 SalesLineArchiveExt extends "Sales Line Archive"
{
    fields
    {
        Field(50000; "Grupo Comision"; Code[10]) //-114: PI0010
        {
            Caption = 'Comission Group';
            Editable = false;
            TableRelation = "Grupos comision ventas";
        }
        Field(50001; "% Comisión"; Decimal) //-114: PI0010
        {
            Caption = 'Comission %';
            DecimalPlaces = 0:3;
        }
        Field(50002; "Importe Comisión"; Decimal) //-114: PI0010
        {
            Caption = 'Comission Import';
            Editable = false;
        }
        Field(50005; Packaging; Text[100]) //-156:PI0025
        {
            Caption = 'Packaging';
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