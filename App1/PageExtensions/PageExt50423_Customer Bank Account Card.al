//HEB.229 MR 26062018 Creació de bancs de client: crear-los a partir d'una plantilla.
pageextension 50423 CustomerBankAccountCardExt extends "Customer Bank Account Card"
{
    layout
    {
        //-HEB.229
        addafter(County)
        {
            field("Template Bank Account No.";"Template Bank Account No.") { }
        }
        //+HEB.229
    }
}