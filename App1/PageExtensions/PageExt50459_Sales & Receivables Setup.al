pageextension 50459 SalesReceivablesSetupExt extends "Sales & Receivables Setup"
{
    layout
    {
        //-HEB.218
        addafter("Return Order Nos.")
        {
            field("ProForma Nos.";"ProForma Nos.") { }
        }
        //+HEB.218
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