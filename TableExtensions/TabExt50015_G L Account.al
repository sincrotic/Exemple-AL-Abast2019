tableextension 50015 GLAccountExt extends "G/L Account" //MyTargetTableId
{
    fields
    {
        //-HEB.506
        field(50001;"INTRASTAT";Boolean)
        {
            Caption = 'INTRASTAT';
        }
        //+HEB.506
    }
    
}