//HEB.123 MT 28052018. Muestra la cantidad total lote L.M. ("TotalBomLotQty") de cada línea.
report 50062 "Quantity Explosion of BOM Ext"
{
    // version NAVW111.00
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Manufacturing;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Quantity Explosion of BOM.rdl';
    Caption = 'Quantity Explosion of BOM';

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.","Search Description","Inventory Posting Group";
            column(AsOfCalcDate;Text000 + FORMAT(CalculateDate))
            {
            }
            column(CompanyName;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(TodayFormatted;FORMAT(TODAY,0,4))
            {
            }
            column(ItemTableCaptionFilter;TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter;ItemFilter)
            {
            }
            column(No_Item;"No.")
            {
            }
            column(Desc_Item;Description)
            {
            }
            column(QtyExplosionofBOMCapt;QtyExplosionofBOMCaptLbl)
            {
            }
            column(CurrReportPageNoCapt;CurrReportPageNoCaptLbl)
            {
            }
            column(BOMQtyCaption;BOMQtyCaptionLbl)
            {
            }
            column(BomCompLevelQtyCapt;BomCompLevelQtyCaptLbl)
            {
            }
            column(BomCompLevelDescCapt;BomCompLevelDescCaptLbl)
            {
            }
            column(BomCompLevelNoCapt;BomCompLevelNoCaptLbl)
            {
            }
            column(LevelCapt;LevelCaptLbl)
            {
            }
            column(BomCompLevelUOMCodeCapt;BomCompLevelUOMCodeCaptLbl)
            {
            }
            dataitem(BOMLoop;Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(Integer;Integer)
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(BomCompLevelNo;BomComponent[Level]."No.")
                    {
                    }
                    column(BomCompLevelDesc;BomComponent[Level].Description)
                    {
                    }
                    column(BOMQty;BOMQty)
                    {
                        DecimalPlaces = 0:5;
                    }
                    //-HEB.123
                    column(TotalBOMLotQty;BomComponent[Level]."Cantidad total Lote")
                    {
                        DecimalPlaces = 0:5;
                    }
                    //+HEB.123
                    column(FormatLevel;PADSTR('',Level,' ') + FORMAT(Level))
                    {
                    }
                    column(BomCompLevelQty;BomComponent[Level].Quantity)
                    {
                        DecimalPlaces = 0:5;
                    }
                    column(BomCompLevelUOMCode;BomComponent[Level]."Unit of Measure Code")
                    {
                        //DecimalPlaces = 0:5;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        BOMQty := Quantity[Level] * QtyPerUnitOfMeasure * BomComponent[Level].Quantity;
                    end;

                    trigger OnPostDataItem();
                    begin
                        Level := NextLevel;
                    end;
                }

                trigger OnAfterGetRecord();
                var
                    BomItem : Record Item;
                begin
                    WHILE BomComponent[Level].NEXT = 0 DO BEGIN
                      Level := Level - 1;
                      IF Level < 1 THEN
                        CurrReport.BREAK;
                    END;

                    NextLevel := Level;
                    CLEAR(CompItem);
                    QtyPerUnitOfMeasure := 1;
                    CASE BomComponent[Level].Type OF
                      BomComponent[Level].Type::Item:
                        BEGIN
                          CompItem.GET(BomComponent[Level]."No.");
                          IF CompItem."Production BOM No." <> '' THEN BEGIN
                            ProdBOM.GET(CompItem."Production BOM No.");
                            IF ProdBOM.Status = ProdBOM.Status::Closed THEN
                              CurrReport.SKIP;
                            NextLevel := Level + 1;
                            IF Level > 1 THEN
                              IF (NextLevel > 50) OR (BomComponent[Level]."No." = NoList[Level - 1]) THEN
                                ERROR(ProdBomErr,50,Item."No.",NoList[Level],Level);
                            CLEAR(BomComponent[NextLevel]);
                            NoListType[NextLevel] := NoListType[NextLevel]::Item;
                            NoList[NextLevel] := CompItem."No.";
                            VersionCode[NextLevel] :=
                              VersionMgt.GetBOMVersion(CompItem."Production BOM No.",CalculateDate,TRUE);
                            BomComponent[NextLevel].SETRANGE("Production BOM No.",CompItem."Production BOM No.");
                            BomComponent[NextLevel].SETRANGE("Version Code",VersionCode[NextLevel]);
                            BomComponent[NextLevel].SETFILTER("Starting Date",'%1|..%2',0D,CalculateDate);
                            BomComponent[NextLevel].SETFILTER("Ending Date",'%1|%2..',0D,CalculateDate);
                          END;
                          IF Level > 1 THEN
                            IF BomComponent[Level - 1].Type = BomComponent[Level - 1].Type::Item THEN
                              IF BomItem.GET(BomComponent[Level - 1]."No.") THEN
                                QtyPerUnitOfMeasure :=
                                  UOMMgt.GetQtyPerUnitOfMeasure(BomItem,BomComponent[Level - 1]."Unit of Measure Code") /
                                  UOMMgt.GetQtyPerUnitOfMeasure(
                                    BomItem,VersionMgt.GetBOMUnitOfMeasure(BomItem."Production BOM No.",VersionCode[Level]));
                        END;
                      BomComponent[Level].Type::"Production BOM":
                        BEGIN
                          ProdBOM.GET(BomComponent[Level]."No.");
                          IF ProdBOM.Status = ProdBOM.Status::Closed THEN
                            CurrReport.SKIP;
                          NextLevel := Level + 1;
                          IF Level > 1 THEN
                            IF (NextLevel > 50) OR (BomComponent[Level]."No." = NoList[Level - 1]) THEN
                              ERROR(ProdBomErr,50,Item."No.",NoList[Level],Level);
                          CLEAR(BomComponent[NextLevel]);
                          NoListType[NextLevel] := NoListType[NextLevel]::"Production BOM";
                          NoList[NextLevel] := ProdBOM."No.";
                          VersionCode[NextLevel] := VersionMgt.GetBOMVersion(ProdBOM."No.",CalculateDate,TRUE);
                          BomComponent[NextLevel].SETRANGE("Production BOM No.",NoList[NextLevel]);
                          BomComponent[NextLevel].SETRANGE("Version Code",VersionCode[NextLevel]);
                          BomComponent[NextLevel].SETFILTER("Starting Date",'%1|..%2',0D,CalculateDate);
                          BomComponent[NextLevel].SETFILTER("Ending Date",'%1|%2..',0D,CalculateDate);
                        END;
                    END;

                    IF NextLevel <> Level THEN
                      Quantity[NextLevel] := BomComponent[NextLevel - 1].Quantity * QtyPerUnitOfMeasure * Quantity[Level];
                end;

                trigger OnPreDataItem();
                begin
                    Level := 1;

                    ProdBOM.GET(Item."Production BOM No.");

                    VersionCode[Level] := VersionMgt.GetBOMVersion(Item."Production BOM No.",CalculateDate,TRUE);
                    CLEAR(BomComponent);
                    BomComponent[Level]."Production BOM No." := Item."Production BOM No.";
                    BomComponent[Level].SETRANGE("Production BOM No.",Item."Production BOM No.");
                    BomComponent[Level].SETRANGE("Version Code",VersionCode[Level]);
                    BomComponent[Level].SETFILTER("Starting Date",'%1|..%2',0D,CalculateDate);
                    BomComponent[Level].SETFILTER("Ending Date",'%1|%2..',0D,CalculateDate);
                    NoListType[Level] := NoListType[Level]::Item;
                    NoList[Level] := Item."No.";
                    Quantity[Level] :=
                      UOMMgt.GetQtyPerUnitOfMeasure(Item,Item."Base Unit of Measure") /
                      UOMMgt.GetQtyPerUnitOfMeasure(
                        Item,
                        VersionMgt.GetBOMUnitOfMeasure(
                          Item."Production BOM No.",VersionCode[Level]));
                end;
            }

            trigger OnPreDataItem();
            begin
                ItemFilter := GETFILTERS;

                SETFILTER("Production BOM No.",'<>%1','');
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
                    field(CalculateDate;CalculateDate)
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Calculation Date';
                        ToolTip = 'Specifies the date you want the program to calculate the quantity of the BOM lines.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            CalculateDate := WORKDATE;
        end;
    }

    labels
    {
        //-HEB.123
        TotalBomLotQtyLabel = 'Total BOM Lot Quantity';
        //+HEB.123
    }

    var
        Text000 : Label 'As of ';
        ProdBOM : Record "Production BOM Header";
        BomComponent : array [99] of Record "Production BOM Line";
        CompItem : Record Item;
        UOMMgt : Codeunit "Unit of Measure Management";
        VersionMgt : Codeunit VersionManagement;
        ItemFilter : Text;
        CalculateDate : Date;
        NoList : array [99] of Code[20];
        VersionCode : array [99] of Code[20];
        Quantity : array [99] of Decimal;
        QtyPerUnitOfMeasure : Decimal;
        Level : Integer;
        NextLevel : Integer;
        BOMQty : Decimal;
        //-HEB.123
        TotalBomLotQty : Decimal;
        //+HEB.123
        QtyExplosionofBOMCaptLbl : Label 'Quantity Explosion of BOM';
        CurrReportPageNoCaptLbl : Label 'Page';
        BOMQtyCaptionLbl : Label 'Total Quantity';
        BomCompLevelQtyCaptLbl : Label 'BOM Quantity';
        BomCompLevelDescCaptLbl : Label 'Description';
        BomCompLevelNoCaptLbl : Label 'No.';
        LevelCaptLbl : Label 'Level';
        BomCompLevelUOMCodeCaptLbl : Label 'Unit of Measure Code';
        NoListType : array [99] of Option " ",Item,"Production BOM";
        ProdBomErr : Label 'The maximum number of BOM levels, %1, was exceeded. The process stopped at item number %2, BOM header number %3, BOM level %4.';
}

