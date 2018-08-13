tableextension 50120 PurchRcptHeaderExt extends "Purch. Rcpt. Header"
{
    procedure PrintRecordsSolConfirm(ShowRequestForm : Boolean)
    var
        ReportSelection : Record "Report Selections";
        PurchRcptLines : Record "Purch. Rcpt. Line";
    begin
        //-110
        //Al ser por lineas el impreso la tabla a pasar como parametros debe ser la de lineas
        FINDFIRST;
        PurchRcptLines.SETRANGE("Document No.",Rec."No.");
        REPORT.RUN(REPORT::"Solicitud de Conformidad Alb.",ShowRequestForm,false,PurchRcptLines);
        //+110
    end;
}