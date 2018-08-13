//HEB.122 MT 22052018. Añadido campo "Shipment Method Code Ext." que valida contra "Shipment Method Code" porque no puede editarse la propiedad TableRelation de éste.
//HEB.135 MR 07062018 Recalular el "Currency factor" al registrar pedidos de compra/venta
//HEB.156 MR 12062018 PI0025_7064 - Tabla 36, 37, 5107, 5108 Añadir Campos
//HEB.242 MR 11062018 Formularis vendes i compres no confirmades i pedido cliente. SP20150603_HEB
//HEB.244 MR 08062018 Camps relacionats venedor a fitxa client i traspassar a documents
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
//HEB.514 MT 12072018. Validar 
tableextension 50036 SalesHeaderExt extends "Sales Header"
{    
    fields
    {
        Field(50000; "Price Validity Date"; Date) //-156: PI0025
        {
            Caption = 'Price Validity Date';
        }
        Field(50001; "Days Validity"; Integer) //-156: PI0025
        {
            Caption = 'Days Validity';
        }
        Field(50002; "Product Availability (value)"; Integer) //-156:PI0025
        {
            Caption = 'Product Availability (value)';
            BlankZero = true;
        }
        Field(50003; "Product Availability (period)"; Option) //-156:PI0025
        {
            Caption = 'Product Availability (period)';
            OptionMembers = " ",Days,Weeks;
            OptionCaption = ' ,days,weeks';
        }
        Field(50004; "Non Accepted"; Boolean)
        {
            Caption = 'Non Accepted';
            trigger OnValidate();
            begin
                //-999
                VALIDATE("Cause NA", "Cause NA"::" ");
                //+999
            end;
        }
        Field(50005; "Cause NA"; Option) //-999
        {
            Caption = 'Cause NA';
            OptionMembers = " ",Expiration,Price,Volume,Availability,"Financial Terms","Reference Price";
            OptionCaption = ' ,Expiration,Price,Volume,Availability,Financial Terms,Reference Price';
            trigger OnValidate();
            begin
                //-999
                IF "Cause NA" <> "Cause NA"::" " THEN BEGIN
                    "Date NA" := WORKDATE;
                END ELSE BEGIN
                    "Date NA" := 0D;
                END;
                //+999
            end;
        }
        Field(50008; "ProForma No."; Code[20]) //-218
        {
            Caption = 'ProForma No.';
        }
        Field(50009; "No. Series ProForma"; Code[10]) //-218
        {
            Caption = 'No. Series Proforma';
            Editable = false;
            TableRelation = "No. Series";
        }
        Field(50006; "Date NA"; Date) //-999
        {
            Caption = 'Date NA';
        }
        //-HEB.244

        Field(50010; "Distributor Code"; Code[10]) //-244
        {
            Caption = 'Distributor Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST(Distribuidor),Blocked=CONST(false));
        }
        Field(50011; "Salesperson/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Salesperson/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Cial."),Blocked=CONST(false));
        }
        Field(50012; "Administr/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Administr/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Administr."),Blocked=CONST(false));
        }
        //+HEB.244
        //-HEB.114
        field(50013; "Importe Comisiones"; Decimal) //-114: PI0010
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Importe Comisión" where ("Document No."=field("No.")));
            Caption = 'Comision Import';
            Enabled = false;
            Editable = false;
        }
        //+HEB.114
        //-HEB.242
        field(50015; "Customer Quote No."; Code[20])
        {
            Caption = 'Customer Quote No.';
        }
        field(50016; "Customer Order No."; Code[20])
        {
            Caption = 'Customer Order No.';
            trigger OnValidate();
            var
                SalesLine2 : Record "Sales Line";
            begin
                //-242
                IF "Customer Order No." <> xRec."Customer Order No." THEN BEGIN
                    CLEAR(SalesLine2);
                    SalesLine2.SETRANGE("Document Type","Document Type");
                    SalesLine2.SETRANGE("Document No.","No.");
                    IF SalesLine2.FINDSET THEN
                        REPEAT
                            SalesLine2."Customer Order No." := "Customer Order No.";
                            SalesLine2.MODIFY;
                        UNTIL SalesLine2.NEXT = 0;
                END;
                //+242
            end;
        }
        //+HEB.242
        //-HEB.508
        field(50017; "SII Exclude"; Boolean)
        {
            Caption = 'SII Exclude';
        }
        //+HEB.508
        //-HEB.122
        field(50027; "Shipment Method Code Ext."; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method" where (Bloqueado=const(false));
            trigger OnValidate();
            begin
                Validate("Shipment Method Code","Shipment Method Code Ext.");
            end;
        }
        //-HEB.242
        //- MT 04062018
        modify("Shipment Method Code")
        {
            trigger OnAfterValidate();
            begin
                //if CurrFieldNo = FieldNo("Shipment Method Code Ext.") then
                //GET()
                //if not Testfield("Shipment Method Code Ext.","Shipment Method Code") then
                //    validate("Shipment Method Code Ext.","Shipment Method Code");
                "Shipment Method Code Ext." := "Shipment Method Code";
            end;
        }
        //+ MT 04062018
        //+HEB.122

        modify("Order Date")
        {
            trigger OnAfterValidate();
            begin
                //-HEB.114
                ReCalcComisIsSalesLinesExist(FIELDCAPTION("Order Date"));
                //+HEB.114                
            end;
        }
        modify("Posting Date")
        {
            trigger OnBeforeValidate();
            begin
                //-HEB.135
                IF CurrFieldNo <> 0 THEN BEGIN
                    TestNoSeriesDateExt("Posting No.","Posting No. Series",
                        FIELDCAPTION("Posting No."),FIELDCAPTION("Posting No. Series"));
                    TestNoSeriesDateExt("Prepayment No.","Prepayment No. Series",
                        FIELDCAPTION("Prepayment No."),FIELDCAPTION("Prepayment No. Series"));
                    TestNoSeriesDateExt("Prepmt. Cr. Memo No.","Prepmt. Cr. Memo No. Series",
                        FIELDCAPTION("Prepmt. Cr. Memo No."),FIELDCAPTION("Prepmt. Cr. Memo No. Series"));
                    VALIDATE("Document Date","Posting Date");
                END;
                //-HEB.135                
            end;
        }
        modify("Salesperson Code")
        {
            trigger OnAfterValidate();
            begin
                //-HEB.114
                ReCalcComisIsSalesLinesExist(FIELDCAPTION("Salesperson Code"));
                //+HEB.114             
            end;
        }
        modify("Bill-to Customer No.")
        {
            trigger OnAfterValidate();
            var 
                Cust: Record Customer;
                NoSeries : Record "No. Series";
                SalesSetup : Record "Sales & Receivables Setup";
            begin       
                //<HEB.001
                SalesSetup.Get;
                IF (xRec."Bill-to Customer No." <> "Bill-to Customer No.") AND (xRec."Bill-to Customer No." <> '') then
                    "Posting No. Series" := '';
                //HEB.001>

                //-HEB.130
                Cust.Get("Bill-to Customer No.");
                "Pay-at Code" := Cust."Cód. dirección pago genérico";
                //+HEB.130  

                //<HEB.001
                IF "Document Type" IN ["Document Type"::Invoice,"Document Type"::Order] THEN BEGIN
                    "Posting No. Series" := SalesSetup."Posted Invoice Nos.";
                    IF Cust."No. Serie Fra. Reg." <>'' THEN BEGIN
                        VALIDATE("Posting No. Series",Cust."No. Serie Fra. Reg.");
                    END;
                END;

                IF "Document Type" IN ["Document Type"::"Credit Memo","Document Type"::"Return Order"] THEN BEGIN
                    "Posting No. Series" := SalesSetup."Posted Credit Memo Nos.";
                    IF Cust."No. Serie Abono Reg." <>'' THEN BEGIN
                        VALIDATE("Posting No. Series",Cust."No. Serie Abono Reg.");
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
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate();
            begin
                //-HEB.126
                "Exit Point" := GetExitPoint("Sell-to Customer No.");
                //+HEB.126
                
            end;
        }
    }
    //-HEB.126
    local procedure GetExitPoint(CustNo : Code[20]) : Code[10]
    var
        cust : Record Customer;
    begin    
        IF NOT (("Document Type" = "Document Type"::Quote) AND (CustNo = '')) THEN BEGIN
            if Cust.GET(CustNo) then
                exit(cust."Exit Point")
            else
                exit('');
        END ELSE
            exit('');
    end;
    //+HEB.126
    procedure ReCalcComisIsSalesLinesExist(ChangedFIeldName : Text[100])   
    var 
        SalesLine : Record "Sales Line";
        Utilidades : Codeunit "Sales Abast Library";
        blnCambio : Boolean	;
        porcentaje : Decimal;	
        grupoComision : Code[20];
        Text031 : Label 'You have modified %1.\\';
        Text50000 : Label 'Do you want to update the lines?';
    begin
        //+114
        blnCambio := TRUE;
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", "Document Type");
        SalesLine.SETRANGE("Document No.", "No.");
        IF SalesLine.FINDFIRST THEN BEGIN
            IF NOT Rec.GetHideValidationDialog THEN
                blnCambio := CONFIRM(Text031 + Text50000, TRUE, ChangedFieldName);

            IF blnCambio THEN
                REPEAT
                    porcentaje := 0;
                    grupoComision := '';
                    porcentaje := Utilidades.BuscaPorcentajeComision(SalesLine,"Salesperson Code",
                                                                    "Order Date",grupoComision);
                    SalesLine.VALIDATE("% Comisión", porcentaje);
                    SalesLine."Grupo Comision" := grupoComision;
                    SalesLine.MODIFY;
                UNTIL SalesLine.NEXT = 0;
        END;
        //-114
    end;
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

    //PENDIENTE USAR EN PAGE 41
    //PENDIENTE VALORACION CON DIEGO
    procedure GetProformaNo()
    var
        NoSeriesMngt : Codeunit "NoSeriesManagement";
        SalesHeaderArchive : Record "Sales Header Archive";
        SalesSetup : Record "Sales & Receivables Setup";
        PaymentTerms : Record "Payment Terms";
        NoSeriesMgt : Codeunit "NoSeriesManagement";
        Text22601 : Label 'No se puede imprimir proforma para el Término de Pago %1';
    begin
        //-218
        IF ("Document Type" = "Document Type"::Quote) AND ("ProForma No." = '')THEN BEGIN
            SalesSetup.GET;
            SalesSetup.TESTFIELD(SalesSetup."ProForma Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."ProForma Nos.",xRec."No. Series ProForma", "Posting Date","ProForma No.","No. Series ProForma");
            MODIFY(TRUE);

            IF Status = Status::Released THEN BEGIN
                CALCFIELDS("No. of Archived Versions");
                IF SalesHeaderArchive.GET("Document Type","No.","Doc. No. Occurrence", "No. of Archived Versions") THEN
                BEGIN
                    SalesHeaderArchive."No. Series ProForma" := "No. Series ProForma";
                    SalesHeaderArchive."ProForma No." := "ProForma No.";
                    SalesHeaderArchive.MODIFY;
                END;
            END;
            COMMIT;
        END;
        //+218
    end;

    trigger OnAfterInsert();
    var
        CompanyInfo : Record "Company Information";
    begin
        CompanyInfo.Get;
        Validate("Operation Description",CompanyInfo."Sales Default Operation Desc.");
    end;
}