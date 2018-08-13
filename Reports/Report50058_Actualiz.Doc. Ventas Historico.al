report 50058 "Actualiz.Doc. Ventas Historico"
{
    Caption = 'Actualiz.Doc. Ventas Historico';
    ProcessingOnly = true;
    Permissions = TableData "Sales Shipment Header"=m,TableData "Sales Invoice Header"=m,TableData "Sales Cr.Memo Header"=m;
    ApplicationArea = All;
    UsageCategory = Tasks;
    dataset
    {
        dataitem(Integer;Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number=CONST(1));
            trigger OnPreDataItem();
            begin
                IF (FromDate = 0D) OR (ToDate = 0D) THEN
                    ERROR('Dates are mandatory');

                IF ToDate < FromDate THEN
                    ERROR('To Date can not be less than From Date');
            end;
            trigger OnAfterGetRecord();
            begin
                // Quote - Orders - Returns - Invoice - Credit Memo
                CLEAR(SalesHeader);
                SalesHeader.SETRANGE("Order Date",FromDate,ToDate);
                IF SalesHeader.FINDSET THEN BEGIN
                    SalesHeader.SetHideValidationDialog(TRUE);
                    REPEAT
                        IF Customer.GET(SalesHeader."Bill-to Customer No.") THEN BEGIN
                            SalesHeader."Distributor Code" := Customer."Distributor Code";
                            SalesHeader."Salesperson/Resp. Code" := Customer."Salesperson/Resp. Code";
                            SalesHeader."Administr/Resp. Code" := Customer."Administr/Resp. Code";
                            IF SalesHeader."Salesperson Code" <> '' THEN BEGIN
                                IF Salesperson.GET(SalesHeader."Salesperson Code") THEN BEGIN
                                    IF Salesperson."Salesperson Type" <> Salesperson."Salesperson Type"::Comisionista THEN
                                        SalesHeader.VALIDATE("Salesperson Code",'');
                                END;
                            END;
                            SalesHeader.MODIFY;
                        END;
                    UNTIL SalesHeader.NEXT = 0;
                END;

                //Shipments
                CLEAR(SalesShipmentHeader);
                SalesShipmentHeader.SETRANGE("Order Date",FromDate,ToDate);
                IF SalesShipmentHeader.FINDSET THEN BEGIN
                    REPEAT
                        IF Customer.GET(SalesShipmentHeader."Bill-to Customer No.") THEN BEGIN
                            SalesShipmentHeader."Distributor Code" := Customer."Distributor Code";
                            SalesShipmentHeader."Salesperson/Resp. Code" := Customer."Salesperson/Resp. Code";
                            SalesShipmentHeader."Administr/Resp. Code" := Customer."Administr/Resp. Code";
                            IF SalesShipmentHeader."Salesperson Code" <> '' THEN BEGIN
                                IF Salesperson.GET(SalesShipmentHeader."Salesperson Code") THEN BEGIN
                                    IF Salesperson."Salesperson Type" <> Salesperson."Salesperson Type"::Comisionista THEN
                                        SalesShipmentHeader."Salesperson Code" := '';
                                END;
                            END;
                            SalesShipmentHeader.MODIFY;
                        END;
                    UNTIL SalesShipmentHeader.NEXT = 0;
                END;

                //Posted Sales Invoice
                CLEAR(SalesInvoiceHeader);
                SalesInvoiceHeader.SETRANGE("Order Date",FromDate,ToDate);
                IF SalesInvoiceHeader.FINDSET THEN BEGIN
                    REPEAT
                        IF Customer.GET(SalesInvoiceHeader."Bill-to Customer No.") THEN BEGIN
                            SalesInvoiceHeader."Distributor Code" := Customer."Distributor Code";
                            SalesInvoiceHeader."Salesperson/Resp. Code" := Customer."Salesperson/Resp. Code";
                            SalesInvoiceHeader."Administr/Resp. Code" := Customer."Administr/Resp. Code";
                            IF SalesInvoiceHeader."Salesperson Code" <> '' THEN BEGIN
                                IF Salesperson.GET(SalesInvoiceHeader."Salesperson Code") THEN BEGIN
                                    IF Salesperson."Salesperson Type" <> Salesperson."Salesperson Type"::Comisionista THEN
                                        SalesInvoiceHeader."Salesperson Code" := '';
                                END;
                            END;
                            SalesInvoiceHeader.MODIFY;
                        END;
                    UNTIL SalesInvoiceHeader.NEXT = 0;
                END;

                //Posted Credit Memo
                CLEAR(SalesCrMemoHeader);
                SalesCrMemoHeader.SETRANGE("Posting Date",FromDate,ToDate);
                IF SalesCrMemoHeader.FINDSET THEN BEGIN
                    REPEAT
                        IF Customer.GET(SalesCrMemoHeader."Bill-to Customer No.") THEN BEGIN
                            SalesCrMemoHeader."Distributor Code" := Customer."Distributor Code";
                            SalesCrMemoHeader."Salesperson/Resp. Code" := Customer."Salesperson/Resp. Code";
                            SalesCrMemoHeader."Administr/Resp. Code" := Customer."Administr/Resp. Code";
                            IF SalesCrMemoHeader."Salesperson Code" <> '' THEN BEGIN
                                IF Salesperson.GET(SalesCrMemoHeader."Salesperson Code") THEN BEGIN
                                    IF Salesperson."Salesperson Type" <> Salesperson."Salesperson Type"::Comisionista THEN
                                        SalesCrMemoHeader."Salesperson Code" := '';
                                END;
                            END;
                            SalesCrMemoHeader.MODIFY;
                        END;
                    UNTIL SalesCrMemoHeader.NEXT = 0;
                END;
            end;
        }
    }
    
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(FromDate;FromDate)
                    {
                        ApplicationArea = All;
                    }
                    field(ToDate;ToDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

    }
    var
        SalesHeader : Record "Sales Header";
        SalesShipmentHeader : Record "Sales Shipment Header";
        SalesInvoiceHeader : Record  "Sales Invoice Header";
        SalesCrMemoHeader : Record "Sales Cr.Memo Header";
        SalesHeaderArchive : Record  "Sales Header Archive";
        FromDate : Date;
        ToDate : Date;
        Customer : Record "Customer";
        Salesperson : Record "Salesperson/Purchaser";
}