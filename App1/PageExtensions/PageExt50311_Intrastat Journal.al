pageextension 50311 IntrastatJournalExt extends "Intrastat Journal" //MyTargetPageId
{
    layout
    {
        
    }
    
    //-HEB.506
    actions
    {
        modify(GetEntries)
        {
            Visible = false;
            Enabled = false;
        }
        addbefore(ChecklistReport)
        {
             action(GetEntriesExt)
             {
                 ApplicationArea = All;
                 Caption = 'Suggest Lines';
                 Image = SuggestLines;
                 Promoted = true;
                 PromotedIsBig = true;
                 PromotedCategory = Process;
                 Ellipsis = true;
                 PromotedOnly = true;
                 ToolTip = 'Suggests Intrastat transactions to be reported and fills in Intrastat journal.';
                 trigger OnAction()
                 var
                    GetItemEntries : Report "Get Item Ledger Entries Ext";
                    VATReportsConfiguration : Record "VAT Reports Configuration";
                 begin
                    VATReportsConfiguration.SETRANGE("VAT Report Type",VATReportsConfiguration."VAT Report Type"::"Intrastat Report");
                    IF VATReportsConfiguration.FINDFIRST AND (VATReportsConfiguration."Suggest Lines Codeunit ID" <> 0) THEN BEGIN
                        CODEUNIT.RUN(VATReportsConfiguration."Suggest Lines Codeunit ID",Rec);
                        EXIT;
                    END;

                    GetItemEntries.SetIntrastatJnlLine(Rec);
                    GetItemEntries.RUNMODAL;
                    CLEAR(GetItemEntries);
                 end;

            }
        }
    }
    //+HEB.506
}