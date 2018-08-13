tableextension 50225 PostCodeext extends "Post Code" //MyTargetTableId
{
    fields
    {
        
    }
    
    procedure LookUpCity(var City : Text [30];var PostCode : code [20];var Country : Text [30]; ReturnValues : Boolean)
    var
        PostCodeRec : Record "Post Code";
    begin
        IF NOT GUIALLOWED THEN
            EXIT;

        PostCodeRec.SETCURRENTKEY(City,Code);
        PostCodeRec.Code := PostCode;
        PostCodeRec.City := City;

        IF (Page.RUNMODAL(page::"Post Codes",PostCodeRec,PostCodeRec.City) = ACTION::LookupOK) AND ReturnValues THEN BEGIN
            PostCode := PostCodeRec.Code;
            City := PostCodeRec.City;
            County := PostCodeRec.County;
        END; 
    end;

    procedure LookUpPostCode(var City : Text [30];var PostCode : code [20];var Country : Text [30]; ReturnValues : Boolean)
    var
        PostCodeRec : Record "Post Code";
    begin 
        IF NOT GUIALLOWED THEN
        EXIT;
        PostCodeRec.SETCURRENTKEY(Code,City);
        PostCodeRec.Code := PostCode;
        PostCodeRec.City := City;
        IF (Page.RUNMODAL(Page::"Post Codes",PostCodeRec,PostCodeRec.Code) = ACTION::LookupOK) AND ReturnValues THEN BEGIN
        PostCode := PostCodeRec.Code;
        City := PostCodeRec.City;
        County := PostCodeRec.County;
        END;
    end;
}