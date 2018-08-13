pageextension 60007 ReleasedProductionOrderExt extends "Released Production Order"
{    
    actions
    {
        addafter("&Print")
        {
            group(Conformidad)
            {
                Caption = 'Conformidad';
                action(ImprimirSolicitud)
                {
                    Caption = 'Imprimir Solicitud Conformidad';
                    Image = Confirm;
                    trigger OnAction();
                    begin
                        CurrPage.ProdOrderLines.Page.ImprimirSolicitudConformidad;
                    end;
                }
            }
        }
    }
}