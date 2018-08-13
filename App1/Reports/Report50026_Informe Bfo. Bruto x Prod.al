report 50026 "Informe Bfo. Bruto x Prod"
{
    // -164 ogarcia 15/09/2009 Exp. 7064
    // -222 ogarcia 31/05/2013 Exp. 9205: Afegir totals per familia tecnica
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Informe Bfo. Bruto x Prod.rdlc';


    dataset
    {
        dataitem(Item;Item)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.","Vendor No.","Manufacturer Code","Item Category Code","Product Group Code";
            column(CompanyInfo_Name;CompanyInformation.Name)
            {
            }
            column(PeriodText;PeriodText)
            {
            }
            column(FiltroText;FiltroText)
            {
            }
            column(Item_No;"No.")
            {
            }
            column(Item_Description;Description)
            {
            }
            column(Date;FORMAT(TODAY,0,4))
            {
            }
            column(VerDetalleProd;verDetalleProd)
            {
            }
            column(blnFamilia;blnFamilia)
            {
            }
            dataitem("Value Entry";"Value Entry")
            {
                DataItemLink = "Item No."=FIELD("No.");
                DataItemTableView = SORTING("Source Type","Source No.","Item No.","Posting Date","Entry Type",Adjustment)
                                    WHERE("Source Type"=CONST(Customer),
                                          "Document Type"=FILTER("Sales Invoice"|"Sales Credit Memo"));

                trigger OnAfterGetRecord();
                var
                    TableNo : Integer;
                begin
                    IF NOT Adjustment THEN BEGIN
                          CASE "Document Type" OF
                            "Document Type"::"Sales Invoice" : TableNo := DATABASE::"Sales Invoice Line";
                            "Document Type"::"Sales Credit Memo": TableNo := DATABASE::"Sales Cr.Memo Line";
                          END;

                          GastoCial   += GetImporteComision(TableNo,"Document No.","Document Line No.") +
                                         GetCostesIndirectos("Item Ledger Entry No.");
                    END;

                    IF MemIntAcumulados.GET(Item."No.", "Value Entry"."Source No.") THEN BEGIN
                      MemIntAcumulados."Decimal 3" += GastoCial;
                      MemIntAcumulados."Decimal 4" += "Value Entry"."Sales Amount (Actual)";
                      MemIntAcumulados."Decimal 5" += "Value Entry"."Cost Amount (Actual)";
                      MemIntAcumulados."Decimal 6" += "Value Entry"."Invoiced Quantity";
                      MemIntAcumulados.MODIFY;
                    END ELSE BEGIN
                      MemIntAcumulados."Code 1" := Item."No.";
                      MemIntAcumulados."Code 2" := "Value Entry"."Source No.";
                      MemIntAcumulados."Decimal 3" := GastoCial;
                      MemIntAcumulados."Decimal 4":= "Value Entry"."Sales Amount (Actual)";
                      MemIntAcumulados."Decimal 5" := "Value Entry"."Cost Amount (Actual)";
                      MemIntAcumulados."Decimal 6" := "Value Entry"."Invoiced Quantity";
                      MemIntAcumulados.INSERT;
                    END;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Posting Date",fechaIni,fechaFin);

                    CurrReport.CREATETOTALS("Sales Amount (Actual)",
                                            "Cost Amount (Actual)",
                                            "Invoiced Quantity",
                                            GastoCial);
                    GastoCial:=0;
                end;
            }
            dataitem(MemIntAcumulados;MemIntAcumulados)
            {
                UseTemporary = true;
                column(ValueEntry_SourceNo;MemIntAcumulados."Code 2")
                {
                }
                column(recCustomer_Name;recCustomer.Name)
                {
                }
                column(recCustomer_Name2;recCustomer."Name 2")
                {
                }
                column(ValueEntry_InvoicedQuantity;MemIntAcumulados."Decimal 6")
                {
                }
                column(ValueEntry_SalesAmountActual;MemIntAcumulados."Decimal 4")
                {
                }
                column(GastoCial;MemIntAcumulados."Decimal 3")
                {
                }
                column(SumaCostAmountActual;SumaCostAmountActual)
                {
                }
                column(PrecioMedVta;PrecioMedVta)
                {
                }
                column(CteMedioKg;CteMedioKg)
                {
                }
                column(BfoBruto;BfoBruto)
                {
                }
                column(BfoKgBruto;BfoKgBruto)
                {
                }
                column(BfoBrutoPorcen;BfoBrutoPorcen)
                {
                }
                column(BfoNeto;BfoNeto)
                {
                }
                column(BfoNetoPorcen;BfoNetoPorcen)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    SumaCostAmountActual += MemIntAcumulados."Decimal 5";
                    IF verDetalleProd THEN BEGIN
                        IF recCustomer.GET(MemIntAcumulados."Code 2") THEN;
                        BfoBruto := MemIntAcumulados."Decimal 4" + MemIntAcumulados."Decimal 5";
                        BfoNeto  := BfoBruto - MemIntAcumulados."Decimal 3";

                        IF MemIntAcumulados."Decimal 6" = 0 THEN
                          BEGIN
                            PrecioMedVta   := 0;
                            CteMedioKg     := 0;
                            BfoKgBruto     := 0;
                          END ELSE BEGIN
                            PrecioMedVta   := MemIntAcumulados."Decimal 4"/-MemIntAcumulados."Decimal 6";
                            CteMedioKg     := MemIntAcumulados."Decimal 5"/MemIntAcumulados."Decimal 6";
                            BfoKgBruto     := BfoBruto / -MemIntAcumulados."Decimal 6";
                          END;
                        IF MemIntAcumulados."Decimal 4" = 0 THEN
                          BEGIN
                            BfoBrutoPorcen := 0;
                            BfoNetoPorcen  := 0;
                          END ELSE BEGIN
                            BfoBrutoPorcen := ROUND((BfoBruto / MemIntAcumulados."Decimal 4")*100,0.01);
                            BfoNetoPorcen  := ROUND((BfoNeto /  MemIntAcumulados."Decimal 4")*100,0.01);
                          END;

                    END;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Code 1",Item."No.");
                    SumaCostAmountActual := 0;
                end;
            }

            trigger OnAfterGetRecord();
            var
                recTecFam : Record "Technical Family";
            begin
                //Item, GroupFooter (6) - OnPreSection
                IF verDetalleProd THEN BEGIN
                    BfoBruto := "Value Entry"."Sales Amount (Actual)" + "Value Entry"."Cost Amount (Actual)";
                    BfoNeto  := BfoBruto - GastoCial;

                    IF "Value Entry"."Invoiced Quantity" = 0 THEN
                      BEGIN
                        PrecioMedVta   := 0;
                        CteMedioKg     := 0;
                        BfoKgBruto     := 0;
                      END ELSE BEGIN
                        PrecioMedVta   := "Value Entry"."Sales Amount (Actual)"/-"Value Entry"."Invoiced Quantity";
                        CteMedioKg     := "Value Entry"."Cost Amount (Actual)"/"Value Entry"."Invoiced Quantity";
                        BfoKgBruto     := BfoBruto / -"Value Entry"."Invoiced Quantity";
                      END;
                    IF "Value Entry"."Sales Amount (Actual)" = 0 THEN
                      BEGIN
                        BfoBrutoPorcen := 0;
                        BfoNetoPorcen  := 0;
                      END ELSE BEGIN
                        BfoBrutoPorcen := ROUND((BfoBruto / "Value Entry"."Sales Amount (Actual)")*100,0.01);
                        BfoNetoPorcen  := ROUND((BfoNeto /  "Value Entry"."Sales Amount (Actual)")*100,0.01);
                      END;
                END;

                //-219
                IF blnFamilia THEN BEGIN
                  IF recTmpFamSales.GET(Item."Technical Family Code") THEN BEGIN
                    recTmpFamSales.Amount+="Value Entry"."Sales Amount (Actual)";
                    recTmpFamSales."Cost Amount" += "Value Entry"."Cost Amount (Actual)";
                    recTmpFamSales.Expenses += GastoCial;
                    recTmpFamSales.Quantity +=  "Value Entry"."Invoiced Quantity";
                    recTmpFamSales.MODIFY;
                  END ELSE BEGIN
                    IF NOT recTecFam.GET(Item."Technical Family Code") THEN
                      recTecFam.INIT;

                    recTmpFamSales.INIT;
                    recTmpFamSales.Family:=recTecFam.Code;
                    recTmpFamSales.Description:=recTecFam.Description;
                    recTmpFamSales."Family Type":=recTecFam.Division;
                    recTmpFamSales.Amount:="Value Entry"."Sales Amount (Actual)";
                    recTmpFamSales."Cost Amount" := "Value Entry"."Cost Amount (Actual)";
                    recTmpFamSales.Expenses := GastoCial;
                    recTmpFamSales.Quantity :=  "Value Entry"."Invoiced Quantity";
                    recTmpFamSales.INSERT;
                  END;
                END;
                //+219

                //Item, Footer (7) - OnPreSection
                BfoBruto := "Value Entry"."Sales Amount (Actual)" + "Value Entry"."Cost Amount (Actual)";
                BfoNeto  := BfoBruto - GastoCial;

                IF "Value Entry"."Invoiced Quantity" = 0 THEN
                  BEGIN
                    PrecioMedVta   := 0;
                    CteMedioKg     := 0;
                    BfoKgBruto     := 0;
                  END ELSE BEGIN
                    PrecioMedVta   := "Value Entry"."Sales Amount (Actual)"/-"Value Entry"."Invoiced Quantity";
                    CteMedioKg     := "Value Entry"."Cost Amount (Actual)"/"Value Entry"."Invoiced Quantity";
                    BfoKgBruto     := BfoBruto / -"Value Entry"."Invoiced Quantity";
                  END;
                IF "Value Entry"."Sales Amount (Actual)" = 0 THEN
                  BEGIN
                    BfoBrutoPorcen := 0;
                    BfoNetoPorcen  := 0;
                  END ELSE BEGIN
                    BfoBrutoPorcen := ROUND((BfoBruto / "Value Entry"."Sales Amount (Actual)")*100,0.01);
                    BfoNetoPorcen  := ROUND((BfoNeto /  "Value Entry"."Sales Amount (Actual)")*100,0.01);
                  END;
            end;

            trigger OnPreDataItem();
            var
                recTecFam : Record "Technical Family";
            begin
                IF (fechaIni = 0D) OR (fechaFin = 0D) THEN
                   ERROR ('Debe especificar un periodo');

                CurrReport.CREATETOTALS("Value Entry"."Sales Amount (Actual)",
                                        "Value Entry"."Cost Amount (Actual)",
                                        "Value Entry"."Invoiced Quantity",
                                        GastoCial);

                GastoCial:=0;
                PeriodText := STRSUBSTNO(Text001,fechaIni,fechaFin);

                IF Item.GETFILTERS <> '' THEN
                  FiltroText := STRSUBSTNO('Filtro %1: %2',Item.TABLECAPTION,Item.GETFILTERS)
                 ELSE
                  FiltroText := '';

                //-219
                   recTmpFamSales.RESET;
                   recTmpFamSales.DELETEALL;
                //+219
            end;
        }
        dataitem(Integer;Integer)
        {
            DataItemTableView = SORTING(Number);
            column(recTmpFamSales_Family;recTmpFamSales.Family)
            {
            }
            column(recTmpFamSales_Description;recTmpFamSales.Description)
            {
            }
            column(recTmpFamSales_Quantity;recTmpFamSales.Quantity)
            {
            }
            column(recTmpFamSales_Amount;recTmpFamSales.Amount)
            {
            }
            column(recTmpFamSales_Expenses;recTmpFamSales.Expenses)
            {
            }
            column(recTmpFamSales_FamilyType;recTmpFamSales."Family Type")
            {
            }
            column(recTmpFamSales_TotalQuantity;recTmpFamSales."Total Quantity")
            {
            }
            column(recTmpFamSales_TotalAmount;recTmpFamSales.TotalAmount)
            {
            }
            column(recTmpFamSales_TotalExpenses;recTmpFamSales."Total Expenses")
            {
            }
            column(recTmpFamSales_Total;recTmpFamSales.Total)
            {
            }
            column(PrecioMedVta_Family;PrecioMedVta)
            {
            }
            column(BfoBruto_Family;BfoBruto)
            {
            }
            column(BfoKgBruto_Family;BfoKgBruto)
            {
            }
            column(BfoBrutoPorcen_Family;BfoBrutoPorcen)
            {
            }
            column(BfoNeto_Family;BfoNeto)
            {
            }
            column(BfoNetoPorcen_Family;BfoNetoPorcen)
            {
            }

            trigger OnAfterGetRecord();
            begin
                //-219
                IF Number=1 THEN BEGIN
                  recTmpFamSales.FINDFIRST;
                  intTipo:=recTmpFamSales."Family Type";
                END ELSE
                  recTmpFamSales.NEXT;
                //+219

                //Integer, Body (2) - OnPreSection
                //-219
                BfoBruto := recTmpFamSales.Amount + recTmpFamSales."Cost Amount";
                BfoNeto  := BfoBruto - recTmpFamSales.Expenses;

                IF recTmpFamSales.Quantity = 0 THEN
                  BEGIN
                    PrecioMedVta   := 0;
                    CteMedioKg     := 0;
                    BfoKgBruto     := 0;
                  END ELSE BEGIN
                    PrecioMedVta   := recTmpFamSales.Amount/-recTmpFamSales.Quantity;
                    BfoKgBruto     := BfoBruto / -recTmpFamSales.Quantity;
                  END;

                IF recTmpFamSales.Amount  = 0 THEN
                  BEGIN
                    BfoBrutoPorcen := 0;
                    BfoNetoPorcen  := 0;
                  END ELSE BEGIN
                    BfoBrutoPorcen := ROUND((BfoBruto / recTmpFamSales.Amount )*100,0.01);
                    BfoNetoPorcen  := ROUND((BfoNeto /  recTmpFamSales.Amount )*100,0.01);
                  END;
                //+219

                //Integer, Body (3) - OnPreSection
                //-219
                IF recTmpFamSales.Total THEN BEGIN
                  BfoBruto := recTmpFamSales.TotalAmount + recTmpFamSales."Total Cost Amount";
                  BfoNeto  := BfoBruto - recTmpFamSales."Total Expenses";

                  IF recTmpFamSales."Total Quantity" = 0 THEN
                    BEGIN
                      PrecioMedVta   := 0;
                      BfoKgBruto     := 0;
                    END ELSE BEGIN
                      PrecioMedVta   := recTmpFamSales.TotalAmount/-recTmpFamSales."Total Quantity";
                      BfoKgBruto     := BfoBruto / -recTmpFamSales."Total Quantity";
                    END;

                  IF recTmpFamSales.TotalAmount  = 0 THEN
                    BEGIN
                      BfoBrutoPorcen := 0;
                      BfoNetoPorcen  := 0;
                    END ELSE BEGIN
                      BfoBrutoPorcen := ROUND((BfoBruto / recTmpFamSales.TotalAmount )*100,0.01);
                      BfoNetoPorcen  := ROUND((BfoNeto /  recTmpFamSales.TotalAmount )*100,0.01);
                    END;
                END;
                //+219
                //END OnPreSection
            end;

            trigger OnPreDataItem();
            begin
                //-219
                IF NOT blnFamilia THEN
                  CurrReport.BREAK;

                SETRANGE(Number,1,recTmpFamSales.COUNT);
                recTmpFamSales.SETCURRENTKEY("Family Type");

                IF recTmpFamSales.FINDFIRST THEN BEGIN
                  intTipo:=recTmpFamSales."Family Type";
                  REPEAT
                    IF intTipo=recTmpFamSales."Family Type" THEN BEGIN
                      decAmount     += recTmpFamSales.Amount;
                      decCostAmount += recTmpFamSales."Cost Amount";
                      decExpenses   += recTmpFamSales.Expenses;
                      decQty        += recTmpFamSales.Quantity;
                      intTipo       := recTmpFamSales."Family Type";
                    END ELSE BEGIN
                      recTmpFamSales.NEXT(-1);
                      recTmpFamSales.Total:=TRUE;
                      recTmpFamSales.TotalAmount := decAmount;
                      recTmpFamSales."Total Cost Amount" := decCostAmount;
                      recTmpFamSales."Total Expenses" := decExpenses;
                      recTmpFamSales."Total Quantity" := decQty;
                      recTmpFamSales.MODIFY;

                      recTmpFamSales.NEXT;
                      decAmount     += recTmpFamSales.Amount;
                      decCostAmount += recTmpFamSales."Cost Amount";
                      decExpenses   += recTmpFamSales.Expenses;
                      decQty        += recTmpFamSales.Quantity;
                      intTipo       := recTmpFamSales."Family Type";
                    END;
                  UNTIL recTmpFamSales.NEXT=0;

                  recTmpFamSales.Total:=TRUE;
                  recTmpFamSales.TotalAmount := decAmount;
                  recTmpFamSales."Total Cost Amount" := decCostAmount;
                  recTmpFamSales."Total Expenses" := decExpenses;
                  recTmpFamSales."Total Quantity" := decQty;
                  recTmpFamSales.MODIFY;

                END;
                //+219
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Opciones)
                {
                    field("Inicio Periodo";fechaIni)
                    {
                    }
                    field("Final Periodo";fechaFin)
                    {
                    }
                    field("Mostrar detalle";verDetalleProd)
                    {
                    }
                    field("Mostrar totales por familia";blnFamilia)
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
        TituloCabeceraLbl = 'Informe de Beneficio Bruto';SalesKgLbl = 'Sales Kg';SalesAmountLbl = 'Sales Amount (Actual)';PrecioMedioVentaLbl = 'Averge Sales Amount';CosteCompraKGLbl = 'Cost Sale by KG';BeneficioBrutoLbl = 'Bfº Bruto';BeneficioPorKGLbl = 'Bfº por KG';PorcentajeBeneficioBrutoLbl = '% Bfº Bruto';GastosComercialesLbl = 'Commercial Cost';BeneficioNetoLbl = 'Bfº Neto';PorcentajeBeneficioNetoLbl = '% Bfº Neto';TotalLbl = 'Total';DivisionLbl = 'Division:';FamiliaLbl = 'Family:';PageLbl = 'Page';TotalporFamiliaLbl = 'Total by Families';}

    trigger OnInitReport();
    begin
        CompanyInformation.GET;
    end;

    var
        GastoCial : Decimal;
        BfoBruto : Decimal;
        BfoNeto : Decimal;
        PeriodText : Text[250];
        FiltroText : Text[250];
        verDetalleProd : Boolean;
        fechaIni : Date;
        fechaFin : Date;
        PrecioMedVta : Decimal;
        CteMedioKg : Decimal;
        BfoKgBruto : Decimal;
        BfoBrutoPorcen : Decimal;
        BfoNetoPorcen : Decimal;
        recTMPComision : Record "TMP Informe Bfo. Bruto" temporary;
        recCustomer : Record Customer;
        recTmpFamSales : Record "Tmp Family Sales" temporary;
        blnFamilia : Boolean;
        decAmount : Decimal;
        decCostAmount : Decimal;
        decExpenses : Decimal;
        decQty : Decimal;
        intTipo : Integer;
        Text001 : TextConst ENU='Period: %1 to %2',ESP='Periodo: %1 al %2';
        CompanyInformation : Record "Company Information";
        SumaCostAmountActual : Decimal;

    procedure GetImporteComision(TableNo : Integer;numFactura : Code[20];numLinFactura : Integer) importe : Decimal;
    var
        refTabla : RecordRef;
        refCampoDoc : FieldRef;
        refCampoLin : FieldRef;
    begin
        importe:=0;

        IF NOT recTMPComision.GET(TableNo,numFactura,numLinFactura) THEN BEGIN
            refTabla.OPEN(TableNo);
            refCampoDoc := refTabla.FIELD(3);  //Document No.
            refCampoLin := refTabla.FIELD(4);  //Line No.

            refCampoDoc.SETRANGE(numFactura);
            refCampoLin.SETRANGE(numLinFactura);

            IF refTabla.FINDFIRST THEN
               BEGIN
                 importe:=refTabla.FIELD(50002).VALUE;
               END;

            recTMPComision.INIT;
            recTMPComision."Table ID"     := TableNo;
            recTMPComision."Document No." := numFactura;
            recTMPComision."Line No."     := numLinFactura;
            recTMPComision.INSERT;
        END;
    end;

    procedure GetCostesIndirectos(numItemMov : Integer) importe : Decimal;
    var
        recValueEntry : Record "Value Entry";
    begin
        importe:=0;

        recValueEntry.SETCURRENTKEY("Item Ledger Entry No.",Inventoriable);

        recValueEntry.SETRANGE("Item Ledger Entry No.",numItemMov);
        recValueEntry.SETRANGE(Inventoriable,FALSE);
        recValueEntry.CALCSUMS("Cost Amount (Non-Invtbl.)");
        importe := -recValueEntry."Cost Amount (Non-Invtbl.)";
    end;
}

