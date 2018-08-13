//HEB.135 MR 07062018 Recalular el "Currency factor" al registrar pedidos de compra/venta
//HEB.216 MR 12062018 Exp. 9205: Control Reg. Doc. Venta.: Avis linies amb "Preu venda" = 0 (CDU 80)
//HEB.218 MR 13062018 Exp. 9205: Nova impresio PROFORMA (Ofertes Venda) amb contador Propi
//HEB.244 MR 08062018 Camps relacionats venedor a fitxa client i traspassar a documents
//HEB.156 MR 12062018 Codeunit Lanzar Documento Nuevas Validaciones
//HEB.104 MT 25062018. Formato de direcciones personalizado.
//HEB.515 MT 12072018. Nueva función RstrPos.
codeunit 50000 "Sales Abast Library"
{
    procedure UpdCustLedgerEntryDescription(var Rec: Record "Cust. Ledger Entry")
    var
        CustLedgEntry:Record "Cust. Ledger Entry";
        GLEntry:Record "G/L Entry";
        BankAccLedgEntry:Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        GenJournalTemplate:Record "Gen. Journal Template";
        TxtErrSC1:Label 'Solo se pueden editar las descripciones de los movimentos \';
        TxtErrSC2:Label 'procedentes del diario General y de %1.';
        SCCob:Label 'Cobros';
    begin
        //-HEB.144
        GenJournalTemplate.RESET;
        GenJournalTemplate.SETFILTER(Type,'%1|%2',GenJournalTemplate.Type::General,
                                                GenJournalTemplate.Type::"Cash Receipts");
        GenJournalTemplate.SETRANGE("Source Code",Rec."Source Code");

        IF NOT GenJournalTemplate.FINDFIRST THEN
        ERROR (TxtErrSC1+TxtErrSC2,SCCob);

        GLEntry.RESET;
        GLEntry.LOCKTABLE;
        GLEntry.SETCURRENTKEY("Document No.","Posting Date");
        GLEntry.SETRANGE("Document No.",Rec."Document No.");
        GLEntry.SETRANGE("Posting Date",Rec."Posting Date");
        GLEntry.SETRANGE("Bill No.",Rec."Bill No.");
        GLEntry.SETRANGE("Document Type",Rec."Document Type");
        IF GLEntry.FINDFIRST THEN
        REPEAT
            GLEntry.Description:= Rec.Description;
            GLEntry.MODIFY;
        UNTIL GLEntry.NEXT=0;

        BankAccLedgEntry.RESET;
        BankAccLedgEntry.LOCKTABLE;
        BankAccLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
        BankAccLedgEntry.SETRANGE("Document No.",Rec."Document No.");
        BankAccLedgEntry.SETRANGE("Posting Date",Rec."Posting Date");
        BankAccLedgEntry.SETRANGE("Bill No.",Rec."Bill No.");
        BankAccLedgEntry.SETRANGE("Document Type",Rec."Document Type");
        IF BankAccLedgEntry.FINDFIRST THEN
        REPEAT
            BankAccLedgEntry.Description := Rec.Description;
            BankAccLedgEntry.MODIFY;
        UNTIL BankAccLedgEntry.NEXT=0;

        //Toni-16_07_18 El cliente no utiliza esta funcionalidad en NAV 2009
        IF Rec."Bill No." = '' THEN BEGIN
        CheckLedgEntry.RESET;
        CheckLedgEntry.LOCKTABLE;
        CheckLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
        CheckLedgEntry.SETRANGE("Document No.",Rec."Document No.");
        CheckLedgEntry.SETRANGE("Posting Date",Rec."Posting Date");
        CheckLedgEntry.SETRANGE("Document Type",Rec."Document Type");
        IF CheckLedgEntry.FINDFIRST THEN
            REPEAT
                CheckLedgEntry.Description := Rec.Description;
                CheckLedgEntry.MODIFY;
            UNTIL CheckLedgEntry.NEXT = 0;
        END;
        //END Toni-16_07_18
        CustLedgEntry.RESET;
        CustLedgEntry.SETCURRENTKEY("Document No.","Document Type");
        CustLedgEntry.SETRANGE("Document No.",Rec."Document No.");
        CustLedgEntry.SETRANGE("Document Type",Rec."Document Type");
        CustLedgEntry.SETRANGE("Bill No.",Rec."Bill No.");
        CustLedgEntry.SETRANGE("Posting Date",Rec."Posting Date");
        IF CustLedgEntry.FINDFIRST THEN
            REPEAT
            CustLedgEntry.Description :=Rec.Description;
            CustLedgEntry.MODIFY;
            UNTIL CustLedgEntry.NEXT=0;

        CustLedgEntry.RESET;
        CustLedgEntry.GET(Rec."Entry No.");
        Rec:=CustLedgEntry;
        //+HEB.144
    end;

    //-114
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitrecord', '', true, true)]
    local procedure OnAfterInitRecordSalesHeader(VAR SalesHeader : Record "Sales Header")
    begin
        IF SalesHeader."Document Type" IN [SalesHeader."Document Type"::"Return Order", SalesHeader."Document Type"::"Credit Memo"] THEN BEGIN
            //-114
            SalesHeader."Order Date" := WORKDATE;
            //+114
        END;        
    end;
    //-114

    //+114
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateAmounts', '', true, true)]
    local procedure OnAfterUpdateAmountsSalesLine(VAR SalesLine : Record "Sales Line")
    begin
        //+114
        SalesLine.CalculaImporteComision();
        //-114         
    end;
    //-114

    //+114
    procedure BuscaPorcentajeComision(SalesLine : Record "Sales Line"; codVendedor : Code[20]; fechaInicial : Date; var grupoComision : Code[20]) Porcen : Decimal
    var
        CuadroComisiones : Record "Cuadro Comisiones Ventas";
        Vendedor : Record "Salesperson/Purchaser";	
        x : Integer;	
        encontrado : Boolean;		
    begin
        //+114
        Porcen:=0;
        encontrado:=FALSE;

        IF NOT Vendedor.GET(codVendedor) THEN EXIT;
        IF Vendedor."Cód. Grupo comisión" = '' THEN EXIT;
        grupoComision:= Vendedor."Cód. Grupo comisión";


        IF fechaInicial = 0D THEN fechaInicial:=WORKDATE;

        WITH CuadroComisiones DO BEGIN
        x:=0;
        REPEAT
            RESET;
            SETRANGE("Nº",grupoComision);
            SETRANGE("Tipo Venta",x);
            CASE x OF
            0: SETRANGE("Valor Venta",SalesLine."Sell-to Customer No.");
            1: SETRANGE("Valor Venta",SalesLine."Gen. Bus. Posting Group");
            2: SETRANGE("Valor Venta",'');
            END;
            SETFILTER("Fecha Inicial",'..%1',fechaInicial);
            SETFILTER("Fecha Final",'%1|%2..',0D,fechaInicial);
            SETFILTER("Cantidad mínima",'0..%1',SalesLine.Quantity);

            SETFILTER("Nº Producto",SalesLine."No.");
            IF FINDLAST THEN BEGIN
                Porcen:="% Comisión";
                encontrado:=TRUE;
            END ELSE SETRANGE("Nº Producto");

            IF (NOT encontrado) AND (SalesLine."Product Group Code" <> '') THEN BEGIN
                SETFILTER("Cód. Grupo producto",SalesLine."Product Group Code");
                IF FINDLAST THEN BEGIN
                    Porcen:="% Comisión";
                    encontrado:=TRUE;
                END ELSE SETRANGE("Cód. Grupo producto");
            END;

            IF (NOT encontrado) AND (SalesLine."Item Category Code" <> '') THEN BEGIN
                SETFILTER("Cód. Categoria producto",SalesLine."Item Category Code");
                IF FINDLAST THEN BEGIN
                    Porcen:="% Comisión";
                    encontrado:=TRUE;
                END ELSE SETRANGE("Cód. Categoria producto");
            END;
            x+=1;
        UNTIL (encontrado) OR (x=3);

        x:=0;
        IF NOT encontrado THEN
            REPEAT
            RESET;
            SETRANGE("Nº",grupoComision);
            SETRANGE("Tipo Venta",x);
            CASE x OF
            0: SETRANGE("Valor Venta",SalesLine."Sell-to Customer No.");
            1: SETRANGE("Valor Venta",SalesLine."Gen. Bus. Posting Group");
            2: SETRANGE("Valor Venta",'');
            END;
            SETFILTER("Fecha Inicial",'..%1',fechaInicial);
            SETFILTER("Fecha Final",'%1|%2..',0D,fechaInicial);
            SETFILTER("Cantidad mínima",'0..%1',SalesLine.Quantity);
            SETFILTER("Nº Producto",'%1','');
            SETFILTER("Cód. Grupo producto",'%1','');
            SETFILTER("Cód. Categoria producto",'%1','');
            IF FINDLAST THEN BEGIN
                Porcen:="% Comisión";
                encontrado:=TRUE;
            END;
            x+=1;
            UNTIL (encontrado) OR (x=3);
        END;
        //-114
    end;
    //-114
 
    //+HEB.180
    procedure SearchInvoice(var Rec: Record "Sales Header Archive")
    var
        TempFacturas : Record "Sales Invoice Header";
        ValueEntry : Record "Value Entry";
        ItemEntryRel : Record "Item Entry Relation";
        SalesInvoiceHeader : Record "Sales Invoice Header";
    begin
        //-HEB.180
        CLEAR(TempFacturas);
        TempFacturas.RESET;
        TempFacturas.DELETEALL;

        //Si no es un pedido ERROR
        IF NOT (Rec."Document Type" IN [Rec."Document Type"::Order]) THEN
            ERROR('Este documento es de tipo %1. Debería ser Pedido',Rec."Document Type");

        //Buscamos el pedido en Item Entry Relation
        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.","Document Type","Document No.","Document Line No.");
        ItemEntryRel.SETCURRENTKEY("Order No.","Order Line No.");
        ItemEntryRel.SETRANGE("Order No.",Rec."No.");
        IF ItemEntryRel.FINDSET THEN
            REPEAT
                ValueEntry.SETRANGE("Item Ledger Entry No.",ItemEntryRel."Item Entry No.");
                ValueEntry.SETRANGE("Document Type",ValueEntry."Document Type"::"Sales Invoice");
                IF ValueEntry.FINDSET THEN
                REPEAT
                    SalesInvoiceHeader.GET(ValueEntry."Document No.");
                    TempFacturas.COPY(SalesInvoiceHeader);
                    IF NOT TempFacturas.INSERT THEN;
                UNTIL ValueEntry.NEXT=0;
            UNTIL ItemEntryRel.NEXT=0;

        //Si hay lineas en TempFacturas, las mostramos, sino un mensaje de error
        TempFacturas.RESET;
        IF TempFacturas.ISEMPTY THEN
            ERROR('No se han encontrado facturas de venta para el pedido %1',Rec."No.");

        Page.RUNMODAL(Page::"Posted Sales Invoices",TempFacturas);
        //-HEB.180        
    end;

    //-HEB.180
   
    //-HEB.156
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', true, true)]
    local procedure OnBeforeeleaseSalesDocSalesHeaderTestFields(VAR SalesHeader : Record "Sales Header";PreviewMode : Boolean)
    var
        SalesLine : Record "Sales Line";
        Text004	: Label 'El campo ''Modo de Transporte'' de la pestaña Envíos debe rellenarse.';
        Text001 : Label 'There is nothing to release for %1 %2.';
    begin
        //-HEB.156
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Quote THEN
        BEGIN
            SalesHeader.TESTFIELD("Price Validity Date");
            SalesHeader.TESTFIELD("Days Validity");
            SalesHeader.TESTFIELD("Product Availability (value)");
            SalesHeader.TESTFIELD("Product Availability (period)");
        END;
        
        SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.",SalesHeader."No.");
        SalesLine.SETFILTER(Type,'>0');
        SalesLine.SETFILTER(Quantity,'<>0');
        IF SalesLine.ISEMPTY THEN
        ERROR(Text001,SalesHeader."Document Type",SalesHeader."No.");

        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Quote THEN BEGIN
            SalesLine.SETRANGE(Type,SalesLine.Type::Item);
            IF SalesLine.FINDSET THEN
                REPEAT
                    SalesLine.TESTFIELD(Packaging);
                UNTIL SalesLine.NEXT=0;
            SalesLine.SETFILTER(Type,'>0');
        END;
        //-HEB.156
        //-HEB.115
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
        BEGIN
            IF SalesHeader."Transport Method" = '' THEN
            ERROR(Text004);
        END;
        //+HEB.115
    end;
    //+HEB.156

    //-HEB.128
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', true, true)]
    local procedure OnAfterReleaseSalesDocSalesHeader(VAR SalesHeader : Record "Sales Header";PreviewMode : Boolean;LinesWereModified : Boolean)
    var 
        ArchiveManagement :Codeunit ArchiveManagement;
    begin
         //+128, 156
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)  THEN
            ArchiveManagement.StoreSalesDocument(SalesHeader,FALSE);
        //-128, 156    
    end;
    //+HEB.128

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptLineInsert', '', true, true)]
    local procedure OnBeforeInsertSalesShptLineSetImportComision (VAR SalesShptLine : Record "Sales Shipment Line";SalesShptHeader : Record "Sales Shipment Header";SalesLine : Record "Sales Line")
    begin
        //-114
        IF SalesLine.Quantity = 0 THEN
            SalesShptLine."Importe Comisión" := 0
        ELSE
            SalesShptLine."Importe Comisión" := ROUND((SalesShptLine."Importe Comisión"  /SalesLine.Quantity) * SalesShptLine.Quantity);
        //+114     
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', true, true)]
    local procedure OnBeforeInsertInvLineSetImportComision (VAR SalesInvLine : Record "Sales Invoice Line";SalesInvHeader : Record "Sales Invoice Header";SalesLine : Record "Sales Line")
    begin
        //-114
        IF SalesInvLine.Quantity = 0 THEN
            SalesInvLine."Importe Comisión" := 0
        ELSE
            SalesInvLine."Importe Comisión" := ROUND((SalesInvLine."Importe Comisión" / SalesInvLine.Quantity) * SalesInvLine.Quantity);
        //+114      
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoLineInsert', '', true, true)]
    local procedure OnBeforeInsertCrMemolineSetImportComision (VAR SalesCrMemoLine : Record "Sales Cr.Memo Line";SalesCrMemoHeader : Record "Sales Cr.Memo Header";SalesLine : Record "Sales Line")
    begin
        //-114
        IF SalesCrMemoLine.Quantity = 0 THEN
            SalesCrMemoLine."Importe Comisión":=0
        ELSE
            SalesCrMemoLine."Importe Comisión" := ROUND((SalesCrMemoLine."Importe Comisión" / SalesCrMemoLine.Quantity) * SalesCrMemoLine.Quantity);
        //+114
    end;
    //-HEB.135
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', true, true)]
    local procedure OnBeforeConfirmSalesPostValidatePostingDate(VAR SalesHeader : Record "Sales Header";VAR HideDialog : Boolean)
    begin
        //-135
        SalesHeader.VALIDATE("Posting Date");
        //+135        
    end;
    //+HEB.135
    //-HEB.135
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeConfirmPost', '', true, true)]
    local procedure OnBeforeConfirmPostValidatePostingDate(VAR SalesHeader : Record "Sales Header";VAR HideDialog : Boolean)
    begin
        //-135
        SalesHeader.VALIDATE("Posting Date");
        //+135        
    end;
    //+HEB.135
    //-HEB.169
    local procedure ConvertToUpperCaseBig(var TextIn : Text [50]);
    begin
        TextIn := UpperCase(TextIn);
    end;

    local procedure ConvertToUpperCaseSmall(var TextIn : Text [30]);

    begin
        TextIn := UpperCase(TextIn);
    end;

    local procedure ConvertToLowerCase(var TextIn : Text [80]);

    begin
        TextIn := LowerCase(TextIn);
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'Name', true, true)]
    local procedure UpperCaseName(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec.Name <> xRec.Name then
            ConvertToUpperCaseBig(Rec.Name);
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'Name 2', true, true)]
    local procedure UpperCaseName2(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec."Name 2" <> xRec."Name 2" then
            ConvertToUpperCaseBig(Rec."Name 2");
    end;

    
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'Address', true, true)]
    local procedure UpperCaseAdress(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec.Address <> xRec.Address then
            ConvertToUpperCaseBig(Rec.Address);
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'Address 2', true, true)]
    local procedure UpperCaseAdress2(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec."Address 2" <> xRec."Address 2" then
            ConvertToUpperCaseBig(Rec."Address 2");
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'Company Name', true, true)]
    local procedure UpperCaseCompanyName(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec."Company Name" <> xRec."Company Name" then
            ConvertToUpperCaseBig(Rec."Company Name");
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'City', true, true)]
    local procedure UpperCaseCity(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec.City <> xRec.City then
            ConvertToUpperCaseSmall(Rec.City);
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'Job Title', true, true)]
    local procedure UpperCaseJobTitle(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec."Job Title" <> xRec."Job Title" then
            ConvertToUpperCaseSmall(Rec."Job Title");
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'Initials', true, true)]
    local procedure UpperCaseInitial(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec.Initials <> xRec.Initials then
            ConvertToUpperCaseSmall(Rec.Initials);
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'First Name', true, true)]
    local procedure UpperCaseFirstName(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec."First Name" <> xRec."First Name" then
            ConvertToUpperCaseSmall(Rec."First Name");
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'Middle Name', true, true)]
    local procedure UpperCaseMiddleName(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec."Middle Name" <> xRec."Middle Name" then
            ConvertToUpperCaseSmall(Rec."Middle Name");
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'Surname', true, true)]
    local procedure UpperCaseSurName(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec.Surname <> xRec.Surname then
            ConvertToUpperCaseSmall(Rec.Surname);
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'E-Mail', true, true)]
    local procedure LowerCaseEMail(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec."E-Mail" <> xRec."E-Mail" then
            ConvertToLowerCase(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'E-Mail 2', true, true)]
    local procedure LowerCaseEMail2(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec."E-Mail 2" <> xRec."E-Mail 2" then
            ConvertToLowerCase(Rec."E-Mail 2");
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'Home Page', true, true)]
    local procedure LowerCaseHomePage(var Rec : Record Contact;var xRec : Record Contact;CurrFieldNo : Integer)
    begin
        if Rec."Home Page" <> xRec."Home Page" then
            ConvertToLowerCase(Rec."Home Page");
    end;
    
    //+HEB.169

    //+HEB.181
    procedure PrintCounter(Table :Integer; Number:Code[20])
    var
        PostedBillGr : Record "Posted Bill Group";
        ClosedBillGr : Record "Closed Bill Group";
        PostedPaymentOrder : Record "Posted Payment Order";
        ClosedPaymentOrder : Record "Closed Payment Order";
        BillGr : Record "Bill Group";
        PaymentOrder : Record "Payment Order";
    begin
        CASE TRUE OF
            Table = DATABASE::"Bill Group":
                BEGIN
                    BillGr.GET(Number);
                    BillGr."No. Printed" := BillGr."No. Printed" + 1;
                    BillGr.MODIFY;
                END;
            Table = DATABASE::"Payment Order":
                BEGIN
                    PaymentOrder.GET(Number);
                    PaymentOrder."No. Printed" := PaymentOrder."No. Printed" + 1;
                    PaymentOrder.MODIFY;
                END;
            Table = DATABASE::"Posted Bill Group":
                BEGIN
                    PostedBillGr.GET(Number);
                    PostedBillGr."No. Printed" := PostedBillGr."No. Printed" + 1;
                    PostedBillGr.MODIFY;
                END;
            Table = DATABASE::"Closed Bill Group":
                BEGIN
                    ClosedBillGr.GET(Number);
                    ClosedBillGr."No. Printed" := ClosedBillGr."No. Printed" + 1;
                    ClosedBillGr.MODIFY;
                END;
            Table = DATABASE::"Posted Payment Order":
                BEGIN
                    PostedPaymentOrder.GET(Number);
                    PostedPaymentOrder."No. Printed" := PostedPaymentOrder."No. Printed" + 1;
                    PostedPaymentOrder.MODIFY;
                END;
            Table = DATABASE::"Closed Payment Order":
                BEGIN
                    ClosedPaymentOrder.GET(Number);
                    ClosedPaymentOrder."No. Printed" := ClosedPaymentOrder."No. Printed" + 1;
                    ClosedPaymentOrder.MODIFY;
                END;
            END;
            COMMIT;
        end;
    //+HEB.181
    //-HEB.244
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure SalespeersonToClientOnGenJnlPostLine(VAR CustLedgerEntry : Record "Cust. Ledger Entry";GenJournalLine : Record "Gen. Journal Line")
    begin
        //-244
        CustLedgerEntry."Distributor Code" := GenJournalLine."Distributor Code";
        CustLedgerEntry."Salesperson/Resp. Code" := GenJournalLine."Salesperson/Resp. Code";
        CustLedgerEntry."Administr/Resp. Code" := GenJournalLine."Administr/Resp. Code";
        //+244
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostCustomerEntry', '', true, true)]
    local procedure SalespeersonToClientOnSalesPost(VAR GenJnlLine : Record "Gen. Journal Line";SalesHeader : Record "Sales Header";VAR TotalSalesLine : Record "Sales Line";VAR TotalSalesLineLCY : Record "Sales Line")
    begin
        //-244
        GenJnlLine."Distributor Code" := SalesHeader."Distributor Code";
        GenJnlLine."Salesperson/Resp. Code" := SalesHeader."Salesperson/Resp. Code";
        GenJnlLine."Administr/Resp. Code" := SalesHeader."Administr/Resp. Code";
        //+244        
    end;
    //+HEB.244
    //-HEB.216
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure OnBeforePostSalesDocCheckUnitPriceZeroValue(VAR SalesHeader : Record "Sales Header")
    begin
        IF NOT CheckUnitPriceZeroValue(SalesHeader."Document Type", SalesHeader."No.") THEN
            ERROR('');        
    end;
    
    local procedure CheckUnitPriceZeroValue(DocType : Integer;DocNo : Code[20]) isOk : Boolean
    var
        SalesLine : Record "Sales Line";
        showWarning : Boolean;
        errorLines : Text[1024];
        SaltoLinea : Char;
        WARNING_MSG : Label 'Lines with %1 equals 0';
        WARNING_Continue : Label 'Do you want to continue?';
    begin
        //-Control valor "Coste unitario directo"
        //-216
        showWarning:=FALSE;
        errorLines:= '';
        isOk:=TRUE;
        SaltoLinea:=13;

        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type",DocType);
        SalesLine.SETRANGE("Document No.",DocNo);
        SalesLine.SETFILTER(Type,'<>%1',SalesLine.Type::" ");
        IF SalesLine.FINDSET(FALSE,FALSE) THEN
        REPEAT
            IF SalesLine."Unit Price" = 0 THEN
            BEGIN
                showWarning := TRUE;
                errorLines += STRSUBSTNO('%1 - (%2) %3 %4%5',SalesLine."Line No.",SalesLine.Type,SalesLine."No.", SalesLine.Description,SaltoLinea);
            END;
        UNTIL (SalesLine.NEXT=0);

        IF showWarning THEN
        BEGIN
            isOk := CONFIRM('%1\ \%2 \%3',FALSE,STRSUBSTNO(WARNING_MSG,SalesLine.FIELDCAPTION("Unit Price")) ,errorLines,WARNING_Continue)
        END;

        EXIT(isOk);
        //+216        
    end;
    //+HEB.216
    //-HEB.218
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderHeader', '', false, false)]
    local procedure OnBeforeInsertSalesOrderHeaderSetQuoteNo(VAR SalesOrderHeader : Record "Sales Header";SalesQuoteHeader : Record "Sales Header")
    begin
        SalesOrderHeader."Quote No." := SalesQuoteHeader."Quote No.";
        SalesOrderHeader."ProForma No." := SalesQuoteHeader."ProForma No.";
    end;
    //+HEB.218 
    //-HEB.218
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeInsertSalesOrderHeader', '', false, false)]
    local procedure OnBeforeInsertSalesOrderHeaderFromBlanketSetQuoteNo(VAR SalesOrderHeader : Record "Sales Header";BlanketOrderSalesHeader : Record "Sales Header")
    begin
        SalesOrderHeader."Quote No." := BlanketOrderSalesHeader."Quote No.";
        SalesOrderHeader."ProForma No." := BlanketOrderSalesHeader."ProForma No.";
    end;
    //+HEB.218
    
    //-HEB.218
    //PENDIENTE DE HACER REPORT
    // procedure PrintProforma(SalesHeader : Record "Sales Header")
    // var    
    //     ReportSelection : Record "Report Selections";
    //     SalesLine : Record "Sales Line";
    //     SalesSetup : Record "Sales & Receivables Setup";
    //     SalesCalcDisc : Codeunit "Sales-Calc. Discount";
    // begin
    //     IF SalesHeader."Document Type" <> SalesHeader."Document Type"::Quote THEN
    //         EXIT;

    //     SalesHeader.SETRANGE("No.",SalesHeader."No.");
    //     SalesSetup.GET;
    //     IF SalesSetup."Calc. Inv. Discount" THEN BEGIN
    //         SalesLine.RESET;
    //         SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
    //         SalesLine.SETRANGE("Document No.",SalesHeader."No.");
    //         SalesLine.FIND('-');
    //         SalesCalcDisc.RUN(SalesLine);
    //         SalesHeader.GET(SalesHeader."Document Type",SalesHeader."No.");
    //         COMMIT;
    //     END;

    //     REPORT.RUNMODAL(REPORT::"Sales - ProForma HEB",TRUE,FALSE,SalesHeader);
    // end;
    //+HEB.218
    //-HEB.248
    //PENDIENTE QUE MICROSOFT PONGA EL EVENTO EN FUTURA RELEASE
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustVendBank-Update", 'OnAfterUpdateCustomer', '', false, false)]
    // local procedure OnAfterUpdateCustomerInformContactFields(VAR Customer : Record Customer;Contact : Record Contact)
    // begin
    //     //-248
    //     //"Salesperson Code" := '';
    //     //"Salesperson/Resp. Code" := Cont."Salesperson Code";
    //     //+248
    //     //<HEB.001
    //     Customer."Salesperson Code" := Contact."Salesperson Code";
    //     Customer."Salesperson/Resp. Code" := Contact."Salesperson/Resp. Code";
    //     Customer."Administr/Resp. Code" := Contact."Administr/Resp. Code";
    //     Customer."Distributor Code" := Contact."Distributor Code";
    //     //HEB.001>
    // end;
    //+HEB.248

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterSetFieldsBilltoCustomer', '', false, false)]
    local procedure OnAfterSetFieldsBillToCustomerSetNewFields(VAR SalesHeader : Record "Sales Header";Customer : Record Customer)
    begin
        //-HEB.130
        SalesHeader."Pay-at Code" := Customer."Cód. dirección pago genérico";
        //+HEB.130
        //-HEB.244
        SalesHeader."Distributor Code" := Customer."Distributor Code";
        SalesHeader."Salesperson/Resp. Code" := Customer."Salesperson/Resp. Code";
        SalesHeader."Administr/Resp. Code" := Customer."Administr/Resp. Code";
        //+HEB.244
    end;

    //-HEB.104
    PROCEDURE SalesInvBillTo2(VAR AddrArray : ARRAY [8] OF Text[50];VAR SalesInvHeader : Record "Sales Invoice Header");
    var
        FormatAddress : Codeunit "Format Address";
    BEGIN
      WITH SalesInvHeader DO
        FormatAddress.FormatAddr(
          AddrArray,"Bill-to Name","Bill-to Name 2",'',"Bill-to Address","Bill-to Address 2",
          "Bill-to City", "Bill-to Post Code","Bill-to County","Bill-to Country/Region Code");
        AddrArray[8] := SalesInvHeader."VAT Registration No.";
        COMPRESSARRAY(AddrArray);
    END;
    //-HEB.104
    
    //-HEB.506
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure CheckInfoINTRASTAT(var SalesHeader :Record "Sales Header");
    var
        CountryRegion : Record "Country/Region";
        SalesLine : Record "Sales Line";
        Item : Record Item;
    begin
        IF (NOT (SalesHeader."Sell-to Country/Region Code" <> 'ES'))  THEN
            EXIT;

        IF NOT CountryRegion.GET(SalesHeader."Sell-to Country/Region Code") THEN
            CountryRegion.INIT;
        IF NOT (CountryRegion."Intrastat Code" <> '') THEN
            EXIT;

        SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.",SalesHeader."No.");
        SalesLine.SETRANGE(Type,SalesLine.Type :: Item);
        SalesLine.SETFILTER("Qty. to Ship",'>0');
        IF SalesLine.FINDFIRST THEN BEGIN
            SalesHeader.TESTFIELD("Transaction Specification");
            SalesHeader.TESTFIELD("Transaction Type");
            SalesHeader.TESTFIELD("Transport Method");
            SalesHeader.TESTFIELD("Shipment Method Code");
            SalesHeader.TESTFIELD("Exit Point");
            REPEAT
            Item.GET(SalesLine."No.");
            Item.TESTFIELD("Tariff No.");
            IF Item.Type <> Item.Type :: Service THEN BEGIN
                //SalesLine.TESTFIELD("Gross Weight");
                SalesLine.TESTFIELD("Net Weight");
            END;
            UNTIL SalesLine.NEXT = 0;
        END;   
    end; 
    //+HEB.506

    procedure PrintCounterExt(Table : Integer;Number : Code[20])
    var
        PostedBillGr : Record "Posted Bill Group";
        ClosedBillGr : Record "Closed Bill Group";
        PostedPaymentOrder : Record "Posted Payment Order";
        ClosedPaymentOrder : Record "Closed Payment Order";
        BillGr : Record "Bill Group";
        PaymentOrder : Record "Payment Order";
    begin
        CASE TRUE OF
        Table = DATABASE::"Bill Group":
            BEGIN
                BillGr.GET(Number);
                BillGr."No. Printed" := BillGr."No. Printed" + 1;
                BillGr.MODIFY;
            END;
        Table = DATABASE::"Payment Order":
            BEGIN
                PaymentOrder.GET(Number);
                PaymentOrder."No. Printed" := PaymentOrder."No. Printed" + 1;
                PaymentOrder.MODIFY;
            END;
        Table = DATABASE::"Posted Bill Group":
            BEGIN
                PostedBillGr.GET(Number);
                PostedBillGr."No. Printed" := PostedBillGr."No. Printed" + 1;
                PostedBillGr.MODIFY;
            END;
        Table = DATABASE::"Closed Bill Group":
            BEGIN
                ClosedBillGr.GET(Number);
                ClosedBillGr."No. Printed" := ClosedBillGr."No. Printed" + 1;
                ClosedBillGr.MODIFY;
            END;
        Table = DATABASE::"Posted Payment Order":
            BEGIN
                PostedPaymentOrder.GET(Number);
                PostedPaymentOrder."No. Printed" := PostedPaymentOrder."No. Printed" + 1;
                PostedPaymentOrder.MODIFY;
            END;
        Table = DATABASE::"Closed Payment Order":
            BEGIN
                ClosedPaymentOrder.GET(Number);
                ClosedPaymentOrder."No. Printed" := ClosedPaymentOrder."No. Printed" + 1;
                ClosedPaymentOrder.MODIFY;
            END;
        END;
        COMMIT;
    end;

    procedure SalesQuoteToOrderYesNo(Var Rec : Record "Sales Header")
    var
        SalesHeader2 : Record "Sales Header";
        SalesQuoteToBlanketOrder : Codeunit "Sales-Quote to Blanket Order";
        ConfirmConvertToOrderQst : Label 'Do you want to convert the quote to an order?';
    begin
        Rec.TESTFIELD("Document Type",Rec."Document Type"::Quote);
        IF GUIALLOWED THEN
            IF NOT CONFIRM(ConfirmConvertToOrderQst,FALSE) THEN
                EXIT;

        IF Rec.CheckCustomerCreated(TRUE) THEN
            Rec.GET(Rec."Document Type"::Quote,Rec."No.")
        ELSE
            EXIT;

        SalesQuoteToBlanketOrder.RUN(Rec);
        SalesQuoteToBlanketOrder.GetSalesOrderHeader(SalesHeader2);
        COMMIT;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderHeader', '', false, false)]
    local procedure OnBeforeInsertSalesOrderHeaderSetSIIExclude(VAR SalesOrderHeader : Record "Sales Header";SalesQuoteHeader : Record "Sales Header")
    begin
        SalesOrderHeader."SII Exclude" := SalesQuoteHeader."SII Exclude";
    end;

    procedure DirectPrintSalesHeader(SalesHeader : Record "Sales Header";PDF : Boolean)
    var
        Language : Record Language;
        Customer : Record Customer;
        ReportSelection : Record "Report Selections";
        SalesSetup : Record "Sales & Receivables Setup";
        SalesLine : Record "Sales Line";
        Utilidades : Codeunit "General Abast Library";
        SalesCalcDisc : Codeunit "Sales-Calc. Discount";
        NombreFichero : Text[250];
        SubjectText : Text[250];
        CurrentLanguage : Integer;
        DocType : Text[30];
        ExtDoc : Label 'CUSTOMER REFERENCE No.';
    begin
        //-156
        SalesHeader.SETRANGE("No.",SalesHeader."No.");
        SalesSetup.GET;
        IF SalesSetup."Calc. Inv. Discount" THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.",SalesHeader."No.");
            SalesLine.FIND('-');
            SalesCalcDisc.RUN(SalesLine);
            SalesHeader.GET(SalesHeader."Document Type",SalesHeader."No.");
            COMMIT;
        END;

        NombreFichero := Utilidades.GenerarPDF(SalesHeader, SalesHeader."No.", SalesHeader."Document Type", 18);
        
        Customer.GET(SalesHeader."Sell-to Customer No.");
        CurrentLanguage := GLOBALLANGUAGE;
        GLOBALLANGUAGE := Language.GetLanguageID(Customer."Language Code");
        DocType := UPPERCASE(FORMAT(SalesHeader."Document Type"));
        IF SalesHeader."External Document No." <> '' THEN
            SubjectText := STRSUBSTNO('%1 %2 %3 %4',DocType,SalesHeader."No.",ExtDoc,SalesHeader."External Document No.")
        ELSE SubjectText := STRSUBSTNO('%1 %2',DocType,SalesHeader."No.");
            GLOBALLANGUAGE := CurrentLanguage;
        
        Utilidades.EnvioDocCorreoPDF(0,SalesHeader."Document Type"+1,0,SalesHeader."Sell-to Customer No.",SubjectText,NombreFichero,TRUE,false);
    end;
}
