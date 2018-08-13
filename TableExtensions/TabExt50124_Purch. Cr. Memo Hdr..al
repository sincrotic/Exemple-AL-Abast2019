//HEB.184 MR 30052018. Nuevos campos cabecera compra para DUA
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
tableextension 50124 PurchCrMemoHdrExt extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        //-HEB.184
        field(50010; "Nº DUA"; Code[20])
        {
            Caption = 'DUA No.';
        }
        //+HEB.184
        //-HEB.184
        field(50011; "Fecha DUA"; Date)
        {
            Caption = 'DUA Date';
        }
        //+HEB.184
        //-HEB.184
        field(50012; "Proveedor Origen"; Code[20])
        {
            Caption = 'Origin Vendor';
        }
        //+HEB.184
        //-HEB.508
        field(50017; "SII Exclude"; Boolean)
        {
            Caption = 'SII Exclude';
        }
        //+HEB.508
    }
}