//HEB.184 MR 30052018. Tipo cuenta forzar Grupo. reg. IVA neg.
//-217 ogarcia 30/05/2013 Exp. 9205: Nous camps "FLOWFIELD" dades enviament a les linies compra (55000 a 55004)
//-124 ogarcia    06/11/2008 Añadido campo Default Location Code a la taula 5721 Purchasing
//                           Añadido codigo en el validate de lineas de ventas, Cód. compra, para que asigne el almacen por defecto
//HEB.242 MR 11062018 Formularis vendes i compres no confirmades i pedido cliente. SP20150603_HEB
tableextension 50039 PurchaseLineExt extends "Purchase Line" 
{

    fields
    {
        field(50000; "Buy-from Vendor Name"; Text [50])
        {
            Caption = 'Buy-from Vendor Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header"."Buy-from Vendor Name" WHERE ("No."=FIELD("Document No.")));
            Editable = false;
        }

        field(50001; "Pay-to Name"; Text [50])
        {
            Caption = 'Pay-to Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header"."Pay-to Name" WHERE ("No."=FIELD("Document No.")));
            Editable = false;
        }
        //-HEB.242
        field(50002; "NOT Confirmed"; Boolean) //-242
        {
            Caption = 'NOT Confirmed';
        }
        //+HEB.242
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
        //-HEB.217
        field(55000; "Shipment Method Code"; Code [10])//-217
        {
            Caption = 'Shipment Method Code';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header"."Shipment Method Code" WHERE ("Document Type"=FIELD("Document Type"),"No."=FIELD("Document No.")));
            Editable = false;
            TableRelation = "Shipment Method";
        }
        //+HEB.217
        //-HEB.217
        field(55001; "Ship-to Post Code"; Code [20])//-217
        {
            Caption = 'Ship-to Post Code';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header"."Ship-to Post Code" WHERE ("Document Type"=FIELD("Document Type"),"No."=FIELD("Document No.")));
            Editable = false;
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        //+HEB.217
        //-HEB.217
        field(55002; "Ship-to City"; Text [30])//-217
        {
            Caption = 'Ship-to City';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header"."Ship-to City" WHERE ("Document Type"=FIELD("Document Type"),"No."=FIELD("Document No.")));
            Editable = false;
        }
        //+HEB.217
        //-HEB.217
        field(55003; "Ship-to County"; Text [30])//-217
        {
            Caption = 'Ship-to County';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header"."Ship-to County" WHERE ("Document Type"=FIELD("Document Type"),"No."=FIELD("Document No.")));
            Editable = false;
        }
        //+HEB.217
        //-HEB.217
        field(55004; "Ship-to Country/Region Code"; Code [10])//-217
        {
            Caption = 'Ship-to Country/Region Code';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header"."Ship-to Country/Region Code" WHERE ("Document Type"=FIELD("Document Type"),"No."=FIELD("Document No.")));
            Editable = false;
            TableRelation = "Country/Region";
        }
        //+HEB.217
        //-HEB.184
        modify("No.")
        {
            trigger OnAfterValidate();
            var
                GLAcc : Record "G/L Account";
            begin
                if Type = Type::"G/L Account" then
                begin
                    GLAcc.GET("No.");
                    IF GLAcc."VAT Bus. Posting Group" <> '' THEN
                        "VAT Bus. Posting Group"  := GLAcc."VAT Bus. Posting Group";
                end;
            end;
        }
        //+HEB.184
        //-HEB.124
        modify("Purchasing Code")
        {
            trigger OnAfterValidate();

            var
                PurchasingCode: Record Purchasing;

            begin
                IF PurchasingCode.GET("Purchasing Code") THEN BEGIN
                    "Drop Shipment" := PurchasingCode."Drop Shipment";
                    "Special Order" := PurchasingCode."Special Order";
                END ELSE
                    "Drop Shipment" := FALSE;
                VALIDATE("Drop Shipment", "Drop Shipment");
            end;

        }
        //+HEB.124
    }
    
}