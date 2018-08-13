tableextension 50113 SalesInvoiceLineExt extends "Sales Invoice Line"//MyTargetTableId
{
    fields
    {
        Field(50000; "Grupo Comision"; Code[10]) //-114: PI0010
        {
            Caption = 'Comission Group';
            Editable = true;
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
        //-HEB.506
        field(50003;"Tariff No.";Code[10])
        {
            Caption = 'Tariff No.';
        }
        //+HEB.506
        //-HEB.247
        Field(50020; "Sell-to Name"; Text[50]) //-247
        {
            Caption = 'Sell-to Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Sell-to Customer Name" WHERE ("No."=FIELD("Document No.")));
        }
        //+HEB.247
        //-HEB.247
        Field(50021; "Sell-to Country/Region Code"; Code[10]) //-247
        {
            Caption = 'Sell-to Country/Region Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Sell-to Country/Region Code" WHERE ("No."=FIELD("Document No.")));            
        }
        //+HEB.247
        //-HEB.247
        Field(50022; "Bill-to Name"; Text[50]) //-247
        {
            Caption = 'Bill-to Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Bill-to Name" WHERE ("No."=FIELD("Document No.")));            
        }
        //+HEB.247
        //-HEB.247
        Field(50023; "Bill-to Country/Region Code"; Code[10]) //-247
        {
            Caption = 'Bill-to Country/Region Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Bill-to Country/Region Code" WHERE ("No."=FIELD("Document No.")));            
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
            CalcFormula = Lookup("Sales Invoice Header"."Shipment Method Code" WHERE ("No."=FIELD("Document No.")));   
        }
        //+HEB.247
    }
}