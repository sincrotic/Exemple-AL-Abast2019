//HEB.244 MR 11062018 Camps relacionats venedor a fitxa client i traspassar a documents
report 60001 "Informar Resp Adm. en Contacto"
{
    Caption = 'Informar Resp Adm. en Contacto';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;
    dataset
    {
        dataitem(Customer;Customer)
        {
            trigger OnAfterGetRecord();
            var
                ContBusRel : Record "Contact Business Relation";
                Cont : Record "Contact";
            begin
                ContBusRel.SETCURRENTKEY("Link to Table","No.");
                ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
                ContBusRel.SETRANGE("No.","No.");
                IF ContBusRel.FIND('-') THEN BEGIN
                    Cont.GET(ContBusRel."Contact No.");
                    Cont."Administr/Resp. Code" := Customer."Administr/Resp. Code";
                    Cont."Distributor Code" := Customer."Distributor Code"; 
                    Cont."Salesperson Code" := Customer."Salesperson Code";
                    Cont."Salesperson/Resp. Code" := Customer."Salesperson/Resp. Code";
                    Cont.MODIFY(TRUE);
                END;
            end;
        }
    }
}