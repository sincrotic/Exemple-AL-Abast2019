//Creada para desarrollo 164
table 75000 "Tmp Family Sales"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Family"; Code[20])
        {
            Caption = 'Family';
        }
        field(2; "Description"; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(4; "Not Invoiced"; Decimal)
        {
            Caption = 'Not Invoiced';
        }
        field(5; "Outstanding"; Decimal)
        {
            Caption = 'Outstanding';
        }
        field(6; "Family Type"; Option)
        {
            Caption = 'Family Type';
            OptionMembers =  "","AZ Div","OP Div","OCC Div";
        }
        field(7; "Total"; Boolean)
        {
            Caption = 'Total';
        }
        field(8; "TotalAmount"; Decimal)
        {
            Caption = 'TotalAmount';
        }
        field(9; "Total Not Invoiced"; Decimal)
        {
            Caption = 'Total Not Invoiced';
        }
        field(10; "Total Outstanding"; Decimal)
        {
            Caption = 'Total Outstanding';
        }
        field(11; "Quantity"; Decimal)//219
        {
            Caption = 'Quantity';
        }
        field(12; "Cost Amount"; Decimal)//219
        {
            Caption = 'Cost Amount';
        }
        field(13; "Expenses"; Decimal)//219
        {
            Caption = 'Expenses';
        }
        field(14; "Total Quantity"; Decimal)//219
        {
            Caption = 'Total Quantity';
        }
        field(15; "Total Cost Amount"; Decimal)//219
        {
            Caption = 'Total Cost Amount';
        }
        field(16; "Total Expenses"; Decimal)//219
        {
            Caption = 'Total Expenses';
        }

    }  
    
    keys
    {
        key(Key1; Family)
        {
        }
        key(Key2; "Family Type")
        {
        }
    }
    
}