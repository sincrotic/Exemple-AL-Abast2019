report 50071 "GetSalesOrdersExt"
{
    // version NAVW111.00

    Caption = 'Get Sales Orders';
    ApplicationArea = All;
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Sales Line";"Sales Line")
        {
            DataItemTableView = WHERE("Document Type"=CONST(Order),
                                      Type=CONST(Item),
                                      "Purch. Order Line No."=CONST(0),
                                      "Outstanding Quantity"=FILTER(<>0));
            RequestFilterFields = "Document No.","Sell-to Customer No.","No.";
            RequestFilterHeading ='Sales Order Line';

            trigger OnAfterGetRecord();
            begin
                IF ("Purchasing Code" = '') AND (SpecOrder <> 1)THEN
                  IF "Drop Shipment" THEN BEGIN
                    LineCount := LineCount + 1;
                    Window.UPDATE(1,LineCount);
                    InsertReqWkshLine("Sales Line");
                  END;

                IF "Purchasing Code" <> '' THEN
                  IF PurchasingCode.GET("Purchasing Code") THEN
                    IF PurchasingCode."Drop Shipment" AND (SpecOrder <> 1) THEN BEGIN
                      LineCount := LineCount + 1;
                      Window.UPDATE(1,LineCount);
                      InsertReqWkshLine("Sales Line");
                    END ELSE
                      IF PurchasingCode."Special Order" AND
                         ("Special Order Purchase No." = '') AND
                         (SpecOrder <> 0)
                      THEN BEGIN
                        LineCount := LineCount + 1;
                        Window.UPDATE(1,LineCount);
                        InsertReqWkshLine("Sales Line");
                      END;
            end;

            trigger OnPostDataItem();
            begin
                IF LineCount = 0 THEN
                  ERROR(Text001);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(GetDim;GetDim)
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Retrieve dimensions from';
                        OptionCaption = 'Item,Sales Line';
                        ToolTip = 'Specifies the source of dimensions that will be copied in the batch job. Dimensions can be copied exactly as they were used on a sales line or can be copied from the items used on a sales line.';
                    }
                }
            }
        }
    }

    trigger OnPreReport();
    begin
        ReqWkshTmpl.GET(ReqLine."Worksheet Template Name");
        ReqWkshName.GET(ReqLine."Worksheet Template Name",ReqLine."Journal Batch Name");
        ReqLine.SETRANGE("Worksheet Template Name",ReqLine."Worksheet Template Name");
        ReqLine.SETRANGE("Journal Batch Name",ReqLine."Journal Batch Name");
        ReqLine.LOCKTABLE;
        IF ReqLine.FINDLAST THEN BEGIN
          ReqLine.INIT;
          LineNo := ReqLine."Line No.";
        END;
        Window.OPEN(Text000);
    end;

    var
        Text000 : Label 'Processing sales lines  #1######';
        Text001 : label 'There are no sales lines to retrieve.';
        ReqWkshTmpl : Record "Req. Wksh. Template";
        ReqWkshName : Record "Requisition Wksh. Name";
        ReqLine : Record "Requisition Line";
        SalesHeader : Record "Sales Header";
        PurchasingCode : Record "Purchasing";
        ItemTrackingMgt : Codeunit "Item Tracking Management";
        LeadTimeMgt : Codeunit "Lead-Time Management";
        Window : Dialog;
        LineCount : Integer;
        SpecOrder : Integer;
        GetDim : Option Item,"Sales Line";
        LineNo : Integer;

        AzoNo : Code [20];
        codProv : Code [20];

    procedure SetReqWkshLine(NewReqLine : Record "Requisition Line";SpecialOrder : Integer);
    begin
        ReqLine := NewReqLine;
        SpecOrder := SpecialOrder;        
        //-HEB.102
        AzoNo:=NewReqLine."No. Doc. Previsión";
        codProv:=NewReqLine."Vendor No.";
        //+HEB.102
    end;

    local procedure InsertReqWkshLine(SalesLine : Record "Sales Line");
    begin
        ReqLine.RESET;
        ReqLine.SETCURRENTKEY(Type,"No.");
        ReqLine.SETRANGE(Type,"Sales Line".Type);
        ReqLine.SETRANGE("No.","Sales Line"."No.");
        ReqLine.SETRANGE("Sales Order No.","Sales Line"."Document No.");
        ReqLine.SETRANGE("Sales Order Line No.","Sales Line"."Line No.");
        IF ReqLine.FINDFIRST THEN
          EXIT;

        LineNo := LineNo + 10000;
        CLEAR(ReqLine);
        ReqLine.SetDropShipment(SalesLine."Drop Shipment");
        WITH ReqLine DO BEGIN
          INIT;
          "Worksheet Template Name" := ReqWkshName."Worksheet Template Name";
          "Journal Batch Name" := ReqWkshName.Name;
          "Line No." := LineNo;
          VALIDATE(Type,SalesLine.Type);
          VALIDATE("No.",SalesLine."No.");
          "Variant Code" := SalesLine."Variant Code";
          VALIDATE("Location Code",SalesLine."Location Code");
          "Bin Code" := SalesLine."Bin Code";

          // Drop Shipment means replenishment by purchase only
          IF ("Replenishment System" <> "Replenishment System"::Purchase) AND
             SalesLine."Drop Shipment"
          THEN
            VALIDATE("Replenishment System","Replenishment System"::Purchase);

          IF SpecOrder <> 1 THEN
            VALIDATE("Unit of Measure Code",SalesLine."Unit of Measure Code");
          VALIDATE(
            Quantity,
            ROUND(SalesLine."Outstanding Quantity" * SalesLine."Qty. per Unit of Measure" / "Qty. per Unit of Measure",0.00001));
          "Sales Order No." := SalesLine."Document No.";
          "Sales Order Line No." := SalesLine."Line No.";
          "Sell-to Customer No." := SalesLine."Sell-to Customer No.";
          SalesHeader.GET(1,SalesLine."Document No.");
          IF SpecOrder <> 1 THEN
            "Ship-to Code" := SalesHeader."Ship-to Code";
          "Item Category Code" := SalesLine."Item Category Code";
          Nonstock := SalesLine.Nonstock;
          "Action Message" := "Action Message"::New;
          "Purchasing Code" := SalesLine."Purchasing Code";
          
          //-HEB.102
            "Vendor No." := codProv;
            "No. Doc. Previsión" := AzoNo;
          //+HEB.102

          // Backward Scheduling
          "Due Date" := SalesLine."Shipment Date";
          "Ending Date" :=
            LeadTimeMgt.PlannedEndingDate(
              "No.","Location Code","Variant Code","Due Date","Vendor No.","Ref. Order Type");
          CalcStartingDate('');
          UpdateDescription;
          UpdateDatetime;

          INSERT;
          ItemTrackingMgt.CopyItemTracking(SalesLine.RowID1,RowID1,TRUE);
          IF GetDim = GetDim::"Sales Line" THEN BEGIN
            "Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
            "Dimension Set ID" := SalesLine."Dimension Set ID";
            MODIFY;
          END;
        END;
    end;

    procedure InitializeRequest(NewRetrieveDimensionsFrom : Option);
    begin
        GetDim := NewRetrieveDimensionsFrom;
    end;
}

