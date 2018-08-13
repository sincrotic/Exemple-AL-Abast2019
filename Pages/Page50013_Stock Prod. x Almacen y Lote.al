page 50013 "Stock Prod. x Almacen y Lote"
{
    // version AITANA
    // -143 ogarcia 26/01/2009

    Editable = false;
    PageType = List;
    SourceTable = "TMP Stock x Prod. almacen";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1100000)
            {
                field("Nº producto";"Nº producto")
                {
                    Caption = 'Item No.';
                    ApplicationArea = All;
                }
                field("Cód. Almacen";"Cód. Almacen")
                {
                    Caption = 'Location Code';
                    ApplicationArea = All;
                }
                field("Nº Lote";"Nº Lote")
                {
                    Caption = 'Lot No.';
                    ApplicationArea = All;
                }
                field(Descripción;Descripción)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field(Cantidad;Cantidad)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                    trigger OnDrillDown();
                    var
                        rec32 : Record "Item Ledger Entry";
                    begin
                        rec32.RESET;
                        rec32.SETRANGE("Item No.","Nº producto");
                        rec32.SETRANGE("Location Code","Cód. Almacen");
                        rec32.SETRANGE("Lot No.","Nº Lote");
                        rec32.SETRANGE(Open,TRUE);
                        Page.RUNMODAL(38,rec32,rec32."Remaining Quantity");
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        LlenaTabla();
    end;

    var
        vItemNo : Code[20];

    procedure LlenaTabla();
    var
        recItemEntry : Record "Item Ledger Entry";
        recItem : Record "Item";
    begin
        recItemEntry.SETCURRENTKEY("Item No.","Location Code",Open,"Variant Code","Unit of Measure Code","Lot No.","Serial No.");
        IF vItemNo <> '' THEN
           recItemEntry.SETRANGE("Item No.",vItemNo);
        recItemEntry.SETRANGE(Open,TRUE);

        IF recItemEntry.FINDSET THEN
          REPEAT
            INIT;
            "Nº producto" := recItemEntry."Item No.";
            "Cód. Almacen":= recItemEntry."Location Code";
            "Nº Lote"     := recItemEntry."Lot No.";
            IF NOT INSERT THEN
               GET(recItemEntry."Item No.", recItemEntry."Location Code",recItemEntry."Lot No.");

            Descripción   := recItemEntry.Description;
            Cantidad+=recItemEntry."Remaining Quantity";

            IF Descripción = '' THEN
               BEGIN
                 recItem.GET(recItemEntry."Item No.");
                 Descripción   := recItem.Description;
               END;

            MODIFY;
          UNTIL recItemEntry.NEXT=0;
    end;

    procedure setSource(pItemNo : Code[20]);
    begin
        vItemNo:=pItemNo;
    end;
}

