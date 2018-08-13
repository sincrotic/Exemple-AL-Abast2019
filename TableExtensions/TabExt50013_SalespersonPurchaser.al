//HEB.114 MR 30052018 PI0010_9999: Calculo de comisiones:
//HEB.243 MR 07062018 Fitxa Vendedor/Comprador crear camp Option i bloqueado
tableextension 50013 "SalespersonPurchaserExt" extends "Salesperson/Purchaser" //MyTargetTableId
{
    fields
    {
        //-HEB.114
        field(50000; "Cód. Grupo comisión"; Code[20]) //-114: PI0010
        {
            TableRelation = "Grupos comision ventas";
            Caption = 'Comision Group Code';
        }
        //+HEB.114
        //-HEB.243
        Field(50001; "Salesperson Type"; Option) //-243
        {
            Caption = 'Salesperson Type';
            OptionMembers = " ",Comisionista,Distribuidor,"Resp. Cial.","Resp. Administr.",Comprador;
            OptionCaption = ' ,Comisionista,Distribuidor,Resp. Cial.,Resp. Administr.,Comprador';
        }
        Field(50002; Blocked; Boolean) //-243
        {
            Caption = 'Blocked';
        }
        //+HEB.243
    }
    
}