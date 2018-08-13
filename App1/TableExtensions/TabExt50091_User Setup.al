//HEB.137 MT 30052018. Añadidos campos 50001 "Allow modify cust. credit" y 50001 "Allow modify cust. blocked".
//HEB.145 MR 25052018. Nou camp a la taula 91 per indicar qui pot accedir al detall dels sous.
//HEB.170 AL 25052018. Nuevo campo en Cong. usuario para poder cmbiar la vista analisis
//HEB.201 MS 25052018. Bloquear productos al crearlos. Poder modificar el bloqueado por Conf. usuario
//HEB.202 MS 25052018. Filtro proveedores (lista/ficha) por defecto según Conf. usuario.
//HEB.204 MT 30052018. Añadido campo 50006 "Allow modify cust. alive".
//HEB.210 MR 31052018. Exp. 9006: Control per usuari "Permite mod. bloqueo proveedor"
//HEB.212 MR 31052018. Exp. 9006: Control visibilitat per usuari camps producte: Unit Cost, Overhead Rate
//HEB.220  Exp. 9205: Form Client/proveïdor NO EDITABLE. Boto per activar la edició
//HEB.232  Fer el modificar producte igual que està fet amb clients i proveidors.
//HEB.241  Gestió permisos contactes. SP20150603_HEB
//HEB.246  Gestió permisos clients. SP20160406_HEB

tableextension 50091 TableSetupExt extends "User Setup"
{
    fields
    {
        //-HEB.137
        Field(50000; "Allow modify cust. credit"; Boolean) 
        {
            Caption = 'Allow modify cust. credit';
        }
        //+HEB.137
        //-HEB.137
        Field(50001; "Allow modify cust. blocked"; Boolean) 
        {
            Caption = 'Allow modify cust. blocked';
        }
        //+HEB.137
        //-HEB.145
        Field(50002; "Allow see detailed salaris"; Boolean) 
        {
            Caption = 'Allow see detailed salaris';
        }
        //+HEB.145
        //-HEB.170
        Field(50003; "Allow change analysis view"; Boolean) 
        {
            Caption = 'Allow change analysis view';
        }
        //+HEB.170
        //-HEB.201
        Field(50004; "Allow unBlock Item"; Boolean) 
        {
            Caption = 'Allow unBlock Item';
        }
        //+HEB.201
        //-HEB.202
        Field(50005; "Default Vendor Filter"; Code[100]) 
        {
            Caption = 'Default Vendor Filter';
            TableRelation = "Vendor Posting Group";
            ValidateTableRelation = false;
            TestTableRelation = false;
        }
        //+HEB.202
        //-HEB.204
        Field(50006; "Allow modify cust. alive"; Boolean) 
        {
            Caption = 'Allow modify cust. alive';
        }
        //+HEB.204
        //-HEB.210
        Field(50007; "Allow modify vendor blocked"; Boolean) 
        {
            Caption = 'Allow modify vendor blocked';
        }
        //+HEB.210
        //-HEB.212
        Field(50008; "Allow view item cost fields"; Boolean) 
        {
            Caption = 'Allow view item cost fields';
        }
        //+HEB.212
        //-HEB.220
        Field(50009; "Allow Edit Customer/Vendor"; Boolean) 
        {
            Caption = 'Allow Edit Customer/Vendor';
        }
        //+HEB.220
        //-HEB.232
        Field(50010; "Allow Edit Item"; Boolean) 
        {
            Caption = 'Allow Edit Item';
        }
        //+HEB.232
        //-HEB.241
        Field(50011; "Allow Edit Contact"; Boolean) 
        {
            Caption = 'Allow Edit Contact';
        }
        //+HEB.241
        //-HEB.246
        Field(50012; "Allow Edit Cust. Fields"; Boolean) 
        {
            Caption = 'Allow Edit Cust. Fields';
        }
        //+HEB.246
    }
    
}