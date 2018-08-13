
pageextension 55062 BussinesRelatCont extends "Business Relation Contacts"
{
    layout
    {
        //-HEB.120
         
        addafter("Link to Table")
        {
            field("Business Relation Code";"Business Relation Code")
            {
                Caption = 'Cód. relación negocio';
                Visible = true;
            }
            field("Business Relation Description";"Business Relation Description")
            {
                Caption = 'Descripción relación negocio';
                Visible = true;
            }   
        }       
        modify("Contact Name") {        
            Visible = true;
        }  

        //+HEB.122
    }
    
    actions
    {
    }
}