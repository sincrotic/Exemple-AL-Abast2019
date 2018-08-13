table 50004 "Grupos comision ventas"
{
    //VersionList PI0010
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    Caption = 'Sales comission Group';
    LookupPageId = "Lista Grupos Comisión";
    DrillDownPageId = "Lista Grupos Comisión";

    fields
    {
        field(1; "Nº"; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Descripción"; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Fecha creación"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(4; "Fecha ult. modificación"; Date)
        {
            Caption = 'Laste Date modification';
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "Nº")
        {
            Clustered = true;
        }
    }
    
    trigger OnInsert()
    begin
        "Fecha creación" := TODAY;
    end;    
}