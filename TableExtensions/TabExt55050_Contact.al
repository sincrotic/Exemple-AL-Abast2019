//HEB.244 MR 08062018 Camps relacionats venedor a fitxa client i traspassar a documents
tableextension 55050 ContactExt extends Contact
{
    fields
    {
        // Add changes to table fields here
        //-HEB.169
        modify(Name)
        {
            trigger OnAfterValidate();

            begin
                CombertToUpperCaseBig(Name);
            end;
        }

        modify("Name 2")
        {
            trigger OnAfterValidate();

            begin
                CombertToUpperCaseBig(Name);
            end;
        }
        modify(Address)
        {
            trigger OnAfterValidate();

            begin
                CombertToUpperCaseBig(Name);
            end;
        }
        modify("Address 2")
        {
            trigger OnAfterValidate();

            begin
                CombertToUpperCaseBig(Name);
            end;
        }
        modify(City)
        {
            trigger OnAfterValidate();

            begin
                CombertToUpperCaseSmall(Name);
            end;
        }
        modify("Job Title")
        {
            trigger OnAfterValidate();

            begin
                CombertToUpperCaseSmall(Name);
            end;
        }
        modify(Initials)
        {
            trigger OnAfterValidate();

            begin
                CombertToUpperCaseSmall(Name);
            end;
        }
        modify("Company Name")
        {
            trigger OnAfterValidate();

            begin
                CombertToUpperCaseBig(Name);
            end;
        }
        modify("First Name")
        {
            trigger OnAfterValidate();

            begin
                CombertToUpperCaseSmall(Name);
            end;
        }
        modify("Middle Name")
        {
            trigger OnAfterValidate();

            begin
                CombertToUpperCaseSmall(Name);
            end;
        }
        modify(Surname)
        {
            trigger OnAfterValidate();

            begin
                CombertToUpperCaseSmall(Name);
            end;
        }
        modify("E-Mail")
        {
            trigger OnAfterValidate();

            begin
                CombertToLowerCase(Name);
            end;
        }
        modify("Home Page")
        {
            trigger OnAfterValidate();

            begin
                CombertToLowerCase(Name);
            end;
        }
        //+HEB.169
        //-HEB.244-HEB.001
        Field(50014; "Distributor Code"; Code[10]) //-244
        {
            Caption = 'Distributor Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST(Distribuidor),Blocked=CONST(false));
        }
        Field(50015; "Salesperson/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Salesperson/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Cial."),Blocked=CONST(false));
        }
        Field(50016; "Administr/Resp. Code"; Code[10]) //-244
        {
            Caption = 'Administr/Resp. Code';
            TableRelation = "Salesperson/Purchaser" WHERE ("Salesperson Type"=CONST("Resp. Administr."),Blocked=CONST(false));
        }
        //+HEB.244-HEB.001
    }
    
    local procedure CombertToUpperCaseBig(var TextIn : Text [50]);
    begin
        TextIn := UpperCase(TextIn);
        Modify;
    end;

    local procedure CombertToUpperCaseSmall(var TextIn : Text [30]);
    begin
        TextIn := UpperCase(TextIn);
        Modify;
    end;

    local procedure CombertToLowerCase(var TextIn : Text [80]);
    begin
        TextIn := LowerCase(TextIn);
    end;

    procedure CreateCustomerExt(CustomerTemplate : Code[10])
    var
        Cust : Record "Customer";
        CustTemplate : Record "Customer Template";
        DefaultDim : Record "Default Dimension";
        DefaultDim2 : Record "Default Dimension";
        ContBusRel : Record "Contact Business Relation";
        OfficeMgt : Codeunit "Office Management";
        NoSeriesMgt : Codeunit "NoSeriesManagement";
        RMSetup : Record "Marketing Setup";
        CampaignMgt : Codeunit "Campaign Target Group Mgt";
        UpdateCustVendBank : Codeunit "CustVendBank-Update";
        RelatedRecordIsCreatedMsg : Label 'The %1 record has been created.';
    begin
        CheckForExistingRelationshipsExt(ContBusRel."Link to Table"::Customer);
        CheckIfPrivacyBlockedGeneric;
        RMSetup.GET;
        RMSetup.TESTFIELD("Bus. Rel. Code for Customers");

        IF CustomerTemplate <> '' THEN
            IF CustTemplate.GET(CustomerTemplate) THEN;

        CLEAR(Cust);
        Cust.SetInsertFromContact(TRUE);
        Cust."Contact Type" := Type;
        OnBeforeCustomerInsert(Cust);
        
        //-165
        IF CustTemplate."No. Series" <> '' THEN
        BEGIN
            NoSeriesMgt.InitSeries(CustTemplate."No. Series",'',0D,Cust."No.",Cust."No. Series");
        END;
        //+165
        Cust.INSERT(TRUE);
        Cust.SetInsertFromContact(FALSE);

        ContBusRel."Contact No." := "No.";
        ContBusRel."Business Relation Code" := RMSetup."Bus. Rel. Code for Customers";
        ContBusRel."Link to Table" := ContBusRel."Link to Table"::Customer;
        ContBusRel."No." := Cust."No.";
        ContBusRel.INSERT(TRUE);

        UpdateCustVendBank.UpdateCustomer(Rec,ContBusRel);

        Cust.GET(ContBusRel."No.");
        IF Type = Type::Company THEN BEGIN
            Cust.VALIDATE(Name,"Company Name");
            Cust.VALIDATE("Country/Region Code","Country/Region Code");
        END;
        Cust.MODIFY;

        IF CustTemplate.Code <> '' THEN BEGIN
            IF "Territory Code" = '' THEN
                Cust."Territory Code" := CustTemplate."Territory Code"
            ELSE
                Cust."Territory Code" := "Territory Code";
            IF "Currency Code" = '' THEN
                Cust."Currency Code" := CustTemplate."Currency Code"
            ELSE
                Cust."Currency Code" := "Currency Code";
            IF "Country/Region Code" = '' THEN
                Cust."Country/Region Code" := CustTemplate."Country/Region Code"
            ELSE
                Cust."Country/Region Code" := "Country/Region Code";
            Cust."Customer Posting Group" := CustTemplate."Customer Posting Group";
            Cust."Customer Price Group" := CustTemplate."Customer Price Group";
            IF CustTemplate."Invoice Disc. Code" <> '' THEN
                Cust."Invoice Disc. Code" := CustTemplate."Invoice Disc. Code";
            Cust."Customer Disc. Group" := CustTemplate."Customer Disc. Group";
            Cust."Allow Line Disc." := CustTemplate."Allow Line Disc.";
            Cust."Gen. Bus. Posting Group" := CustTemplate."Gen. Bus. Posting Group";
            Cust."VAT Bus. Posting Group" := CustTemplate."VAT Bus. Posting Group";
            Cust."Payment Terms Code" := CustTemplate."Payment Terms Code";
            Cust."Payment Method Code" := CustTemplate."Payment Method Code";
            Cust."Prices Including VAT" := CustTemplate."Prices Including VAT";
            Cust."Shipment Method Code" := CustTemplate."Shipment Method Code";
            Cust.MODIFY;

            DefaultDim.SETRANGE("Table ID",DATABASE::"Customer Template");
            DefaultDim.SETRANGE("No.",CustTemplate.Code);
            IF DefaultDim.FIND('-') THEN
                REPEAT
                    CLEAR(DefaultDim2);
                    DefaultDim2.INIT;
                    DefaultDim2.VALIDATE("Table ID",DATABASE::Customer);
                    DefaultDim2."No." := Cust."No.";
                    DefaultDim2.VALIDATE("Dimension Code",DefaultDim."Dimension Code");
                    DefaultDim2.VALIDATE("Dimension Value Code",DefaultDim."Dimension Value Code");
                    DefaultDim2."Value Posting" := DefaultDim."Value Posting";
                    DefaultDim2.INSERT(TRUE);
                UNTIL DefaultDim.NEXT = 0;
            END;

            UpdateQuotesExt(Cust);
            CampaignMgt.ConverttoCustomer(Rec,Cust);
            IF OfficeMgt.IsAvailable THEN
                PAGE.RUN(PAGE::"Customer Card",Cust)
            ELSE
                MESSAGE(RelatedRecordIsCreatedMsg,Cust.TABLECAPTION);
    end;

    procedure CreateVendorExt(VendorTemplate : Code[10])
    var
        NoSeriesMgt : Codeunit "NoSeriesManagement";
        VendTemplate : Record "Vendor Template";
        ContComp : Record "Contact";
        RMSetup : Record "Marketing Setup";
        ContBusRel : Record "Contact Business Relation";
        UpdateCustVendBank : Codeunit "CustVendBank-Update";
        Vend : Record "Vendor";
        OfficeMgt : Codeunit "Office Management";
        RelatedRecordIsCreatedMsg : Label 'The %1 record has been created.';
    begin
        CheckForExistingRelationshipsExt(ContBusRel."Link to Table"::Vendor);
        CheckIfPrivacyBlockedGeneric;
        Rec.TESTFIELD("Company No.");
        RMSetup.GET;
        RMSetup.TESTFIELD("Bus. Rel. Code for Vendors");

        CLEAR(Vend);
        Vend.SetInsertFromContact(TRUE);
        
        //-165
        IF VendTemplate."No. Series" <> '' THEN
        BEGIN
            NoSeriesMgt.InitSeries(VendTemplate."No. Series",'',0D,Vend."No.",Vend."No. Series");
        END;
        //+165
        OnBeforeVendorInsert(Vend);
        Vend.INSERT(TRUE);
        Vend.SetInsertFromContact(FALSE);


        IF VendTemplate.Code <> '' THEN BEGIN
            Vend."Territory Code" := "Territory Code";
            Vend."Currency Code" := ContComp."Currency Code";
            Vend."Country/Region Code" := "Country/Region Code";
            Vend."Vendor Posting Group" := VendTemplate."Vendor Posting Group";
            Vend."Invoice Disc. Code" := VendTemplate."Invoice Disc. Code";
            Vend."Gen. Bus. Posting Group" := VendTemplate."Gen. Bus. Posting Group";
            Vend."VAT Bus. Posting Group" := VendTemplate."VAT Bus. Posting Group";
            Vend."Payment Terms Code" := VendTemplate."Payment Terms Code";
            Vend."Payment Method Code" := VendTemplate."Payment Method Code";
            Vend."Shipment Method Code" := VendTemplate."Shipment Method Code";
            Vend.MODIFY;
        END;

        IF Type = Type::Company THEN
            ContComp := Rec
        ELSE
            ContComp.GET("Company No.");

        ContBusRel."Contact No." := ContComp."No.";
        ContBusRel."Business Relation Code" := RMSetup."Bus. Rel. Code for Vendors";
        ContBusRel."Link to Table" := ContBusRel."Link to Table"::Vendor;
        ContBusRel."No." := Vend."No.";
        ContBusRel.INSERT(TRUE);

        UpdateCustVendBank.UpdateVendor(ContComp,ContBusRel);

        IF OfficeMgt.IsAvailable THEN
            PAGE.RUN(PAGE::"Vendor Card",Vend)
        ELSE
            MESSAGE(RelatedRecordIsCreatedMsg,Vend.TABLECAPTION);     
    end;

    procedure CheckForExistingRelationshipsExt(LinkToTable : Option " ",Customer,Vendor,"Bank Account")
    var
        Contact : Record "Contact";
        ContBusRel : Record "Contact Business Relation";
        AlreadyExistErr : Label '%1 %2 already has a %3 with %4 %5.';
    begin
        Contact := Rec;

        IF "No." <> '' THEN BEGIN
            IF ContBusRel.FindByContactExt(LinkToTable,Contact."No.") THEN
                ERROR( AlreadyExistErr, Contact.TABLECAPTION,"No.",ContBusRel.TABLECAPTION,LinkToTable,ContBusRel."No.");

            IF ContBusRel.FindByRelationExt(LinkToTable,"No.") THEN
                ERROR( AlreadyExistErr, LinkToTable,"No.",ContBusRel.TABLECAPTION,Contact.TABLECAPTION,ContBusRel."Contact No.");
        END;
    end;

    procedure UpdateQuotesExt(Customer : Record Customer)
    var
        SalesHeader : Record "Sales Header";
        SalesHeader2 : Record "Sales Header";
        Cont : Record "Contact";
        SalesLine : Record "Sales Line";
    begin
    IF "Company No." <> '' THEN
        Cont.SETRANGE("Company No.","Company No.")
    ELSE
        Cont.SETRANGE("No.","No.");

    IF Cont.FINDSET THEN
        REPEAT
            SalesHeader.RESET;
            SalesHeader.SETRANGE("Sell-to Customer No.",'');
            SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Quote);
            SalesHeader.SETRANGE("Sell-to Contact No.",Cont."No.");
            IF SalesHeader.FINDSET THEN
                REPEAT
                    SalesHeader2.GET(SalesHeader."Document Type",SalesHeader."No.");
                    SalesHeader2."Sell-to Customer No." := Customer."No.";
                    SalesHeader2."Sell-to Customer Template Code" := '';
                    IF SalesHeader2."Sell-to Contact No." = SalesHeader2."Bill-to Contact No." THEN BEGIN
                        SalesHeader2."Bill-to Customer No." := Customer."No.";
                        SalesHeader2."Bill-to Customer Template Code" := '';
                        SalesHeader2."Salesperson Code" := Customer."Salesperson Code";
                    END;
                    SalesHeader2.MODIFY;
                    SalesLine.SETRANGE("Document Type",SalesHeader2."Document Type");
                    SalesLine.SETRANGE("Document No.",SalesHeader2."No.");
                    SalesLine.MODIFYALL("Sell-to Customer No.",SalesHeader2."Sell-to Customer No.");
                    IF SalesHeader2."Sell-to Contact No." = SalesHeader2."Bill-to Contact No." THEN
                        SalesLine.MODIFYALL("Bill-to Customer No.",SalesHeader2."Bill-to Customer No.");
                UNTIL SalesHeader.NEXT = 0;

            SalesHeader.RESET;
            SalesHeader.SETRANGE("Bill-to Customer No.",'');
            SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Quote);
            SalesHeader.SETRANGE("Bill-to Contact No.",Cont."No.");
            IF SalesHeader.FINDSET THEN
                REPEAT
                    SalesHeader2.GET(SalesHeader."Document Type",SalesHeader."No.");
                    SalesHeader2."Bill-to Customer No." := Customer."No.";
                    SalesHeader2."Bill-to Customer Template Code" := '';
                    SalesHeader2."Salesperson Code" := Customer."Salesperson Code";
                    SalesHeader2.MODIFY;
                    SalesLine.SETRANGE("Document Type",SalesHeader2."Document Type");
                    SalesLine.SETRANGE("Document No.",SalesHeader2."No.");
                    SalesLine.MODIFYALL("Bill-to Customer No.",SalesHeader2."Bill-to Customer No.");
                UNTIL SalesHeader.NEXT = 0;
        UNTIL Cont.NEXT = 0;
    end;

    procedure ChooseVendorTemplate() ChooseVendTemplate : Code[10]
    var
        VendTemplate : Record "Vendor Template";
        ContBusRel : Record "Contact Business Relation";
        Text019 : Label 'The %2 record of the %1 already has the %3 with %4 %5.';
        Text023 : Label 'The creation of the vendor has been aborted.';
        Text033 : Label 'Do you want to create a contact %1 %2 as a vendor using a vendor template?';
    begin
        ContBusRel.RESET;
        ContBusRel.SETRANGE("Contact No.","No.");
        ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
        IF ContBusRel.FIND('-') THEN
            ERROR(Text019, TABLECAPTION,"No.",ContBusRel.TABLECAPTION,ContBusRel."Link to Table",ContBusRel."No.")
        ELSE
            IF CONFIRM(Text033,TRUE,"No.",Name) THEN
                IF Page.RUNMODAL(0,VendTemplate) = ACTION::LookupOK THEN
                    EXIT(VendTemplate.Code)
                ELSE
                     ERROR(Text023);
    end;

    //-HEB.244
    trigger OnAfterModify();
    var
        UpdateCustVendBank : Codeunit "CustVendBank-Update";
        RMSetup : Record "Marketing Setup";
        Cont : Record Contact;
        OldCont : Record Contact;
        ContChanged : Boolean;
        RecRef : RecordRef;
        xRecRef : RecordRef;
        ChangeLogMgt : Codeunit "Change Log Management";
    begin
        IF Type = Type::Company then
            IF ("Administr/Resp. Code" <> xRec."Administr/Resp. Code") OR ("Distributor Code" <> xRec."Distributor Code") OR ("Salesperson/Resp. Code" <> xRec."Salesperson/Resp. Code") then
                UpdateCustVendBank.RUN(Rec);
            
            RMSetup.GET;
            Cont.RESET;
            Cont.SETCURRENTKEY("Company No.");
            Cont.SETRANGE("Company No.","No.");
            Cont.SETRANGE(Type,Type::Person);
            IF Cont.FIND('-') THEN
                REPEAT
                    //<HEB.001
                    IF RMSetup."Inherit Salesperson Code" AND
                        (xRec."Administr/Resp. Code" <> "Administr/Resp. Code") AND
                        (xRec."Administr/Resp. Code" = Cont."Administr/Resp. Code")
                    THEN BEGIN
                        Cont."Administr/Resp. Code" := "Administr/Resp. Code";
                        ContChanged := TRUE;
                    END;
                    IF RMSetup."Inherit Salesperson Code" AND
                        (xRec."Distributor Code" <> "Distributor Code") AND
                        (xRec."Distributor Code" = Cont."Distributor Code")
                    THEN BEGIN
                        Cont."Distributor Code" := "Distributor Code";
                        ContChanged := TRUE;
                    END;
                    IF RMSetup."Inherit Salesperson Code" AND
                        (xRec."Salesperson/Resp. Code" <> "Salesperson/Resp. Code") AND
                        (xRec."Salesperson/Resp. Code" = Cont."Salesperson/Resp. Code")
                    THEN BEGIN
                        Cont."Salesperson/Resp. Code":= "Salesperson/Resp. Code";
                        ContChanged := TRUE;
                    END;
                    //HEB.001>
                    IF ContChanged THEN BEGIN
                        Cont.OnModify(OldCont);
                        Cont.MODIFY;
                    END;
                UNTIL Cont.NEXT = 0;
    end;
    //+HEB.244
}