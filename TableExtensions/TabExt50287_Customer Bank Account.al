//HEB.229 MR 26062018 Creació de bancs de client: crear-los a partir d'una plantilla.
tableextension 50287 CustomerBankAccountExt extends "Customer Bank Account"
{
    fields
    {
        //-HEB.229
        field(50000; "Template Bank Account No."; Code[20]) //-229
        {
            Caption = 'Template Bank Account No.';
            TableRelation = "Bank Account";
            trigger OnValidate();
            var
                BankAccount : Record "Bank Account";
                Text50000 : Label 'You are modifying %1. Do you want to continue ?';
            begin
                //-229
                IF (xRec."Template Bank Account No." <> '') AND (xRec."Template Bank Account No." <> "Template Bank Account No.") THEN
                IF NOT CONFIRM(Text50000, FALSE, FIELDCAPTION("Template Bank Account No.")) THEN BEGIN
                    "Template Bank Account No." := xRec."Template Bank Account No.";
                    EXIT;
                END;

                CLEAR(BankAccount);
                BankAccount.GET("Template Bank Account No.");
                VALIDATE(Code, COPYSTR(BankAccount."No.", 1, 10));
                VALIDATE(Name, BankAccount.Name);
                VALIDATE("Name 2", BankAccount."Name 2");
                VALIDATE(Address, BankAccount.Address);
                VALIDATE("Address 2", BankAccount."Address 2");
                VALIDATE(City, BankAccount.City);
                VALIDATE(Contact, BankAccount.Contact);
                VALIDATE("Phone No.", BankAccount."Phone No.");
                VALIDATE("Telex No.", BankAccount."Telex No.");
                VALIDATE("Currency Code", BankAccount."Currency Code");
                VALIDATE("Language Code", BankAccount."Language Code");
                VALIDATE("Country/Region Code", BankAccount."Country/Region Code");
                VALIDATE("Post Code", BankAccount."Post Code");
                VALIDATE(County, BankAccount.County);
                VALIDATE("E-Mail", BankAccount."E-Mail");
                VALIDATE("Home Page", BankAccount."Home Page");
                VALIDATE("Transit No.", BankAccount."Transit No.");
                VALIDATE("Telex Answer Back", BankAccount."Telex Answer Back");
                VALIDATE("CCC No.", BankAccount."CCC No.");
                VALIDATE("SWIFT Code", BankAccount."SWIFT Code");
                //+229    
            end;
        }
        //+HEB.229
    }
    
}