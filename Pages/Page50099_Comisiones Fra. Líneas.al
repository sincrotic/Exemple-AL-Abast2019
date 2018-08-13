page 50099 "Comisiones Fra. Líneas"
{
    //VersionList AITANA
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    //-227 cnicolas  16/01/2014 Mostrar Fecha Pedido i Fecha Registro a F50007 i F50008
    PageType = List;
    SourceTable = "Sales Invoice Line";
    SourceTableView = SORTING("Document No.","Line No.") WHERE(Type=CONST(Item));
    Caption = 'Comisiones Fra. Líneas';
    Permissions = TableData "Sales Invoice Line" = rm;
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                Field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Document No.";"Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Line No.";"Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("No.";"No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Location Code";"Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = All;
                    Editable = false;
                }
                Field(Quantity;Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Unit Price";"Unit Price")
                {
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                    Editable = false;
                }
                Field(Amount;Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                    Editable = false;
                }
                //-HEB.114
                Field("Grupo Comision";"Grupo Comision") //-114: PI0010
                {
                    Caption = 'Grupo Comision';
                    ApplicationArea = All;
                }
                //+HEB.114
                //-HEB.114
                Field("% Comisión";"% Comisión") //-114: PI0010
                {
                    Caption = '% Comisión';
                    ApplicationArea = All;
                }
                //+HEB.114
                //-HEB.114
                Field("Importe Comisión";"Importe Comisión") //-114: PI0010
                {
                    Caption = 'Importe Comisión';
                    ApplicationArea = All;
                }
                //+HEB.114
            }
        }
    }
}