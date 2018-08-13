tableextension 55054 ContactBusinessRelationExt extends "Contact Business Relation"
{
    procedure FindByContactExt(LinkType : Option;ContactNo : Code[20]) : Boolean
    begin
        RESET;
        SETCURRENTKEY("Link to Table","Contact No.");
        SETRANGE("Link to Table",LinkType);
        SETRANGE("Contact No.",ContactNo);
        EXIT(FINDFIRST);
    end;

    procedure FindByRelationExt(LinkType : Option;LinkNo : Code[20]) : Boolean
    begin
        RESET;
        SETCURRENTKEY("Link to Table","No.");
        SETRANGE("Link to Table",LinkType);
        SETRANGE("No.",LinkNo);
        EXIT(FINDFIRST);
    end;
}