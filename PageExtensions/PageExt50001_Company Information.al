//HEB.121 MT 22052018. Muestra el campo "Registro Mercantil".
//HEB.509 MT 27062018. Muestra los campos de URLs de condiciones de venta y de compra.
//           28062018. Muestra los campos de imágenes adicionales.
//           03072018. Muestra los campos de entrega de bienes y modificación de datos.
//HEB.514 MT 12072018. Muestra el campo "Sales Default Operation Desc.".
pageextension 50001 CompanyInformationExt extends "Company Information"
{
    layout
    {
        addlast(General)
        {
            //-HEB.121
            field("Registro Mercantil";"Registro Mercantil") { }
            //+HEB.121
            //-HEB.002
            field("Swedish VAT Registration No.";"Swedish VAT Registration No.") { }
            //+HEB.002
            //-HEB.509
            field("Sales URL Terms";"Sales URL Terms") { }
            field("Purchases URL Terms";"Purchases URL Terms") { }
            //+HEB.509
        }
        addafter(Shipping)
        {
            group(PDF)
            {
                Caption = 'PDF';
                field("PDF Files Folder";"PDF Files Folder") { }
                field("Delete PDF File";"Delete PDF File") { }        
            }
            group("Company")
            {
                Caption = 'Company';


                //-HEB.509
                field("Condiciones Mercancía";"Condiciones Mercancía") { }
                field("Responsabilidad Mercancía";"Responsabilidad Mercancía") { }
                field("Modificación Datos";"Modificación Datos") { }
                field("Entrega Bienes";"Entrega Bienes") { }
                field("Imagen adic. 1";"Imagen adic. 1") { }
                field("Imagen adic. 2";"Imagen adic. 2") { }
                field("Imagen adic. 3";"Imagen adic. 3") { }
                //+HEB.509
                //-HEB.514
                field("Sales Default Operation Desc.";"Sales Default Operation Desc.")
                {
                }
                //+HEB.514
            }
        }
    }
}