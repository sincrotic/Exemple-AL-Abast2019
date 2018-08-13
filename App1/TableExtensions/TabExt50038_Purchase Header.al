//-102 Añadido campo "No.Doc.Previsión"
//HEB.122 MT 22052018. Añadido campo "Shipment Method Code Ext" que valida contra "Shipment Method Code" porque no puede editarse la propiedad TableRelation de éste.
//HEB.135 MR 28052018. Recalular el "Currency factor" al registrar pedidos de compra/venta
//HEB.184 MR 30052018. Nuevos campos cabecera compra para DUA
//HEB.242 MR 11062018 Formularis vendes i compres no confirmades i pedido cliente. SP20150603_HEB
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
tableextension 50038 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        //-HEB.122
        field(50027; "Shipment Method Code Ext."; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method" WHERE (Bloqueado=CONST(FALSE));
            trigger OnValidate();
            begin
                Validate("Shipment Method Code");
            end;
        }
                
        //- MT 04062018
        modify("Shipment Method Code")
        {
            trigger OnAfterValidate();
            begin
                "Shipment Method Code Ext." := "Shipment Method Code";
            end;
        }
        //+ MT 04062018
        //+HEB.122

        //-HEB.102
        field(50001; "No.Doc.Previsión"; Code[20])
        {
            Caption = 'No.Doc.Prevision';
        }
        //+HEB.102
        //-HEB.184
        field(50010; "Nº DUA"; Code[20])
        {
            Caption = 'DUA No.';
        }
        //+HEB.184
        //-HEB.184
        field(50011; "Fecha DUA"; Date)
        {
            Caption = 'DUA Date';
        }
        //+HEB.184
        //-HEB.184
        field(50012; "Proveedor Origen"; Code[20])
        {
            Caption = 'Origin Vendor';
            TableRelation = Vendor;
        }
        //+HEB.184
        //-HEB.242
        field(50013; "NOT Confirmed"; Boolean) //-242
        {
            Caption = 'NOT Confirmed';
            trigger OnValidate();
            var
                PurchaseLine2 : Record "Purchase Line";
            begin
                //-242
                IF "NOT Confirmed" <> xRec."NOT Confirmed" THEN BEGIN
                CLEAR(PurchaseLine2);
                PurchaseLine2.SETRANGE("Document Type","Document Type");
                PurchaseLine2.SETRANGE("Document No.","No.");
                IF PurchaseLine2.FINDSET THEN
                    REPEAT
                    PurchaseLine2."NOT Confirmed" := "NOT Confirmed";
                    PurchaseLine2.MODIFY;
                    UNTIL PurchaseLine2.NEXT = 0;
                END;
                //+242
            end;
        }
        //+HEB.242
        //-HEB.508
        field(50017; "SII Exclude"; Boolean)
        {
            Caption = 'SII Exclude';
            Editable = false;
        }
        //+HEB.508
        //-HEB.135
        modify("Posting Date")
        {
            trigger OnBeforeValidate();
            begin
                //-135
                IF CurrFieldNo <> 0 THEN BEGIN
                    TestNoSeriesDateExt("Posting No.","Posting No. Series",
                        FIELDCAPTION("Posting No."),FIELDCAPTION("Posting No. Series"));
                    TestNoSeriesDateExt("Prepayment No.","Prepayment No. Series",
                        FIELDCAPTION("Prepayment No."),FIELDCAPTION("Prepayment No. Series"));
                    TestNoSeriesDateExt("Prepmt. Cr. Memo No.","Prepmt. Cr. Memo No. Series",
                        FIELDCAPTION("Prepmt. Cr. Memo No."),FIELDCAPTION("Prepmt. Cr. Memo No. Series"));
                    VALIDATE("Document Date","Posting Date");
                END;
                //-135                
            end;
        }
        //+HEB.135
        modify("Pay-to Vendor No.")
        {
            trigger OnAfterValidate();
            var 
                Vend : Record Vendor;
                NoSeries : Record "No. Series";
                PurchaseSetup : Record "Purchases & Payables Setup";
            begin           
                //<HEB.001
                Vend.Get("Pay-to Vendor No.");
                PurchaseSetup.Get;
                IF (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") AND (xRec."Pay-to Vendor No." <> '') then
                    "Posting No. Series" := '';
                IF "Document Type" IN ["Document Type"::Invoice,"Document Type"::Order] THEN BEGIN
                    "Posting No. Series" := PurchaseSetup."Posted Invoice Nos.";
                    IF Vend."No. Serie Fra. Reg." <> '' THEN BEGIN
                        VALIDATE("Posting No. Series", Vend."No. Serie Fra. Reg.");
                    END;
                END;

                IF "Document Type" IN ["Document Type"::"Credit Memo","Document Type"::"Return Order"] THEN BEGIN
                    "Posting No. Series" := PurchaseSetup."Posted Credit Memo Nos.";
                    IF Vend."No. Serie Abono Reg." <> '' THEN BEGIN
                        VALIDATE("Posting No. Series", Vend."No. Serie Abono Reg.");
                    END;
                END;
                //HEB.001>
                //-HEB.508
                IF ("Posting No. Series" <> '') THEN BEGIN
                    NoSeries.GET("Posting No. Series");
                    "SII Exclude" := NoSeries."SII Exclude";
                END;
                //+HEB.508
            end;
        }
    }
    local procedure TestNoSeriesDateExt(No : Code[20]; NoSeriesCode : Code[20]; NoCapt : Text[1024]; NoSeriesCapt : Text[1024]);
    var
        NoSeries : Record "No. Series";
        Text045	: Label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
    begin
        IF (No <> '') AND (NoSeriesCode <> '') THEN BEGIN
            NoSeries.GET(NoSeriesCode);
            IF NoSeries."Date Order" THEN
                ERROR(
                    Text045,
                    FIELDCAPTION("Posting Date"),NoSeriesCapt,NoSeriesCode,
                    NoSeries.FIELDCAPTION("Date Order"),NoSeries."Date Order","Document Type",
                    NoCapt,No);
        END;
    end;
}