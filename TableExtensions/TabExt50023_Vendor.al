//HEB.239 MT 30052018. Añadido campo 50002 "Proveedor Vivo".
//HEB.238 MT 04062018. Añadido campo 50001 "Vendor Out-Dated".
tableextension 50023 VendorExt extends Vendor
{
    //-238 xtrullols 03/06/2015 Creació camp baja a client i proveidor. SP20150603_HEB
    //-239 xtrullols 03/06/2015 Report 50043 amb albarans i copiar a proveidor. SP20150603_HEB
    
    fields
    {
        //-HEB.239
        field(50002; "Proveedor Vivo"; Boolean)
        {
            Caption = 'Alive Vendor';
        }
        //+HEB.239

        //-HEB.238
        field(50001; "Vendor Out-Dated"; Boolean)
        {
            Caption = 'Vendor Out-Dated';
            Description = '-238';
        }
        //+HEB.238
        //-HEB.001
        field(50020; "No. Serie Fra. Reg."; Code[20])
        {
            Caption = 'No. Serie Fra. Reg.';
            TableRelation = "No. Series";
        }
        field(50021; "No. Serie Abono Reg."; Code[20])
        {
            Caption = 'No. Serie Abono Reg.';
            TableRelation = "No. Series";
        }
        //+HEB.001
        //-HEB.002
        Field(50030; "Usar Registro Merc. Sueco"; Boolean) //HEB.002
        {
            Caption = 'Usar VAT de Suecia';
        }
        //+HEB.002
    }
    
}