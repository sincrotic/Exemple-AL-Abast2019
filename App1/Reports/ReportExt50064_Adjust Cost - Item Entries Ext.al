//HEB.232 MR 07062018 En producte crear dos camps nous i que un tingui en compte pel report de val. stock
report 50064 "Adjust Cost - Item Entries Ext"
{
    // version NAVW111.00

    Caption = 'Adjust Cost - Item Entries';
    Permissions = TableData 32=rimd,
                  TableData 339=r,
                  TableData 5802=rimd,
                  TableData 5804=rimd;
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(FilterItemNo;ItemNoFilter)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Item No. Filter';
                        Editable = FilterItemNoEditable;
                        TableRelation = Item;
                        ToolTip = 'Specifies a filter to run the Adjust Cost - Item Entries batch job for only certain items. You can leave this field blank to run the batch job for all items.';
                    }
                    field(FilterItemCategory;ItemCategoryFilter)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Item Category Filter';
                        Editable = FilterItemCategoryEditable;
                        TableRelation = "Item Category";
                        ToolTip = 'Specifies a filter to run the Adjust Cost - Item Entries batch job for only certain item categories. You can leave this field blank to run the batch job for all item categories.';
                    }
                    field(Post;PostToGL)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Post to G/L';
                        ToolTip = 'Specifies that inventory values created during the Adjust Cost - Item Entries batch job are posted to the inventory accounts in the general ledger. The option is only available if the Automatic Cost Posting check box is selected in the Inventory Setup window.';

                        trigger OnValidate();
                        var
                            ObjTransl : Record "Object Translation";
                        begin
                            IF NOT PostToGL THEN
                              MESSAGE(
                                ResynchronizeInfoMsg,
                                ObjTransl.TranslateObject(ObjTransl."Object Type"::Report,REPORT::"Post Inventory Cost to G/L"));
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            FilterItemCategoryEditable := TRUE;
            FilterItemNoEditable := TRUE;
            PostEnable := TRUE;
        end;

        trigger OnOpenPage();
        begin
            InvtSetup.GET;
            PostToGL := InvtSetup."Automatic Cost Posting";
            PostEnable := PostToGL;
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    var
        ItemLedgEntry : Record "Item Ledger Entry";
        ValueEntry : Record "Value Entry";
        ItemApplnEntry : Record "Item Application Entry";
        AvgCostAdjmtEntryPoint : Record "Avg. Cost Adjmt. Entry Point";
        Item : Record Item;
        UpdateItemAnalysisView : Codeunit "Update Item Analysis View";
    begin
        ItemApplnEntry.LOCKTABLE;
        IF NOT ItemApplnEntry.FINDLAST THEN
          EXIT;
        ItemLedgEntry.LOCKTABLE;
        IF NOT ItemLedgEntry.FINDLAST THEN
          EXIT;
        AvgCostAdjmtEntryPoint.LOCKTABLE;
        IF AvgCostAdjmtEntryPoint.FINDLAST THEN;
        ValueEntry.LOCKTABLE;
        IF NOT ValueEntry.FINDLAST THEN
          EXIT;

        IF (ItemNoFilter <> '') AND (ItemCategoryFilter <> '') THEN
          ERROR(Text005);

        IF ItemNoFilter <> '' THEN
          Item.SETFILTER("No.",ItemNoFilter);
        IF ItemCategoryFilter <> '' THEN
          Item.SETFILTER("Item Category Code",ItemCategoryFilter);
        //-HEB.232
        Item.SETFILTER("Skip Adjust Cost Item Entries",'<>%1',TRUE); //-232
        //+HEB.232
        InvtAdjmt.SetProperties(FALSE,PostToGL);
        InvtAdjmt.SetFilterItem(Item);
        InvtAdjmt.MakeMultiLevelAdjmt;

        UpdateItemAnalysisView.UpdateAll(0,TRUE);
    end;

    var
        ResynchronizeInfoMsg : Label 'Your general and item ledgers will no longer be synchronized after running the cost adjustment. You must run the %1 report to synchronize them again.';
        InvtSetup : Record "Inventory Setup";
        InvtAdjmt : Codeunit "Inventory Adjustment";
        ItemNoFilter : Text[250];
        ItemCategoryFilter : Text[250];
        Text005 : Label 'You must not use Item No. Filter and Item Category Filter at the same time.';
        PostToGL : Boolean;
        [InDataSet]
        PostEnable : Boolean;
        [InDataSet]
        FilterItemNoEditable : Boolean;
        [InDataSet]
        FilterItemCategoryEditable : Boolean;

    [Scope('Personalization')]
    procedure InitializeRequest(NewItemNoFilter : Text[250];NewItemCategoryFilter : Text[250]);
    begin
        ItemNoFilter := NewItemNoFilter;
        ItemCategoryFilter := NewItemCategoryFilter;
    end;
}

