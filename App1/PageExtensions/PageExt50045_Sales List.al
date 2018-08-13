//HEB.242 MR 11062018 Formularis vendes i compres no confirmades i pedido cliente. SP20150603_HEB
pageextension 50045 SalesListExt extends "Sales List"
{
    layout
    {
        addafter("No.")
        {
            field("ProForma No.";"ProForma No.") { }
        }
        //-HEB.242
        addafter("Bill-to Customer No.")
        {
            field("Non Accepted";"Non Accepted") { }
            field("Cause NA";"Cause NA") { }
            field("Date NA";"Date NA") { }
        }
        //+HEB.242
    }
}