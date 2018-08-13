//HEB.156 MR 12062018 PI0025_7064 - Formularios relacionados Añadir Campos
pageextension 55161 SalesListArchive extends "Sales List Archive"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Price Validity Date";"Price Validity Date") { }
            field("Days Validity";"Days Validity") { }
        }
        addafter("Archived By")
        {
            field("Cause NA";"Cause NA") { }
            field("Date NA";"Date NA") { }
            field("Non Accepted";"Non Accepted") { }
        }
    }
}