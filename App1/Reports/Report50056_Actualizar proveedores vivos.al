//HEB.204 MT 30052018. Nuevo report.
//HEB.239 MT 31052018. Añade albaranes.
report 50056 "Actualizar proveedores vivos"
{
    //-204 ogarcia   12/04/2011 Nuevo campo: Clientes Vivos y proceso de actualización
    //-239 xtrullols 03/06/2015 Report 50043 amb albarans i copiar a proveidor. SP20150603_HEB
    UsageCategory = Administration;
    ProcessingOnly = true;
    Caption = 'Update alive vendors'; 
    ApplicationArea = All;
    
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields ="No.","Vendor Posting Group";

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

                dlg.Update(1,Vendor."No.");
                dlg.Update(2,Vendor.Name);
                dlg.Update(3,ROUND(llevo/total*10000,1));

                WITH VendLedgerEntry DO BEGIN
                RESET;
                SETCURRENTKEY("Document Type","Vendor No.","Posting Date","Currency Code");
                SETFILTER("Document Type",'%1|%2',"Document Type"::Invoice,"Document Type"::"Credit Memo");
                SETRANGE("Vendor No.",Vendor."No.");
                SETRANGE("Posting Date",fechaIni,fechaFin);
                Vendor."Proveedor Vivo" := (NOT ISEMPTY);
                Vendor.MODIFY;
                END;

                //-239
                //Check Shipments if it's not Vivo
                IF NOT(Vendor."Proveedor Vivo") THEN BEGIN
                    CLEAR(PurchReceiptHeader);
                    //PurchReceiptHeader.SETCURRENTKEY("Buy-from Vendor No.","Posting Date");
                    PurchReceiptHeader.SETRANGE("Buy-from Vendor No.",Vendor."No.");
                    PurchReceiptHeader.SETRANGE("Posting Date",fechaIni,fechaFin);
                    IF NOT PurchReceiptHeader.ISEMPTY THEN BEGIN
                        Vendor."Proveedor Vivo" := TRUE;
                        Vendor.MODIFY;
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
        VendLedgerEntry : Record "Vendor Ledger Entry";
        PurchReceiptHeader : Record "Purch. Rcpt. Header";
        dlg : Dialog;
        fechaIni : Date;
        fechaFin : Date;
        formulafecha : DateFormula;
        meses :  Integer;
        llevo : Integer;
        total : Integer; 
}