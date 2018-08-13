report 50049 "Cambio ref. CV/MP"
{
//208 mmartinez 8611. Informe de cambio de referencias CV/MP.
//corregir la quantitat a acumular s'ha d'agafar de "item application entry", no de "ILE" (ja que un mateix moviment
// de sortida pot estar liquidant diferents moviments d'entrada)
    Caption = 'Cambio ref. CV/MP';   
    UseRequestPage = true; 
    DefaultLayout = RDLC;
    RDLCLayout = '.\Reports\Layouts\Cambio ref CV_MP.rdl';

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields ="Gen. Prod. Posting Group";
            column(datAvui;format(Today,0,4)){}
            column(pag;CurrReport.PAGENO){}
            column(usr;userid){}
            column(tit;'Cambio referencias CV/MP'){}
            column(company;companyname){}    
            dataitem("Item Ledger Entry";"Item Ledger Entry")
            {
                DataItemTableView = SORTING("Entry No.") WHERE("Entry Type"=CONST(Output)); 
                DataItemLinkReference = "Item";
                DataItemLink = "Item No." = FIELD("No.");
                RequestFilterFields = "Posting Date";
                CalcFields = "Cost Amount (Expected)","Cost Amount (Actual)";     
                column(Document_No_;"Document No."){}
                column(Item_No_;"Item No."){}
                column(Descripción;TexteProd){}
                column(Cantidad;Quantity-decQtyOut){}
                column(Importe_Coste; decUnitCost * (Quantity-decQtyOut)){}
                //column(Cost_Amount__Actual;GetUnitCostLCY){}                                         
                column(Coste_Unitario;decUnitCost){}
                trigger OnAfterGetRecord();
                begin
                    TexteProd := '';
                    decQtyOut := 0;
                    recItemApplEntry.RESET;
                    recItemApplEntry.SETRANGE("Inbound Item Entry No.", "Entry No.");
                    recItemApplEntry.SETFILTER("Outbound Item Entry No.", '<>0');
                    IF recItemApplEntry.FINDSET(FALSE, FALSE) THEN BEGIN
                        REPEAT
                        recItemLedgEntry.GET(recItemApplEntry."Outbound Item Entry No.");
                        IF recItemLedgEntry."Posting Date" <= datReportDate THEN BEGIN
                            decQtyOut := decQtyOut - recItemApplEntry.Quantity;
                        END;
                        UNTIL recItemApplEntry.NEXT = 0;
                    END;                    
                    if Description ='' then begin
                      if itemT.Get(recItemApplEntry."Outbound Item Entry No.") then
                        TexteProd := ItemT.Description;
                    end else begin
                      TexteProd := Description;
                    end;
                    decUnitCost := ("Cost Amount (Expected)" + "Cost Amount (Actual)") / Quantity;
                end;        
            } 
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
                    field(datReportDate;datReportDate)
                    {
                        Caption = 'Fecha Informe';
                    }
                    field(blnShowStockOnl;blnShowStockOnl)
                    {
                        Caption = 'Mostrar solo productos con stock';
                    }
                }
            }
        }

    }
    var
      recItemLedgEntry : Record 32;
      recItemApplEntry : Record 339;
      datReportDate : Date;
      Text001 : TextConst ENU='You must enter a report date',ESP='Debe indicar fecha de informe';
      decQtyOut : Decimal;
      decUnitCost: Decimal;
      blnShowStockOnl : Boolean;    
      TexteProd : Text[50] ;  
      ItemT : Record Item;
}