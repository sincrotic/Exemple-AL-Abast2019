//HEB.173 MT 31052018. Añadido campo 50009 "Cód. Tunel" (ADR).
//HEB.187 MT 01062018. Añadido campo 50016 "REACH No.".
//HEB.225 MT 13062018. Control "Tasa Costes Generales" de la ficha del producto.
//HEB.225 MT 19062018. Añadido campo 50010 "Unit List Price 2".
tableextension 50027 ItemExt extends Item
{
    fields
    {
        Field(50001; "UN No."; Code[4])
        {
            Caption = 'UN No.';
        }
        Field(50002; "Nombre del Producto"; Text[30])
        {
            Caption = 'Nombre del Producto';
        }
        Field(50003; "Descripción ADR (Carta Portes)"; Text[250])
        {
            Caption = 'Descripción ADR (Carta Portes)';
        }
        Field(50004; "Estado"; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Líquido,Sólido,"Líquido/Sólido",Gas,Pasta;
            OptionCaption = ' ,Líquido,Sólido,Líquido/Sólido,Gas,Pasta';
        }
        Field(50005; "Clase"; Option)
        {
            Caption = 'Class';
            OptionMembers = " ",C41,C61,C9,C3,C8,C51,C1,C2,C42,C43,C52,C62,C7;
            OptionCaption = ' ,4.1,6.1,9,3,8,5.1,1,2,4.2,4.3,5.2,6.2,7';
        }
        Field(50006; "Packaging Group"; Text[10])
        {
            Caption = 'Packaging Group';
        }
        field(50007; "Clasificación LOC"; Option)
        {
            Caption = 'Clasificación LOC';
            OptionMembers= " ","H-TYPE Small","H-TYPE Normal", "H-TYPE Improved","L-TYPE";
            OptionCaption = ' ,H-TYPE Small,H-TYPE Normal, H-TYPE Improved,L-TYPE';
        }
        Field(50008; "Etiqueta"; Text[10])
        {
            Caption = 'Label';
        }
        //-HEB.173
        //-173 ogarcia 09/11/2009 Mostrar "Cód. Tunel" (ADR)
        field(50009; "Cód. Tunel"; Text[10])
        {
            Caption = 'Cód Tunel';
            Description = '-173';
        }
        //+HEB.173
        //-HEB.188
        field(50010; "Unit List Price 2"; Decimal)
        {
            Caption = 'Unit List Price 2';
            Description = '-188';
            AutoFormatType = 2;
            MinValue = 0;
        }
        //+HEB.188
        Field(50015; "Technical Family Code"; Code[20]) //-185
        {
            Caption = 'Technical Family Code';
            TableRelation = "Technical Family".Code;
        }
        //-HEB.187
        //-187 ogarcia   02/11/2010 Nuevo campo "REACH No." en tabla Item
        field(50016; "REACH No."; Text[25])
        {
            Caption = 'REACH No.';
            Description = '-187';
        }
        //+HEB.187
        Field(50017; "Skip Adjust Cost Item Entries"; Boolean) //-232
        {
            Caption = 'Skip Adjust Cost Item Entries';
        }
        Field(50018; "Product Out-Dated"; Boolean) //-232
        {
            Caption = 'Product Out-Dated';
        }
        //-HEB.225
        Field(60000; "ID. Doc. OP"; Integer)
        {
            Caption = 'ID. Doc. OP';
            TableRelation = "Record Link";
            trigger OnValidate();
            var
                Vinculos : Record "Record Link";
            begin
                Vinculos.GET("ID. Doc. OP");
                "Doc. OP Desc" := Vinculos.Description;
            end;
        }
        Field(60001; "Doc. OP Desc"; Text[250])
        {
            Caption = 'Doc. OP Desc';
            Editable = false;
        }
        //-225 cnicolas  16/01/2014 Control "Tasa Costes Generales" de la fitxa del producte
        modify(Blocked){
            trigger OnAfterValidate();
            begin
                IF Blocked = FALSE THEN
                BEGIN
                    IF "Production BOM No." <> '' THEN
                    BEGIN
                        IF "Overhead Rate" = 0 THEN
                        BEGIN
                        IF NOT CONFIRM(STRSUBSTNO(Text22501,FIELDCAPTION("Overhead Rate"),"No.")) THEN
                            ERROR(Text22502);
                        END;
                    END;
                END;
            end;
        }
        //-HEB.225
    }

    var
        //-HEB.225
        Text22501 : label '%1 es 0 para producto %2, que tiene una Lista de Materiales. ¿Está seguro que quiere desbloquear el producto?';
        Text22502 : label 'No se ha desbloqueado el producto';
        //+HEB.225

    //-HEB.201
    trigger OnAfterInsert();
    begin
        Blocked := true;
    end;
    //+HEB.201
}