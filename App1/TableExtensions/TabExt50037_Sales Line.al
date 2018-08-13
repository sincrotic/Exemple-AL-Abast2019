//HEB.242 MR 11062018 Formularis vendes i compres no confirmades i pedido cliente. SP20150603_HEB
//HEB.156 MR 12062018 Tabla 37 Añadir Campos. Añadir en formularios
tableextension 50037 SalesLineExt extends "Sales Line"
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
            trigger OnValidate();
            begin
                //+114
                CalculaImporteComision();
                //-114
            end;
        }
        Field(50002; "Importe Comisión"; Decimal) //-114: PI0010
        {
            Caption = 'Comission Import';
        }
        field(50003; "Sell-to Customer Name"; Text[50])
        {
            Caption = 'Sell-to Customer Name';
            FieldClass = FlowField;
            CalcFormula = Lookup (Customer.Name WHERE ("No." = FIELD ("Sell-to Customer No.")));
            Editable = false;

        }
        field(50004; "Bill-to Customer Name"; Text[50])
        {
            Caption = 'Bill-to Customer Name';
            FieldClass = FlowField;
            CalcFormula = Lookup (Customer.Name WHERE ("No." = FIELD ("Bill-to Customer No.")));
            Editable = false;
        }
        //-HEB.156
        Field(50005; Packaging; Text[100]) //-156:PI0025
        {
            Caption = 'Packaging';
            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        //+HEB.156
        field(50010; "Order Date"; Date) //-227
        {
            Caption = 'Order Date';        
           FieldClass = FlowField;
           CalcFormula = Lookup("Sales Header"."Order Date" WHERE ("Document Type"=FIELD("Document Type"),"No."=FIELD("Document No.")));
        }
        //-HEB.242
        field(50012; "Customer Order No."; Code[20]) //-242
        {
            Caption = 'Customer Order No.';
        }
        //-HEB.506
        field(50013;"Tariff No.";Code[10])
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
        //+HEB.242
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate();
            var
                SalesHeader : Record "Sales Header";
                Utilidades : Codeunit "Sales Abast Library";
            begin
                //+114
                Rec.GetSalesHeader(SalesHeader);

                Rec.VALIDATE("% Comisión", Utilidades.BuscaPorcentajeComision(Rec, SalesHeader."Salesperson Code", SalesHeader."Order Date", Rec."Grupo Comision"));
                //-114  
            end;
        }
        modify("Quantity")
        {
            trigger OnAfterValidate();
            var
                SalesHeader : Record "Sales Header";
                Utilidades : Codeunit "Sales Abast Library";
            begin
                //+114
                Rec.GetSalesHeader(SalesHeader);

                Rec.VALIDATE("% Comisión", Utilidades.BuscaPorcentajeComision(Rec, SalesHeader."Salesperson Code", SalesHeader."Order Date", Rec."Grupo Comision"));
                //-114  
            end;
        }
        modify("Gen. Bus. Posting Group")
        {
            trigger OnAfterValidate();
            var
                SalesHeader : Record "Sales Header";
                Utilidades : Codeunit "Sales Abast Library";
            begin
                //+114
                Rec.GetSalesHeader(SalesHeader);

                Rec.VALIDATE("% Comisión", Utilidades.BuscaPorcentajeComision(Rec, SalesHeader."Salesperson Code", SalesHeader."Order Date", Rec."Grupo Comision"));
                //-114  
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate();
            var
                SalesHeader : Record "Sales Header";
                Utilidades : Codeunit "Sales Abast Library";
            begin
                //+114
                Rec.GetSalesHeader(SalesHeader);

                Rec.VALIDATE("% Comisión", Utilidades.BuscaPorcentajeComision(Rec, SalesHeader."Salesperson Code", SalesHeader."Order Date", Rec."Grupo Comision"));
                //-114  
            end;
        }
        modify("Purchasing Code")
        {
            trigger OnBeforeValidate();
            var
                PurchasingCode : Record Purchasing;
            begin
                //+124
                if PurchasingCode.Get("Purchasing Code") then
                    IF PurchasingCode."Default Location Code" <> '' THEN
                        "Location Code" := PurchasingCode."Default Location Code";
                //-124
            end;
        }
    }

    procedure GetSalesHeader(var SalesHeader : Record "Sales Header")
    var
        Currency : Record Currency;
    begin
        Rec.TESTFIELD("Document No.");
        IF ("Document Type" <> SalesHeader."Document Type") OR ("Document No." <> SalesHeader."No.") THEN BEGIN
            SalesHeader.GET("Document Type","Document No.");
            IF SalesHeader."Currency Code" = '' THEN
                Currency.InitRoundingPrecision
            ELSE BEGIN
                SalesHeader.TESTFIELD("Currency Factor");
                Currency.GET(SalesHeader."Currency Code");
                Currency.TESTFIELD("Amount Rounding Precision");
            END;
        END;
    end;

    procedure CalculaImporteComision()
    begin
        //+114
        "Importe Comisión" := "Line Amount" * ("% Comisión" / 100);
        //-114        
    end;
}