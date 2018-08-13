report 50024 "Informe Bfo. Bruto y Neto"
//207 mmartinez 29/03/2012 PI9999_HEB_8611 Exp. 8611. Cambios en informes de beneficio por cliente.
{
    Caption = 'Informe Bfo. Bruto y Neto';   
    UseRequestPage = true; 
    DefaultLayout = RDLC;
    RDLCLayout = '.\Reports\Layouts\Informe Bfo. Bruto y Neto.rdl';        
    dataset
    {
        dataitem(Customer;Customer)        
        {
            RequestFilterFields = "No.","Territory Code","Customer Posting Group","Salesperson Code";                        
            PrintOnlyIfDetail =true;
            column(datAvui;format(Today,0,4)){}
            column(pag;CurrReport.PAGENO){}
            column(usr;userid){}
            column(tit;'Informe de Beneficio Bruto'){}
            column(company;companyname){}    
            column(No_;"No."){}
            column(Name;Name){}           
            column(PeriodText;PeriodText){}
          dataitem("Value Entry";"Value Entry")
          {
            DataItemTableView = SORTING("Source Type","Source No.","Item No.","Posting Date","Entry Type",Adjustment) 
            WHERE("Source Type"=CONST(Customer),"Document Type"=FILTER("Sales Invoice"|"Sales Credit Memo"));
            DataItemLinkReference = Customer;
            DataItemLink = "Source No." = field("No.");
            RequestFilterFields = "Item No.","Posting Date","Inventory Posting Group";            
            //
           column(Item_No_;"Item No."){}
           column(ItemDescription; recItem.Description + recItem."description 2" ){}           
           column(Description;Description){}
           column("Kilos_Venta";-"Value Entry"."Invoiced Quantity"){
              Caption = 'Kilos Venta';
              DecimalPlaces=0:0;
            }
           column(PrecioMedVta;PrecioMedVta){
             Caption ='Precio Medio Venta';
           }
           column(CteMedioKg;CteMedioKg){
             Caption ='Coste Compra por KG';
           }
           column(BfoBruto;BfoBruto){
             DecimalPlaces=2:2;
             Caption = 'Bfo. Bruto';
            }
           column(BfoBrutoPorcen;BfoBrutoPorcen){
             DecimalPlaces=2:2;
             Caption = 'Bfo. por KG';
            }
           column(GastoCial;GastoCial){
             DecimalPlaces=2:2;
             Caption = 'Gastos Comerciales';
            }
           column(BfoNeto;BfoNeto){
             DecimalPlaces=2:2;
             Caption ='Bf0. Neto'; 
            }
           column(BfoNetoPorcen;BfoNetoPorcen){
             DecimalPlaces=2:2;
             Caption ='% Bfo. Neto';
             }
           column(totname;'Total' + Customer.Name){}
           column(Sales_Amount__Actual_;"Sales Amount (Actual)"){
             Caption ='Precio venta actual';
           }
           column(Cost_Amount__Actual_;"Cost Amount (Actual)"){
             Caption ='Coste Actual';
           }
           column(Invoiced_Quantity;"Invoiced Quantity"){
             Caption ='Cantidad Enviada';
           }            
           column(verDetalleProd;verDetalleProd){}
            trigger OnPreDataItem();              
            begin              
              IF "Value Entry".GETFILTER("Posting Date")='' THEN
                ERROR ('Debe especificar un periodo');

              CurrReport.CREATETOTALS("Sales Amount (Actual)",
                                      "Cost Amount (Actual)",
                                      "Invoiced Quantity", GastoCial);
              GastoCial:=0;
            end;
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
              
              IF verDetalleProd THEN BEGIN
                  IF recItem.GET("Item No.") THEN;

                  BfoBruto := "Sales Amount (Actual)" + "Cost Amount (Actual)";
                  BfoNeto  := BfoBruto - GastoCial;

                  IF "Invoiced Quantity" = 0 THEN
                    BEGIN
                      PrecioMedVta   := 0;
                      CteMedioKg     := 0;
                      BfoKgBruto     := 0;
                    END ELSE BEGIN
                      PrecioMedVta   := "Sales Amount (Actual)"/-"Invoiced Quantity";
                      CteMedioKg     := "Cost Amount (Actual)"/"Invoiced Quantity";
                      BfoKgBruto     := BfoBruto / -"Invoiced Quantity";
                    END;

                  IF "Sales Amount (Actual)" = 0 THEN
                    BEGIN
                      BfoBrutoPorcen := 0;
                      BfoNetoPorcen  := 0;
                    END ELSE BEGIN
                      BfoBrutoPorcen := ROUND((BfoBruto / "Sales Amount (Actual)")*100,0.01);
                      BfoNetoPorcen  := ROUND((BfoNeto / "Sales Amount (Actual)")*100,0.01);
                    END;

              END;// ELSE
                //if CurrReport.ShowOutput then;
            end; 
          }
          trigger OnPreDataItem();
          var            
            PeriodText : Text[30];
          begin
              CurrReport.CREATETOTALS("Value Entry"."Sales Amount (Actual)",
                                  "Value Entry"."Cost Amount (Actual)",
                                 "Value Entry"."Invoiced Quantity",
                                 GastoCial);
            GastoCial:=0;                
            PeriodText := STRSUBSTNO(Text100,fechaIni,fechaFin);
            IF Customer.GETFILTERS <> '' THEN
                FiltroText := STRSUBSTNO('Filtro %1: %2',Customer.TABLECAPTION,Customer.GETFILTERS)
            ELSE
                FiltroText := '';   
                
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
                    field(verDetalleProd;verDetalleProd)                    
                    {
                        Caption = 'Ver detalles prod.';
                    }

                    field(PrintToExcel;PrintToExcel)
                    {
                        Caption = 'Imprimir en Excel';
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
    begin
      IF PrintToExcel THEN
        MakeExcelInfo;          
    end;
    trigger OnPostReport();
    begin
       IF PrintToExcel THEN
         CreateExcelbook;      
    end;
    var      
      GastoCial : Decimal;
      BfoBruto : Decimal;
      BfoNeto : Decimal;
      PeriodText : Text[250];
      FiltroText : Text[250];
      verDetalleProd : Boolean;
      PrintToExcel : Boolean;
      recItem : Record 27;
      ExcelBuf : record 370 temporary;
      fechaIni : Date;
      fechaFin : Date;
      PrecioMedVta : Decimal;
      CteMedioKg : Decimal;
      BfoKgBruto : Decimal;
      BfoBrutoPorcen : Decimal;
      BfoNetoPorcen : Decimal;
      recTMPComision :  Record 65002 TEMPORARY;
      Text000 : TextConst ENU='Period: %1',ESP='Periodo: %1';
      Text001 : TextConst ENU='Data',ESP='Datos';
      Text002 : TextConst ENU='Customer/Item Sales',ESP='Informe Bfo. Bruto y Neto';
      Text003 : TextConst ENU='Company Name',ESP='Nombre empresa';
      Text004 : TextConst ENU='Report No.',ESP='No informe';
      Text005 : TextConst ENU='Report Name',ESP='Nombre informe';
      Text006 : TextConst ENU='User ID',ESP='Id. usuario';
      Text007 : TextConst ENU='Date',ESP='Fecha';
      Text008 : TextConst ENU='Customer Filters',ESP='Filtros cliente';
      Text009 : TextConst ENU='Value Entry Filters',ESP='Filtros mov. valor';
      Text010 : TextConst ENU='Profit',ESP='Bf§ bruto';
      Text011 : TextConst ENU='Profit %',ESP='% Bf§ bruto';
      Text012 : TextConst ENU='Unit Price',ESP='Precio venta';
      Text020 : TextConst ENU='Sales Kg.',ESP='Kilos venta';
      Text021 : TextConst ENU='Real Sale Amount',ESP='Importe ventas real';
      Text022 : TextConst ENU='Sales Average Price',ESP='Precio medio venta';
      Text023 : TextConst ENU='Purchase Cost by Kg.',ESP='Coste compra por Kg.';
      Text024 : TextConst ENU='Gross Benefit',ESP='Bf§ bruto';
      Text025 : TextConst ENU='Benefit by Kg.',ESP='Bf§ por Kg.';
      Text026 : TextConst ENU='Gross Benefit %',ESP='% Bf§ bruto';
      Text027 : TextConst ENU='Commercial Expenses',ESP='Gastos comerciales';
      Text028 : TextConst ENU='Net Benefit',ESP='Bf§ Neto';
      Text029 : TextConst ENU='Net Benefit %',ESP='% Bf§ Neto';
      Text100 : TextConst ENU='Period: %1 to %2',ESP='Periodo: %1 al %2';
      
    PROCEDURE GetImporteComision (TableNo : Integer;numFactura : Code[20];numLinFactura : Integer) importe : Decimal;
    VAR
      refTabla : RecordRef;
      refCampoDoc : FieldRef;
      refCampoLin : FieldRef;
    BEGIN
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
    END;

    PROCEDURE GetCostesIndirectos (numItemMov : Integer) importe : Decimal;
    VAR
      recValueEntry: Record 5802;
    BEGIN
      importe:=0;

      recValueEntry.SETCURRENTKEY("Item Ledger Entry No.",Inventoriable);

      recValueEntry.SETRANGE("Item Ledger Entry No.",numItemMov);
      recValueEntry.SETRANGE(Inventoriable,FALSE);
      recValueEntry.CALCSUMS("Cost Amount (Non-Invtbl.)");
      importe := -recValueEntry."Cost Amount (Non-Invtbl.)";
    END;

    PROCEDURE MakeExcelInfo();
    BEGIN
      //-207
      ExcelBuf.SetUseInfoSheet;
      ExcelBuf.AddInfoColumn(FORMAT(Text003),FALSE,TRUE,FALSE,FALSE,'',0);
      ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,FALSE,FALSE,FALSE,'',0);
      ExcelBuf.NewRow;
      ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,TRUE,FALSE,FALSE,'',0);
      ExcelBuf.AddInfoColumn(FORMAT(Text002),FALSE,FALSE,FALSE,FALSE,'',0);
      ExcelBuf.NewRow;
      ExcelBuf.AddInfoColumn(FORMAT(Text004),FALSE,TRUE,FALSE,FALSE,'',0);
      ExcelBuf.AddInfoColumn('Informe Bfo. Bruto y Neto',FALSE,FALSE,FALSE,FALSE,'',0);
      ExcelBuf.NewRow;
      ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,TRUE,FALSE,FALSE,'',0);
      ExcelBuf.AddInfoColumn(USERID,FALSE,FALSE,FALSE,FALSE,'',0);
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
      //+207
    END;

    LOCAL PROCEDURE MakeExcelDataHeader();
    BEGIN
      //-207
      ExcelBuf.NewRow;
      ExcelBuf.AddColumn(Customer.FIELDCAPTION("No."),FALSE,'',TRUE,FALSE,TRUE,'@',0);    
      ExcelBuf.AddColumn(Customer.FIELDCAPTION(Name),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(FORMAT(Text020),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(FORMAT(Text021),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(FORMAT(Text022),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(FORMAT(Text023),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(FORMAT(Text024),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(FORMAT(Text025),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(FORMAT(Text026),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(FORMAT(Text027),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(FORMAT(Text028),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(FORMAT(Text029),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(Customer.FIELDCAPTION("VAT Bus. Posting Group"),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(recItem.FIELDCAPTION("Gen. Prod. Posting Group"),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(recItem.FIELDCAPTION("Product Group Code"),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      ExcelBuf.AddColumn(recItem.FIELDCAPTION("Clasificación LOC"),FALSE,'',TRUE,FALSE,TRUE,'@',0);
      //+207
    END;

    PROCEDURE CreateExcelbook();
    BEGIN
      ExcelBuf.CreateBook('',Text001);
      ExcelBuf.WriteSheet(Text002,COMPANYNAME,USERID);
      ExcelBuf.GiveUserControl;
      //ERROR('');
    END;  
}