//HEB.190 MT 06072018. Nuevo report
report 50041 "Ventas - ClienteProdPeriodo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Ventas - ClienteProdPeriodo.rdlc';
    Caption = 'Sales - CustomerItemPeriod';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Sales;

    dataset
    {
        dataitem(Customer;Customer)
        {
            RequestFilterFields = "No.";
            dataitem(Item;Item)
            {
                RequestFilterFields = "No.";

                trigger OnPreDataItem();
                begin
                    CurrReport.BREAK;
                end;
            }
            dataitem("Sales Invoice Header";"Sales Invoice Header")
            {
                DataItemLink = "Sell-to Customer No."=FIELD("No.");
                DataItemTableView = SORTING("Sell-to Customer No.","No.");
                dataitem("Sales Invoice Line";"Sales Invoice Line")
                {
                    DataItemLink = "Document No."=FIELD("No.");
                    DataItemTableView = SORTING("Document No.","Line No.") WHERE(Type=CONST(Item), Quantity=FILTER(<>0));

                    trigger OnAfterGetRecord();
                    begin

                        numMov += 1;
                        Datos."Nº mov" := numMov;
                        Datos."User ID" := USERID;
                        Datos.Cliente  := "Sales Invoice Header"."Sell-to Customer No.";
                        Datos."Nombre Cliente" := "Sales Invoice Header"."Sell-to Customer Name" +"Sales Invoice Header"."Sell-to Customer Name 2";
                        Datos.Producto         := "No.";
                        Datos.Descripción      := Description + "Description 2";
                        Datos.Mes              := FORMAT("Sales Invoice Header"."Posting Date",0,'<Month,2>');
                        Datos.AnyMes           := STRSUBSTNO('%1%2',FORMAT("Sales Invoice Header"."Posting Date",0,'<Year4>'),Datos.Mes);
                        Datos."Tipo Documento" := Datos."Tipo Documento"::Factura;
                        Datos."Nº Documento"   := "Sales Invoice Header"."No.";
                        Datos.Kilos            := Quantity;
                        Datos."Importe (DL)"   := CurrExchRate.ExchangeAmtFCYToLCY("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", Amount, "Sales Invoice Header"."Currency Factor");
                        IF Datos.Kilos = 0 THEN
                          Datos."Precio venta (DL)" := 0
                        ELSE
                          Datos."Precio venta (DL)" := (Datos."Importe (DL)" / Datos.Kilos);
                        Datos."Cód. Divisa" := '';
                        Datos.INSERT;
                    end;

                    trigger OnPreDataItem();
                    begin
                        IF Item.GETFILTER("No.") <> '' THEN
                          SETFILTER("No.",  Item.GETFILTER("No."));
                    end;
                }

                trigger OnPreDataItem();
                begin
                    SETRANGE("Posting Date",FechaIni,FechaFin);
                end;
            }
            dataitem("Sales Cr.Memo Header";"Sales Cr.Memo Header")
            {
                DataItemLink = "Sell-to Customer No."=FIELD("No.");
                DataItemTableView = SORTING("Sell-to Customer No.","No.");
                dataitem("Sales Cr.Memo Line";"Sales Cr.Memo Line")
                {
                    DataItemLink = "Document No."=FIELD("No.");
                    DataItemTableView = SORTING("Document No.","Line No.") WHERE(Type=CONST(Item), Quantity=FILTER(<>0));

                    trigger OnAfterGetRecord();
                    begin
                        numMov += 1;
                        Datos."Nº mov" := numMov;
                        Datos."User ID":= USERID;
                        Datos.Cliente  := "Sales Cr.Memo Header"."Sell-to Customer No.";
                        Datos."Nombre Cliente" := "Sales Cr.Memo Header"."Sell-to Customer Name" +"Sales Cr.Memo Header"."Sell-to Customer Name 2";
                        Datos.Producto         := "No.";
                        Datos.Descripción      := Description + "Description 2";
                        Datos.Mes              := FORMAT("Sales Cr.Memo Header"."Posting Date",0,'<Month,2>');
                        Datos.AnyMes           := STRSUBSTNO('%1%2',FORMAT("Sales Invoice Header"."Posting Date",0,'<Year4>'),Datos.Mes);
                        Datos."Tipo Documento" := Datos."Tipo Documento"::Abono;
                        Datos."Nº Documento"   := "Sales Cr.Memo Header"."No.";
                        Datos.Kilos            := -Quantity;
                        Datos."Importe (DL)"   := -CurrExchRate.ExchangeAmtFCYToLCY("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", Amount, "Sales Cr.Memo Header"."Currency Factor");
                        IF Datos.Kilos = 0 THEN
                          Datos."Precio venta (DL)" := 0
                        ELSE
                          Datos."Precio venta (DL)" := (Datos."Importe (DL)" / Datos.Kilos);

                        Datos."Cód. Divisa" := '';
                        Datos.INSERT;
                    end;

                    trigger OnPreDataItem();
                    begin
                        IF Item.GETFILTER("No.") <> '' THEN
                          SETFILTER("No.",  Item.GETFILTER("No."));
                    end;
                }

                trigger OnPreDataItem();
                begin
                    SETRANGE("Posting Date",FechaIni,FechaFin);
                end;
            }

            trigger OnPreDataItem();
            begin
                IF Customer.GETFILTERS <> '' THEN
                  filtroCli := STRSUBSTNO(TextFiltroCli,Customer.GETFILTERS);
            end;
        }
        dataitem("Ventas-Cliente-Producto";"Ventas-Cliente-Producto")
        {
            DataItemTableView = SORTING(Cliente,Producto,AnyMes,"Tipo Documento","Nº Documento");
            column(CompanyName;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(TodayFormatted;FORMAT(TODAY, 0, 4))
            {
            }
            column(txtFiltro;txtFiltro)
            {
            }
            column(filtroCli;filtroCli)
            {
            }
            column(filtroProd;filtroProd)
            {
            }
            column(Customer_No;"Ventas-Cliente-Producto".Cliente)
            {
            }
            column(Item_No;"Ventas-Cliente-Producto".Producto)
            {
            }
            column(VCP_NombreCliente;"Ventas-Cliente-Producto"."Nombre Cliente")
            {
            }
            column(VCP_Mes;"Ventas-Cliente-Producto".Mes)
            {
            }
            column(VCP_NoDocumento;"Ventas-Cliente-Producto"."Nº Documento")
            {
            }
            column(VCP_Kilos;"Ventas-Cliente-Producto".Kilos)
            {
            }
            column(VCP_ImporteDL;"Ventas-Cliente-Producto"."Importe (DL)")
            {
            }
            column(VCP_PrecioVentaDL;"Ventas-Cliente-Producto"."Precio venta (DL)")
            {
            }
            column(VCP_Descripcion;"Ventas-Cliente-Producto".Descripción)
            {
            }
            column(precMed;precMed)
            {
            }
            column(total;STRSUBSTNO(TextTotCli,"Nombre Cliente"))
            {
            }
            column(esAbono;esAbono)
            {
            }

            trigger OnAfterGetRecord();
            begin
                IF "Tipo Documento" = "Tipo Documento"::Abono THEN esAbono := '*'
                 ELSE esAbono := '';

                IF Kilos = 0 THEN
                  precMed := 0
                 ELSE
                  precMed := "Importe (DL)" / Kilos;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("User ID",USERID);
                IF ISEMPTY THEN
                  CurrReport.BREAK;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("period")
                {
                    field("Fecha inicial";FechaIni)
                    {
                    }
                    field("Fecha final";FechaFin)
                    {
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        TituloLbl = 'Sales - Customer/Item/Period';
        PaginaLbl = 'Page';
        DescripcionLbl = 'Item description';
        MesLbl = 'Month';
        NoDocumentoLbl = 'Document No.';
        KilosLbl = 'Kilos';
        ImporteDlLbl = 'Amount (LCY)';
        PrecioVentaDL = 'Sales Price (LCY)';
        LineaPuntos = '" . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ."';}

    trigger OnPreReport();
    begin
        Datos.RESET;
        Datos.SETRANGE("User ID",USERID);
        Datos.DELETEALL;

        numMov:=0;

        IF (FechaIni = 0D) OR (FechaFin = 0D) THEN
           ERROR('Debe de indicar un periodo en la pestaña opciones');

        txtFiltro := STRSUBSTNO(TextPeriodo,FechaIni,FechaFin);
        IF Item.GETFILTERS <> '' THEN
           filtroProd := STRSUBSTNO(TextFiltroProd,Item.GETFILTERS);
    end;

    var
        Datos : Record "Ventas-Cliente-Producto";
        CurrExchRate : Record "Currency Exchange Rate";
        FechaIni : Date;
        FechaFin : Date;
        numMov : Integer;
        txtFiltro : Text[60];
        esAbono : Text[1];
        filtroProd : Text[250];
        filtroCli : Text[250];
        precMed : Decimal;
        TextFiltroCli : Label 'Customer Filter: %1';
        TextPeriodo : Label 'Sales invoiced from %1 to %2';
        TextTotCli : Label 'Total %1 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ';
        TextFiltroProd : Label 'Item Filter: %1';
}

