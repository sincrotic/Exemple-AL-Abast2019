page 50005 "Cuadro Comisiones Venta"
{
    //VersionList PI0010
    //-114 ogarcia 23/04/2008 PI0010_9999: Calculo de comisiones
    PageType = List;
    SourceTable = "Cuadro Comisiones Ventas";
    DelayedInsert = true;
    SaveValues = true;
    Caption = 'Cuadro Comisiones Venta';
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(GroupName)
            {
                field(ComissionCode; CodComision)
                {
                    ApplicationArea = All;
                    Caption = 'Comission Code';
                    TableRelation = "Grupos comision ventas";
                    trigger OnValidate();
                    begin
                        CodComisionOnAfterValidate;
                    end;
                }
                field(Description; GrupoComision.Descripción)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    Editable = false; 
                }
                field(StartingDate; fechaInicial)
                {
                    ApplicationArea = All;
                    Caption = 'Starting Date';
                    trigger OnValidate();
                    begin
                        fechaInicialOnAfterValidate;
                    end;
                }
                field(EndingDate; "Fecha Final")
                {
                    ApplicationArea = All;
                    Caption = 'Ending Date';
                }
            }
            repeater(RepeaterName)
            {
                field("Nº"; "Nº")
                {
                    ApplicationArea = All;
                    
                }
                field("Tipo Venta"; "Tipo Venta")
                {
                    ApplicationArea = All;
                    OptionCaption = 'Customer,Gen. Business Posting Group,All Customers';                    
                }
                field("Valor Venta"; "Valor Venta")
                {
                    ApplicationArea = All;
                    
                }
                field("Nº Producto"; "Nº Producto")
                {
                    ApplicationArea = All;
                    
                }
                field("Fecha Final2"; "Fecha Final")
                {
                    ApplicationArea = All;
                    
                }
                field("Cód. Categoria producto"; "Cód. Categoria producto")
                {
                    ApplicationArea = All;
                    
                }
                field("Cód. Grupo producto"; "Cód. Grupo producto")
                {
                    ApplicationArea = All;
                    
                }
                field("Fecha Inicial"; "Fecha Inicial")
                {
                    ApplicationArea = All;
                    
                }
                field("Cantidad mínima"; "Cantidad mínima")
                {
                    ApplicationArea = All;
                    
                }
                field("Fecha Final3"; "Fecha Final")
                {
                    ApplicationArea = All;
                    
                }
                //-HEB.114 PI0010
                field("% Comisión"; "% Comisión") 
                {
                    ApplicationArea = All;
                    DecimalPlaces = 2:3;
                }
                //+HEB.114 PI0010
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(CopiarLineas)
            {
                ApplicationArea = All;
                Caption = 'Copy lines';
                trigger OnAction();
                var
                    pageCopiar : Page "Copiar Lineas comision";
                begin
                    CLEAR(pageCopiar);
                    pageCopiar.SetDestino("Nº");
                    pageCopiar.RUNMODAL;
                    CLEAR(pageCopiar);
                end;
            }
        }
    }
    
    var
        fechaInicial : Text[30];
        GrupoComision : Record "Grupos comision ventas";
        CodComision : Code[20];

    trigger OnOpenPage();
    begin
        GetRecFilters;
        SetRecFilters;        
    end;
    procedure GetRecFilters()
    begin
        IF GETFILTERS <> '' THEN BEGIN
            CodComision := GETFILTER("Nº");
        END;

        EVALUATE(fechaInicial,GETFILTER("Fecha Inicial"));       
    end;

    procedure SetRecFilters()
    begin
        IF CodComision <> '' THEN
            SETFILTER("Nº",CodComision)
        ELSE
            SETRANGE("Nº");

        IF fechaInicial <> '' THEN
            SETFILTER("Fecha Inicial",fechaInicial)
        ELSE
            SETRANGE("Fecha Inicial");

        CLEAR(GrupoComision);
        IF GrupoComision.GET(CodComision) THEN;

        CurrPage.UPDATE(FALSE);        
    end;

    procedure CodComisionOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;        
    end;

    procedure fechaInicialOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;        
    end;

}