//HEB.190 MT 05072018. Nueva tabla
table 50012 "Ventas-Cliente-Producto"
{
    Caption = 'Sales-Customer-Item';

    fields
    {
        field(1; "Nº mov"; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; Cliente; Code[20])
        {
            Caption = 'Customer';
        }
        field(3; "Nombre Cliente"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(4; Producto; Code[20])
        {
            Caption = 'Item';
        }
        field(5; Descripción; Text[100])
        {
            Caption = 'Description';
        }
        field(6; Mes; Code[2])
        {
            Caption = 'Month';
        }
        field(7; "Tipo Documento"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = "Factura","Abono";
            OptionCaption = 'Invoice,Credit Memo';
        }
        field(8; "Nº Documento"; Code[20])
        {
            Caption = 'Document No.';
        }
        field(9; Kilos; Decimal)
        {
            Caption = 'Kilos';
        }
        field(10; "Importe (DL)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            AutoFormatExpression = "Cód. Divisa";
        }
        field(11; "Precio Venta (DL)"; Decimal)
        {
            Caption = 'Sales Price (LCY)';
            AutoFormatExpression = "Cód. Divisa";
        }
        field(12; "Cód. Divisa"; Code[20])
        {
            Caption = 'Currency Code';
        }
        field(13; AnyMes; Code[6])
        {
            Caption = 'YearMonth';
        }
        field(100; "User ID"; Code[80])
        {
            Caption = 'User ID';
        }
        
    }
    
    keys
    {
        key(Key1; "User ID","Nº mov")
        {
            Clustered = true;
        }
        key(Key2; Cliente,Producto,AnyMes,"Tipo Documento","Nº Documento")
        {
        }
    }
    
}