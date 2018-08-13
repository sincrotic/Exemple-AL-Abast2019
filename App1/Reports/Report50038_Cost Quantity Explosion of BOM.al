//HEB.XXX MT 21062018. Nuevo Report.
//HEB.188 MT 21062018. Aplicar iteración a productos de nivel 1
report 50038 "Cost Quantity Explosion of BOM"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Cost Quantity Explosion of BOM.rdl';
    Caption = 'Cost Quantity Explosion of BOM';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Manufacturing;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Search Description", "Inventory Posting Group";
            column(AsOfCalcDate; Text000 + FORMAT(CalcDate))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(ItemTableCaptionFilter; TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No_Item; "No.")
            {
            }
            column(Desc_Item; Description)
            {
            }
            dataitem(BOMLoop; Integer)
            {
                DataItemTableView = SORTING (Number);
                DataItemLinkReference = Item;

                column(ItemOverheadRate; Item."Overhead Rate")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(GeneralCostAmount; Item."Overhead Rate" * ProdBOM."Tamaño Lote")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(ProdBOMLotSize; ProdBOM."Tamaño Lote")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(precRef; precRef)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TotalCostAmount; (Item."Overhead Rate" * ProdBOM."Tamaño Lote") + decCoste)
                {
                    DecimalPlaces = 3 : 3;
                }

                dataitem("Integer"; Integer)
                {
                    DataItemTableView = SORTING (Number);
                    DataItemLinkReference = BOMLoop;
                    MaxIteration = 1;

                    column(FormatLevel; PADSTR('', Level, ' ') + FORMAT(Level))
                    {
                    }
                    column(BomCompLevelNo; BomComponent[Level]."No.")
                    {
                    }
                    column(BomCompLevelDesc; BomComponent[Level].Description)
                    {
                    }
                    column(BomCompLevelQty; BomComponent[Level].Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(BomCompLevelTotalLotQty; BomComponent[Level]."Cantidad total Lote")
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(BomCompLevelUOMCode; BomComponent[Level]."Unit of Measure Code")
                    {
                    }
                    column(decPrecio; decPrecio)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(decCoste; decCoste)
                    {
                        DecimalPlaces = 3 : 3;
                    }

                    trigger OnAfterGetRecord();
                    begin

                        BOMQty := Quantity[Level] * QtyPerUnitOfMeasure * BomComponent[Level].Quantity;
                        recItem.GET(BomComponent[Level]."No.");
                        CASE optPrecio OF
                          optPrecio::"Precio Ref. 1S" :
                            decPrecio := recItem."Unit List Price";
                        optPrecio::"Precio Ref. 2S" :
                            decPrecio := recItem."Unit List Price 2";
                        optPrecio::"Coste Unitario" :
                            decPrecio := recItem."Unit Cost";
                        optPrecio::"Último Coste Directo" :
                            decPrecio := recItem."Last Direct Cost";
                        END;
                        decCoste := decPrecio * BomComponent[Level]."Cantidad total Lote";
                    end;

                    trigger OnPostDataItem();
                    begin
                        Level := NextLevel;

                        IF CompItem."Production BOM No." <> '' THEN
                            UpperLevelItem := CompItem;
                    end;

                }

                trigger OnPreDataItem();
                begin
                    Level := 1;

                    ProdBOM.GET(Item."Production BOM No.");

                    VersionCode[Level] := VersionMgt.GetBOMVersion(Item."Production BOM No.", CalcDate, FALSE);
                    CLEAR(BomComponent);
                    BomComponent[Level]."Production BOM No." := Item."Production BOM No.";
                    BomComponent[Level].SETRANGE("Production BOM No.", Item."Production BOM No.");
                    BomComponent[Level].SETRANGE("Version Code", VersionCode[Level]);
                    BomComponent[Level].SETFILTER("Starting Date", '%1|..%2', 0D, CalcDate);
                    BomComponent[Level].SETFILTER("Ending Date", '%1|%2..', 0D, CalcDate);
                    NoList[Level] := Item."No.";
                    Quantity[Level] :=
                      UOMMgt.GetQtyPerUnitOfMeasure(Item, Item."Base Unit of Measure") /
                      UOMMgt.GetQtyPerUnitOfMeasure(
                        Item,
                        VersionMgt.GetBOMUnitOfMeasure(
                          Item."Production BOM No.", VersionCode[Level]));

                    UpperLevelItem := Item;

                end;

                trigger OnAfterGetRecord();
                var
                    BomItem: Record Item;
                begin
                    WHILE BomComponent[Level].NEXT = 0 DO
                    BEGIN
                        Level := Level - 1;
                        IF Level < 1 THEN
                            CurrReport.BREAK;
                        IF NOT UpperLevelItem.GET(NoList[Level]) THEN
                            UpperLevelItem."Production BOM No." := NoList[Level];
                        BomComponent[Level].SETRANGE("Production BOM No.", UpperLevelItem."Production BOM No.");
                        BomComponent[Level].SETRANGE("Version Code", VersionCode[Level]);
                    END;

                    NextLevel := Level;

                    CLEAR(CompItem);
                    QtyPerUnitOfMeasure := 1;
                    CASE BomComponent[Level].Type OF
                      BomComponent[Level].Type::Item :
                    BEGIN
                        CompItem.GET(BomComponent[Level]."No.");
                        //-188
                        //Se elimina el codigo que recorre los subniveles
                        //+188
                        IF Level > 1 THEN BEGIN
                            IF BomItem.GET(BomComponent[Level - 1]."No.") THEN BEGIN
                                QtyPerUnitOfMeasure :=
                                UOMMgt.GetQtyPerUnitOfMeasure(BomItem, BomComponent[Level - 1]."Unit of Measure Code")
                                /
                                UOMMgt.GetQtyPerUnitOfMeasure(
                                  BomItem, VersionMgt.GetBOMUnitOfMeasure(BomItem."Production BOM No.", VersionCode[Level]));
                            END;
                        END;
                    END;

                    BomComponent[Level].Type::"Production BOM" :
                    BEGIN
                        ProdBOM.GET(BomComponent[Level]."No.");
                        NextLevel := Level + 1;
                        CLEAR(BomComponent[NextLevel]);
                        NoList[NextLevel] := ProdBOM."No.";
                        VersionCode[NextLevel] := VersionMgt.GetBOMVersion(ProdBOM."No.", CalcDate, FALSE);
                        BomComponent[NextLevel].SETRANGE("Production BOM No.", NoList[NextLevel]);
                        BomComponent[NextLevel].SETRANGE("Version Code", VersionCode[NextLevel]);
                        BomComponent[NextLevel].SETFILTER("Starting Date", '%1|..%2', 0D, CalcDate);
                        BomComponent[NextLevel].SETFILTER("Ending Date", '%1|%2..', 0D, CalcDate);
                    END;

                    END;

                    IF NextLevel <> Level THEN
                        Quantity[NextLevel] := BomComponent[NextLevel - 1].Quantity * QtyPerUnitOfMeasure * Quantity[Level];

                    IF ProdBOM."Tamaño Lote" = 0 THEN
                        ERROR('El tamaño de Lote en L.Mat. no esta definido para %1 - %2', ProdBOM."No.", ProdBOM.Description);

                    precRef := ((Item."Overhead Rate" * ProdBOM."Tamaño Lote") + decCoste) / ProdBOM."Tamaño Lote";

                    IF blnActualizar THEN BEGIN
                        CASE optPrecio OF
                            optPrecio::"Precio Ref. 1S" :
                            BEGIN
                                Item."Unit List Price" := ((Item."Overhead Rate" * ProdBOM."Tamaño Lote") + decCoste) / ProdBOM."Tamaño Lote";
                            END;
                            optPrecio::"Precio Ref. 2S" :
                            BEGIN
                                Item."Unit List Price 2" := ((Item."Overhead Rate" * ProdBOM."Tamaño Lote") + decCoste) / ProdBOM."Tamaño Lote";
                            END;
                        END;
                        Item.MODIFY;
                    END;

                end;

            }

            trigger OnPreDataItem();
            begin
                ItemFilter := Item.GETFILTERS;

                SETFILTER("Production BOM No.", '<>%1', '');
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
                    field(CalcDate;CalcDate)
                    {
                        Caption = 'Calculation Date';
                    }
                    field(optPrecio;optPrecio)
                    {
                        Caption = 'Reference Price';
                    }
                    field(blnActualizar;blnActualizar)
                    {
                        Caption = 'Update Item Price';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            CalcDate := WORKDATE;
        end;

        trigger OnOpenPage();
        begin
            IF NOT(optPrecio IN [optPrecio::"Precio Ref. 1S", optPrecio::"Precio Ref. 2S"]) THEN
                blnActualizar := FALSE;
        end;

        //-MT 20062018. Controla que se informe Item No. como parámetro.
        trigger OnQueryClosePage(CloseAction: Action): Boolean;
        begin
            if not (CloseAction in [ACTION::Cancel]) then
                if Item.GetFilter("No.") = '' then
                    Error(Text001);
            exit(true)        
        end;
        //+MT 20062018
    }

    labels
    {
        TitleLbl = 'Quantity Explosion of BOM';
        PaginaLbl = 'Page';
        LevelLbl = 'Level';
        NoLbl = 'No.';
        DescriptionLbl = 'Description';
        BOMQtyLbl = 'BOM Qty.';
        TotalBomLotQtyLbl = 'Total BOM Lot Quantity';
        UOMCodeLbl = 'Unit of Measure Code';
        ReferencePriceLbl = 'Reference Price';
        CostAmountLbl = 'Cost Amount';
        SubtotalLbl = 'Subtotal';
        GeneralCostLbl = 'General Cost';
        TotalLbl = 'Total';
    }

    var
        ProdBOM: Record "Production BOM Header";
        BomComponent: array[99] of Record "Production BOM Line";
        UpperLevelItem: Record Item;
        CompItem: Record Item;
        recItem: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgt: Codeunit VersionManagement;
        ItemFilter: Text[250];
        CalcDate: Date;
        NoList: array[99] of Code[20];
        VersionCode: array[99] of Code[10];
        Quantity: array[99] of Decimal;
        QtyPerUnitOfMeasure: Decimal;
        Level: Integer;
        NextLevel: Integer;
        BOMQty: Decimal;
        "TamañoLote": Decimal;
        CadTotalLote: Decimal;
        decPrecio: Decimal;
        decCoste: Decimal;
        optPrecio: Option "Precio Ref. 1S", "Precio Ref. 2S", "Coste Unitario", "Último Coste Directo";
        blnActualizar: Boolean;
        precRef: Decimal;
        Text000: Label 'As of ';
        //-MT 20062018
        Text001: Label 'You must provide an Item No.';
        //+MT 20062018
        "---": Integer;
        NoListType: array[99] of Option " ", Item, "Production BOM";

}

