//HEB.191 MT 09072018. Nuevo report
report 50042 "P.Acabado-Comparativa Consumos"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/P.Acabado-Comparativa Consumos.rdlc';
    Caption = 'Item - Real vs Teoric Ord. Prod.';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Manufacturing;

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.","Technical Family Code";
            
            dataitem("Production Order";"Production Order")
            {
                DataItemLink = "Source No."=FIELD("No.");
                DataItemTableView = SORTING("Source Type","Source No.")WHERE("Source Type"=CONST(Item));

                dataitem("Prod. Order Line";"Prod. Order Line")
                {
                    DataItemLink = Status=FIELD(Status),"Prod. Order No."=FIELD("No.");
                    DataItemTableView = SORTING(Status,"Prod. Order No.","Line No.")WHERE("Planning Level Code"=CONST(0));
                    
                    dataitem("Prod. Order Component";"Prod. Order Component")
                    {
                        DataItemLink = Status=FIELD(Status),"Prod. Order No."=FIELD("Prod. Order No."),"Prod. Order Line No."=FIELD("Line No.");
                        DataItemTableView = SORTING(Status,"Prod. Order No.","Prod. Order Line No.","Line No.");

                        trigger OnAfterGetRecord();
                        begin
                            BOMRealCost:= 0;
                            BOMRealCostACY:=0;
                            BOMRealQty := 0;

                            "Manufacturing Abast Libary".CalcProdOrderComponentActCost("Prod. Order Component",BOMRealCost,BOMRealCostACY,BOMRealQty);
                            
                            IF NOT MemInt.GET("Item No.") THEN
                             BEGIN
                               MemInt.INIT;
                               MemInt."Code 1":= "Item No.";
                               MemInt."Decimal 1" := BOMRealQty;
                               MemInt."Decimal 2" := "Expected Quantity";
                               MemInt."Decimal 3" := BOMRealCost;
                               MemInt."Text 80"  := Description;
                               MemInt.INSERT;
                             END
                            ELSE
                             BEGIN
                               MemInt."Decimal 1"     += BOMRealQty;
                               MemInt."Decimal 2"      += "Expected Quantity";
                               MemInt."Decimal 3"      += BOMRealCost;
                               MemInt.MODIFY;
                             END;

                            BOMRealCostTotal+=BOMRealCost;
                            IF BOMRealQty <> 0 THEN
                              BOMTeoricCostTotal += (BOMRealCost/BOMRealQty) * "Expected Quantity"
                             ELSE
                              BOMTeoricCostTotal += "Expected Quantity" * "Unit Cost";
                        end;
                    }
                    dataitem("Item Ledger Entry";"Item Ledger Entry")
                    {
                        DataItemLink = "Order No."=FIELD("Prod. Order No."),
                                       "Order Line No."=FIELD("Line No.");
                        DataItemTableView = SORTING("Order No.","Order Line No.","Entry Type","Prod. Order Comp. Line No.")
                                            WHERE("Entry Type"=CONST(Consumption),
                                                  "Prod. Order Comp. Line No."=CONST(0));
                        CalcFields = "Descripción Producto","Cost Amount (Actual)";

                        trigger OnAfterGetRecord();
                        begin
                            BOMRealQty := Quantity*-1;
                            BOMRealCost:= "Cost Amount (Actual)"*-1;

                            IF NOT MemInt.GET("Item No.") THEN
                             BEGIN
                               MemInt.INIT;
                               MemInt."Code 1" := "Item No.";
                               MemInt."Decimal 1" := BOMRealQty;
                               MemInt."Decimal 3" := BOMRealCost;
                               MemInt."Text 80" := "Item Ledger Entry"."Descripción Producto";
                               MemInt.INSERT;
                             END
                            ELSE
                             BEGIN
                               MemInt."Decimal 1" += BOMRealQty;
                               MemInt."Decimal 3" += BOMRealCost;
                               MemInt.MODIFY;
                             END;

                            BOMRealCostTotal+=BOMRealCost;
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
                        RealOvHead:=0;
                        RealOvHeadACY:=0;

                        CostCalcMgt.CalcShareOfTotalCapCost("Prod. Order Line",ShareOfTotalCapCost);
                        "Manufacturing Abast Libary".CalcProdOrderLineOvhdCost("Prod. Order Line",ShareOfTotalCapCost,GLSetup."Amount Rounding Precision",1,BOMRealCostTotal,BOMRealCostACY,RealOvHead,RealOvHeadACY);

                        totalCte1+= BOMRealCostTotal;
                        totalCte2+= RealOvHead;

                        //Valores Costes Esperados
                        TeoricOvHead:=0;
                        TeoricOvHeadACY:=0;

                        "Manufacturing Abast Libary".CalcProdOrderLineOvhdCost("Prod. Order Line",ShareOfTotalCapCost,GLSetup."Amount Rounding Precision",1,BOMTeoricCostTotal,BOMRealCostACY,TeoricOvHead,TeoricOvHeadACY);
                        totalTCte1+= BOMTeoricCostTotal;
                        totalTCte2+= TeoricOvHead;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    BOMRealCostTotal:=0;
                    BOMRealCostACY:=0;
                    BOMTeoricCostTotal:=0;
                    totalOF += 1;
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

                column(CompanyName;COMPANYPROPERTY.DISPLAYNAME)
                {
                }
                column(TodayFormatted;FORMAT(TODAY, 0, 4))
                {
                }
                column(ItemNo;Item."No.")
                {
                }
                column(ItemDescription;Item.Description)
                {
                }
                column(totalFabricado;totalFabricado)
                {
                }
                column(tamLote;tamLote)
                {
                }
                column(cantidadLotes;STRSUBSTNO('%1 (%2)',totalOF,numLotes))
                {
                }
                column(txtFiltro;txtFiltro)
                {
                }
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
                column(QtyTeorica;QtyTeorica)
                {
                }
                column(QtyReal;QtyReal)
                {
                }
                column(PorcenDesv;PorcenDesv)
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
                    BOMUnitCost:=0;
                    IF Number = 1 THEN
                      MemInt.FINDFIRST
                     ELSE
                      MemInt.NEXT;

                    IF MemInt."Decimal 1" <> 0 THEN
                      BOMUnitCost := MemInt."Decimal 3" / MemInt."Decimal 1";

                    QtyTeorica:=0;
                    QtyReal:=0;
                    PorcenDesv:=0;

                    IF totalOF <> 0 THEN
                     BEGIN
                        QtyTeorica := ROUND(MemInt."Decimal 2" / totalOF,0.01);
                        QtyReal    := ROUND(MemInt."Decimal 1" / totalOF,0.01);
                        IF QtyReal <> 0 THEN
                           PorcenDesv :=  100 - (ROUND((QtyTeorica/ QtyReal),0.01)*100)
                          ELSE
                           PorcenDesv := 100;
                     END;
                    
                    //-999
                    // IF blnExcel THEN BEGIN
                    //  InsertaCeldaExcel(intLinea,1,MemInt."Code 1",FALSE,'',FALSE,'');
                    //  InsertaCeldaExcel(intLinea,2,MemInt."Text 80",FALSE,'',FALSE,'');
                    //  InsertaCeldaExcel(intLinea,3,FORMAT(QtyTeorica),FALSE,'',FALSE,'');
                    //  InsertaCeldaExcel(intLinea,4,FORMAT(QtyReal),FALSE,'',FALSE,'');
                    //  InsertaCeldaExcel(intLinea,5,FORMAT(PorcenDesv),FALSE,'',FALSE,'');
                    //  InsertaCeldaExcel(intLinea,6,FORMAT(MemInt."Decimal 1"),FALSE,'',FALSE,'');
                    //  InsertaCeldaExcel(intLinea,7,FORMAT(MemInt."Decimal 3"),FALSE,'',FALSE,'');
                    //  InsertaCeldaExcel(intLinea,8,FORMAT(BOMUnitCost),FALSE,'',FALSE,'');
                    //  intLinea+=1;
                    // END;
                    //+999

                    //OnPreSection()
                    costeUnidad:=0;
                    totalCoste:=totalCte1 + totalCte2;
                    totalCosteT:=totalTCte1 + totalTCte2;

                    IF totalFabricado<>0 THEN
                      BEGIN
                       costeUnidad:= totalCoste / totalFabricado;
                       costeUnidadT:= totalCosteT / totalFabricado;
                      END;
                end;

                trigger OnPostDataItem();
                begin
                    //-999
                    // IF (totalFabricado <> 0) AND (blnExcel) THEN BEGIN
                    //   intLinea+=1;
                    //   InsertaCeldaExcel(intLinea,3,'Coste total material',FALSE,'',FALSE,'');
                    //   InsertaCeldaExcel(intLinea,4,FORMAT(totalCte1),FALSE,'',FALSE,'');
                    //   InsertaCeldaExcel(intLinea+1,3,'Coste gen. mat.',FALSE,'',FALSE,'');
                    //   InsertaCeldaExcel(intLinea+1,4,FORMAT(totalCte2),FALSE,'',FALSE,'');
                    //   InsertaCeldaExcel(intLinea+3,3,'Total',TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(intLinea+3,4,FORMAT(totalCte1+totalCte2),FALSE,'',FALSE,'');
                    //   InsertaCeldaExcel(intLinea+3,5,FORMAT((totalCte1 + totalCte2)/totalFabricado),FALSE,'',FALSE,'');

                    //  ExcelBuffer.CreateBook;
                    //  ExcelBuffer.CreateSheet(Item."No.",'',COMPANYNAME,USERID);
                    //  ExcelBuffer.GiveUserControl;
                    //  ExcelBuffer.DELETEALL;
                    // END;
                    //+999
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE(Number,1,MemInt.COUNT());

                    IF tamLote <> 0 THEN
                       numLotes := ROUND((totalFabricado / tamLote),1)
                      ELSE
                       numLotes := 1;

                    //-999
                    // IF blnExcel THEN BEGIN
                    //   InsertaCeldaExcel(1,1,Item."No.",TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(1,2,Item.Description,TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(2,2,'Cantidad terminada',TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(2,3,FORMAT(totalFabricado),TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(3,2,'Tamaño Lote',TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(3,3,FORMAT(tamLote),TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(4,2,'Cantidad Lotes',TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(4,3,STRSUBSTNO('%1 (%2)',totalOF,numLotes),TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(5,2,txtFiltro,FALSE,'',FALSE,'');

                    //   InsertaCeldaExcel(7,2,'Componente',TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(7,3,'Cantidad Teórica',TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(7,4,'Cantidad Real',TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(7,5,'% Desviación',TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(7,6,'Cantidad consumida',TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(7,7,'Total Coste',TRUE,'',FALSE,'');
                    //   InsertaCeldaExcel(7,8,'Coste unitario',TRUE,'',FALSE,'');
                    //   intLinea:=8;
                    // END;
                end;
            }

            trigger OnAfterGetRecord();
            var
                recLMat : Record "Production BOM Header";
            begin
                totalCte1:=0;
                totalCte2:=0;
                totalTCte1:=0;
                totalTCte2:=0;
                totalOF := 0;

                totalFabricado:=0;
                tamLote := 0;

                MemInt.RESET;
                MemInt.DELETEALL;

                ExcelBuffer.RESET;
                ExcelBuffer.DELETEALL;

                //CurrReport.PAGENO(1);

                //Buscamos la Ficha de LM para tanaño lote
                  IF "Production BOM No." <> '' THEN
                     BEGIN
                       recLMat.GET("Production BOM No.");
                       tamLote := recLMat."Tamaño Lote";
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
                group(Options)
                {
                    Caption = 'Options';
                    field(tipoOP;tipoOP)
                    {
                        Caption = 'PO Type';
                    }
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

        actions
        {
        }
    }

    labels
    {
        TituloLbl = 'Item - Real Ord. Prod.';
        PaginaLbl = 'Page';
        CdadTerminadaLbl = 'Finished quantity';
        TamañoLoteLbl = 'Lot Size';
        CdadLotesLbl = 'Lot Quantity';
        ComponenteLbl = 'Component';
        CantidadTeoricaLbl = 'Theorical\nQuantity';
        CantidadRealLbl = 'Actual\nQuantity';
        PorcentajeDesviadoLbl = 'Dev.\n%';
        CdadConsumidaLbl = 'Consumed\nQuantity';
        CosteLbl = 'Cost';
        CosteUnitarioLbl = 'Unit\nCost';
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
        BOMRealCostTotal : Decimal;
        BOMTeoricCostTotal : Decimal;
        BOMRealCost : Decimal;
        BOMRealCostACY : Decimal;
        BOMRealQty : Decimal;
        BOMUnitCost : Decimal;
        "Manufacturing Abast Libary" : Codeunit "Manufacturing Abast Libary";
        CostCalcMgt : Codeunit "Cost Calculation Management";
        costeUnidad : Decimal;
        costeUnidadT : Decimal;
        totalFabricado : Decimal;
        MemInt : Record MemIntAcumulados temporary;
        ExcelBuffer : Record "Excel Buffer" temporary;
        tipoOP : Option " ",Lanzada,Terminada;
        fechaIni : Date;
        fechaFin : Date;
        txtFiltro : Text[250];
        RealOvHead : Decimal;
        RealOvHeadACY : Decimal;
        TeoricOvHead : Decimal;
        TeoricOvHeadACY : Decimal;
        GLSetup : Record "General Ledger Setup";
        ShareOfTotalCapCost : Decimal;
        totalCte1 : Decimal;
        totalCte2 : Decimal;
        totalCoste : Decimal;
        totalTCte1 : Decimal;
        totalTCte2 : Decimal;
        totalCosteT : Decimal;
        blnExcel : Boolean;
        intLinea : Integer;
        tamLote : Decimal;
        numLotes : Integer;
        QtyTeorica : Decimal;
        QtyReal : Decimal;
        PorcenDesv : Decimal;
        totalOF : Integer;
        cadenaTerminadas : Label 'OP Finished from %1 to %2';
        cadenaLanzadas : Label 'OP Released';
        error001 : Label 'You must choose a PO Type';
        error002 : Label 'You must specify a period for Finished POs';

    // posar al layout
    procedure InsertaCeldaExcel(fila : Integer;columna : Integer;texto : Text[1024];negrita : Boolean;formato : Text[30];esFormula : Boolean;bgColor : Text[30]);
    begin
        // //-999
        // ExcelBuffer.INIT;
        // ExcelBuffer.VALIDATE("Row No.",fila);
        // ExcelBuffer.VALIDATE("Column No.",columna);
        // IF esFormula THEN
        // ExcelBuffer.SetFormula(texto)
        // ELSE
        // ExcelBuffer."Cell Value as Text":=texto;
        // ExcelBuffer.Bold:=negrita;
        // ExcelBuffer.NumberFormat:=formato;
        // IF bgColor <> '' THEN EVALUATE(ExcelBuffer."Background Color",bgColor);
        // ExcelBuffer.INSERT;
        // //+999
    end;
}