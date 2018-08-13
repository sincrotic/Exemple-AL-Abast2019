pageextension 50103 AccountScheduleNamesExt extends "Account Schedule Names" //MyTargetPageId
{

    layout
    {
        modify("Analysis View Name")
        {
            Enabled = AnalysisVisible;
        }

    }

    var
        AnalysisVisible : Boolean;

    trigger OnOpenPage();
    var
        confUser : Record "User Setup";
    begin      
        //-170
       AnalysisVisible := FALSE;
        IF confUser.GET(USERID) THEN
            AnalysisVisible := confUser."Allow change analysis view";
        //+170     
    end;

}