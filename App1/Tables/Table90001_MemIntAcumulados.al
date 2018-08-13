table 90001 MemIntAcumulados
{
    // version ABA10.01
    Caption = 'MemIntAcumulados';

    fields
    {
        field(1;"Code 1";Code[20])
        {
            Caption = 'Code 1';
        }
        field(2;"Code 2";Code[20])
        {
            Caption = 'Code 2';
        }
        field(3;"Code 3";Code[20])
        {
            Caption = 'Code 3';
        }
        field(4;"Code 4";Code[20])
        {
            Caption = 'Code 4';
        }
        field(5;"Code 5";Code[20])
        {
            Caption = 'Code 5';
        }
        field(6;"Code 6";Code[20])
        {
            Caption = 'Code 6';
        }
        field(7;"Code 7";Code[20])
        {
            Caption = 'Code 7';
        }
        field(8;"Code 8";Code[20])
        {
            Caption = 'Code 8';
        }
        field(9;"Decimal 1";Decimal)
        {
            Caption = 'Decimal 1';
        }
        field(10;"Decimal 2";Decimal)
        {
            Caption = 'Decimal 2';
        }
        field(11;"Date 1";Date)
        {
            Caption = 'Date 1';
        }
        field(12;"Text 80";Text[80])
        {
            Caption = 'Text 80';
        }
        field(13;"Text 250";Text[250])
        {
            Caption = 'Text 250';
        }
        field(14;"Date 2";Date)
        {
            Caption = 'Date 2';
        }
        field(15;"Decimal 3";Decimal)
        {
            Caption = 'Decimal 3';
        }
        field(16;"Decimal 4";Decimal)
        {
            Caption = 'Decimal 4';
        }
        field(17;"Code 9";Code[20])
        {
            Caption = 'Code 9';
        }
        field(18;"Code 10";Code[20])
        {
            Caption = 'Code 10';
        }
        field(19;"Code 11";Code[20])
        {
            Caption = 'Code 11';
        }
        field(25;"Decimal 5";Decimal)
        {
            Caption = 'Decimal 5';
        }
        field(26;Text250;Text[250])
        {
            Caption = 'Text250';
        }
        field(27;"Decimal 6";Decimal)
        {
            Caption = 'Decimal 6';
        }
        field(28;"Decimal 7";Decimal)
        {
            Caption = 'Decimal 7';
        }
        field(29;"Decimal 8";Decimal)
        {
            Caption = 'Decimal 8';
        }
    }

    keys
    {
        key(Key1;"Code 1","Code 2","Code 3","Code 4","Code 5","Code 6","Code 7","Code 8","Code 9","Date 1","Decimal 1","Decimal 2")
        {
            SumIndexFields = "Decimal 1","Decimal 2","Decimal 3","Decimal 4";
        }
        key(Key2;"Code 6","Code 1","Code 2","Code 3","Code 4","Code 5")
        {
            SumIndexFields = "Decimal 1","Decimal 2","Decimal 3","Decimal 4";
        }
        key(Key3;"Code 1","Decimal 1")
        {
        }
    }

    fieldgroups
    {
    }
}

