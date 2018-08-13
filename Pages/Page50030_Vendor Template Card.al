page 50030 "Vendor Template Card Hebron"
{
    Caption = 'Vendor Template Card';
    PageType = Card;
    SourceTable = "Vendor Template";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code;Code) { }
                field(Description;Description) { }
                field("Country/Region Code";"Country/Region Code") { }
                field("Territory Code";"Territory Code") { }
                field("Currency Code";"Currency Code") { }
                field("No. Series";"No. Series") { }
                field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group") { }
                field("VAT Bus. Posting Group";"VAT Bus. Posting Group") { }
                field("Vendor Posting Group";"Vendor Posting Group") { }
                field("Vendor Price Group";"Vendor Price Group") { }
                field("Allow Line Disc.";"Allow Line Disc.") { }
                field("Invoice Disc. Code";"Invoice Disc. Code") { }
                field("Payment Terms Code";"Payment Terms Code") { }
                field("Payment Method Code";"Payment Method Code") { }
                field("Shipment Method Code";"Shipment Method Code") { }
            }
        }
    }
}

