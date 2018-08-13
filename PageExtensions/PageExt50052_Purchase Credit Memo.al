//HEB.184 MR 30052018. Nuevos campos cabecera compra para DUA
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 50052 PurchaseCreditMemoExt extends "Purchase Credit Memo" //MyTargetPageId
{
    layout
    {
        addafter("Foreign Trade")
        {
            group(Aduanas)
            {
                Caption = 'Aduanas';
                field("Nº DUA";"Nº DUA"){}
                field("Fecha DUA";"Fecha DUA"){}
                field("Proveedor Origen";"Proveedor Origen"){}
            }
        }  
        addafter("Corrected Invoice No.")
        {
            field("Posting No. Series";"Posting No. Series")
            {

            }
        }
        //-HEB.508
        addfirst("SII Information")
        {
            field("SII Exclude";"SII Exclude") { }
        }
        //+HEB.508
    }
}