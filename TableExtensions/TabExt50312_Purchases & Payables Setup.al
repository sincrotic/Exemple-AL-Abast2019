//HEB.215 MR 21062018 Exp. 9205: Control Dim. FAMILIA al asociar carrecs producte (CDU 5805)
tableextension 50312 PurchasesPayablesSetupExt extends "Purchases & Payables Setup"
{
    fields
    {
        //-HEB.155
        Field(50001; "Archivo Body Pedidos (ES)"; Text[250]) //-155
        {
            Caption = 'Archivo Body Pedidos (ES)';
            ExtendedDatatype = URL;
        }
        //+HEB.155
        //-HEB.155
        Field(50002; "Archivo Body Pedidos (ENU)"; Text[250]) //-155
        {
            Caption = 'Archivo Body Pedidos (ENU)';
            ExtendedDatatype = URL;
        }
        //+HEB.155
        //-HEB.215
        field(50004; "FAMILY Dimension Code"; Code[20])
        {
            Caption = 'FAMILY Dimension Code';
            TableRelation = Dimension.Code;
        }
        //+HEB.215     
    }
}