//HEB.184 MR 30052018. Nuevos campos cabecera compra para DUA
pageextension 50147 PostedPurchaseCreditMemosExt extends "Posted Purchase Credit Memos" //MyTargetPageId
{
    layout
    {
        addlast(Control1)
        {
                field("Nº DUA";"Nº DUA"){}
                field("Fecha DUA";"Fecha DUA"){}
                field("Proveedor Origen";"Proveedor Origen"){}
        }  
    }
}