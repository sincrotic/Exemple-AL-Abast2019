page 50037 "Specific conditions list"
{
    // version AITANA
    // -240 xtrullols 03/06/2015 Formulari amb filtres per llistar clients/proveïdors/productes. SP20150603_HEB
    Caption = 'Specific conditions list';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            field(SourceTable;SourceTable)
            {
                Caption = 'Source Table';
                OptionCaption = ' ,Customer,Vendor,Item';

                trigger OnValidate();
                begin
                    SourceTableOnAfterValidate;
                end;
            }
            field(AreaCode;AreaCode)
            {
                Caption = 'Area';
                TableRelation = "Corporate Area";
            }
            field(CommentCode;CommentCode)
            {
                Caption = 'Code Comment';
                trigger OnLookup(Text : Text) : Boolean;
                var
                    ListCommentCode : Page "Comment Area-Code";
                    CommentCodes : Record "Comment Area-Code";
                begin
                    CLEAR(CommentCodes);
                    IF AreaCode <> '' THEN
                      CommentCodes.SETFILTER("Area Code",AreaCode);
                    ListCommentCode.SETTABLEVIEW(CommentCodes);
                    ListCommentCode.LOOKUPMODE(TRUE);
                    //ListCommentCode.EDITABLE(FALSE);
                    IF ListCommentCode.RUNMODAL = ACTION::LookupOK THEN BEGIN
                      ListCommentCode.GETRECORD(CommentCodes);
                      CommentCode := CommentCodes."Comment Code";
                      CLEAR(ListCommentCode);
                    END;
                end;
            }
            group(CustomerBox)
            {
                Caption = 'Customer Options';
                Visible = CustomerBoxVisible;
                field(CustBloqued;CustBloqued)
                {
                    Caption = 'Blocked';
                    OptionCaption = ' ,Ship,Invoice,All';

                    trigger OnValidate();
                    begin
                        CustBloquedOnAfterValidate;
                    end;
                }
                field(ClienteVivo;ClienteVivo)
                {
                    Caption = 'Cliente vivo';
                    OptionCaption = ' ,Yes,No';

                    trigger OnValidate();
                    begin
                        ClienteVivoOnAfterValidate;
                    end;
                }
                field(CustomerOutDated;CustomerOutDated)
                {
                    Caption = 'Out-Dated';
                    OptionCaption = ' ,Yes,No';

                    trigger OnValidate();
                    begin
                        CustomerOutDatedOnAfterValidate;
                    end;
                }
            }
            group(VendorBox)
            {
                Caption = 'Vendor Options';
                Visible = VendorBoxVisible;
                field(VendBloqued;VendBloqued)
                {
                    Caption = 'Blocked';
                    OptionCaption = ' ,Payment,All';

                    trigger OnValidate();
                    begin
                        VendBloquedOnAfterValidate;
                    end;
                }
                field(ProveedorVivo;ProveedorVivo)
                {
                    Caption = 'Proveedor vivo';
                    OptionCaption = ' ,Yes,No';

                    trigger OnValidate();
                    begin
                        ProveedorVivoOnAfterValidate;
                    end;
                }
                field(VendorOutDated;VendorOutDated)
                {
                    Caption = 'Out-Dated';
                    OptionCaption = ' ,Yes,No';

                    trigger OnValidate();
                    begin
                        VendorOutDatedOnAfterValidate;
                    end;
                }
            }
            group(ItemBox)
            {
                Caption = 'Item Options';
                Visible = ItemBoxVisible;
                field(ItemBlocked;ItemBlocked)
                {
                    Caption = 'Blocked';
                    OptionCaption = ' ,Yes,No';

                    trigger OnValidate();
                    begin
                        ItemBlockedOnAfterValidate;
                    end;
                }
                field(ProductOutDated;ProductOutDated)
                {
                    Caption = 'Out-Dated';
                    OptionCaption = ' ,Yes,No';

                    trigger OnValidate();
                    begin
                        ProductOutDatedOnAfterValidate;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("GENERATE EXCEL")
            {
                Caption = 'GENERATE EXCEL';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    CASE SourceTable OF
                      SourceTable::Customer:
                        BEGIN
                          GenerateCustomer;
                        END;
                      SourceTable::Vendor:
                        BEGIN
                          GenerateVendor;
                        END;
                      SourceTable::Item:
                        BEGIN
                          GenerateItem;
                        END;
                      ELSE BEGIN
                        IF SourceTable = SourceTable::" " THEN
                          ERROR('Es obligatorio seleccionar un origen de tabla');
                      END;
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        UpdateScreen;
    end;

    var
        SourceTable : Option " ",Customer,Vendor,Item;
        AreaCode : Code[10];
        CommentCode : Code[10];
        ClienteVivo : Option " ",Yes,No;
        CustomerOutDated : Option " ",Yes,No;
        ProveedorVivo : Option " ",Yes,No;
        VendorOutDated : Option " ",Yes,No;
        ProductOutDated : Option " ",Yes,No;
        CustBloqued : Option " ",Ship,Invoice,All;
        VendBloqued : Option " ",Payment,All;
        ItemBlocked : Option " ",Yes,No;
        TempCustomer : Record Customer temporary;
        Text50000 : Label 'No hay clientes con los filtros actuales';
        ExcelBuf : Record "Excel Buffer" temporary;
        Text001 : Label 'Data';
        Text002 : Label 'Customer/Item Sales';
        Text003 : Label 'Company Name';
        Text005 : Label 'Report Name';
        Text004 : Label 'Report No.';
        Text006 : Label 'User ID';
        Text007 : Label 'Date';
        Text008 : Label 'Customer Filters';
        Text009 : Label 'Área';
        Text010 : Label 'Cód. Comentario';
        Text011 : Label 'Bloqueado';
        Text012 : Label 'Cliente vivo';
        Text013 : Label 'Baja';
        Text014 : Label 'Proveedor vivo';
        TempVendor : Record "Vendor" temporary;
        TempItem : Record "Item" temporary;
        [InDataSet]
        CustomerBoxVisible : Boolean;
        [InDataSet]
        VendorBoxVisible : Boolean;
        [InDataSet]
        ItemBoxVisible : Boolean;
        Text19061770 : Label 'Comments';

    procedure UpdateScreen();
    begin
        CASE SourceTable OF
          SourceTable::Customer:
            BEGIN
              CustomerBoxVisible := TRUE;
              VendorBoxVisible := FALSE;
              ItemBoxVisible := FALSE;
            END;
          SourceTable::Vendor:
            BEGIN
              CustomerBoxVisible := FALSE;
              VendorBoxVisible := TRUE;
              ItemBoxVisible := FALSE;
            END;
          SourceTable::Item:
            BEGIN
              CustomerBoxVisible := FALSE;
              VendorBoxVisible := FALSE;
              ItemBoxVisible := TRUE;
            END;
          ELSE BEGIN
            CustomerBoxVisible := FALSE;
            VendorBoxVisible := FALSE;
            ItemBoxVisible := FALSE;
            ClearValues;
          END;
        END;
    end;

    procedure ClearValues();
    begin
        ClienteVivo := ClienteVivo::" ";
        CustomerOutDated := CustomerOutDated::" ";
        ProveedorVivo := ProveedorVivo::" ";
        VendorOutDated := VendorOutDated::" ";
        ProductOutDated := ProductOutDated::" ";
        CustBloqued := CustBloqued::" ";
        VendBloqued := VendBloqued::" ";
        ItemBlocked := ItemBlocked::" ";
    end;

    procedure GenerateCustomer();
    var
        Customer : Record Customer;
        CustomerHasComments : Boolean;
        Customer2 : Record Customer;
    begin
        CLEAR(TempCustomer);
        TempCustomer.DELETEALL;

        CLEAR(Customer);
        CASE ClienteVivo OF
          ClienteVivo::Yes: Customer.SETRANGE("Cliente Vivo",TRUE);
          ClienteVivo::No: Customer.SETRANGE("Cliente Vivo",FALSE);
        END;
        CASE CustomerOutDated OF
          CustomerOutDated::Yes: Customer.SETRANGE("Customer Out-Dated",TRUE);
          CustomerOutDated::No: Customer.SETRANGE("Customer Out-Dated",FALSE);
        END;
        IF CustBloqued <> CustBloqued::" " THEN
          Customer.SETRANGE(Blocked,CustBloqued);
        IF Customer.FINDSET THEN BEGIN
          REPEAT
            IF (AreaCode = '') AND (CommentCode = '') THEN BEGIN
              TempCustomer := Customer;
              TempCustomer.INSERT;
            END
            ELSE BEGIN
              CustomerHasComments := FALSE;
              CustomerHasComments := ExistCommentLine(1,Customer."No.",AreaCode,CommentCode);
              IF CustomerHasComments THEN BEGIN
                TempCustomer := Customer;
                TempCustomer.INSERT;
              END;
            END;
          UNTIL Customer.NEXT = 0;
        END;
        CLEAR(TempCustomer);
        IF TempCustomer.FINDSET THEN BEGIN
          MakeExcelInfo(1);
          MakeExcelDataHeader(1);
          REPEAT
            IF NOT(Customer2.GET(TempCustomer."Bill-to Customer No.")) THEN
              CLEAR(Customer2);
            ExcelBuf.NewRow;
            ExcelBuf.AddColumn(TempCustomer."No.",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustomer.Name,FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustomer."Salesperson Code",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustomer."Post Code",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustomer.City,FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustomer."Country/Region Code",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustomer."Bill-to Customer No.",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(Customer2.Name,FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            CASE CustBloqued  OF
              CustBloqued::" ": ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              CustBloqued::Ship: ExcelBuf.AddColumn('Envío',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              CustBloqued::Invoice: ExcelBuf.AddColumn('Facturar',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              CustBloqued::All: ExcelBuf.AddColumn('Todos',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            END;
            CASE ClienteVivo OF
              ClienteVivo::Yes: ExcelBuf.AddColumn('Sí',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              ClienteVivo::No: ExcelBuf.AddColumn('No',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              ClienteVivo::" ": ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            END;
            CASE CustomerOutDated OF
              CustomerOutDated::Yes: ExcelBuf.AddColumn('Sí',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              CustomerOutDated::No: ExcelBuf.AddColumn('No',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              CustomerOutDated::" ": ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            END;

          UNTIL TempCustomer.NEXT = 0;
          CreateExcelbook;
        END
        ELSE
          MESSAGE(Text50000);
    end;

    procedure ExistCommentLine(TypeSource : Integer;SourceNo : Code[20];AreaCode2 : Code[10];CommentCode2 : Code[10]) : Boolean;
    var
        CommentLine : Record "Comment Line";
    begin
        //1 Cusomter, 2 Vendor, 3 Item
        CLEAR(CommentLine);
        CommentLine.SETCURRENTKEY("Table Name","No.","Area Code","Comment Code");
        CommentLine.SETRANGE("Table Name",TypeSource);
        CommentLine.SETRANGE("No.",SourceNo);
        IF AreaCode2 <> '' THEN
          CommentLine.SETRANGE("Area Code",AreaCode2);
        IF CommentCode2 <> '' THEN
          CommentLine.SETRANGE("Comment Code",CommentCode2);
        IF NOT(CommentLine.ISEMPTY) THEN
          EXIT(TRUE);
        EXIT(FALSE);
    end;

    procedure MakeExcelDataHeader(SourceType : Integer);
    begin
        IF SourceType = 1 THEN BEGIN
          ExcelBuf.AddColumn('Nº',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Nombre',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Vendedor',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('C.P',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Población',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('País',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Factura a Nº cliente',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Factura a Nombre cliente',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Bloqueado',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Cliente vivo',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Baja',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        IF SourceType = 2 THEN BEGIN
          ExcelBuf.AddColumn('Nº',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Nombre',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('C.P',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Población',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('País',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Bloqueado',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Proveedor vivo',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Baja',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        IF SourceType = 3 THEN BEGIN
          ExcelBuf.AddColumn('Nº',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Descripción',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Cód. familia técnica',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Descripción familia técnica',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Grupo Contable Producto',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Cód. Arancelario',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('UN no.',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Bloqueado',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Baja',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
    end;

    procedure CreateExcelbook();
    begin
        ExcelBuf.CreateNewBook('Specific Conditions List');
        ExcelBuf.WriteSheet(Text002,COMPANYNAME,USERID);
        ExcelBuf.CloseBook;
        ExcelBuf.OpenExcel;
        //ExcelBuf.GiveUserControl;
    end;

    procedure MakeExcelInfo(SourceType : Integer);
    begin
        CLEAR(ExcelBuf);
        ExcelBuf.DELETEALL;
        //ExcelBuf.DeleteTempExcel;

        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text003),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text002),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text004),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Page::"Specific conditions list",FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID,FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY,FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(SourceTable),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(AreaCode),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text010),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(CommentCode),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        CASE SourceTable OF
          1 : ExcelBuf.AddInfoColumn(FORMAT(CustBloqued),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          2 : ExcelBuf.AddInfoColumn(FORMAT(VendBloqued),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          3 : ExcelBuf.AddInfoColumn(FORMAT(ItemBlocked),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.NewRow;
        CASE SourceTable OF
          SourceTable::Customer :
            BEGIN
              ExcelBuf.AddInfoColumn(FORMAT(Text012),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
              ExcelBuf.AddInfoColumn(FORMAT(ClienteVivo),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
              ExcelBuf.NewRow;
            END;
          SourceTable::Vendor :
            BEGIN
              ExcelBuf.AddInfoColumn(FORMAT(Text014),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
              ExcelBuf.AddInfoColumn(FORMAT(ProveedorVivo),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
              ExcelBuf.NewRow;
            END;
        END;
        ExcelBuf.AddInfoColumn(FORMAT(Text013),FALSE,TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        CASE SourceTable OF
          1 : ExcelBuf.AddInfoColumn(FORMAT(CustomerOutDated),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          2 : ExcelBuf.AddInfoColumn(FORMAT(VendorOutDated),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          3 : ExcelBuf.AddInfoColumn(FORMAT(ProductOutDated),FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.ClearNewRow;
    end;

    procedure GenerateVendor();
    var
        Vendor : Record Vendor;
        VendorHasComments : Boolean;
    begin
        CLEAR(TempVendor);
        TempVendor.DELETEALL;

        CLEAR(Vendor);
        CASE ProveedorVivo OF
          ProveedorVivo::Yes: Vendor.SETRANGE("Proveedor Vivo",TRUE);
          ProveedorVivo::No: Vendor.SETRANGE("Proveedor Vivo",FALSE);
        END;
        CASE VendorOutDated OF
          VendorOutDated::Yes: Vendor.SETRANGE("Vendor Out-Dated",TRUE);
          VendorOutDated::No: Vendor.SETRANGE("Vendor Out-Dated",FALSE);
        END;
        IF VendBloqued <> VendBloqued::" " THEN
          Vendor.SETRANGE(Blocked,VendBloqued);
        IF Vendor.FINDSET THEN BEGIN
          REPEAT
            IF (AreaCode = '') AND (CommentCode = '') THEN BEGIN
              TempVendor := Vendor;
              TempVendor.INSERT;
            END
            ELSE BEGIN
              VendorHasComments := FALSE;
              VendorHasComments := ExistCommentLine(2,Vendor."No.",AreaCode,CommentCode);
              IF VendorHasComments THEN BEGIN
                TempVendor := Vendor;
                TempVendor.INSERT;
              END;
            END;
          UNTIL Vendor.NEXT = 0;
        END;
        CLEAR(TempVendor);
        IF TempVendor.FINDSET THEN BEGIN
          CLEAR(ExcelBuf);
          ExcelBuf.DELETEALL;
          //FORM.RUNMODAL(22,TempCustomer)
          MakeExcelInfo(2);
          MakeExcelDataHeader(2);
          REPEAT
            ExcelBuf.NewRow;
            ExcelBuf.AddColumn(TempVendor."No.",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempVendor.Name,FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempVendor."Post Code",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempVendor.City,FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempVendor."Country/Region Code",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            CASE VendBloqued  OF
              VendBloqued::" ": ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              VendBloqued::Payment: ExcelBuf.AddColumn('Pago',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              VendBloqued::All: ExcelBuf.AddColumn('Todos',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            END;
            CASE ProveedorVivo OF
              ProveedorVivo::Yes: ExcelBuf.AddColumn('Sí',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              ProveedorVivo::No: ExcelBuf.AddColumn('No',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              ProveedorVivo::" ": ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            END;
            CASE VendorOutDated OF
              VendorOutDated::Yes: ExcelBuf.AddColumn('Sí',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              VendorOutDated::No: ExcelBuf.AddColumn('No',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              VendorOutDated::" ": ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            END;

          UNTIL TempVendor.NEXT = 0;
          CreateExcelbook;
        END
        ELSE
          MESSAGE(Text50000);
    end;

    procedure GenerateItem();
    var
        Item : Record Item;
        ITemHasComments : Boolean;
        TechnicalFamily : Record "Technical Family";
    begin
        CLEAR(TempItem);
        TempItem.DELETEALL;

        CLEAR(Item);
        CASE ProductOutDated OF
          ProductOutDated::Yes: Item.SETRANGE("Product Out-Dated",TRUE);
          ProductOutDated::No: Item.SETRANGE("Product Out-Dated",FALSE);
        END;

        CASE ItemBlocked OF
          ItemBlocked::Yes: Item.SETRANGE(Blocked,TRUE);
          ItemBlocked::No: Item.SETRANGE(Blocked,FALSE);
        END;

        IF Item.FINDSET THEN BEGIN
          REPEAT
            IF (AreaCode = '') AND (CommentCode = '') THEN BEGIN
              TempItem := Item;
              TempItem.INSERT;
            END
            ELSE BEGIN
              ITemHasComments := FALSE;
              ITemHasComments := ExistCommentLine(3,Item."No.",AreaCode,CommentCode);
              IF ITemHasComments THEN BEGIN
                TempItem := Item;
                TempItem.INSERT;
              END;
            END;
          UNTIL Item.NEXT = 0;
        END;
        CLEAR(TempItem);
        IF TempItem.FINDSET THEN BEGIN
          CLEAR(ExcelBuf);
          ExcelBuf.DELETEALL;
          //FORM.RUNMODAL(22,TempCustomer)
          MakeExcelInfo(3);
          MakeExcelDataHeader(3);
          REPEAT
            ExcelBuf.NewRow;
            ExcelBuf.AddColumn(TempItem."No.",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempItem.Description,FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempItem."Technical Family Code",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            IF NOT(TechnicalFamily.GET(TempItem."Technical Family Code")) THEN
              CLEAR(TechnicalFamily);
            ExcelBuf.AddColumn(TechnicalFamily.Description,FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempItem."Gen. Prod. Posting Group",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempItem."Tariff No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempItem."UN No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
            CASE ItemBlocked OF
              ItemBlocked::Yes: ExcelBuf.AddColumn('Sí',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              ItemBlocked::No: ExcelBuf.AddColumn('No',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              ItemBlocked::" ": ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            END;
            CASE ProductOutDated OF
              ProductOutDated::Yes: ExcelBuf.AddColumn('Sí',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              ProductOutDated::No: ExcelBuf.AddColumn('No',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
              ProductOutDated::" ": ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf."Cell Type"::Text);
            END;
          UNTIL TempItem.NEXT = 0;
          CreateExcelbook;
        END
        ELSE
          MESSAGE(Text50000);
    end;

    local procedure CustBloquedOnAfterValidate();
    begin
        UpdateScreen;
    end;

    local procedure ClienteVivoOnAfterValidate();
    begin
        UpdateScreen;
    end;

    local procedure CustomerOutDatedOnAfterValidate();
    begin
        UpdateScreen;
    end;

    local procedure VendBloquedOnAfterValidate();
    begin
        UpdateScreen;
    end;

    local procedure ProveedorVivoOnAfterValidate();
    begin
        UpdateScreen;
    end;

    local procedure VendorOutDatedOnAfterValidate();
    begin
        UpdateScreen;
    end;

    local procedure ItemBlockedOnAfterValidate();
    begin
        UpdateScreen;
    end;

    local procedure ProductOutDatedOnAfterValidate();
    begin
        UpdateScreen;
    end;

    local procedure SourceTableOnAfterValidate();
    begin
        UpdateScreen;
    end;
}

