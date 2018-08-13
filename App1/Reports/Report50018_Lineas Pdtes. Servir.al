//HEB.141 MR 07062018. Document Type,Completely Shipped,Planned Shipment Date,Type,No.,Sell-to Customer No.
report 50018 "Lineas Pdtes. Servir"
{
    // -141 ogarcia 26/01/2009
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Lineas Pdtes. Servir.rdlc';


    dataset
    {
        dataitem("Sales Line";"Sales Line")
        {
            DataItemTableView = SORTING("Document Type","Completely Shipped","Planned Shipment Date",Type,"No.","Sell-to Customer No.")
                                WHERE("Document Type"=CONST(Order),
                                      "Completely Shipped"=CONST(false));
            RequestFilterFields = "Sell-to Customer No.","Document No.",Type,"No.","Location Code";
            column(CompanyName;COMPANYPROPERTY.DISPLAYNAME) { }
            column(cadenaFiltro;cadenaFiltro) { }
            column(DocumentNo_SalesLine;"Sales Line"."Document No.") { }
            column(LineNo_SalesLine;"Sales Line"."Line No.") { }
            column(PlannedShipmentDate_SalesLine;"Sales Line"."Planned Shipment Date") { }
            column(Type_SalesLine;"Sales Line".Type) { }
            column(No_SalesLine;"Sales Line"."No.") { }
            column(Description_SalesLine;"Sales Line".Description) { }
            column(Description2_SalesLine;"Sales Line"."Description 2") { }
            column(OutstandingQuantity_SalesLine;"Sales Line"."Outstanding Quantity") { }
            column(LocationCode_SalesLine;"Sales Line"."Location Code") { }
            column(SellToCustomerName_SalesLine;"Sales Line"."Sell-to Customer Name") { }

            trigger OnPreDataItem();
            begin
                cadenaFiltro:="Sales Line".GETFILTERS;
            end;
        }
    }
    labels
    {
        TituloLbl = 'OutStanding Sales Line';
        PageLbl = 'Page';
        PlannedShipmentDateLbl = 'Planned Shipment Date';
        NoLbl = 'No.';
        DescriptionLbl = 'Description';
        OutstandingQuantityLbl = 'Outstanding Quantity';
        LocationCodeLbl = 'Location Code';
        SellToCustomerNameLbl = 'Sell-to Customer Name';
    }

    var
        cadenaFiltro : Text[1024];
        Txt001 : Label 'Filtros: %1';
}

