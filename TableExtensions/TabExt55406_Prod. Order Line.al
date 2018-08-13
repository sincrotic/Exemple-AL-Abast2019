tableextension 55406 ProdOrderLineExt extends "Prod. Order Line"
{
    procedure ImprimirSolicitudConformidad()
    var
        recProdOrderLine : Record "Prod. Order Line";
    begin
        recProdOrderLine.COPY(Rec);
        recProdOrderLine.SETRECFILTER;
        REPORT.RUN(REPORT::"Solicitud de Conformidad Fab.",TRUE,TRUE,recProdOrderLine);
    end;
}