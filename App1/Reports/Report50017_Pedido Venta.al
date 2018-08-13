report 50017 "Pedido Venta"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    
    dataset
    {
        dataitem("Sales Header";"Sales Header")
        {
        }
    }
    var
        blnValorado : Boolean;
        blnVerLotes : Boolean;
        NoOfCopies : Integer;
        ArchiveDocument : Boolean;
        optTexto : Option;
        LogInteraction : Boolean;
        ForceLanguage : Boolean;

    procedure SetParameters(pCopias : Integer;pValor : Boolean;pLotes : Boolean; pTipo : Option " ","CONFIRMACIÓN PEDIDO","FACTURA EXPORTACIÓN","PREPARACIÓN PEDIDO"; pArchivo : Boolean; pLog : Boolean)
    
    begin
        NoOfCopies := pCopias;
        blnValorado := pValor;
        blnVerLotes := pLotes;
        optTexto := pTipo;
        ArchiveDocument := pArchivo;
        LogInteraction := pLog;
    end;

    procedure SetLanguage(SetForceLanguage : Boolean)
    begin
        ForceLanguage := SetForceLanguage; //-245
    end;
}