table 50005 "Cuadro Comisiones Ventas"
{
    //VersionList PI0010
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    Caption = 'Sales comission table';
    fields
    {
        field(1; "Nº"; Code[20])
        {
            Caption = 'Nº';
            TableRelation = "Grupos comision ventas";
        }
        field(2; "Tipo Venta"; Option)
        {
            Caption = 'Sales type';
            OptionMembers = Customer,"Gen. Business Posting Group","All Customers";
            OptionCaption = 'Customer,Gen. Business Posting Group,All Customers';
            trigger OnValidate();
            begin
                IF "Tipo Venta" <> xRec."Tipo Venta" THEN
                    VALIDATE("Valor Venta",'');
            end;
        }
        field(3; "Valor Venta"; Code[20])
        {
            Caption = 'Sales value';
            TableRelation = IF ("Tipo Venta"=CONST(Customer)) Customer ELSE IF ("Tipo Venta"=CONST("Gen. Business Posting Group")) "Gen. Business Posting Group";
            trigger OnValidate();
            var
                Text001 : Label '%1 must be blank.';
            begin
                IF ("Valor Venta" <> '')  THEN
                    IF "Tipo Venta" = "Tipo Venta"::"All Customers" THEN
                        ERROR(Text001,FIELDCAPTION("Valor Venta"));                
            end;
        }
        field(4; "Nº Producto"; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            trigger OnValidate();
            var
                Text002Prod : Label 'Can not inform %1 if %2 or %3 have been informed.';
            begin                
                IF ("Nº Producto" <> xRec."Nº Producto") AND ("Nº Producto" <> '') THEN
                    IF ("Cód. Categoria producto" <> '') OR ("Cód. Grupo producto" <> '') THEN
                        ERROR(Text002Prod,FIELDCAPTION("Nº Producto"),FIELDCAPTION("Cód. Categoria producto"),FIELDCAPTION("Cód. Grupo producto"));
            end;
        }
        field(5; "Cód. Categoria producto"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category".Code;
            trigger OnValidate();
            var
                Text002Categ : Label 'Can not inform %1 if %2 or %3 have been informed.';
            begin
                IF ("Cód. Categoria producto" <> xRec."Cód. Categoria producto") THEN BEGIN
                    IF ("Cód. Categoria producto" <> '') AND ("Nº Producto" <> '') THEN
                        ERROR(Text002Categ,FIELDCAPTION("Cód. Categoria producto"),FIELDCAPTION("Nº Producto"));
                    VALIDATE("Cód. Grupo producto",'');
                END;     
            end;       
        }
        field(6; "Cód. Grupo producto"; Code[20])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE ("Item Category Code"=FIELD("Cód. Categoria producto"));
            trigger OnValidate();
            var
                Text002Grupo : Label 'Can not inform %1 if %2 or %3 have been informed.';
            begin                       
                IF ("Cód. Grupo producto" <> xRec."Cód. Grupo producto") THEN BEGIN
                    IF ("Cód. Grupo producto" <> '') AND ("Nº Producto" <> '') THEN
                        ERROR(Text002Grupo,FIELDCAPTION("Cód. Grupo producto"),FIELDCAPTION("Nº Producto"));
                END;
            end;
        }
        field(7; "Fecha Inicial"; Date)
        {
            Caption = 'Starting Date';
            trigger OnValidate();
            var
                Text000 : Label '%1 cannot be after %2';
            begin            
                IF ("Fecha Inicial" > "Fecha Final") AND ("Fecha Final" <> 0D) THEN
                 ERROR(Text000,FIELDCAPTION("Fecha Inicial"),FIELDCAPTION("Fecha Final"));
            end;
        }
        field(8; "Cantidad mínima"; Decimal)
        {
            Caption = 'Minimum Quantity';
        }
        field(16; "Fecha Final"; Date)
        {
            Caption = 'Ending Date';
            trigger OnValidate();
            begin            
                IF CurrFieldNo = 0 THEN
                    EXIT;
                VALIDATE("Fecha Inicial");
            end;
        }
        field(17; "% Comisión"; Decimal) //-114: PI0010
        {
            Caption = 'Comision %';
            DecimalPlaces = 0:3;
        }
    }
    
    keys
    {
        key(PK; "Nº", "Tipo Venta", "Valor Venta", "Fecha Inicial", "Cantidad mínima", "Nº Producto", "Cód. Categoria producto", "Cód. Grupo producto")
        {
            Clustered = true;            
        }
    }
    
    trigger OnInsert();
    begin  
        IF "Tipo Venta" = "Tipo Venta"::"All Customers" THEN
            "Valor Venta" := ''
        ELSE
            TESTFIELD("Valor Venta");

        TESTFIELD("Fecha Inicial");
        TESTFIELD("% Comisión");

        ActualizaFechaModGrupo();
    end;

    trigger OnModify();
    begin
        ActualizaFechaModGrupo();
    end;

    trigger OnDelete();
    begin
        ActualizaFechaModGrupo();
    end;

    trigger OnRename();
    begin
        IF "Tipo Venta" <> "Tipo Venta"::"All Customers" THEN
            TESTFIELD("Valor Venta");

        TESTFIELD("% Comisión");

        ActualizaFechaModGrupo();
    end;

    local procedure ActualizaFechaModGrupo()
    var
        GrupoComision : Record "Grupos comision ventas";
    begin
 
        IF GrupoComision.GET("Nº") THEN BEGIN
            GrupoComision."Fecha ult. modificación" := TODAY;
            GrupoComision.MODIFY;
        END;       
    end;
}