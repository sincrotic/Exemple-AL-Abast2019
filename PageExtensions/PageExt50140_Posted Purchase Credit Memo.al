//HEB.184 MR 30052018. Nuevos campos cabecera compra para DUA
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 50140 PostedPurchaseCreditMemoExt extends "Posted Purchase Credit Memo" //MyTargetPageId
{
    layout
    {
        addafter("Shipping and Payment")
        {
            group(Aduanas)
            {
                Caption = 'Aduanas';
                field("Nº DUA";"Nº DUA"){}
                field("Fecha DUA";"Fecha DUA"){}
                field("Proveedor Origen";"Proveedor Origen"){}
            }
        } 
        //-HEB.508
        addfirst("SII Information")
        {
            field("SII Exclude";"SII Exclude")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        //+HEB.508 
    }
}