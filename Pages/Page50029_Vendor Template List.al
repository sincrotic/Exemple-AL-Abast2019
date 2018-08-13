page 50029 "Vendor Template List"
{
    // version NAVW15.00,AITANA

    Caption = 'Vendor Template List';
    Editable = false;
    PageType = Card;
    SourceTable = "Vendor Template";

    layout
    {
        area(content)
        {
            repeater(Repeater1)
            {
                field(Code;Code) { }
                field(Description;Description) { }
                field("No. Series";"No. Series") { }
                field("Country/Region Code";"Country/Region Code") { }
                field("Territory Code";"Territory Code") { }
                field("Currency Code";"Currency Code") { }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Vendor Template")
            {
                Caption = '&Vendor Template';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunPageLink = Code=FIELD(Code);
                    RunObject = Page "Vendor Template Card Hebron";
                    ShortCutKey = 'Mayús+F5';
                }
            }
        }
    }
}

