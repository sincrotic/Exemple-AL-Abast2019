//HEB.123 MT 29052018. La acción "Quantity Explosion of BOM" ejecuta el Report 50062 "Quantity Explosion of BOM Ext" en vez del estandar NAV.
pageextension 59010 ProductionPlannerRoleCenterExt extends "Production Planner Role Center"
{
    layout
    {
    }
    
    actions
    {
        //-HEB.123
        addfirst(Reporting)
        {
            action("Routing Sheet Ext.")
            {
                Caption = 'Routing Sheet';
                ToolTip = 'View basic information for routings, such as send-ahead quantity, setup time, run time and time unit. This report shows you the operations to be performed in this routing, the work or machine centers to be used, the personnel, the tools, and the description of each operation.';
                RunObject = report "Routing Sheet Ext";
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                ApplicationArea = Manufacturing;
            }
        }

        modify("Ro&uting Sheet"){
            Visible = false;
            Promoted = false;
            Enabled = false;
        }
        //+HEB.123
    }

}