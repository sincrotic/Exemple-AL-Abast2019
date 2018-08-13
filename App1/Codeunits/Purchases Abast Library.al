//HEB.144 AL 25052018 Posibilidad de modificar la descripción del mov. cliente/proveedor (condicionado)
//HEB.102 AL 25052018 Añadido campo "No.Doc.Previsión" en tabla 246 Requisition Line
//HEB.135 MR 07062018 Recalular el "Currency factor" al registrar pedidos de compra/venta
//HEB.184 MR 30052018 Al Registrar compra, si exitiste ADUANA comprobar DUA
//HEB.209 MR 31052018 Exp. 9006: Control "% Coste Indirecto" al registrar documents de compra  (CDU 90)
//HEB.214 MR 31052018 Exp. 9205: Control Reg. Doc. Compra: Avis linies amb "Cost Unitari Directa" = 0
//HEB.215 MR 21062018 Exp. 9205: Control Dim. FAMILIA al asociar carrecs producte (CDU 5805)
//HEB.229 MR 31052018 Control de cost unitari respecte cost unitari directe
codeunit 50001 "Purchases Abast Library"
{
    var
      AsciiStr : Text [250];
      AnsiStr : Text [250];
      VATBusPostingGr : Code [10];
      CharVar : array [32] of Char;
      ExchRateDate : Date;
      PricesInCurrency : Boolean; 
      PricesInclVAT : Boolean;
      PriceInSKU : Boolean;
      FoundPurchPrice : Boolean;
      CurrencyFactor : Decimal;
      VATPerCent : Decimal;
      Qty : Decimal;
      QtyPerUOM : Decimal;
      LineDiscPerCent : Decimal;
      item : Record Item;
      Currency : Record Currency;
      GLSetup : Record "General Ledger Setup";
      SKU : Record "Stockkeeping Unit";
      TempPurchPrice : Record "Purchase Price";
      Vend : Record Vendor;
      
  procedure UpdVendLedgerEntryDescription(var Rec: Record "Vendor Ledger Entry")
  var 
    VendLedgEntry:Record "Vendor Ledger Entry";
    GLEntry:Record "G/L Entry";
    BankAccLedgEntry:Record "Bank Account Ledger Entry";
    CheckLedgEntry:Record "Check Ledger Entry";
    GenJournalTemplate: Record "Gen. Journal Template";
    SCPay : Label 'Payments';
    TxtErrSC1 : Label 'Solo se pueden editar las descripciones de los movimentos\';
    TxtErrSC2 : Label 'Procedentes del diario General y de %1';
  begin         
    //-HEB.144
    GenJournalTemplate.RESET;
    GenJournalTemplate.SETFILTER(Type,'%1|%2',GenJournalTemplate.Type::General,
                                              GenJournalTemplate.Type::Payments);
    GenJournalTemplate.SETRANGE("Source Code",Rec."Source Code");

    IF NOT GenJournalTemplate.FINDFIRST THEN
      ERROR (TxtErrSC1+TxtErrSC2,SCPay);

    GLEntry.RESET;
    GLEntry.LOCKTABLE;
    GLEntry.SETCURRENTKEY("Document No.","Posting Date");
    GLEntry.SETRANGE("Document No.",Rec."Document No.");
    GLEntry.SETRANGE("Bill No.",Rec."Bill No.");
    GLEntry.SETRANGE("Posting Date",Rec."Posting Date");
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
    BankAccLedgEntry.SETRANGE("Document Type",Rec."Document Type");
    BankAccLedgEntry.SETRANGE("Bill No.",Rec."Bill No.");
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
        UNTIL CheckLedgEntry.NEXT=0;
    END;
    //END Toni-16_07_18
    
    VendLedgEntry.RESET;
    VendLedgEntry.SETCURRENTKEY("Document No.");
    VendLedgEntry.SETRANGE("Document No.",Rec."Document No.");
    VendLedgEntry.SETRANGE("Bill No.",Rec."Bill No.");
    VendLedgEntry.SETRANGE("Posting Date",Rec."Posting Date");
    VendLedgEntry.SETRANGE("Document Type",Rec."Document Type");
      IF VendLedgEntry.FINDFIRST THEN
        REPEAT
          VendLedgEntry.Description :=Rec.Description;
          VendLedgEntry.MODIFY;
        UNTIL VendLedgEntry.NEXT=0;

    VendLedgEntry.RESET;
    VendLedgEntry.GET(Rec."Entry No.");
    Rec:=VendLedgEntry;
    //+HEB.144
  end;

  //-HEB.102_TLM
  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInsertPurchOrderHeader','', true, true)]
  local procedure InsertNoDocPrevision (var RequisitionLine:Record "Requisition Line"; var PurchaseOrderHeader:Record "Purchase Header")

  begin
    //-HEB.102
      PurchaseOrderHeader."No.Doc.Previsión" := RequisitionLine."No. Doc. Previsión";
    //+HEB.102
  end;

  procedure Ascii2Ansi(_Text : Text [250]) : Text [250]
  begin
    MakeVars;
    EXIT(CONVERTSTR(_Text,AsciiStr,AnsiStr));
  end;

  local procedure MakeVars()

  begin  
    AsciiStr := 'ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜø£Ø×ƒáíóúñÑªº¿®¬½¼¡«»¦¦¦¦¦ÁÂÀ©¦¦++¢¥++--+-+ãÃ++--¦-+';
    AsciiStr := AsciiStr +'¤ðÐÊËÈiÍÎÏ++¦_¦Ì¯ÓßÔÒõÕµþÞÚÛÙýÝ¯´­±=¾¶§÷¸°¨·¹³²¦ ';
    CharVar[1] := 196;
    CharVar[2] := 197;
    CharVar[3] := 201;
    CharVar[4] := 242;
    CharVar[5] := 220;
    CharVar[6] := 186;
    CharVar[7] := 191;
    CharVar[8] := 188;
    CharVar[9] := 187;
    CharVar[10] := 193;
    CharVar[11] := 194;
    CharVar[12] := 192;
    CharVar[13] := 195;
    CharVar[14] := 202;
    CharVar[15] := 203;
    CharVar[16] := 200;
    CharVar[17] := 205;
    CharVar[18] := 206;
    CharVar[19] := 204;
    CharVar[20] := 175;
    CharVar[21] := 223;
    CharVar[22] := 213;
    CharVar[23] := 254;
    CharVar[24] := 218;
    CharVar[25] := 219;
    CharVar[26] := 217;
    CharVar[27] := 180;
    CharVar[28] := 177;
    CharVar[29] := 176;
    CharVar[30] := 185;
    CharVar[31] := 179;
    CharVar[32] := 178;
    AnsiStr  := 'Ã³ÚÔõÓÕþÛÙÞ´¯ý'+FORMAT(CharVar[1])+FORMAT(CharVar[2])+FORMAT(CharVar[3])+ 'µã¶÷'+FORMAT(CharVar[4]);
    AnsiStr := AnsiStr + '¹¨ Í'+FORMAT(CharVar[5])+'°úÏÎâßÝ¾·±Ð¬'+FORMAT(CharVar[6])+FORMAT(CharVar[7]);
    AnsiStr := AnsiStr + '«¼¢'+FORMAT(CharVar[8])+'í½'+FORMAT(CharVar[9])+'___ªª' + FORMAT(CharVar[10])+FORMAT(CharVar[11]);
    AnsiStr := AnsiStr + FORMAT(CharVar[12]) + '®ªª++óÑ++--+-+Ò' + FORMAT(CharVar[13]) + '++--ª-+ñ­ð';
    AnsiStr  :=  AnsiStr +FORMAT(CharVar[14])+FORMAT(CharVar[15])+FORMAT(CharVar[16])+'i'+FORMAT(CharVar[17])+FORMAT(CharVar[18]);
    AnsiStr  :=  AnsiStr + '¤++__ª' + FORMAT(CharVar[19])+FORMAT(CharVar[20])+'Ë'+FORMAT(CharVar[21])+'ÈÊ§';
    AnsiStr  :=  AnsiStr + FORMAT(CharVar[22]) + 'Á' + FORMAT(CharVar[23]) + 'Ì' + FORMAT(CharVar[24])+ FORMAT(CharVar[25]);
    AnsiStr  :=  AnsiStr + FORMAT(CharVar[26]) + '²¦»' + FORMAT(CharVar[27]) + '¡' + FORMAT(CharVar[28]) +'=¥Âº¸©'+ FORMAT(CharVar[29]);
    AnsiStr  :=  AnsiStr + '¿À' + FORMAT(CharVar[30]) +FORMAT(CharVar[31]) +FORMAT(CharVar[32]) +'_ ';
  end;

  local procedure SetCurrency(CurrencyCode2 : Code [10];CurrencyFactor2 : Decimal;ExchRateDate2 : Date)
  begin  
    PricesInCurrency := CurrencyCode2 <> '';
    IF PricesInCurrency THEN BEGIN
      Currency.GET(CurrencyCode2);
      Currency.TESTFIELD("Unit-Amount Rounding Precision");
      CurrencyFactor :=  CurrencyFactor2;
      ExchRateDate := ExchRateDate2;
    END ELSE
      GLSetup.GET;
  end;

  local procedure SetVAT(PriceInclVAT2 : Boolean;VATPerCent2 : Decimal;VATBusPostingGr2:Code [10])
  begin
    PricesInclVAT :=  PriceInclVAT2;
    VATPerCent := VATPerCent2;
    VATBusPostingGr :=  VATBusPostingGr2;
  end;
  local procedure SetUoM(Qty2 : Decimal;QtyPerUom2 :Decimal)
  begin
    Qty := Qty2;
    QtyPerUOM := QtyPerUoM2;
  end;

  local procedure FindPurchPrice(var ToPurchPrice : Record "Purchase Price";VendorNo : Code[20];ItemNo : Code[20];VariantCode : Code[10];UOM : Code[10];CurrencyCode : Code[10];StartingDate : Date;ShowAll : Boolean)
  var
    FromPurchPrice : Record "Purchase Price";
  begin
    WITH FromPurchPrice DO
    BEGIN
        SETRANGE("Item No.", ItemNo);
        SETRANGE("Vendor No.", VendorNo);
        SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
        SETFILTER("Variant Code", '%1|%2', VariantCode, '');
        IF NOT ShowAll THEN BEGIN
            SETRANGE("Starting Date", 0D, StartingDate);
            SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
            SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
        END;

        ToPurchPrice.RESET;
        ToPurchPrice.DELETEALL;
        IF FIND('-') THEN
            REPEAT
      IF "Direct Unit Cost" <> 0 THEN BEGIN
                ToPurchPrice := FromPurchPrice;
                ToPurchPrice.INSERT;
            END;
            UNTIL NEXT = 0;
    END;
  end;
  local procedure IsInMinQty(UnitofMeasureCode : Code[10];MinQty : Decimal) : Boolean
    begin
      IF UnitofMeasureCode = '' THEN
        EXIT(MinQty <= QtyPerUOM * Qty);
      EXIT(MinQty <= Qty);
    end;
  local procedure ConvertPriceToVAT(FromPriceInclVAT : Boolean;FromVATProdPostingGr : Code[20];FromVATBusPostingGr : Code[20];VAR UnitPrice : Decimal)
  var
    VATPostingSetup : Record "VAT Posting Setup";
  begin
    IF FromPriceInclVAT THEN BEGIN
      IF NOT VATPostingSetup.GET(FromVATBusPostingGr,FromVATProdPostingGr) THEN
        VATPostingSetup.INIT;

      IF PricesInclVAT THEN BEGIN
        IF VATBusPostingGr <> FromVATBusPostingGr THEN
          UnitPrice := UnitPrice * (100 + VATPerCent) / (100 + VATPostingSetup."VAT %");
      END ELSE
        UnitPrice := UnitPrice / (1 + VATPostingSetup."VAT %" / 100);
    END ELSE
      IF PricesInclVAT THEN
        UnitPrice := UnitPrice * (1 + VATPerCent / 100);
  end;
  local procedure ConvertPriceToUoM(UnitOfMeasureCode : Code[10];VAR UnitPrice : Decimal)
  begin
    IF UnitOfMeasureCode = '' THEN
      UnitPrice := UnitPrice * QtyPerUOM;
  end;
  local procedure ConvertPriceLCYToFCY(CurrencyCode: Code[10]; VAR UnitPrice: Decimal)
  var
    CurrExchRate : Record "Currency Exchange Rate";
  begin
      IF PricesInCurrency THEN BEGIN
          IF CurrencyCode = '' THEN
              UnitPrice :=
        CurrExchRate.ExchangeAmtLCYToFCY(ExchRateDate, Currency.Code, UnitPrice, CurrencyFactor);
          UnitPrice := ROUND(UnitPrice, Currency."Unit-Amount Rounding Precision");
      END ELSE
          UnitPrice := ROUND(UnitPrice, GLSetup."Unit-Amount Rounding Precision");
  end;
  local procedure CalcLineAmount(PurchPrice : Record "Purchase Price") : Decimal
  begin
    WITH PurchPrice DO
      EXIT("Direct Unit Cost" * (1 - LineDiscPerCent / 100));
  end;
  local procedure CalcBestDirectUnitCost(var PurchPrice : Record "Purchase Price")
  var
    BestPurchPrice : Record "Purchase Price";
  begin
    WITH PurchPrice DO
    BEGIN
        FoundPurchPrice := FIND('-');
        IF FoundPurchPrice THEN
            REPEAT
      IF IsInMinQty("Unit of Measure Code", "Minimum Quantity") THEN BEGIN
                ConvertPriceToVAT(Vend."Prices Including VAT", Item."VAT Prod. Posting Group",Vend."VAT Bus. Posting Group", "Direct Unit Cost");
                ConvertPriceToUoM("Unit of Measure Code", "Direct Unit Cost");
                ConvertPriceLCYToFCY("Currency Code", "Direct Unit Cost");

                CASE TRUE OF
          ((BestPurchPrice."Currency Code" = '') AND("Currency Code" <> '')) OR
          ((BestPurchPrice."Variant Code" = '') AND("Variant Code" <> '')) :
            BestPurchPrice := PurchPrice;
                ((BestPurchPrice."Currency Code" = '') OR("Currency Code" <> '')) AND
          ((BestPurchPrice."Variant Code" = '') OR("Variant Code" <> '')) :
            IF(BestPurchPrice."Direct Unit Cost" = 0) OR
                (CalcLineAmount(BestPurchPrice) > CalcLineAmount(PurchPrice))
            THEN
                    BestPurchPrice := PurchPrice;
                END;
            END;
            UNTIL NEXT = 0;
    END;

    // No price found in agreement
    IF BestPurchPrice."Direct Unit Cost" = 0 THEN BEGIN
        PriceInSKU := PriceInSKU AND(SKU."Last Direct Cost" <> 0);
        IF PriceInSKU THEN
            BestPurchPrice."Direct Unit Cost" := SKU."Last Direct Cost"
        ELSE
            BestPurchPrice."Direct Unit Cost" := Item."Last Direct Cost";

        ConvertPriceToVAT(FALSE, Item."VAT Prod. Posting Group", '', BestPurchPrice."Direct Unit Cost");
        ConvertPriceToUoM('', BestPurchPrice."Direct Unit Cost");
        ConvertPriceLCYToFCY('', BestPurchPrice."Direct Unit Cost");
    END;

    PurchPrice := BestPurchPrice;
  end;
  //+HEB.102_TLM

  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterCheckPurchDoc', '', false, false)]
  local procedure OnAfterCheckPurchDocTestAduana(PurchHeader : Record "Purchase Header")
  begin
    //-184
    IF (PurchHeader.Invoice) AND (NOT TestADUANAOk(PurchHeader)) THEN
      ERROR('Debe informar los datos DUA en la cabecera del documento');
    //+184    
  end;

  procedure TestADUANAOk(PurchHeader : Record "Purchase Header") : Boolean;
  var
    PurhLines : Record "Purchase Line";
  begin
    //-184
      PurhLines.RESET;
      PurhLines.SETRANGE("Document Type",PurchHeader."Document Type");
      PurhLines.SETRANGE("Document No.",PurchHeader."No.");
      PurhLines.SETRANGE("VAT Bus. Posting Group",GetFilterStringADUANAS);
      IF PurhLines.ISEMPTY THEN EXIT(TRUE);
      CLEAR(PurhLines);

      IF (PurchHeader."Nº DUA" = '') OR
        (PurchHeader."Fecha DUA" = 0D) OR
        (PurchHeader."Proveedor Origen" = '') THEN EXIT(FALSE);

      EXIT(TRUE);
    //+184
  end;

  procedure GetFilterStringADUANAS() FiltroAduanas : Text[1024]
  var
    ListaAduanas : Text[1024];
    Position : Integer;
    VATBusPosting : Record "VAT Business Posting Group";
  begin
    //+184
    FiltroAduanas := '';
    VATBusPosting.RESET;
    VATBusPosting.SETRANGE("Requiere DUA",TRUE);
    IF VATBusPosting.FINDSET(FALSE,FALSE) THEN
      REPEAT
        IF ListaAduanas = '' THEN
          ListaAduanas := VATBusPosting.Code
        ELSE
          ListaAduanas += ListaAduanas + ';' + VATBusPosting.Code;
      UNTIL VATBusPosting.NEXT=0;

    REPEAT
      Position := STRPOS(ListaAduanas,';');
      IF ListaAduanas <> '' THEN BEGIN
        IF Position <> 0 THEN BEGIN
          FiltroAduanas := FiltroAduanas + COPYSTR(ListaAduanas,1,Position - 1);
          ListaAduanas := COPYSTR(ListaAduanas,Position + 1);
        END ELSE BEGIN
          FiltroAduanas := FiltroAduanas + COPYSTR(ListaAduanas,1);
          ListaAduanas := '';
        END;
        IF ListaAduanas <> '' THEN
          FiltroAduanas := FiltroAduanas + '|';
      END;
    UNTIL ListaAduanas = '';
    //-184
  end;


  //+HEB.128
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', true,true)]
    local procedure OnAfterReleasePurchaseDocPurchase(VAR PurchaseHeader: Record "Purchase Header")
    var 
        ArchiveManagement :Codeunit ArchiveManagement;

    begin
        //+HEB.128
        IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) THEN
            ArchiveManagement.StorePurchDocument(PurchaseHeader,FALSE);
        //-HEB.128
    end;
    //-HEB.128

  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', true, true)]
  local procedure OnBeforePostPurchaseDocCheckCosteIndirecto(VAR PurchaseHeader : Record "Purchase Header")
  var
    Text50000 : Label	'%1 is not 0 in all lines';
    Text50001 : Label '%1 is greater than %2 in one of the lines. \Do you want to continue posting ?';
    PurchLine : Record "Purchase Line";
  begin
      //-HEB.209
      //-Control valor campo "% coste indirecto"
      IF NOT CheckIndirecCostValue(PurchaseHeader."Document Type",PurchaseHeader."No.") THEN
        ERROR(Text50000,PurchLine.FIELDCAPTION("Indirect Cost %"));
      //+HEB.209

      //-HEB.229
      // Control de cost unitari respecte cost unitari directe
      IF NOT CheckUnitCostValue(PurchaseHeader."Document Type", PurchaseHeader."No.") THEN
        IF NOT CONFIRM(Text50001, FALSE, PurchLine.FIELDCAPTION("Direct Unit Cost"), PurchLine.FIELDCAPTION("Unit Cost")) THEN
          EXIT;
      //+HEB.229

      //-HEB.214
      //-Control Linies amb Preu Compra 0
      IF NOT CheckDirectUnitCostZeroValue(PurchaseHeader."Document Type",PurchaseHeader."No.") THEN
        ERROR('');
      //+HEB.214
  end;

  //-HEB.209
  //-Control valor campo "% coste indirecto"
  procedure CheckIndirecCostValue(DocType : Integer;DocNo : Code[20]) isOk : Boolean
  var
    PurchLine : Record "Purchase Line";
  begin
    isOk:=TRUE;
    PurchLine.RESET;
    PurchLine.SETRANGE("Document Type",DocType);
    PurchLine.SETRANGE("Document No.",DocNo);
    IF PurchLine.FINDSET(FALSE,FALSE) THEN
      REPEAT
        isOk := (PurchLine."Indirect Cost %" = 0);
      UNTIL (PurchLine.NEXT=0) OR (NOT isOk);

    EXIT(isOk);
  end;
  //+HEB.209 
  //-HEB.214
  //-Control valor "Coste unitario directo"
  procedure CheckDirectUnitCostZeroValue(DocType : Integer;DocNo : Code[20]) isOk : Boolean
  var
    PurchLine : Record "Purchase Line";
    showWarning : Boolean;
    errorLines : Text[1024];
    SaltoLinea : Char;
    WARNING_MSG : Label 'Lines with %1 equals 0';
    WARNING_Continue : Label 'Do you want to continue?';
  begin
    showWarning := FALSE;
    errorLines := '';
    isOk := TRUE;
    SaltoLinea := 13;
    PurchLine.RESET;
    PurchLine.SETRANGE("Document Type", DocType);
    PurchLine.SETRANGE("Document No.", DocNo);
    PurchLine.SETFILTER(Type, '<>%1', PurchLine.Type::" ");
    IF PurchLine.FINDSET(FALSE, FALSE) THEN
      REPEAT
        IF PurchLine."Direct Unit Cost" = 0 THEN BEGIN
          showWarning := TRUE;
          errorLines += STRSUBSTNO('%1 - (%2) %3 %4%5', PurchLine."Line No.", PurchLine.Type, PurchLine."No.", PurchLine.Description, SaltoLinea);
        END;
      UNTIL (PurchLine.NEXT = 0);

    IF showWarning THEN BEGIN
      isOk := CONFIRM('%1\ \%2 \%3',FALSE,STRSUBSTNO(WARNING_MSG,PurchLine.FIELDCAPTION("Direct Unit Cost")),errorLines,WARNING_Continue)
    END;
    EXIT(isOk);
  end;
  //+HEB.214
  //-HEB.229
  //-Control valor coste unitari no superi el preu de compra
  procedure CheckUnitCostValue(DocType : Integer;DocNo : Code[20]) isOk : Boolean
  var
    PurchLine : Record "Purchase Line";
  begin
    isOk:=TRUE;
    PurchLine.RESET;
    PurchLine.SETRANGE("Document Type", DocType);
    PurchLine.SETRANGE("Document No.", DocNo);
    IF PurchLine.FINDSET(FALSE,FALSE) THEN
      REPEAT
        isOk := (PurchLine."Direct Unit Cost" = PurchLine."Unit Cost");
      UNTIL (PurchLine.NEXT=0) OR (NOT isOk);

    EXIT(isOk);
  end;
  //+HEB.229
  //-HEB.135
  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', true, true)]
  local procedure OnBeforeConfirmPurchasePostValidatePostingDate(VAR PurchaseHeader : Record "Purchase Header";VAR HideDialog : Boolean)
  begin
    //-135
    PurchaseHeader.VALIDATE("Posting Date");
    //+135        
  end;
  //+HEB.135
  //-HEB.135
  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforeConfirmPost', '', true, true)]
  local procedure OnBeforeConfirmPurchPostValidatePostingDate(VAR PurchaseHeader : Record "Purchase Header";VAR HideDialog : Boolean)
  begin
    //-135
    PurchaseHeader.VALIDATE("Posting Date");
    //+135        
  end;
  //+HEB.135
  //-HEB.215
  [EventSubscriber(ObjectType::Table, Database::"Item Charge Assignment (Purch)", 'OnAfterInsertEvent', '', false, false)]
  local procedure OnAfterInsertItemChargePurchCheckFamilyDimension(VAR Rec : Record "Item Charge Assignment (Purch)";RunTrigger : Boolean)
  var
    W_MSG : Label 'Dimension FAMILIA difierentes\Linea Asociada: %1 %2 %3';
  begin
    //-215
    IF NOT CheckFamilyDimension(Rec."Item Charge No.", Rec."Item No.") THEN BEGIN
      IF Rec."Applies-to Doc. Type" <> Rec."Document Type" THEN
        MESSAGE(W_MSG, Rec."Applies-to Doc. No.", Rec."Applies-to Doc. Line No.", Rec."Item No.");
      Rec.Delete(true);
    END;
    //+215    
  end;

  local procedure CheckFamilyDimension(ItemChargeNo : Code[20];ItemNo : Code[20]) isOk : Boolean
  var
    PurchaseSetup : Record "Purchases & Payables Setup";
    ItemCharge : Record "Item Charge";
    ItemChargeDefaultDim : Record "Default Dimension";
    ItemDefaultDim : Record "Default Dimension";
  begin
    //-215
    isOk:=TRUE;
    //Buscamos el valor de Código de dimension FAMILIA
    PurchaseSetup.GET;
    IF PurchaseSetup."FAMILY Dimension Code" = '' THEN
      EXIT;
    //Comprobamos si el cargo producto debe controlar la dimension Familia
      ItemCharge.GET(ItemChargeNo);
      IF NOT ItemCharge."Check FAMILY Dimension" THEN
        EXIT;
    //Buscamos el valor Dimension FAMILIA para el cargo producto
      CLEAR(ItemChargeDefaultDim);
      IF ItemChargeDefaultDim.GET(DATABASE::"Item Charge",ItemCharge."No.",PurchaseSetup."FAMILY Dimension Code") THEN;
    //Buscamos el valor Dimension FAMILIA para el producto
      CLEAR(ItemDefaultDim);
      IF ItemDefaultDim.GET(DATABASE::Item,ItemNo,PurchaseSetup."FAMILY Dimension Code") THEN;
    //Comparamos los valores
      isOk := (ItemChargeDefaultDim."Dimension Value Code" = ItemDefaultDim."Dimension Value Code");
    //+215
  end;
  //+HEB.215
  //-HEB.506
  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', true, true)]
  local procedure CheckInfoINTRASTAT(VAR PurchaseHeader : Record "Purchase Header")
  var
    CountryRegion : Record "Country/Region";
    PurchLine : Record "Purchase Line";
    Item : Record Item;
    
  begin
    IF (NOT (PurchaseHeader."Buy-from Country/Region Code" <> 'ES'))  THEN
        EXIT;

      IF NOT CountryRegion.GET(PurchaseHeader."Buy-from Country/Region Code") THEN
        CountryRegion.INIT;
      IF NOT (CountryRegion."Intrastat Code" <> '') THEN
        EXIT;

      PurchLine.SETRANGE("Document Type",PurchLine."Document Type");
      PurchLine.SETRANGE("Document No.",PurchaseHeader."No.");
      PurchLine.SETRANGE(Type,PurchLine.Type :: Item);
      PurchLine.SETFILTER("Qty. to Receive",'>0');
      IF PurchLine.FINDFIRST THEN BEGIN
        PurchaseHeader.TESTFIELD("Transaction Specification");
        PurchaseHeader.TESTFIELD("Transaction Type");
        PurchaseHeader.TESTFIELD("Transport Method");
        PurchaseHeader.TESTFIELD("Shipment Method Code");
        PurchaseHeader.TESTFIELD(PurchaseHeader."Entry Point");
        REPEAT
          Item.GET(PurchLine."No.");
          PurchLine.TESTFIELD("Tariff No.");
          IF Item.Type <> Item.Type :: Service THEN BEGIN
            //PurchLine.TESTFIELD("Gross Weight");
            PurchLine.TESTFIELD("Net Weight");
          END;
        UNTIL PurchLine.NEXT = 0;
      END;
  end;
  //+HEB.506

  procedure DirectPrintPurchaseHeader(PurchaseHeader : Record "Purchase Header";PDF : Boolean)
  var
      Language : Record Language;
      Vendor : Record Vendor;
      ReportSelection : Record "Report Selections";
      Purchase : Record "Purchases & Payables Setup";
      PurchaseLine : Record "Purchase Line";
      Utilidades : Codeunit "General Abast Library";
      PurchaseCalcDisc : Codeunit "Purch - Calc Disc. By Type";
      NombreFichero : Text[250];
      SubjectText : Text[250];
      CurrentLanguage : Integer;
      DocType : Text[30];
      ExtDoc : Label 'VENDOR REFERENCE No.';
  begin
    //-156
    PurchaseHeader.SETRANGE("No.",PurchaseHeader."No.");
    Purchase.GET;
    IF Purchase."Calc. Inv. Discount" THEN BEGIN
      PurchaseLine.RESET;
      PurchaseLine.SETRANGE("Document Type",PurchaseHeader."Document Type");
      PurchaseLine.SETRANGE("Document No.",PurchaseHeader."No.");
      PurchaseLine.FIND('-');
      PurchaseCalcDisc.RUN(PurchaseLine);
      PurchaseHeader.GET(PurchaseHeader."Document Type",PurchaseHeader."No.");
      COMMIT;
    END;

    NombreFichero := Utilidades.GenerarPDF(PurchaseHeader, PurchaseHeader."No.", PurchaseHeader."Document Type", 21);
    
    Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
    CurrentLanguage := GLOBALLANGUAGE;
    GLOBALLANGUAGE := Language.GetLanguageID(Vendor."Language Code");
    DocType := UPPERCASE(FORMAT(PurchaseHeader."Document Type"));
    IF PurchaseHeader."Vendor Order No." <> '' THEN
      SubjectText := STRSUBSTNO('%1 %2 %3 %4',DocType,PurchaseHeader."No.",ExtDoc,PurchaseHeader."Vendor Order No.")
    ELSE SubjectText := STRSUBSTNO('%1 %2',DocType,PurchaseHeader."No.");
      GLOBALLANGUAGE := CurrentLanguage;
    
    Utilidades.EnvioDocCorreoPDF(1,PurchaseHeader."Document Type"+1,0,PurchaseHeader."Buy-from Vendor No.",SubjectText,NombreFichero,TRUE,false);
  end;
}