//HEB.156 MR 12062018 Tabla 37 Añadir Campos. Añadir en formularios
pageextension 50095 SalesQuoteSubformExt extends "Sales Quote Subform"
{
    //VersionList NAVW15.00,NAVES4.00.02,PI0025
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    layout
    {
        addlast(Control1)
        {
            //-HEB.114
            field("% Comisión";"% Comisión")
            {
                ApplicationArea = All;
            }
            //+HEB.114
            //-HEB.114
            field("Importe Comisión";"Importe Comisión")
            {
                ApplicationArea = All;
            }
            //+HEB.114
        }
        //-HEB.156
        addafter("Unit Cost (LCY)")
        {
            field(Packaging;Packaging) { }
        }
        //-HEB.156
    }
}