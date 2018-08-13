//HEB.215 MR 21062018 Exp. 9205: Control Dim. FAMILIA al asociar carrecs producte (CDU 5805)
pageextension 50460 PurchasesPayablesSetupExt extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Number Series")
        {
            //-HEB.215
            group(Dimensions)
            {
                Caption = 'Dimensions';
                field("FAMILY Dimension Code";"FAMILY Dimension Code") { }
            }
            //+HEB.215
        }
        addlast(General)
        {
            //-HEB.155
            field("Archivo Body Pedidos (ES)";"Archivo Body Pedidos (ES)")
            {
                trigger OnAssistEdit();
                var
                    c412 : Codeunit "File Management";
                begin
                    //"Archivo Body Pedidos (ES)":=c412.OpenFile('Texto Correo (ES)','',4,'*.*',1);
                    "Archivo Body Pedidos (ES)" := c412.OpenFileDialog('Texto Correo (ES)', "Archivo Body Pedidos (ES)", '*.*');
                end;
            }
            //+HEB.155
            //-HEB.155
            field("Archivo Body Pedidos (ENU)";"Archivo Body Pedidos (ENU)")
            {
                trigger OnAssistEdit();
                var
                    c412 : Codeunit "File Management";
                begin
                    //"Archivo Body Pedidos (ENU)":=c412.OpenFile('Body Text (ENU)','',4,'*.*',1);
                    "Archivo Body Pedidos (ENU)" := c412.OpenFileDialog('Body Text (ENU)', "Archivo Body Pedidos (ENU)", '*.*');
                end;
            }
            //+HEB.155           
        }
    }
}