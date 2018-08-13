table 50006 "Correos Clientes/Proveedor"
{
    // version PI0023,245

    // -153 ogarcia 31/03/2009 PI0023_7064
    // -245 apicazo   04/02/2016 Ajustos enviament documents per PDF.

    LookupPageID = "Lista Correos Asociados";

    fields
    {
        field(1;Type;Option)
        {
            Caption = 'Type';
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
        field(2;"Source No.";Code[10])
        {
            Caption = 'No.';
            TableRelation = IF (Type=CONST(Customer)) Customer."No." WHERE ("No."=FIELD("Source No."))
                            ELSE IF (Type=CONST(Vendor)) Vendor."No." WHERE ("No."=FIELD("Source No."));
        }
        field(3;"Code";Code[10])
        {
            Caption = 'Código';
        }
        field(10;Email;Text[80])
        {
            Caption = 'E-mail';

            trigger OnValidate();
            begin
                CheckValidEmailAddress(Email); //-245
            end;
        }
        field(11;"Send Type";Option)
        {
            Caption = 'Send Type';
            OptionCaption = 'Main,CC,BCC';
            OptionMembers = Main,CC,BCC;
        }
        field(12;"Document Type";Option)
        {
            Caption = 'Tipo Documento';
            OptionCaption = ' ,Quote,Order,Shipment,Invoice,Credit Memo';
            OptionMembers = " ",Quote,Order,Shipment,Invoice,"Credit Memo";

            trigger OnValidate();
            begin
                //-245
                IF "Document Type" <> "Document Type"::Order THEN
                    "Document SubType" := xRec."Document SubType"::" ";
                //+245
            end;
        }
        field(13;"Document SubType";Option)
        {
            Caption = 'Subtipo Documento';
            Description = '-245';
            OptionCaption = ' ,Order Confirmation,Export Invoice,Preparation Order';
            OptionMembers = " ","Order Confirmation","Export Invoice","Preparation Order";
        }
        field(100;"Customer Name";Text[50])
        {
            Caption = 'Nombre';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE ("No."=FIELD("Source No.")));
        }
        field(110;"Vendor Name";Text[50])
        {
            Caption = 'Nombre';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE ("No."=FIELD("Source No.")));
        }
    }

    keys
    {
        key(Key1;Type,"Source No.","Document Type","Document SubType","Send Type",Email) { }
        key(Key2;"Document Type","Document SubType","Send Type",Email) { }
        key(Key3;Email,"Document Type","Document SubType") { }
    }

    procedure CheckValidEmailAddress(EmailAddress : Text[250]);
    var
        i : Integer;
        NoOfAtSigns : Integer;
        InvalidEmailAddressErr : Label 'The email address "%1" is not valid.';
    begin
        EmailAddress := DELCHR(EmailAddress,'<>');

        IF EmailAddress = '' THEN
            ERROR(InvalidEmailAddressErr,EmailAddress);

        IF (EmailAddress[1] = '@') OR (EmailAddress[STRLEN(EmailAddress)] = '@') THEN
            ERROR(InvalidEmailAddressErr,EmailAddress);

        FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
            IF EmailAddress[i] = '@' THEN
                NoOfAtSigns := NoOfAtSigns + 1
            ELSE
                IF EmailAddress[i] = ' ' THEN
                    ERROR(InvalidEmailAddressErr,EmailAddress);
        END;

        IF NoOfAtSigns <> 1 THEN
            ERROR(InvalidEmailAddressErr,EmailAddress);
    end;
}

