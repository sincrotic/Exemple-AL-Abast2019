//HEB.151 ogarcia 31/03/2009 PI0021_7064
report 50021 "Movimientos Productos HEB"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Movimientos Productos HEB.rdlc';

    dataset
    {
        dataitem("Item Ledger Entry";"Item Ledger Entry")
        {
            CalcFields = "Reason code";
            RequestFilterFields = "Entry Type","Posting Date","Reason code","Contact No";
            column(PostingDate;"Item Ledger Entry"."Posting Date")
            {
            }
            column(EntryType;"Item Ledger Entry"."Entry Type")
            {
            }
            column(DocumentNo;"Item Ledger Entry"."Document No.")
            {
            }
            column(ItemNo;"Item Ledger Entry"."Item No.")
            {
            }
            column(Description;RecItem.Description + RecItem."Description 2")
            {
            }
            column(Quantity;"Item Ledger Entry".Quantity)
            {
            }
            column(CostAmountActual;"Item Ledger Entry"."Cost Amount (Actual)")
            {
            }
            column(LotNo;"Item Ledger Entry"."Lot No.")
            {
            }
            column(ReasonCode;"Item Ledger Entry"."Reason code")
            {
            }
            column(Contact;STRSUBSTNO('%1 - %2',"Item Ledger Entry"."Contact No",RecContact.Name +  RecContact."Name 2"))
            {
            }
            column(TextoFiltros;STRSUBSTNO('Filtro: %1',TextoFiltros))
            {
            }
            column(CompanyName;RecCompanyInformation.Name)
            {
            }
            column(FechaCabecera;FORMAT(WORKDATE,0,4))
            {
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(RecItem);
                CLEAR(RecContact);

                IF NOT RecItem.GET("Item No.") THEN;
                IF NOT RecContact.GET("Contact No") THEN;
            end;

            trigger OnPreDataItem();
            begin
                TextoFiltros := "Item Ledger Entry".GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        TituloCabeceraLbl = 'Listado Movimientos Producto';PageLbl = 'Page';PostingDateLbl = 'Posting Date';EntryTypeLbl = 'Entry Type';DocumentNoLbl = 'Document No.';ItemNoLbl = 'Item No.';DescriptionLbl = 'Description';QuantityLbl = 'Quantity';CostAmountActualLbl = 'Cost Amount (Actual)';LotNoLbl = 'Lot No.';ReasonCodeLbl = 'Reason Code';ContactLbl = 'Contact';}

    trigger OnInitReport();
    begin
        RecCompanyInformation.GET;
    end;

    var
        RecItem : Record Item;
        RecContact : Record Contact;
        TextoFiltros : Text[250];
        RecCompanyInformation : Record "Company Information";
}

