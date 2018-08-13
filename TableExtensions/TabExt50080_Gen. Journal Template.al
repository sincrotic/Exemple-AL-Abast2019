tableextension 50080 GenJournalTemplateExt extends "Gen. Journal Template" //MyTargetTableId
{
    fields
    {
        modify(Type)
        {
            trigger OnAfterValidate();
            begin
                "Posting Report ID" := Report::"G/L Register Ext";
            end;
        }
    }
}