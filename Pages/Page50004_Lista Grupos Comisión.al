page 50004 "Lista Grupos Comisión"
{
    //VersionList PI0010
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    PageType = List;
    SourceTable = "Grupos comision ventas";
    Caption = 'Lista Grupos Comisión';
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Nº"; "Nº")
                {
                    ApplicationArea = All;
                    
                }
                field("Descripción"; "Descripción")
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }
}