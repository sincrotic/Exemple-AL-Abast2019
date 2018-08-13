//HEB.108 MT 13062018. Añadido campo "Logistico".
tableextension 50014 LocationExt extends Location
{
    //Caption = 'Location';
    DataCaptionFields = Code,Name;

    fields
    {
        //-108 ogarcia 07/04/2008 PI0004_9999 A¤adir campo 50000 Logistico
        //-HEB.108
        field(50000;Logistico;Boolean)
        {
            Description = '-108 PI0004';
        }
        //+HEB.108

        //-HEB.500
        field(50001; "Código Cliente"; Code[20])
        {
            Caption = 'Customer Code';
            TableRelation = Customer."No.";
        }

        field(50002; "Código Idioma"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language.Code;
        }
        field(50003; "Nombre Cliente"; Text[50])
        {
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE ("No."=FIELD("Código Cliente")));
        }
        //+HEB.500
    }
    
}