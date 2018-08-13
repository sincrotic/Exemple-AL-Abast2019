pageextension 50133 PostedSalesInvoiceSubformExt extends "Posted Sales Invoice Subform"
{
    //VersionList NAVW15.00,NAVES4.00
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