page 50040 "Solicitud Conformidad Log"
{
    // version PI0008,PI0009
    Caption = 'Solicitud Conformidad Log';
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Solicitud conformidad Log";
    SourceTableView = SORTING("Nº mov.");

    layout
    {
        area(content)
        {
            repeater(Control1100000)
            {
                field("Nº mov.";"Nº mov.")
                {
                    Editable = false;
                }
                field("Tipo movimiento";"Tipo movimiento")
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
                field("Nº Lote";"Nº Lote")
                {
                    Editable = false;
                }
                field(Usuario;Usuario)
                {
                    Editable = false;
                }
                field(Fecha;Fecha)
                {
                    Editable = false;
                }
                field(Hora;Hora)
                {
                    Editable = false;
                }
                field("Calidad Lote";"Calidad Lote")
                {
                    Editable = false;
                }
                field("New Calidad Lote";"New Calidad Lote")
                {
                    Editable = false;
                }
                field(Destino;Destino)
                {
                    Editable = false;
                }
                field("New Destino";"New Destino")
                {
                    Editable = false;
                }
                field("Tipo Documento";"Tipo Documento")
                {
                    Editable = false;
                }
            }
        }
    }
}

