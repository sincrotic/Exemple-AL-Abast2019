//HEB.108 MT 13062018. Publicación de campo "Nº Contenedor".
pageextension 56510 ItemTrackingLinesExt extends "Item Tracking Lines"
{
    actions
    {
        addafter(FunctionsDemand)
        {
            action(FichaLote)
            {
                Caption = 'Nueva ficha lote y contenedor';
                ToolTip = 'Acción para crear una nueva ficha de lote y poder informar un Nº contenedor';
                Image = LotInfo;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction();
                var
                    LotNoInformation : Record "Lot No. Information";
                    LotNoInformationCard : Page "Lot No. Information Card";
                begin
                    LotNoInformation.Init;
                    LotNoInformation."Item No." := Rec."Item No.";
                    LotNoInformation."Variant Code" := Rec."Variant Code";
                    LotNoInformation."Lot No." := Rec."Lot No.";
                    LotNoInformation.Insert;
                    LotNoInformationCard.SetRecord(LotNoInformation);
                    LotNoInformationCard.SetTableView(LotNoInformation);
                    LotNoInformationCard.Run;
                end;
            }
        }
    }
}