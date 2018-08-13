pageextension 50020 GeneralLedgerEntriesExt extends "General Ledger Entries"
{
    trigger OnOpenPage();
    var
        ConfUsu : Record "User Setup";
    begin
        //-145
        ConfUsu.GET(USERID);
        IF NOT ConfUsu."Allow see detailed salaris" THEN BEGIN
            FILTERGROUP(2);
            SETFILTER("G/L Account No.",'<%1|>%2','640000','649999');
            FILTERGROUP(0);
        END;
        //+145
    end;
}