page 50003 "Solicitud Conformidad Pdte."
{
    // version PI0008,PI0009
    Caption = 'Solicitud Conformidad Pdte.';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Solicitud Conformidad";
    SourceTableView = SORTING("Cód. Almacen","Fecha Pedido","Fecha Documento","Fecha Solicitud","Nº Proveedor","Nº Producto")
                      WHERE(Procesado=CONST(False));

    layout
    {
        area(content)
        {
            field(FiltroCodAlmacen;FiltroCodAlmacen)
            {
                Caption = 'Filtro Cód. Almacen';
                TableRelation = Location;

                trigger OnValidate();
                begin
                    FiltroCodAlmacenOnAfterValidat;
                end;
            }
            repeater(Control1100000)
            {
                field("Tipo Documento";"Tipo Documento")
                {
                    Editable = false;
                }
                field("Nº Documento";"Nº Documento")
                {
                    Editable = false;
                }
                field("Nº Linea";"Nº Linea")
                {
                    Editable = false;
                }
                field("Cód. Almacen";"Cód. Almacen")
                {
                    Editable = false;
                }
                field("Nº Lote";"Nº Lote")
                {
                    Editable = false;
                }
                field("Fecha Pedido";"Fecha Pedido")
                {
                    Editable = false;
                }
                field("Fecha Documento";"Fecha Documento")
                {
                    Editable = false;
                }
                field("Fecha Solicitud";"Fecha Solicitud")
                {
                    Editable = false;
                }
                field("Nº Proveedor";"Nº Proveedor")
                {
                    Editable = false;
                }
                field(Nombre;Nombre)
                {
                    Editable = false;
                }
                field("Nº Producto";"Nº Producto")
                {
                    Editable = false;
                }
                field(Descripción;Descripción)
                {
                    Editable = false;
                }
                field("Calidad Lote";"Calidad Lote") { }
                field("Cód. Almacen destino";"Cód. Almacen destino") { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Procesar)
            {
                Caption = 'Procesar';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    recLocation : Record Location;
                begin
                    recLocation.RESET;
                    IF FiltroCodAlmacen <> '' THEN
                       recLocation.SETRANGE(Code,FiltroCodAlmacen);

                    REPORT.RUN(REPORT::"Transfer Confirmacion Lotes",FALSE,FALSE,recLocation);
                end;
            }
        }
    }

    var
        FiltroCodAlmacen : Code[20];

    local procedure FiltroCodAlmacenOnAfterValidat();
    begin
        FILTERGROUP(2);
        IF FiltroCodAlmacen = '' THEN
           SETRANGE("Cód. Almacen")
          ELSE
           SETRANGE("Cód. Almacen",FiltroCodAlmacen);
        FILTERGROUP(0);

        CurrPage.UPDATE;
    end;
}

