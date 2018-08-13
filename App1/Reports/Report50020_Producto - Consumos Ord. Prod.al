//HEB.146 MT 05072018. Nuevo report.
report 50020 "Producto - Consumos Ord. Prod"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Producto - Consumos Ord. Prod.rdlc';

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(CompanyName;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(TodayFormatted;FORMAT(TODAY, 0, 4))
            {
            }
            column(ItemNo;"No.")
            {
            }
            column(ItemDescription;Description)
            {
            }
            column(totalFabricado;totalFabricado)
            {
            }
            column(txtFiltro;txtFiltro)
            {
            }
            dataitem("Production Order";"Production Order")
            {
                DataItemLink = "Source No."=FIELD("No.");
                DataItemTableView = SORTING("Source Type","Source No.")
                                    WHERE("Source Type"=CONST(Item));
                dataitem("Prod. Order Line";"Prod. Order Line")
                {
                    DataItemLink = Status=FIELD(Status),
                                   "Prod. Order No."=FIELD("No.");
                    DataItemTableView = SORTING(Status,"Prod. Order No.","Line No.")
                                        WHERE("Planning Level Code"=CONST(0));
                    dataitem("Prod. Order Component";"Prod. Order Component")
                    {
                        DataItemLink = Status=FIELD(Status),
                                       "Prod. Order No."=FIELD("Prod. Order No."),
                                       "Prod. Order Line No."=FIELD("Line No.");
                        DataItemTableView = SORTING(Status,"Prod. Order No.","Prod. Order Line No.","Line No.");

                        trigger OnAfterGetRecord();
                        begin
                            BOMRealCost:= 0;
                            BOMRealCostACY:=0;
                            BOMRealQty := 0;

                            //CostCalcMgt.CalcProdOrderComponentActCost("Prod. Order Component",BOMRealCost,BOMRealCostACY,BOMRealQty);
                            "Manufacturing Abast Libary".CalcProdOrderComponentActCost("Prod. Order Component",BOMRealCost,BOMRealCostACY,BOMRealQty);

                            if not MemInt.Get("Item No.") then begin
                                MemInt.Init;
                                MemInt."Code 1" := "Item No.";
                                MemInt."Decimal 1" := BOMRealQty;
                                MemInt."Decimal 3" := BOMRealCost;
                                MemInt."Text 80" := Description;
                                MemInt.Insert;
                            end else begin
                                MemInt."Decimal 1" += BOMRealQty;
                                MemInt."Decimal 3" += BOMRealCost;
                                MemInt.Modify;
                            end;

                            BOMRealCostTotal += BOMRealCost;
                        end;
                    }
                    dataitem("Item Ledger Entry";"Item Ledger Entry")
                    {
                        CalcFields = "Descripción Producto","Cost Amount (Actual)";
                        DataItemLink = "Order No."=FIELD("Prod. Order No."),
                                       "Order Line No."=FIELD("Line No.");
                        DataItemTableView = SORTING("Order Type","Order No.","Order Line No.","Entry Type","Prod. Order Comp. Line No.")
                                            WHERE("Entry Type"=CONST(Consumption),
                                                  "Prod. Order Comp. Line No."=CONST(0));

                        trigger OnAfterGetRecord();
                        begin

                            BOMRealQty := Quantity*-1;
                            BOMRealCost:= "Cost Amount (Actual)"*-1;


                            if not MemInt.Get("Item No.") then begin
                                MemInt.Init;
                                MemInt."Code 1" := "Item No.";
                                MemInt."Decimal 1" := BOMRealQty;
                                MemInt."Decimal 3" := BOMRealCost;
                                MemInt."Text 80" := "Item Ledger Entry"."Descripción Producto";
                                MemInt.Insert;
                            end else begin
                                MemInt."Decimal 1" += BOMRealQty;
                                MemInt."Decimal 3" += BOMRealCost;
                                MemInt.Modify;
                            end;

                            BOMRealCostTotal += BOMRealCost;
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        totalFabricado+="Prod. Order Line"."Finished Quantity";
                    end;
                }
                dataitem(Integer;Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number=CONST(1));

                    trigger OnAfterGetRecord();
                    begin
                        RealOvHead := 0;
                        RealOvHeadACY := 0;

                        CostCalcMgt.CalcShareOfTotalCapCost("Prod. Order Line",ShareOfTotalCapCost);
                        // CostCalcMgt.CalcProdOrderLineOvhdCost("Prod. Order Line",ShareOfTotalCapCost,
                        //                                      GLSetup."Amount Rounding Precision",1,
                        //                                      BOMRealCostTotal,BOMRealCostACY,RealOvHead,RealOvHeadACY);

                        totalCte1 += BOMRealCostTotal;
                        totalCte2 += RealOvHead;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    BOMRealCostTotal := 0;
                    BOMRealCostACY := 0;
                end;

                trigger OnPreDataItem();
                begin

                    CASE tipoOP OF
                        tipoOP::Lanzada:
                           SETRANGE(Status,"Production Order".Status::Released);
                        tipoOP::Terminada:
                          BEGIN
                            SETRANGE(Status,"Production Order".Status::Finished);
                            SETRANGE("Finished Date",fechaIni,fechaFin);
                          END;
                    END;
                end;
            }
            dataitem(Impresion;Integer)
            {
                DataItemTableView = SORTING(Number);
                column(MemInt_NoProducto;MemInt."Code 1")
                {
                }
                column(Memint_Cantidad;MemInt."Decimal 1")
                {
                }
                column(MemInt_UnidadMedida;MemInt."Code 2")
                {
                }
                column(MemInt_Importe;MemInt."Decimal 2")
                {
                }
                column(MemInt_Coste;MemInt."Decimal 3")
                {
                }
                column(MemInt_Descripcion;MemInt."Text 80")
                {
                }
                column(MemInt_Descripcion2;MemInt."Text 250")
                {
                }
                column(BOMUnitCost;BOMUnitCost)
                {
                }
                column(totalCte1;totalCte1)
                {
                }
                column(totalCte2;totalCte2)
                {
                }
                column(totalCoste;totalCoste)
                {
                }
                column(costeUnidad;costeUnidad)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    BOMUnitCost := 0;
                    if Number = 1 then
                        MemInt.FindFirst
                    else
                        MemInt.Next;

                    if MemInt."Decimal 1" <> 0 then
                        BOMUnitCost := MemInt."Decimal 3" / MemInt."Decimal 1";

                    //-999
                    IF blnExcel THEN BEGIN
                        InsertaCeldaExcel(intLinea,1,MemInt."Code 1",FALSE,'',FALSE,'');
                        InsertaCeldaExcel(intLinea,2,MemInt."Text 80",FALSE,'',FALSE,'');
                        InsertaCeldaExcel(intLinea,3,FORMAT(MemInt."Decimal 1"),FALSE,'',FALSE,'');
                        InsertaCeldaExcel(intLinea,4,FORMAT(MemInt."Decimal 3"),FALSE,'',FALSE,'');
                        InsertaCeldaExcel(intLinea,5,FORMAT(BOMUnitCost),FALSE,'',FALSE,'');
                        intLinea+=1;
                    END;
                    //+999


                    //Impresion, Footer (3) - OnPreSection()
                    costeUnidad := 0;
                    totalCoste := totalCte1 + totalCte2;

                    IF totalFabricado <> 0 THEN
                       costeUnidad := totalCoste / totalFabricado;
                end;

                trigger OnPostDataItem();
                begin
                    //-999
                    IF blnExcel THEN BEGIN
                      intLinea+=1;
                      InsertaCeldaExcel(intLinea,3,'Coste total material',FALSE,'',FALSE,'');
                      InsertaCeldaExcel(intLinea,4,FORMAT(totalCte1),FALSE,'',FALSE,'');
                      InsertaCeldaExcel(intLinea+1,3,'Coste gen. mat.',FALSE,'',FALSE,'');
                      InsertaCeldaExcel(intLinea+1,4,FORMAT(totalCte2),FALSE,'',FALSE,'');
                      InsertaCeldaExcel(intLinea+3,3,'Total',TRUE,'',FALSE,'');
                      InsertaCeldaExcel(intLinea+3,4,FORMAT(totalCte1+totalCte2),FALSE,'',FALSE,'');
                      InsertaCeldaExcel(intLinea+3,5,FORMAT((totalCte1 + totalCte2)/totalFabricado),FALSE,'',FALSE,'');

                      //ExcelBuffer.CreateBook;
                      //ExcelBuffer.CreateSheet("Production Order"."No.",'',COMPANYNAME,USERID);
                      ExcelBuffer.GiveUserControl;
                      ExcelBuffer.DELETEALL;
                    END;
                    //+999
                end;

                trigger OnPreDataItem();
                begin
                    SetRange(Number,1,MemInt.Count());
                    //-999
                    IF blnExcel THEN BEGIN
                      InsertaCeldaExcel(1,1,Item."No.",TRUE,'',FALSE,'');
                      InsertaCeldaExcel(1,2,Item.Description,TRUE,'',FALSE,'');
                      InsertaCeldaExcel(2,2,'Cantidad terminada',TRUE,'',FALSE,'');
                      InsertaCeldaExcel(2,3,FORMAT(totalFabricado),TRUE,'',FALSE,'');
                      InsertaCeldaExcel(3,2,txtFiltro,FALSE,'',FALSE,'');
                      InsertaCeldaExcel(5,2,'Componente',TRUE,'',FALSE,'');
                      InsertaCeldaExcel(5,3,'Cantidad consumida',TRUE,'',FALSE,'');
                      InsertaCeldaExcel(5,4,'Coste',TRUE,'',FALSE,'');
                      InsertaCeldaExcel(5,5,'Coste unitario',TRUE,'',FALSE,'');
                      intLinea:=6;
                    END;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                totalCte1:=0;
                totalCte2:=0;
                totalFabricado:=0;

                MemInt.Reset;
                MemInt.DeleteAll;

                // CurrReport.PAGENO(1);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Prod. Order - Detailed Calc.")
                {
                    Caption = 'Prod. Order - Detailed Calc.';
                    field(tipoOP;tipoOP)
                    {
                        Caption = 'Production Order Type';
                    }
                    group(Period)
                    {
                        Caption = 'Period';
                        field(fechaIni;fechaIni)
                        {
                            Caption = 'Start Date';
                        }
                        field(fechaFin;fechaFin)
                        {
                            Caption = 'End Date';
                        }
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
        TiituloLbl = 'Item - Real Ord. Prod.';
        PaginaLbl = 'Page';
        CdadTerminadaLbl = 'Finished quantity';
        ComponenteLbl = 'Component';
        CdadConsumidaLbl = 'Consumed Quantity';
        CosteLbl = 'Cost';
        CosteUnitarioLbl = 'Unit Cost';
        TotalCosteMaterialLbl = 'Total Material Cost . . . . . . . . . . . . . . . . . . . . . . . . . .';
        CosteGeneralMaterialLbl = 'Mat. Overhead Cost . . . . . . . . . . . . . . . . . . . . . . . . .';
        TotalLbl = 'Total . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .';
    }

    trigger OnPreReport();
    begin
        CASE tipoOP OF
           tipoOP::" ":
             ERROR (error001);
           tipoOP::Lanzada:
             txtFiltro:= cadenaLanzadas;
           tipoOP::Terminada:
             BEGIN
               IF (fechaIni = 0D) OR (fechaFin=0D) THEN
                  ERROR(error002);
               txtFiltro:=STRSUBSTNO(cadenaTerminadas,fechaIni,fechaFin);
             END;
        END;
    end;

    var
        MemInt : Record MemIntAcumulados;
        GLSetup : Record "General Ledger Setup";
        ExcelBuffer : Record "Excel Buffer" temporary;
        CostCalcMgt : Codeunit "Cost Calculation Management";
        "Manufacturing Abast Libary" : Codeunit "Manufacturing Abast Libary";
        tipoOP : Option " ",Lanzada,Terminada;
        BOMRealCostTotal : Decimal;
        BOMRealCost : Decimal;
        BOMRealCostACY : Decimal;
        BOMRealQty : Decimal;
        BOMUnitCost : Decimal;
        costeUnidad : Decimal;
        totalFabricado : Decimal;
        fechaIni : Date;
        fechaFin : Date;
        txtFiltro : Text[250];
        RealOvHead : Decimal;
        RealOvHeadACY : Decimal;
        ShareOfTotalCapCost : Decimal;
        totalCte1 : Decimal;
        totalCte2 : Decimal;
        totalCoste : Decimal;
        blnExcel : Boolean;
        intLinea : Integer;
        cadenaTerminadas : Label 'Finished PO from %1 to %2';
        cadenaLanzadas : Label 'Released PO';
        error001 : Label 'You must choose a PO Type';
        error002 : Label 'You must specify a period for Finished POs';

    procedure InsertaCeldaExcel(fila : Integer;columna : Integer;texto : Text[1024];negrita : Boolean;formato : Text[30];esFormula : Boolean;bgColor : Text[30]);
    begin
        //-999
        ExcelBuffer.INIT;
        ExcelBuffer.VALIDATE("Row No.",fila);
        ExcelBuffer.VALIDATE("Column No.",columna);
        IF esFormula THEN
          ExcelBuffer.SetFormula(texto)
        ELSE
          ExcelBuffer."Cell Value as Text":=texto;
        ExcelBuffer.Bold:=negrita;
        ExcelBuffer.NumberFormat:=formato;
        // IF bgColor <> '' THEN EVALUATE(ExcelBuffer."Background Color",bgColor);
        // ExcelBuffer.INSERT;
        //+999
    end;
}

