//HEB.204 MT 30052018. Nuevo report.
//HEB.239 MT 31052018. Añade albaranes.
report 50043 "Actualizar clientes vivos"
{
    //-204 ogarcia   12/04/2011 Nuevo campo: Clientes Vivos y proceso de actualización
    //-239 xtrullols 03/06/2015 Report 50043 amb albarans i copiar a proveidor. SP20150603_HEB
    UsageCategory = Administration;
    ProcessingOnly = true;
    Caption = 'Update alive customers'; 
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields ="No.","Customer Posting Group";

            trigger OnPreDataItem();
            begin
                Evaluate(formulafecha,StrSubstNo('<-%1M>',meses));
                fechaFin := WorkDate;
                fechaIni := CalcDate(formulaFecha,fechaFin);
                total := Count;
                llevo := 0;
                dlg.OPEN('Procesando: #1##### #2##########################\'
                        +'@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
            end;

            trigger OnAfterGetRecord();
            begin              
                llevo+=1;

                dlg.Update(1,Customer."No.");
                dlg.Update(2,Customer.Name);
                dlg.Update(3,ROUND(llevo/total*10000,1));

                WITH CustLedgerEntry DO BEGIN
                RESET;
                SETCURRENTKEY("Document Type","Customer No.","Posting Date","Currency Code");
                SETFILTER("Document Type",'%1|%2',"Document Type"::Invoice,"Document Type"::"Credit Memo");
                SETRANGE("Customer No.",Customer."No.");
                SETRANGE("Posting Date",fechaIni,fechaFin);
                Customer."Cliente Vivo" := (NOT ISEMPTY);
                Customer.MODIFY;
                END;

                //-239
                //Check Shipments if it's not Vivo
                IF NOT(Customer."Cliente Vivo") THEN BEGIN
                    CLEAR(SalesShipmentHeader);
                    //SalesShipmentHeader.SETCURRENTKEY("Sell-to Customer No.","Posting Date");
                    SalesShipmentHeader.SETRANGE("Sell-to Customer No.",Customer."No.");
                    SalesShipmentHeader.SETRANGE("Posting Date",fechaIni,fechaFin);
                    IF NOT SalesShipmentHeader.ISEMPTY THEN BEGIN
                        Customer."Cliente Vivo" := TRUE;
                        Customer.MODIFY;
                    END;
                END;
                //+239
            end;

            trigger OnPostDataItem();
            begin
                dlg.Close;
            end;
        }
    }
    
    var
        CustLedgerEntry : Record "Cust. Ledger Entry";
        SalesShipmentHeader : Record "Sales Shipment Header";
        dlg : Dialog; 
        fechaIni : Date;
        fechaFin : Date;
        formulafecha : DateFormula;
        meses :  Integer;
        llevo : Integer;
        total : Integer; 
}