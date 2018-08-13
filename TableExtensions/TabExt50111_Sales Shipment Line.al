tableextension 50111 SalesShipmentLineExt extends "Sales Shipment Line"//MyTargetTableId
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
            Editable = true;
        }
        field(50003; "Sell-to Customer Name"; Text [50]) //-157: PI0021
        {
            Caption = 'Sell-to Customer Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE ("No."=FIELD("Sell-to Customer No.")));
            Editable = false;
        }
        field(50004; "Bill-to Customer Name"; Text [50]) //-157: PI0021
        {
            Caption = 'Bill-to Customer Name';    
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE ("No."=FIELD("Bill-to Customer No.")));
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