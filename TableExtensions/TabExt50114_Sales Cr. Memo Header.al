//HEB.242 MR 11062018 Formularis vendes i compres no confirmades i pedido cliente. SP20150603_HEB
//HEB.244 MR 08062018 Camps relacionats venedor a fitxa client i traspassar a documents
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
tableextension 50114 SalesCrMemoHeaderExt extends "Sales Cr.Memo Header"
{
    fields
    {
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
        field(50013; "Importe Comisiones"; Decimal) //-114: PI0010
        {
            //TableRelation = grupos comision ventas";
            FieldClass = FlowField;
            CalcFormula = sum("Sales Cr.Memo Line"."Importe Comisión" where ("Document No."=field("No."),Type=FIELD("Filtro Tipo Linea")));
            Caption = 'Comision Import';
            Editable = false;
        }
        field(50014; "Filtro Tipo Linea"; Option) //-165
        {
            Caption = 'Line type filter';
            FieldClass = FlowFilter;
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        //-HEB.242
        field(50015; "Customer Quote No."; Code[20])
        {
            Caption = 'Customer Quote No.';
        }
        field(50016; "Customer Order No."; Code[20])
        {
            Caption = 'Customer Order No.';
        }
        //+HEB.242
        //-HEB.508
        field(50017; "SII Exclude"; Boolean)
        {
            Caption = 'SII Exclude';
        }
        //+HEB.508
    }
}