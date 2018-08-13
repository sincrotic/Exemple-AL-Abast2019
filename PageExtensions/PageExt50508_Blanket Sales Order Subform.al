
pageextension 50508 BlanketSalesOrderSubformExt extends "Blanket Sales Order Subform"
{
    //VersionList NAVW14.00.01,NAVES4.00.02
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
    }
}