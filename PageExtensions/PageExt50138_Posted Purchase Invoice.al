//HEB.159 MR 26062018 PI0027_7064 - Consulta Documentos asociados a Cargos Productos
//HEB.184 MR 30052018. Nuevos campos cabecera compra para DUA
//HEB.508 MR 17072018 Excluir facturas Suecia en SII.
pageextension 50138 PostedPurchaseInvoiceExt extends "Posted Purchase Invoice" //MyTargetPageId
{
    layout
    {
        addafter("Shipping and Payment")
        {
            group(Aduanas)
            {
                Caption = 'Aduanas';
                field("Nº DUA";"Nº DUA"){}
                field("Fecha DUA";"Fecha DUA"){}
                field("Proveedor Origen";"Proveedor Origen"){}
            }
        }
        //-HEB.508
        addfirst("SII Information")
        {
            field("SII Exclude";"SII Exclude")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        //+HEB.508
    }
    actions
    {
        //-HEB.159
        addafter(Approvals)
        {
            action(LineasAsociadasCargo)
            {
                Caption = 'Lineas Asociadas Cargo Producto';
                ToolTip = 'Lineas Asociadas Cargo Producto';
                Image = AllLines;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    GetItemChargeValueEntries;
                end;
            }
        }
        //+HEB.159
    }
}