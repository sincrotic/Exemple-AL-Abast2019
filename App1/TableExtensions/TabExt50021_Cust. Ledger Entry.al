//HEB.244 MR 08062018 Camps relacionats venedor a fitxa client i traspassar a documents
tableextension 50021 CustLedgerEntryExt extends "Cust. Ledger Entry"
{
    fields
    {
        //-HEB.144
        modify(Description)
        {
            trigger OnAfterValidate();
            var SalesAbastLib : Codeunit "Sales Abast Library";
            
            begin           
                SalesAbastLib.UpdCustLedgerEntryDescription(Rec);
            end;
        }
        //+HEB.144
        //-HEB.176
        field(50000; "Accepted"; Option) //-176
        {
            Caption = 'Accepted';
            FieldClass = FlowField;
            CalcFormula = Lookup("Cartera Doc.".Accepted WHERE (Type=CONST(Receivable),"Document No."=FIELD("Document No."),"No."=FIELD("Bill No.")));
            OptionMembers = "Not Required",Yes,No;
            OptionCaption = 'Not Required,Yes,No';
            Editable = false;
        }
        //+HEB.176
        //-HEB.128
        field(50001;"Order No.";Code [20])//-128
        {
            Caption = 'Order No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Order No." WHERE ("No."=FIELD("Document No.")));
        }
        //+HEB.128
        //-HEB.244
        Field(50010; "Distributor Code"; Code[10]) //-244
        {
            Caption = 'Distributor Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST(Distribuidor),Blocked=CONST(false));
        }
        Field(50011; "Salesperson/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Salesperson/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Cial."),Blocked=CONST(false));
        }
        Field(50012; "Administr/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Administr/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Administr."),Blocked=CONST(false));
        }
        //+HEB.244
    }
    
}