report 50009 Comisiones
{
    // -179 ogarcia   17/11/2009 Añadir Importe comision en divisa venta y modificar formato
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Comisiones.rdlc';
    Caption = 'Comissions';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            column(No_Customer;Customer."No.") { }
            column(Name_Customer;Customer.Name) { }
            column(Name2_Customer;Customer."Name 2") { }
            column(ImporteTotalLinAm;ImporteTotalLinAm) { }
            column(ImporteTotalCom;ImporteTotalCom) { }
            column(ImporteTotalFactLCY;ImporteTotalFactLCY) { }
            column(ImporteTotalComisLCY;ImporteTotalComisLCY) { }
            column(PeriodoLbl;STRSUBSTNO(PeriodoLbl, fechaIni, fechaFin)) { }
            column(TotalNameLbl;STRSUBSTNO(TotalNameLbl,Name)) { }
            column(filtrosTxt;filtrosTxt) { }
            column(CompanyName;COMPANYPROPERTY.DISPLAYNAME) { }
            dataitem("Sales Invoice Header";"Sales Invoice Header")
            {
                CalcFields = Amount, "Importe Comisiones";
                DataItemLink = "Sell-to Customer No."=FIELD("No.");
                DataItemTableView = SORTING("Sell-to Customer No.","No.");
                column(No_SalesInvoiceHeader;"Sales Invoice Header"."No.") { }
                column(PostingDate_SalesInvoiceHeader;"Sales Invoice Header"."Posting Date") { }
                column(DueDate_SalesInvoiceHeader;"Sales Invoice Header"."Due Date") { }
                column(Name_Vendor_Invoice;rVendedor.Name) { }
                column(CurrencyCode_SalesInvoiceHeader;"Sales Invoice Header"."Currency Code") { }
                column(Amount_SalesInvoiceHeader;"Importe Comisiones") { }
                column(ImporteComisiones_SalesInvoiceHeader;"Importe Comisiones") { }
                column(ImporteLCY_SalesInvoiceHeader;ImporteLCY) { }
                column(ImporteComisLCY_SalesInvoiceHeader;ImporteComisLCY) { }
                dataitem("Sales Invoice Line";"Sales Invoice Line")
                {
                    DataItemLink = "Document No."=FIELD("No.");
                    DataItemTableView = SORTING("Document No.","Line No.")
                                        ORDER(Ascending)
                                        WHERE(Quantity=FILTER(<>0),
                                              Type=CONST(Item));
                    column(Type_SalesInvoiceLinea;"Sales Invoice Line".Type) { }
                    column(LineNo_SalesInvoiceLinea;"Sales Invoice Line"."Line No.") { }
                    column(No_SalesInvoiceLinea;"Sales Invoice Line"."No.") { }
                    column(Description_SalesInvoiceLinea;"Sales Invoice Line".Description) { }
                    column(Quantity_SalesInvoiceLinea;"Sales Invoice Line".Quantity) { }
                    column(LineAmount_SalesInvoiceLinea;"Sales Invoice Line"."Line Amount") { }
                    column(UnitOfMeasureCode_SalesInvoiceLinea;"Sales Invoice Line"."Unit of Measure Code") { }
                    column(ImporteComision_SalesInvoiceLinea;"Sales Invoice Line"."Importe Comisión") { }
                    column(ImporteLineaLCY_SalesInvoiceLinea;ImporteLineaLCY) { }

                    trigger OnAfterGetRecord();
                    begin
                        IF NOT detalle THEN CurrReport.SKIP;

                        ImporteLineaLCY:=CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE,
                                                                          "Sales Invoice Header"."Currency Code",
                                                                          "Line Amount",
                                                                          "Sales Invoice Header"."Currency Factor");
                        ImporteComisLCY:=CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE,
                                                                          "Sales Invoice Header"."Currency Code",
                                                                          "Importe Comisión",
                                                                          "Sales Invoice Header"."Currency Factor");
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    ImporteLCY           := CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE,"Currency Code","Importe Comisiones","Currency Factor");
                    ImporteComisLCY      := CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE,"Currency Code","Importe Comisiones","Currency Factor");

                    ImporteTotalCom      += "Importe Comisiones";
                    ImporteTotalLinAm    += "Importe Comisiones";
                    ImporteTotalFact     += "Importe Comisiones";
                    ImporteTotalFactLCY  += ImporteLCY;
                    ImporteTotalComisLCY += ImporteComisLCY;

                    CLEAR(rVendedor);
                    IF rVendedor.GET("Salesperson Code") THEN;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Posting Date",fechaIni,fechaFin);

                    IF codVendedor <> '' THEN
                       SETRANGE("Salesperson Code", codVendedor);

                    VALIDATE("Filtro Tipo Linea","Filtro Tipo Linea"::Item);
                end;
            }
            dataitem("Sales Cr.Memo Header";"Sales Cr.Memo Header")
            {
                CalcFields = Amount, "Importe Comisiones";
                DataItemLink = "Sell-to Customer No."=FIELD("No.");
                DataItemTableView = SORTING("Sell-to Customer No.","No.");
                column(No_SalesCrMemoHeader;"Sales Cr.Memo Header"."No.") { }
                column(PostingDate_SalesCrMemoHeader;"Sales Cr.Memo Header"."Posting Date") { }
                column(DueDate_SalesCrMemoHeader;"Sales Cr.Memo Header"."Due Date") { }
                column(Name_Vendor_CrMemo;rVendedor.Name) { }
                column(CurrencyCode_SalesCrMemoHeader;"Sales Cr.Memo Header"."Currency Code") { }
                column(Amount_SalesCrMemoHeader;"Sales Cr.Memo Header"."Importe Comisiones") { }
                column(ImporteComisiones_SalesCrMemoHeader;"Sales Cr.Memo Header"."Importe Comisiones") { }
                column(ImporteLCY_SalesCrMemoHeader;ImporteLCY) { }
                column(ImporteComisLCY_SalesCrMemoHeader;ImporteComisLCY) { }
                dataitem("Sales Cr.Memo Line";"Sales Cr.Memo Line")
                {
                    DataItemLink = "Document No."=FIELD("No.");
                    DataItemTableView = SORTING("Document No.","Line No.")
                                        ORDER(Ascending) 
                                        WHERE(Quantity=FILTER(<>0),
                                              Type=CONST(Item));
                    column(Type_SalesCrMemoLinea;"Sales Cr.Memo Line".Type) { }
                    column(LineNo_SalesCrMemoLinea;"Sales Cr.Memo Line"."Line No.") { }
                    column(No_SalesCrMemoLinea;"Sales Cr.Memo Line"."No.") { }
                    column(Description_SalesCrMemoLinea;"Sales Cr.Memo Line".Description) { }
                    column(Quantity_SalesCrMemoLinea;"Sales Cr.Memo Line".Quantity) { }
                    column(UnitofMeasureCode_SalesCrMemoLine;"Sales Cr.Memo Line"."Unit of Measure Code") { }
                    column(LineAmount_SalesCrMemoLinea;"Sales Cr.Memo Line"."Line Amount") { }
                    column(ImporteComision_SalesCrMemoLinea;"Sales Cr.Memo Line"."Importe Comisión") { }
                    column(ImporteLineaLCY_SalesCrMemoLinea;ImporteLineaLCY) { }

                    trigger OnAfterGetRecord();
                    begin
                        IF NOT detalle THEN CurrReport.SKIP;

                        ImporteLineaLCY:=CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE,
                                                                          "Sales Cr.Memo Header"."Currency Code",
                                                                          "Line Amount",
                                                                          "Sales Cr.Memo Header"."Currency Factor");
                        ImporteComisLCY:=CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE,
                                                                          "Sales Invoice Header"."Currency Code",
                                                                          "Importe Comisión",
                                                                          "Sales Invoice Header"."Currency Factor");
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    ImporteLCY          := CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE,"Currency Code","Importe comisiones","Currency Factor");
                    ImporteComisLCY     := CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE,"Currency Code","Importe comisiones","Currency Factor");

                    ImporteTotalCom     -= "Importe Comisiones";
                    ImporteTotalLinAm   -= "Importe Comisiones";
                    ImporteTotalFact    -= "Importe Comisiones";
                    ImporteTotalFactLCY -= ImporteLCY;
                    ImporteTotalComisLCY-= ImporteComisLCY;

                    CLEAR(rVendedor);
                    IF rVendedor.GET("Salesperson Code") THEN;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Posting Date",fechaIni,fechaFin);

                    IF codVendedor <> '' THEN
                       SETRANGE("Salesperson Code", codVendedor);

                    VALIDATE("Filtro Tipo Linea","Filtro Tipo Linea"::Item);
                end;
            }

            trigger OnPreDataItem();
            begin
                IF codCliente <> '' THEN
                   SETRANGE("No.",codCliente);

                CurrReport.CREATETOTALS(ImporteTotalFact,ImporteTotalComisLCY,
                                        ImporteTotalFactLCY,ImporteTotalLinAm,ImporteTotalCom);

                ImporteTotalFact    := 0;
                ImporteTotalComisLCY:= 0;
                ImporteTotalFactLCY := 0;
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
                    field(fechaIni;fechaIni)
                    {
                        Caption = 'Starting date';
                    }
                    field(fechaFin;fechaFin)
                    {
                        Caption = 'Ending date';
                    }
                    field(codVendedor;codVendedor)
                    {
                        Caption = 'Vendor Code';
                        TableRelation = "Salesperson/Purchaser";
                    }
                    field(codCliente;codCliente)
                    {
                        Caption = 'Customer Code';
                        TableRelation = Customer;
                    }
                    field(detalle;detalle)
                    {
                        Caption = 'Show detail';
                    }
                }
            }
        }
    }

    labels
    {
        TotalInformeLbl = 'Total Informe';NoLbl = 'No.';InvoiceDateLbl = 'Invoice Date';FirstExpirationDateLbl = 'First Expiration Date';VendorNameLbl = 'Vendor Name';AmountLbl = 'Amount';ComissionAmountLbl = 'Comission Amount';AmountLCYLbl = 'Amount (LCY)';ComissionAmountLCYLbl = 'Comission Amount (LCY)';TituloLbl = 'Listado Comisiones Ventas Facturadas';PaginaLbl = 'Page';}

    trigger OnInitReport();
    begin
        detalle:=TRUE;
        fechaIni:=DMY2DATE(1,DATE2DMY(WORKDATE,2),DATE2DMY(WORKDATE,3));
        fechaFin:=CALCDATE('+1M-1D',fechaIni);
        filtrosTxt:='';
    end;

    trigger OnPreReport();
    begin
        IF fechaIni = 0D THEN
           ERROR('Debe especificar una fecha de inicio de periodo');
        IF fechaFin = 0D THEN
           ERROR('Debe especificar una fecha de final de periodo');
        IF fechaIni > fechaFin THEN
           ERROR('La fecha inicial no puede ser posterior a la fecha final');

        IF codVendedor <> '' THEN
           filtrosTxt+='Cód. Vendedor: '+codVendedor;

        IF codCliente <> '' THEN BEGIN
           IF STRLEN(filtrosTxt) > 0 THEN filtrosTxt+=' y ';
           filtrosTxt+='Cód. Cliente: ' + codCliente;
        END;
    end;

    var
        fechaIni : Date;
        fechaFin : Date;
        codVendedor : Code[20];
        detalle : Boolean;
        codCliente : Code[20];
        ImporteTotalLinAm : Decimal;
        ImporteTotalCom : Decimal;
        ImporteTotalFact : Decimal;
        ImporteTotalFactLCY : Decimal;
        ImporteTotalComisLCY : Decimal;
        filtrosTxt : Text[250];
        rVendedor : Record "Salesperson/Purchaser";
        CurrExchRate : Record "Currency Exchange Rate";
        ImporteLCY : Decimal;
        ImporteLineaLCY : Decimal;
        ImporteComisLCY : Decimal;
        TotalNameLbl : Label 'Total %1';
        PeriodoLbl : Label 'Period: %1 to %2';
}