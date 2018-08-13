//HEB.189 ogarcia 02/11/2010
report 50040 "Item - Period Real Cost."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Item - Period Real Cost.rdlc';

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(Company_Name;RecCompanyInformation.Name)
            {
            }
            column(Date;FORMAT(TODAY,0,4))
            {
            }
            column(TxtFiltro;txtFiltro)
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
                        DataItemLink = Status = FIELD(Status),
                                       "Prod. Order No." = FIELD("Prod. Order No."),
                                       "Prod. Order Line No." = FIELD("Line No.");
                        DataItemTableView = SORTING(Status,"Prod. Order No.","Prod. Order Line No.","Line No.");

                        trigger OnAfterGetRecord();
                        begin
                            BOMRealCost:= 0;
                            BOMRealCostACY:=0;
                            BOMRealQty := 0;

                            "Manufacturing Abast Libary".CalcProdOrderComponentActCost("Prod. Order Component",BOMRealCost, BOMRealCostACY,BOMRealQty);
                            BOMRealCostTotal += BOMRealCost;
                        end;
                    }
                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
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

                            BOMRealCostTotal += BOMRealCost;
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        totalFabricado += "Prod. Order Line"."Finished Quantity";
                    end;
                }
                dataitem(Integer; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number=CONST(1));

                    trigger OnAfterGetRecord();
                    begin
                        RealOvHead:=0;
                        RealOvHeadACY:=0;

                        CostCalcMgt.CalcShareOfTotalCapCost("Prod. Order Line",ShareOfTotalCapCost);
                        "Manufacturing Abast Libary".CalcProdOrderLineOvhdCostNCF("Prod. Order Line",ShareOfTotalCapCost,GLSetup."Amount Rounding Precision",1,BOMRealCostTotal,BOMRealCostACY,RealOvHead,RealOvHeadACY);

                        totalCte1+= BOMRealCostTotal;
                        totalCte2+= RealOvHead;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    BOMRealCostTotal:=0;
                    BOMRealCostACY:=0;
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
                MaxIteration = 1;
                column(Item_No;Item."No.")
                {
                }
                column(Item_Description;Item.Description)
                {
                }
                column(totalFabricado;totalFabricado)
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
                    costeUnidad:=0;
                    totalCoste:=totalCte1 + totalCte2;

                    IF totalFabricado <> 0 THEN
                      costeUnidad:= totalCoste / totalFabricado;
                end;

                trigger OnPreDataItem();
                begin
                    IF totalFabricado = 0 THEN
                       CurrReport.BREAK;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                totalCte1:=0;
                totalCte2:=0;
                totalFabricado:=0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Opciones)
                {
                    field("Tipo OP";tipoOP)
                    {
                        Caption = 'Tipo OP';

                        trigger OnValidate();
                        begin
                            tipo := '';
                            IF tipoOP = tipoOP::Terminada THEN
                            BEGIN
                                tipo := 'Terminada';
                                //RequestOptionsForm.f1.EDITABLE(TRUE);
                                //RequestOptionsForm.f2.EDITABLE(TRUE);
                            END
                            ELSE
                            BEGIN
                                fechaIni:=0D;
                                fechaFin:=0D;
                                //RequestOptionsForm.f1.EDITABLE(FALSE);
                                //RequestOptionsForm.f2.EDITABLE(FALSE);
                            END;
                        end;
                    }
                    field("Fecha inicio";fechaIni)
                    {
                        Caption = 'Fecha inicio';
                        Editable = tipo = 'Terminada';
                    }
                    field("Fecha fin";fechaFin)
                    {
                        Caption = 'Fecha fin';
                        Editable = tipo = 'Terminada';
                    }
                }
            }
        }


        trigger OnOpenPage();
        begin
            tipo := '';
            IF tipoOP = tipoOP::Terminada THEN
              BEGIN
                tipo := 'Terminada';
                //RequestOptionsForm.f1.EDITABLE(TRUE);
                //RequestOptionsForm.f2.EDITABLE(TRUE);
              END
            ELSE
              BEGIN
                fechaIni:=0D;
                fechaFin:=0D;
                //RequestOptionsForm.f1.EDITABLE(FALSE);
                //RequestOptionsForm.f2.EDITABLE(FALSE);
              END;
        end;
    }

    labels
    {
        TituloCabeceraLbl = 'Item - Period Real Cost.';
        PageLbl = 'Page';
        ItemLbl = 'Item';
        FinishedQuantityLbl = 'Finished Quantity';
        TotalMaterialCostLbl = 'Total Material Cost';
        MatOverheadCostLbl = 'Mat. Overhead Cost';
        TotalLbl = 'Total';
        UnitCostLbl = 'Unit Cost';
    }

    trigger OnInitReport();
    begin
        RecCompanyInformation.GET;
    end;

    trigger OnPreReport();
    var
        TxtError1 : Label 'Debe elegir un tipo de OP';
        TxtError2 : Label 'Debe especificar un periodo para OP Terminadas';
    begin
        CASE tipoOP OF
           tipoOP::" ":
             ERROR (TxtError1);
           tipoOP::Lanzada:
             txtFiltro:= cadenaLanzadas;
           tipoOP::Terminada:
             BEGIN
               IF (fechaIni = 0D) OR (fechaFin = 0D) THEN
                  ERROR(TxtError2);
               txtFiltro:=STRSUBSTNO(cadenaTerminadas,fechaIni,fechaFin);
             END;
        END;
    end;

    var
        BOMRealCostTotal : Decimal;
        BOMRealCost : Decimal;
        BOMRealCostACY : Decimal;
        BOMRealQty : Decimal;
        BOMUnitCost : Decimal;
        CostCalcMgt : Codeunit "Cost Calculation Management";
        costeUnidad : Decimal;
        totalFabricado : Decimal;
        tipoOP : Option " ",Lanzada,Terminada;
        fechaIni : Date;
        fechaFin : Date;
        txtFiltro : Text[250];
        RealOvHead : Decimal;
        RealOvHeadACY : Decimal;
        GLSetup : Record "General Ledger Setup";
        ShareOfTotalCapCost : Decimal;
        totalCte1 : Decimal;
        totalCte2 : Decimal;
        totalCoste : Decimal;
        blnExcel : Boolean;
        intLinea : Integer;
        cadenaTerminadas : Label 'OP Terminadas desde el %1 al %2';
        cadenaLanzadas : Label 'OP Lanzadas';
        ColorFondo : Label '12566463';
        RecCompanyInformation : Record "Company Information";
        "Manufacturing Abast Libary" : Codeunit "Manufacturing Abast Libary";
        [InDataSet]
        tipo : Text[50];
}

