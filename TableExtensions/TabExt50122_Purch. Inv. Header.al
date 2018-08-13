//HEB.159 MR 26062018 PI0027_7064 - Consulta Documentos asociados a Cargos Productos
//HEB.184 MR 30052018. Nuevos campos cabecera compra para DUA
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
tableextension 50122 PurchInvHeaderExt extends "Purch. Inv. Header"
{
    fields
    {

        //-HEB.184
        field(50010; "Nº DUA"; Code[20])
        {
            Caption = 'DUA No.';
        }
        //+HEB.184
        //-HEB.184
        field(50011; "Fecha DUA"; Date)
        {
            Caption = 'DUA Date';
        }
        //+HEB.184
        //-HEB.184
        field(50012; "Proveedor Origen"; Code[20])
        {
            Caption = 'Origin Vendor';
        }
        //+HEB.184
        //-HEB.508
        field(50017; "SII Exclude"; Boolean)
        {
            Caption = 'SII Exclude';
        }
        //+HEB.508
    }
    //-HEB.159
    procedure FilterPstdDocLineValueEntries(VAR ValueEntry : Record "Value Entry")
    begin
        //+159
        ValueEntry.RESET;
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.","No.");
        ValueEntry.SETRANGE("Document Type",ValueEntry."Document Type"::"Purchase Invoice");
        //-159
    end;
    //+HEB.159
    //-HEB.159
    procedure GetItemChargeValueEntries()
    var
        ValueEntry : Record "Value Entry";
        ValueEntry2 : Record "Value Entry";
        TempValueEntry : Record "Value Entry";
    begin
        //+159
        TempValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry2.SETCURRENTKEY("Item Ledger Entry No.","Document No.","Document Line No.");

        FilterPstdDocLineValueEntries(ValueEntry);
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
        Page.RUNMODAL(PAGE::"Value Entries Item Charge",TempValueEntry);
        //-159
    end;
    //+HEB.159
}