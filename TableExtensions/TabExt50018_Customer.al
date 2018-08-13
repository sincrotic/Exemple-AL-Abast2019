//HEB.204 MT 30052018. Añadido campo 50012 "Cliente Vivo".
//HEB.238 MT 04062018. Añadido campo 50013 "Customer Out-Dated".
//HEB.244 MR 08062018 Camps relacionats venedor a fitxa client i traspassar a documents
tableextension 50018 CustomerExt extends Customer
{
    //-204 ogarcia   12/04/2011 Nuevo campo: Clientes Vivos y proceso de actualizaci¢n
    //-238 xtrullols 03/06/2015 Creació camp baja a client i proveidor. SP20150603_HEB
    //-239 xtrullols 03/06/2015 Report 50043 amb albarans i copiar a proveidor. SP20150603_HEB

    fields
    {
        //-HEB.126
        field(50001;"Exit Point";Code [10])//-101
        {
           Caption = 'Exit Point';
           TableRelation =  "Entry/Exit Point";
        }

        field(50002;"Shipping Instruccions";Code [10])//-101
        {
            Caption = 'Shipping Instruccions';
        }
        //+HEB.126

        //-HEB.130
        field(50003; "Cód. dirección pago genérico"; Code[10]) 
        {
            TableRelation = "Customer Pmt. Address".Code WHERE ("Customer No."=FIELD("No."));
            Caption = 'Default Payment Addr. Code';
        }
        //+HEB.130
        Field(50010; "Special Conditions"; Boolean)
        {
            Caption = 'Special Conditions';
        }
        Field(50011; "Variable Payment Conditions"; Boolean)
        {
            Caption = 'Variable Payment Conditions';
        }
        //-HEB.204
        field(50012; "Cliente Vivo"; Boolean)
        {
            Caption = 'Alive Customer';
        }
        //+HEB.204

        //-HEB.238
        field(50013; "Customer Out-Dated"; Boolean)
        {
            Caption = 'Customer Out-Dated';
            Description = '-238';
        }
        //+HEB.238
        //-HEB.244
        Field(50014; "Distributor Code"; Code[10]) //-244
        {
            Caption = 'Distributor Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST(Distribuidor),Blocked=CONST(false));
        }
        Field(50015; "Salesperson/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Salesperson/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Cial."),Blocked=CONST(false));
        }
        Field(50016; "Administr/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Administr/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Administr."),Blocked=CONST(false));
        }
        //+HEB.244
        
        //-HEB.001
        field(50020; "No. Serie Fra. Reg."; Code[20])
        {
            Caption = 'No. Serie Fra. Reg.';
            TableRelation = "No. Series";
        }
        field(50021; "No. Serie Abono Reg."; Code[20])
        {
            Caption = 'No. Serie Abono Reg.';
            TableRelation = "No. Series";
        }
        //+HEB.001
        //-HEB.002
        Field(50030; "Usar Registro Merc. Sueco"; Boolean) //HEB.002
        {
            Caption = 'Usar VAT de Suecia';
        }
        //+HEB.002
    }
    //-HEB.244
    trigger OnAfterModify();
    var
        UpdateContFromCust : Codeunit "CustCont-Update";
    begin
        IF "Administr/Resp. Code" <> xRec."Administr/Resp. Code" then
        begin
            Modify;
            UpdateContFromCust.OnModify(Rec);
        end;
    end;
    //+HEB.244
}