report 50072 "Cliente - Ventas por productos"
{
    // version NAVW111.00.00.19846    
    // -172 ogarcia 09/11/2009 Mostrar precio unitario
    // -999 mmartinez 10/02/2010. Afegir grup contable IVA negoci a l'exportació a excel.
    // -207 mmartinez 29/03/2012 PI9999_HEB_8611 Exp. 8611. Cambios en informes de beneficio por cliente.
    // -219 ogarcia   31/05/2013 Exp. 9205: Afegir camps exportacio EXCEL Report 113
    // -221 ogarcia   31/05/2013 Exp. 9205: Report 113, afegir detall lots    
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layouts/Cliente - Ventas por productos.rdlc';     
    Caption = 'Cliente - Ventas por productos';

    dataset
    {
        dataitem(Customer;Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.","Search Name","Customer Posting Group";
            column(STRSUBSTNO_Text000_PeriodText_;STRSUBSTNO(Text000,PeriodText))
            {
            }
            column(CurrReport_PAGENO;CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(PrintOnlyOnePerPage;PrintOnlyOnePerPage)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter;TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter;CustFilter)
            {
            }
            column(Value_Entry__TABLECAPTION__________ItemLedgEntryFilter;"Value Entry".TABLECAPTION + ': ' + ValueEntryFilter)
            {
            }
            column(ItemLedgEntryFilter;ValueEntryFilter)
            {
            }
            column(Customer__No__;"No.")
            {
            }
            column(Customer_Name;Name)
            {
            }
            column(Customer__Phone_No__;"Phone No.")
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual__;ValueEntryBuffer."Sales Amount (Actual)")
            {
            }
            column(ValueEntryBuffer__Discount_Amount_;-ValueEntryBuffer."Discount Amount")
            {
            }
            column(Profit;Profit)
            {
                AutoFormatType = 1;
            }
            column(ProfitPct;ProfitPct)
            {
                DecimalPlaces = 1:1;
            }
            column(Customer_Item_SalesCaption;Customer_Item_SalesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption;All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Item_No__Caption;ValueEntryBuffer__Item_No__CaptionLbl)
            {
            }
            column(Item_DescriptionCaption;Item_DescriptionCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Invoiced_Quantity_Caption;ValueEntryBuffer__Invoiced_Quantity_CaptionLbl)
            {
            }
            column(Item__Base_Unit_of_Measure_Caption;Item__Base_Unit_of_Measure_CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual___Control44Caption;ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Discount_Amount__Control45Caption;ValueEntryBuffer__Discount_Amount__Control45CaptionLbl)
            {
            }
            column(Profit_Control46Caption;Profit_Control46CaptionLbl)
            {
            }
            column(ProfitPct_Control47Caption;ProfitPct_Control47CaptionLbl)
            {
            }
            column(Customer__Phone_No__Caption;FIELDCAPTION("Phone No."))
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            dataitem("Value Entry";"Value Entry")
            {
                DataItemLink = "Source No."=FIELD("No."),
                               "Posting Date"=FIELD("Date Filter"),
                               "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter");

                DataItemTableView = SORTING("Source Type","Source No.","Item No.","Variant Code","Posting Date")
                                    WHERE("Source Type"=CONST(Customer),
                                          "Item Charge No."=CONST(),
                                          "Expected Cost"=CONST(False),
                                          Adjustment=CONST(false));
                RequestFilterFields = "Item No.","Posting Date";

                trigger OnAfterGetRecord();
                var
                    ValueEntry : Record "Value Entry";
                    EntryInBufferExists : Boolean;
                begin
                    ValueEntryBuffer.INIT;
                    ValueEntryBuffer.SETRANGE("Item No.","Item No.");
                    EntryInBufferExists := ValueEntryBuffer.FINDFIRST;

                    IF NOT EntryInBufferExists THEN
                      ValueEntryBuffer."Entry No." := "Item Ledger Entry No.";
                    ValueEntryBuffer."Item No." := "Item No.";
                    ValueEntryBuffer."Invoiced Quantity" += "Invoiced Quantity";
                    ValueEntryBuffer."Sales Amount (Actual)" += "Sales Amount (Actual)";
                    ValueEntryBuffer."Cost Amount (Actual)" += "Cost Amount (Actual)";
                    ValueEntryBuffer."Cost Amount (Non-Invtbl.)" += "Cost Amount (Non-Invtbl.)";
                    ValueEntryBuffer."Discount Amount" += "Discount Amount";

                    TempItemLedgerEntry.SETRANGE("Entry No.","Item Ledger Entry No.");
                    IF TempItemLedgerEntry.ISEMPTY THEN BEGIN
                      TempItemLedgerEntry."Entry No." := "Item Ledger Entry No.";
                      TempItemLedgerEntry.INSERT;

                      // Add item charges regardless of their posting date
                      ValueEntry.SETRANGE("Item Ledger Entry No.","Item Ledger Entry No.");
                      ValueEntry.SETFILTER("Item Charge No.",'<>%1','');
                      ValueEntry.CALCSUMS("Sales Amount (Actual)","Cost Amount (Actual)","Cost Amount (Non-Invtbl.)","Discount Amount");

                      ValueEntryBuffer."Sales Amount (Actual)" += ValueEntry."Sales Amount (Actual)";
                      ValueEntryBuffer."Cost Amount (Actual)" += ValueEntry."Cost Amount (Actual)";
                      ValueEntryBuffer."Cost Amount (Non-Invtbl.)" += ValueEntry."Cost Amount (Non-Invtbl.)";
                      ValueEntryBuffer."Discount Amount" += ValueEntry."Discount Amount";

                      // Add cost adjustments regardless of their posting date
                      ValueEntry.SETRANGE("Item Charge No.",'');
                      ValueEntry.SETRANGE(Adjustment,TRUE);
                      ValueEntry.CALCSUMS("Cost Amount (Actual)");
                      ValueEntryBuffer."Cost Amount (Actual)" += ValueEntry."Cost Amount (Actual)";
                    END;

                    IF EntryInBufferExists THEN
                      ValueEntryBuffer.MODIFY
                    ELSE
                      ValueEntryBuffer.INSERT;
                    
                    //-221
                    IF (blnShowLots) AND ("Invoiced Quantity" <> 0) THEN
                        BEGIN
                            CALCFIELDS("Lot No.");
                            SearchLotsDetail("Item No.","Lot No.", "Invoiced Quantity");
                        END;
                    //+221
                end;

                trigger OnPreDataItem();
                begin
                    ValueEntryBuffer.RESET;
                    ValueEntryBuffer.DELETEALL;                    
                    //-221
                    InventoryBuffer.RESET;
                    InventoryBuffer.DELETEALL;
                    //+221
                    NextEntryNo := 1;
                end;
            }
            dataitem(DataItem5444;2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(ValueEntryBuffer__Item_No__;ValueEntryBuffer."Item No.")
                {
                }
                column(Item_Description;Item.Description)
                {
                }
                column(ValueEntryBuffer__Invoiced_Quantity_;-ValueEntryBuffer."Invoiced Quantity")
                {
                    DecimalPlaces = 0:5;
                }
                column(ValueEntryBuffer__Sales_Amount__Actual___Control44;ValueEntryBuffer."Sales Amount (Actual)")
                {
                    AutoFormatType = 1;
                }
                column(ValueEntryBuffer__Discount_Amount__Control45;-ValueEntryBuffer."Discount Amount")
                {
                    AutoFormatType = 1;
                }
                column(Profit_Control46;Profit)
                {
                    AutoFormatType = 1;
                }
                column(ProfitPct_Control47;ProfitPct)
                {
                    DecimalPlaces = 1:1;
                }
                column(Item__Base_Unit_of_Measure_;Item."Base Unit of Measure")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF Number = 1 THEN
                      ValueEntryBuffer.FIND('-')
                    ELSE
                      ValueEntryBuffer.NEXT;

                    Profit :=
                      ValueEntryBuffer."Sales Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Non-Invtbl.)";

                    IF Item.GET(ValueEntryBuffer."Item No.") THEN ;
                    
                    //-172
                    UnitPrice:=0;
                    IF ValueEntryBuffer."Invoiced Quantity" <> 0 THEN BEGIN
                      UnitPrice:= ValueEntryBuffer."Sales Amount (Actual)" / -ValueEntryBuffer."Invoiced Quantity";
                    END;
                    //+172

                    IF PrintToExcel AND Item.GET(ValueEntryBuffer."Item No.") THEN BEGIN
                      CalcProfitPct;
                      MakeExcelDataBody;
                    END;
                end;

                trigger OnPreDataItem();
                begin
                    CurrReport.CREATETOTALS(
                      ValueEntryBuffer."Sales Amount (Actual)",
                      ValueEntryBuffer."Discount Amount",
                      Profit);

                    ValueEntryBuffer.RESET;
                    SETRANGE(Number,1,ValueEntryBuffer.COUNT);
                end;
            }

            dataitem(Lots;Integer )
            {
                DataItemTableView = SORTING(Number);
            trigger OnPreDataItem();
            begin                
                InventoryBuffer.RESET;
                InventoryBuffer.SETRANGE("Item No.",ValueEntryBuffer."Item No.");
                SETRANGE(Number,1,InventoryBuffer.COUNT);
            end;
            trigger OnAfterGetRecord();
            begin                
                IF Number = 1 THEN
                    InventoryBuffer.FINDSET
                ELSE
                    InventoryBuffer.NEXT;
            end;
            }

            trigger OnPreDataItem();
            begin
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;

                CurrReport.CREATETOTALS(
                  ValueEntryBuffer."Sales Amount (Actual)",
                  ValueEntryBuffer."Discount Amount",
                  Profit);
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
                group(Options)
                {
                    Caption = 'Opciones';
                    field(PrintOnlyOnePerPage;PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Página nueva por cliente';
                    }
                    field(PrintoEXcel;PrintToExcel)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Imprimir en Excel';
                    }
                    field(blnShowLots ;blnShowLots)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Mostrar detall Lots';
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
    }

    trigger OnPreReport();
    var
        CaptionManagement : Codeunit "CaptionManagement";
    begin
        CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Customer);
        ValueEntryFilter := "Value Entry".GETFILTERS;
        PeriodText := "Value Entry".GETFILTER("Posting Date");
    end;

    var
        Text000 : TextConst ENU='Period: %1',ESP='Periodo: %1';
        Item : Record "Item";
        ValueEntryBuffer : Record "Value Entry" temporary;
        TempItemLedgerEntry : Record "Item Ledger Entry" temporary;
        CustFilter : Text;
        ValueEntryFilter : Text;
        PeriodText : Text;
        PrintOnlyOnePerPage : Boolean;
        Profit : Decimal;
        ProfitPct : Decimal;
        Customer_Item_SalesCaptionLbl : TextConst ENU='Customer/Item Sales',ESP='Cliente - Ventas por productos';
        CurrReport_PAGENOCaptionLbl : TextConst ENU='Page',ESP='Pág.';
        All_amounts_are_in_LCYCaptionLbl : TextConst ENU='All amounts are in LCY',ESP='Importes en divisa local';
        ValueEntryBuffer__Item_No__CaptionLbl : TextConst ENU='Item No.',ESP='Nº producto';
        Item_DescriptionCaptionLbl : TextConst ENU='Description',ESP='Descripción';
        ValueEntryBuffer__Invoiced_Quantity_CaptionLbl : TextConst ENU='Invoiced Quantity',ESP='Cantidad facturada';
        Item__Base_Unit_of_Measure_CaptionLbl : TextConst ENU='Unit of Measure',ESP='Unidad medida';
        ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl : TextConst ENU='Amount',ESP='Importe';
        ValueEntryBuffer__Discount_Amount__Control45CaptionLbl : TextConst ENU='Discount Amount',ESP='Importe dto.';
        Profit_Control46CaptionLbl : TextConst ENU='Profit',ESP='Bfº bruto';
        ProfitPct_Control47CaptionLbl : TextConst ENU='Profit %',ESP='% Bfº bruto';
        TotalCaptionLbl : TextConst ENU='Total',ESP='Total';
        InventoryBuffer : Record "Inventory Buffer";
        blnShowLots : Boolean;
        PrintToExcel : Boolean;
        UnitPrice : Decimal;
        NextEntryNo : Integer;
        ExcelBuf : Record "Excel Buffer";
      Text001 : TextConst ENU='Data', ESP='Datos';

      Text002 : TextConst ENU='Customer/Item Sales',ESP='Cliente - Ventas por productos';
      Text003 : TextConst ENU='Company Name',ESP='Nombre empresa';
      Text004 : TextConst ENU='Report No',ESP='Nº informe';
      Text005 : TextConst ENU='Report Name',ESP='Nombre informe';
      Text006 : TextConst ENU='User ID',ESP='Id. usuario';
      Text007 : TextConst ENU='Date',ESP='Fecha';
      Text008 : TextConst ENU='Customer Filters',ESP='Filtros cliente';
      Text009 : TextConst ENU='Value Entry Filters',ESP='Filtros mov. valor';
      Text010 : TextConst ENU='Profit',ESP='Bfo bruto';
      Text011 : TextConst ENU='Profit %',ESP='% Bf§ bruto';
      Text012 : TextConst ENU='Unit Price',ESP='Precio venta';
      Text013 : TextConst ENU='Salesperson Name',ESP='Nombre Vendedor';
      SalesPerson: Record "Salesperson/Purchaser";
      
    procedure InitializeRequest(NewPagePerCustomer : Boolean);
    begin
        PrintOnlyOnePerPage := NewPagePerCustomer;
    end;
    procedure CalcProfitPct();
    begin        
        WITH ValueEntryBuffer DO BEGIN
        IF "Sales Amount (Actual)" <> 0 THEN
            ProfitPct := ROUND(100 * Profit / "Sales Amount (Actual)",0.1)
        ELSE
            ProfitPct := 0;
        END;
    end;
    PROCEDURE MakeExcelInfo();
    BEGIN
      ExcelBuf.SetUseInfoSheet;
      ExcelBuf.AddInfoColumn(FORMAT(Text003),FALSE,TRUE,FALSE,FALSE,'',0);
      ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,FALSE,FALSE,FALSE,'',0);
      ExcelBuf.NewRow;
      ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,FALSE,FALSE,false,'',0);
      ExcelBuf.AddInfoColumn(FORMAT(Text002),FALSE,FALSE,FALSE,FALSE,'',0);
      ExcelBuf.NewRow;
      ExcelBuf.AddInfoColumn(FORMAT(Text004),FALSE,TRUE,FALSE,FALSE,'',0);
      ExcelBuf.AddInfoColumn(REPORT::"Customer/Item Sales",FALSE,FALSE,FALSE,FALSE,'',0);
      ExcelBuf.NewRow;
      ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,TRUE,FALSE,FALSE,'',0);
      ExcelBuf.AddInfoColumn(USERID,FALSE,FALSE,FALSE,false,'',0);
      ExcelBuf.NewRow;
      ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,TRUE,FALSE,FALSE,'',0);
      ExcelBuf.AddInfoColumn(TODAY,FALSE,FALSE,FALSE,FALSE,'',0);
      ExcelBuf.NewRow;
      ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,TRUE,FALSE,FALSE,'',0);
      ExcelBuf.AddInfoColumn(Customer.GETFILTERS,FALSE,FALSE,FALSE,FALSE,'',0);
      ExcelBuf.NewRow;
      ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,TRUE,FALSE,FALSE,'',0);
      ExcelBuf.AddInfoColumn("Value Entry".GETFILTERS,FALSE,FALSE,FALSE,FALSE,'',0);
      ExcelBuf.ClearNewRow;
      MakeExcelDataHeader;
    END;

    LOCAL PROCEDURE MakeExcelDataHeader();
    BEGIN
         ExcelBuf.NewRow;
      ExcelBuf.AddColumn(Customer.FIELDCAPTION("No."),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(Customer.FIELDCAPTION(Name),FALSE,'',TRUE,FALSE,TRUE,'',0);
      ExcelBuf.AddColumn(Customer.FIELDCAPTION("Chain Name"),FALSE,'',TRUE,FALSE,TRUE,'@',0);//-219
      ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Item No."),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(Item.FIELDCAPTION(Description),FALSE,'',TRUE,FALSE,TRUE,'',0);
      ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Invoiced Quantity"),FALSE,'',TRUE,FALSE,TRUE,'',0);
      ExcelBuf.AddColumn(Item.FIELDCAPTION("Base Unit of Measure"),FALSE,'',TRUE,FALSE,TRUE,'',0);
      ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Sales Amount (Actual)"),FALSE,'',TRUE,FALSE,TRUE,'',0);
      ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Discount Amount"),FALSE,'',TRUE,FALSE,TRUE,'',0);
      ExcelBuf.AddColumn(FORMAT(Text012),FALSE,'',TRUE,FALSE,TRUE,'',0);
      ExcelBuf.AddColumn(FORMAT(Text010),FALSE,'',TRUE,FALSE,TRUE,'',0);
      ExcelBuf.AddColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,TRUE,'',0);
      ExcelBuf.AddColumn(Customer.FIELDCAPTION("VAT Bus. Posting Group"),FALSE,'',TRUE,FALSE,TRUE,'@',0); //-999
      ExcelBuf.AddColumn(Item.FIELDCAPTION("Gen. Prod. Posting Group"),FALSE,'',TRUE,FALSE,TRUE,'@',0);//-207
      ExcelBuf.AddColumn(Item.FIELDCAPTION("Product Group Code"),FALSE,'',TRUE,FALSE,TRUE,'@',0); //-207
      ExcelBuf.AddColumn(Item.FIELDCAPTION("Clasificación LOC"),FALSE,'',TRUE,FALSE,TRUE,'@',0);//-207 (Valor Entero)
      ExcelBuf.AddColumn(Item.FIELDCAPTION("Clasificación LOC"),FALSE,'',TRUE,FALSE,TRUE,'@',0);//-219 (Valor Cadena)
      ExcelBuf.AddColumn(Customer.FIELDCAPTION("Salesperson Code"),FALSE,'',TRUE,FALSE,TRUE,'@',0);//-219
      ExcelBuf.AddColumn(FORMAT(Text013),FALSE,'',TRUE,FALSE,TRUE,'@',0);//-219
    END;

    PROCEDURE MakeExcelDataBody();
    BEGIN
         ExcelBuf.NewRow;
      ExcelBuf.AddColumn(Customer."No.",FALSE,'',FALSE,FALSE,FALSE,'@',0);
      ExcelBuf.AddColumn(Customer.Name,FALSE,'',FALSE,FALSE,FALSE,'@',0);
      ExcelBuf.AddColumn(Customer."Chain Name",FALSE,'',FALSE,FALSE,FALSE,'@',0);//-219
      ExcelBuf.AddColumn(ValueEntryBuffer."Item No.",FALSE,'',FALSE,FALSE,FALSE,'@',0);
      ExcelBuf.AddColumn(Item.Description,FALSE,'',FALSE,FALSE,FALSE,'@',0);
      ExcelBuf.AddColumn(-ValueEntryBuffer."Invoiced Quantity",FALSE,'',FALSE,FALSE,FALSE,'',0);
      ExcelBuf.AddColumn(Item."Base Unit of Measure",FALSE,'',FALSE,FALSE,FALSE,'@',0);
      ExcelBuf.AddColumn(ValueEntryBuffer."Sales Amount (Actual)",FALSE,'',FALSE,FALSE,FALSE,'',0);
      ExcelBuf.AddColumn(-ValueEntryBuffer."Discount Amount",FALSE,'',FALSE,FALSE,FALSE,'',0);
      ExcelBuf.AddColumn(UnitPrice,FALSE,'',FALSE,FALSE,FALSE,'',0);
      ExcelBuf.AddColumn(Profit,FALSE,'',FALSE,FALSE,FALSE,'',0);
      ExcelBuf.AddColumn(ProfitPct,FALSE,'',FALSE,FALSE,FALSE,'',0);
      ExcelBuf.AddColumn(Customer."VAT Bus. Posting Group",FALSE,'',FALSE,FALSE,FALSE,'@',0);//-999
      ExcelBuf.AddColumn(Item."Gen. Prod. Posting Group",FALSE,'',FALSE,FALSE,FALSE,'@',0);//-207
      ExcelBuf.AddColumn(Item."Product Group Code",FALSE,'',FALSE,FALSE,FALSE,'@',0); //-207
      ExcelBuf.AddColumn(Item."Clasificación LOC",FALSE,'',FALSE,FALSE,FALSE,'##0',0); //-207 (Valor Entero)
      ExcelBuf.AddColumn(FORMAT(Item."Clasificación LOC"),FALSE,'',FALSE,FALSE,FALSE,'@',0);//-219 (Valor Cadena)
      ExcelBuf.AddColumn(Customer."Salesperson Code",FALSE,'',FALSE,FALSE,FALSE,'@',0);//-219
      ExcelBuf.AddColumn(SalesPerson.Name,FALSE,'',FALSE,FALSE,FALSE,'@',0);//-219
    END;

    PROCEDURE CreateExcelbook();
    BEGIN       
       ExcelBuf.CreateNewBook(Text001);
       ExcelBuf.WriteSheet(Text002,COMPANYNAME,USERID);
       ExcelBuf.GiveUserControl;
       ERROR('');
    END;

    PROCEDURE SearchLotsDetail(ItemNo : Code[20];LotNo : Code[20];Qty : Decimal);
    BEGIN
      //-221
      IF LotNo <> '' THEN BEGIN
        InventoryBuffer.RESET;
        InventoryBuffer.SETRANGE("Item No.",ItemNo);
        InventoryBuffer.SETRANGE("Lot No.", LotNo);
        IF InventoryBuffer.FINDFIRST THEN
          BEGIN
            InventoryBuffer.Quantity += Qty;
            InventoryBuffer.MODIFY;
          END
         ELSE
          BEGIN
           InventoryBuffer.INIT;
           InventoryBuffer."Item No." := ItemNo;
           InventoryBuffer."Lot No." := LotNo;
           InventoryBuffer.Quantity := Qty;
           InventoryBuffer.INSERT;
          END;
      END;
      //+221
    END;
}

