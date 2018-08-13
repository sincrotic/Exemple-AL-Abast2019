//HEB.121 MT 22052018. Añadido campo "Registro Mercantil" (50000).
//HEB.107 MT 26062018. Añadido campo "Código F.Pago asociada" (50004).
//HEB.509 MT 27062018. Añadidos campos de URLs de condiciones de venta y de compra.
//           28062018. Añadidos campos de imágenes adicionales.
//HEB.514 MT 12072018. Añadido campo "Sales Default Operation Desc." (50022).
tableextension 50079 CompanyInformationExt extends "Company Information"
{
    fields
    {
        //-HEB.121
        field(50000;"Registro Mercantil";Text[200])
        {
            Caption = 'Registro Mercantil';
        }
        //+HEB.121
        //-HEB.107
        field(50004;"Código F.Pago asociada";Code[10])
        {
            Caption = 'Payment Method Assoc.';
            TableRelation = "Payment Method";
        }
        //+HEB.107
        Field(50009; "Delete PDF File"; Boolean) //-245
        {
            Caption = 'Delete PDF File';
        }
        Field(50011; "PDF Files Folder"; Text[250])//-245
        {
            Caption = 'PDF Files Folder';
            ExtendedDatatype = URL;
        }
        Field(50012; "Swedish VAT Registration No."; Text[20]) //HEB.002
        {
            Caption = 'VAT Registration No.';
            trigger OnValidate();
            var
                VATRegNoFormat : Record "VAT Registration No. Format";
            begin
                VATRegNoFormat.Test("VAT Registration No.","Country/Region Code",'',DATABASE::"Company Information");
            end;
        }
        //-HEB.509
        field(50013; "Sales URL Terms"; Text[250])
        {
            Caption = 'Sales URL Terms';
        }
        field(50014; "Purchases URL Terms"; Text[250])
        {
            Caption = 'Purchases URL Terms';
        }
        field(50015; "Imagen adic. 1"; Blob)
        {
            Caption = 'Add. Image 1';
            Subtype = Bitmap;
        }
        field(50016; "Imagen adic. 2"; Blob)
        {
            Caption = 'Add. Image 2';
            Subtype = Bitmap;
        }
        field(50017; "Imagen adic. 3"; Blob)
        {
            Caption = 'Add. Image 3';
            Subtype = Bitmap;
        }
        field(50018; "Condiciones Mercancía"; Text[250])
        {
            Caption = 'Condiciones Mercancía';
        }
        field(50019; "Responsabilidad Mercancía"; Text[250])
        {
            Caption = 'Responsabilidad Mercancía';
        }
        field(50020; "Entrega Bienes"; Text[250])
        {
            Caption = 'Entrega Bienes';
        }
        field(50021; "Modificación Datos"; Text[250])
        {
            Caption = 'Modificación Datos';
        }
        //+HEB.509
        //-HEB.514
        field(50022;"Sales Default Operation Desc.";Text[250])
        {
            Caption = 'Sales Default Operation Desc.';
        }
        //+HEB.514
    }
}
