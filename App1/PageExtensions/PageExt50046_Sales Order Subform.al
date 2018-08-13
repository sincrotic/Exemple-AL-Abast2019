pageextension 50046 SalesOrderSubformExt extends "Sales Order Subform"
{
    //VersionList NAVW15.00,NAVES4.00.02
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    layout
    {
        //-HEB.506
        addafter("Cross-Reference No.")
        {
            field("Tariff No.";"Tariff No.")
            {
                ApplicationArea = All;
            }
        }
        //+HEB.506
        //-HEB.114
        addafter("VAT Prod. Posting Group")
        {
            field("% Comisión";"% Comisión")
            {
                ApplicationArea = All;
            }
        }
        //+HEB.114
        //-HEB.114
        addlast(Control1)
        {
            field("Importe Comisión";"Importe Comisión")
            {
                ApplicationArea = All;
            }
        }
        //+HEB.114
    }
}