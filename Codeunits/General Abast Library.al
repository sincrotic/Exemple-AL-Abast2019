//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
codeunit 50004 "General Abast Library"
{
    //-HEB.508
    [EventSubscriber(ObjectType::Table, Database::"SII History", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertSIIHistoreCheckSuecia(VAR Rec: Record "SII History"; RunTrigger: Boolean)
    var
        SIIDocUploadState: Record "SII Doc. Upload State";
    begin
        if SIIDocUploadState.Get(Rec."Document State Id") then
            if EsSuecia(SIIDocUploadState) then begin
                Rec.Status := Rec.Status::Accepted;
                Rec.Excluded := true;
            end;
    end;
    //+HEB.508
    //-HEB.508
    [EventSubscriber(ObjectType::Table, Database::"SII Doc. Upload State", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertSIIDocUploadStatCheckSuecia(VAR Rec: Record "SII Doc. Upload State"; RunTrigger: Boolean)
    begin
        If EsSuecia(Rec) then
            Rec.Status := Rec.Status::Accepted;
    end;
    //+HEB.508
    //-HEB.508
    local procedure EsSuecia(Rec: Record "SII Doc. Upload State"): Boolean
    var
        SalesInvoice: Record "Sales Invoice Header";
        SalesCrMemo: Record "Sales Cr.Memo Header";
        PurchaseInvoice: Record "Purch. Inv. Header";
        PurchaseCrMemo: Record "Purch. Cr. Memo Hdr.";
    begin
        case Rec."Document Type" of
            Rec."Document Type"::"Credit Memo":
                begin
                    if (Rec."Document Source" = Rec."Document Source"::"Customer Ledger") OR (Rec."Document Source" = Rec."Document Source"::"Detailed Customer Ledger") then begin
                        if SalesCrMemo.get(Rec."Document No.") then
                            exit(SalesCrMemo."SII Exclude");
                        exit(false);
                    end else
                        if (Rec."Document Source" = Rec."Document Source"::"Vendor Ledger") OR (Rec."Document Source" = Rec."Document Source"::"Detailed Vendor Ledger") then begin
                            if PurchaseCrMemo.get(Rec."Document No.") then
                                exit(PurchaseCrMemo."SII Exclude");
                            exit(false);
                        end;
                end;
            Rec."Document Type"::Invoice:
                begin
                    if (Rec."Document Source" = Rec."Document Source"::"Customer Ledger") OR (Rec."Document Source" = Rec."Document Source"::"Detailed Customer Ledger") then begin
                        if SalesInvoice.get(Rec."Document No.") then
                            exit(SalesInvoice."SII Exclude");
                        exit(false);
                    end else
                        if (Rec."Document Source" = Rec."Document Source"::"Vendor Ledger") OR (Rec."Document Source" = Rec."Document Source"::"Detailed Vendor Ledger") then begin
                            if PurchaseInvoice.get(Rec."Document No.") then
                                exit(PurchaseInvoice."SII Exclude");
                            exit(false);
                        end;
                end;
            Rec."Document Type"::Payment:
                begin
                    exit(false);
                end;
        end;
    end;
    //+HEB.508

    procedure GenerarPDF(RecordVariant: Variant; AccountNo: Code[20]; DocType: Option Quote,Order,Shipment,Invoice,"Posted Invoice","Credit Memo","Return Order","Posted Credit Memo","Posted Return Order"; TableNo: Integer): Text
    var
        ReportSelections: Record "Report Selections";
        TempReportSelections: Record "Report Selections" TEMPORARY;
        RecRef: RecordRef;
        FieldRef: FieldRef;
        FilePath: Text;
        FileName: Text;
        CompanyInformation: Record "Company Information";
    begin
        RecRef.GETTABLE(RecordVariant);
        if TableNo = 18 then
            ReportSelections.FindPrintUsage(GetReportUsage(DocType, TableNo), AccountNo, TempReportSelections)
        else
            ReportSelections.FindPrintUsageVendor(GetReportUsage(DocType, TableNo), AccountNo, TempReportSelections);

        CompanyInformation.Get;
        FilePath := CompanyInformation."PDF Files Folder";
        FieldRef := RecRef.Field(3);
        FileName := FORMAT(FieldRef.Value) + '.pdf';
        /*IF Report.SaveAsPdf(ReportSelections."Report ID", FilePath+FileName, RecordVariant) then
            exit(FileName)
        else*/
        exit('');
    end;

    procedure GenerarPDFPedido(SalesHeader: Record "Sales Header"; vCopias: Integer; blnValorado: Boolean; blnLotes: Boolean; vTipo: Option " ","CONFIRMACIÓN PEDIDO","FACTURA EXPORTACIÓN","PREPARACIÓN PEDIDO"; blnArchivo: Boolean; blnLog: Boolean; blnOrderLang: Boolean): Text
    var
        FilePath: Text;
        FileName: Text;
        CompanyInformation: Record "Company Information";
        rptOrder: Report "Pedido Venta";
    begin
        FilePath := CompanyInformation."PDF Files Folder";
        FileName := SalesHeader."No." + '.pdf';
        rptOrder.SetParameters(vCopias, blnValorado, blnLotes, vTipo, blnArchivo, blnLog);
        rptOrder.SetLanguage(NOT blnOrderLang); //-245
        rptOrder.USEREQUESTPAGE := FALSE;
        rptOrder.SETTABLEVIEW(SalesHeader);
        /*if rptOrder.SaveAsPdf(FileName+FilePath) then
            exit(FileName)
        else*/
        exit('');
    end;

    local procedure GetReportUsage(DocType: Option Quote,Order,Shipment,Invoice,"Posted Invoice","Credit Memo","Return Order","Posted Credit Memo","Posted Return Order"; TableNo: Integer): Integer
    var
        ReportSelections: Record "Report Selections";
    begin
        case DocType of
            DocType::Quote:
                begin
                    if TableNo = 18 then
                        EXIT(ReportSelections.Usage::"S.Quote")
                    else
                        if TableNo = 23 then
                            EXIT(ReportSelections.Usage::"P.Quote");
                end;
            DocType::Order:
                begin
                    if TableNo = 18 then
                        EXIT(ReportSelections.Usage::"S.Order")
                    else
                        if TableNo = 23 then
                            EXIT(ReportSelections.Usage::"P.Order");
                end;
            DocType::Shipment:
                begin
                    if TableNo = 18 then
                        EXIT(ReportSelections.Usage::"S.Shipment")
                    else
                        if TableNo = 23 then
                            EXIT(ReportSelections.Usage::"P.Receipt");
                end;
            DocType::Invoice:
                begin
                    if TableNo = 18 then
                        EXIT(ReportSelections.Usage::"Pro Forma S. Invoice")
                    else
                        if TableNo = 23 then
                            EXIT(ReportSelections.Usage::"P.Invoice");
                end;
            DocType::"Posted Invoice":
                begin
                    if TableNo = 18 then
                        EXIT(ReportSelections.Usage::"S.Invoice")
                    else
                        if TableNo = 23 then
                            ;//EXIT(ReportSelections.Usage::"P.Invoice");
                end;
            // DocType::"Credit Memo": begin
            //     if TableNo = 18 then
            //         EXIT(ReportSelections.Usage::)
            //     else if TableNo = 23 then
            //         ;//EXIT(ReportSelections.Usage::"P.Cr.Memo");
            // end;
            DocType::"Return Order":
                begin
                    if TableNo = 18 then
                        EXIT(ReportSelections.Usage::"S.Return")
                    else
                        if TableNo = 23 then
                            EXIT(ReportSelections.Usage::"P.Return");
                end;
            DocType::"Posted Credit Memo":
                begin
                    if TableNo = 18 then
                        EXIT(ReportSelections.Usage::"S.Cr.Memo")
                    else
                        if TableNo = 23 then
                            EXIT(ReportSelections.Usage::"P.Cr.Memo");
                end;
            DocType::"Posted Return Order":
                begin
                    if TableNo = 18 then
                        EXIT(ReportSelections.Usage::"S.Ret.Rcpt.")
                    else
                        if TableNo = 23 then
                            EXIT(ReportSelections.Usage::"P.Ret.Shpt.");
                end;
        end;
    end;

    procedure EnvioDocCorreoPDF(Tipo: Option Customer,Vendor; DocType: Option " ",Quote,Order,Shipment,Invoice,"Credit Memo"; DocSubType: Integer; SourceNo: Code[20]; Asunto: Text[250]; FicheroPDF: Text[80]; MostrarVentana: Boolean; ForzarIdioma: Boolean)
    var
        ConfVtas: Record "Sales & Receivables Setup";
        ConfComp: Record "Purchases & Payables Setup";
        Vendor: Record "Vendor";
        Customer: Record "Customer";
        recListaEmails: Record "Correos Clientes/Proveedor";
        CompanyInfo: Record "Company Information";
        Correo: Codeunit "SMTP Mail";
        rutaBodyES: Text[260];
        rutaBodyENU: Text[260];
        rutaBody: Text[260];
        Idioma: Code[20];
        ToName: Text[1024];
        CCName: Text[1024];
        BCCName: Text[1024];
        linea: Text[260];
        SaltoLinea: Char;
        BodyFile: File;
        BodyFileInStream: InStream;
        BodyText: Text;
        FileManagement: Codeunit "File Management";
    begin
        rutaBodyES := '';
        rutaBodyENU := '';

        CASE Tipo OF
            Tipo::Customer:
                BEGIN
                    ConfVtas.GET;
                    rutaBodyES := ConfVtas."Archivo Body Pedidos (ES)";
                    rutaBodyENU := ConfVtas."Archivo Body Pedidos (ENU)";
                    Customer.GET(SourceNo);
                    Idioma := Customer."Language Code";

                    recListaEmails.RESET;
                    recListaEmails.SETRANGE(Type, recListaEmails.Type::Customer);
                    recListaEmails.SETRANGE("Source No.", SourceNo);
                END;

            Tipo::Vendor:
                BEGIN
                    ConfComp.GET;
                    rutaBodyES := ConfComp."Archivo Body Pedidos (ES)";
                    rutaBodyENU := ConfComp."Archivo Body Pedidos (ENU)";
                    Vendor.GET(SourceNo);
                    Idioma := Vendor."Language Code";

                    recListaEmails.RESET;
                    recListaEmails.SETRANGE(Type, recListaEmails.Type::Vendor);
                    recListaEmails.SETRANGE("Source No.", SourceNo);
                END;
        END;

        ToName := '';
        CCName := '';
        BCCName := '';
        recListaEmails.SETRANGE("Document Type", DocType);
        recListaEmails.SETRANGE("Document SubType", DocSubType);
        IF recListaEmails.FINDSET THEN BEGIN
            REPEAT
                CASE recListaEmails."Send Type" OF
                    recListaEmails."Send Type"::Main:
                        ToName += ';' + recListaEmails.Email;
                    recListaEmails."Send Type"::CC:
                        CCName += ';' + recListaEmails.Email;
                    recListaEmails."Send Type"::BCC:
                        BCCName += ';' + recListaEmails.Email;
                END;
            UNTIL recListaEmails.NEXT = 0;

            //Quitamos el ; que ponemos siempre al principio
            IF STRLEN(ToName) > 0 THEN
                ToName := COPYSTR(ToName, 2, 1024);
            IF STRLEN(CCName) > 0 THEN
                CCName := COPYSTR(CCName, 2, 1024);
            IF STRLEN(BCCName) > 0 THEN
                BCCName := COPYSTR(BCCName, 2, 1024);
        END;

        linea := '';
        SaltoLinea := 13;
        // CREATE(BodyFile);

        IF ForzarIdioma THEN
            rutaBody := rutaBodyES
        ELSE BEGIN
            CASE Idioma OF
                'ESP':
                    rutaBody := rutaBodyES;
                ELSE
                    rutaBody := rutaBodyENU;
            END;
        END;
        CompanyInfo.get;
        Correo.CreateMessage(CompanyInfo.Name, CompanyInfo."E-Mail", '', Asunto, '', False);
        IF ToName <> '' then
            Correo.AddRecipients(ToName);
        IF CCName <> '' then
            Correo.AddCC(CCName);
        IF BCCName <> '' then
            Correo.AddBCC(BCCName);
        /*
       Correo.AddAttachment(CompanyInfo."PDF Files Folder"+FicheroPDF, FicheroPDF);
       // FileManagement.CreateClientDirectory(rutaBody);
       BodyFile.Open(rutaBody);
       BodyFile.CREATEINSTREAM(BodyFileInStream);
       WHILE NOT BodyFileInStream.EOS DO BEGIN  
           BodyFileInStream.READTEXT(BodyText);  
           Correo.AppendBody(BodyText);
       END;  
       BodyFile.Close();
       if not Correo.TrySend then
           error(Correo.GetLastSendMailErrorText);

       // Correo.NewMessage2(ToName,CCName,BCCName,Asunto,RutaAdjunto,MostrarVentana);

       IF CompanyInfo."Delete PDF File" THEN
           IF EXISTS(CompanyInfo."PDF Files Folder"+FicheroPDF) THEN
               ERASE(CompanyInfo."PDF Files Folder"+FicheroPDF);
               */
    end;

    procedure RStrPos(String: Text; SubString: Text): Integer
    var
        Chr: Text;
        Found: Boolean;
    begin
        while StrLen(String) > 0 do begin
            Chr := CopyStr(String, StrLen(String), 1);
            if chr = SubString then
                exit(strlen(String));
            String := CopyStr(String, 1, StrLen(String) - 1);
            if StrLen(String) = 1 then
                String := '';
        end;
        if not Found then
            exit(0);
    end;
}