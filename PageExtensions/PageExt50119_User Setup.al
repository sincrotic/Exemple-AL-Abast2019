//HEB.204 MT 30052018. Publicación de campo "Allow modify cust. alive".
//HEB.210 MR 31052018 Exp. 9006: Control per usuari "Allow modify vendor blocked"
//HEB.212 MR 31052018 Exp. 9006: Control per usuari "Allow view item cost fields" (Fitxe producte)
pageextension 50119 UserSetupExt extends "User Setup"
{
    layout
    {
        addafter("Register Time")
        {
            field("Allow Edit Cust. Fields";"Allow Edit Cust. Fields") { }
            //-HEB.241
            field("Allow Edit Contact";"Allow Edit Contact") { }
            //+HEB.241
            field("Allow modify cust. blocked";"Allow modify cust. blocked") { }

            field("Allow modify cust. credit";"Allow modify cust. credit") { }
            //-HEB.204
            field("Allow modify cust. alive";"Allow modify cust. alive") { }
            //+HEB.204
            //-HEB.210
            field("Allow modify vendor blocked";"Allow modify vendor blocked") { }
            //+HEB.210
            //-HEB.232
            field("Allow Edit Customer/Vendor";"Allow Edit Customer/Vendor") { }
            //+HEB.232
            //-HEB.232
            field("Allow Edit Item";"Allow Edit Item") { }
            //+HEB.232
            field("Allow unBlock Item";"Allow unBlock Item") { }
            //+HEB.212
            field("Allow view item cost fields";"Allow view item cost fields") { }
            //+HEB.212
            field("Allow change analysis view";"Allow change analysis view") { }

            field("Allow see detailed salaris";"Allow see detailed salaris") { }
        }
    }
}