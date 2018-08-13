//HEB.159 MR 26062018 PI0027_7064 - Consulta Documentos asociados a Cargos Productos
tableextension 50123 PurchInvLineExt extends "Purch. Inv. Line"
{
    fields
    {
        //-HEB.247
        Field(50020; "Sell-to Name"; Text[50]) //-247
        {
            Caption = 'Sell-to Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Header"."Buy-from Vendor Name" WHERE ("No."=FIELD("Document No.")));
        }
        //+HEB.247
        //-HEB.247
        Field(50021; "Sell-to Country/Region Code"; Code[10]) //-247
        {
            Caption = 'Sell-to Country/Region Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Header"."Buy-from Country/Region Code" WHERE ("No."=FIELD("Document No.")));            
        }
        //+HEB.247
        //-HEB.247
        Field(50022; "Bill-to Name"; Text[50]) //-247
        {
            Caption = 'Bill-to Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Header"."Pay-to Name" WHERE ("No."=FIELD("Document No.")));            
        }
        //+HEB.247
        //-HEB.247
        Field(50023; "Bill-to Country/Region Code"; Code[10]) //-247
        {
            Caption = 'Bill-to Country/Region Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Header"."Pay-to Country/Region Code" WHERE ("No."=FIELD("Document No.")));            
        }
        //+HEB.247
        //-HEB.247
        Field(50024; "Clasificación LOC"; Option)//-247
        {
            Caption = 'Clasificación LOC';
            OptionMembers = " ","H-TYPE Small","H-TYPE Normal","H-TYPE Improved","L-TYPE";
            OptionCaption = ' ,H-TYPE Small,H-TYPE Normal,H-TYPE Improved,L-TYPE';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Clasificación LOC" WHERE ("No."=FIELD("No.")));
            Editable = false;
        }
        //+HEB.247
        //-HEB.247
        Field(50025; Incoterm; Code[20]) //-247
        {
            Caption = 'Incoterm';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Header"."Shipment Method Code" WHERE ("No."=FIELD("Document No.")));   
        }
        //+HEB.247
    }
    
    //-HEB.159
    procedure ShowItemChargeLines()
    var
        TempValueEntry : Record "Value Entry" temporary;
    begin
        //+159
        IF Type = Type::"Charge (Item)" THEN BEGIN
            GetItemChargeValueEntries(TempValueEntry);
            PAGE.RUNMODAL(Page::"Value Entries Item Charge",TempValueEntry);
        END;
        //-159
    end;
    //+HEB.159
    //-HEB.159
    procedure GetItemChargeValueEntries(VAR TempValueEntry : Record "Value Entry" TEMPORARY)
    var
        ValueEntry : Record "Value Entry";
        ValueEntry2 : Record "Value Entry";
    begin
        //+159
        TempValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry2.SETCURRENTKEY("Item Ledger Entry No.","Document No.","Document Line No.");

        FilterPstdDocLineValueEntriesExt(ValueEntry);
        IF ValueEntry.FINDSET THEN
            REPEAT
                ValueEntry2.SETRANGE("Item Ledger Entry No.",ValueEntry."Item Ledger Entry No.");
                ValueEntry2.SETRANGE("Item Charge No.",'');
                ValueEntry2.SETFILTER("Entry Type",'%1|%2',ValueEntry2."Entry Type"::"Direct Cost",
                                                        ValueEntry2."Entry Type"::"Indirect Cost");
                IF ValueEntry2.FINDSET THEN
                    REPEAT
                        TempValueEntry.SETRANGE("Document No.", ValueEntry2."Document No.");
                        TempValueEntry.SETRANGE("Document Line No.", ValueEntry2."Document Line No.");
                        IF NOT TempValueEntry.FINDFIRST THEN BEGIN
                            TempValueEntry.COPY(ValueEntry2);
                            TempValueEntry.INSERT;
                        END;
                    UNTIL ValueEntry2.NEXT=0;
            UNTIL ValueEntry.NEXT = 0;

        TempValueEntry.RESET;
        //-159
    end;
    //+HEB.159
    LOCAL Procedure FilterPstdDocLineValueEntriesExt(VAR ValueEntry : Record "Value Entry")
    begin
        ValueEntry.RESET;
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.","Document No.");
        ValueEntry.SETRANGE("Document Type",ValueEntry."Document Type"::"Purchase Invoice");
        ValueEntry.SETRANGE("Document Line No.","Line No.");
    end;
}