page 50006 "Copiar Lineas comision"
{
    //VersionList PI0010
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    PageType = Card;
    Caption = 'Copiar Lineas comision';
    ApplicationArea = All;
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            group(GroupName)
            {
                field("Grupo comisión destino"; codDestino)
                {
                    ApplicationArea = All;
                    TableRelation = "Grupos comision ventas";
                }
                field("Grupo comisión origen"; codOrigen)
                {
                    ApplicationArea = All;
                    TableRelation = "Grupos comision ventas";
                }
                field("Fecha inicio"; fechaIni)
                {
                    ApplicationArea = All;
                    
                }
                field("Fecha fin"; fechaFin)
                {
                    ApplicationArea = All;
                    
                }
                field("Actualizar duplicados"; actualizar)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(Copiar)
            {
                ApplicationArea = All;
                Caption = 'Copiar';

                trigger OnAction()
                begin
                    IF codDestino = '' THEN
                        ERROR('Debe elegir un grupo de comisión destino');
                    IF codOrigen = '' THEN
                        ERROR('Debe elegir un grupo de comisión origen');
                    IF codDestino = codOrigen THEN
                        ERROR('El origen y destino no pueden ser el mismo');
                    IF fechaIni = 0D THEN
                        fechaIni := 20000101D;
                    IF fechaFin = 0D THEN
                        fechaFin := 99991231D;
                    IF fechaIni > fechaFin THEN
                        ERROR('La fecha inicial no puede ser superior a la final');
                    WITH CuadroComisiones DO BEGIN
                        RESET;
                        SETRANGE("Nº", codOrigen);
                        SETFILTER("Fecha Inicial", '%1|%2..%3', 0D, fechaIni, fechaFin);
                        IF FINDFIRST THEN
                            REPEAT
                                CuadroComisiones2.INIT;
                                CuadroComisiones2.COPY(CuadroComisiones);
                                CuadroComisiones2."Nº" := codDestino;
                                IF NOT CuadroComisiones2.INSERT THEN BEGIN
                                    IF actualizar THEN BEGIN
                                        IF CuadroComisiones2.GET(codDestino, "Tipo Venta", "Valor Venta",
                                                                "Fecha Inicial", "Cantidad mínima",
                                                                "Nº Producto", "Cód. Categoria producto",
                                                                "Cód. Grupo producto") THEN BEGIN
                                            CuadroComisiones2."% Comisión" := "% Comisión";
                                            CuadroComisiones2.MODIFY;
                                        END;
                                    END
                                END;
                            UNTIL CuadroComisiones.NEXT=0;
                    END;
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        codOrigen : Code[20];
        codDestino : Code[20];
        fechaIni : Date;
        fechaFin : Date;
        CuadroComisiones : Record "Cuadro Comisiones Ventas";
        CuadroComisiones2 : Record "Cuadro Comisiones Ventas";
        actualizar : Boolean;

    trigger OnInit();
    begin
        actualizar := TRUE;
    end;

    procedure SetDestino(prmGrupoComisionDestino : Code[20])
    begin
        codDestino := prmGrupoComisionDestino;
    end;
}