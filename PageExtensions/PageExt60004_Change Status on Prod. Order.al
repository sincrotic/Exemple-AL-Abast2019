//HEB.168 MR 12062018 Exp. 7064 Al terminar un OF comprobar fecha regsitro
pageextension 60004 ChangeStatusOnProdOrderExt extends "Change Status on Prod. Order"
{

    layout
    {
        modify(PostingDate)
        {
            trigger OnAfterValidate();
            var
                StatusExt : Option Simulated,Planned,"Firm Planned",Released,Finished;
                PostingDateExt : Date;
                UpdUnitCostExt : Boolean;
                GenJnlCheckLine : Codeunit "Gen. Jnl.-Check Line";
            begin
                //-HEB.168
                ReturnPostingInfo(StatusExt, PostingDateExt, UpdUnitCostExt);
                IF StatusExt = StatusExt::Finished THEN BEGIN
                    IF GenJnlCheckLine.DateNotAllowed(PostingDateExt) THEN
                        ERROR('La fecha de registro debe estar en un periodo valido');
                END;
                //+HEB.168
            end;
        }
    }
    var
        RecProdOrder : Record "Production Order" temporary;

    trigger OnQueryClosePage(CloseAction : Action) : Boolean;
    
    var
        StatusExt : Option Simulated,Planned,"Firm Planned",Released,Finished;
        PostingDateExt : Date;
        UpdUnitCostExt : Boolean;
        GenJnlCheckLine : Codeunit "Gen. Jnl.-Check Line";
    begin
        //-HEB.168
        if CloseAction in ["Action"::Yes] then
            ReturnPostingInfo(StatusExt, PostingDateExt, UpdUnitCostExt)
        else
            exit(true);
        IF StatusExt = StatusExt::Finished THEN BEGIN
            IF GenJnlCheckLine.DateNotAllowed(PostingDateExt) THEN
                ERROR('La fecha de registro debe estar en un periodo valido');
        END;
        exit(true);
        //+HEB.168*/
        
    end;
}