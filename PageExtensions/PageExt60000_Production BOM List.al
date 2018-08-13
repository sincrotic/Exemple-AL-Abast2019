//HEB.123 MT 29052018. La acción "Quantity Explosion of BOM" ejecuta el Report 50062 "Quantity Explosion of BOM Ext" en vez del estandar NAV.
pageextension 60000 ProductionBOMListExt extends "Production BOM List"
{
    layout
    {
        addafter(Status)
        {
            field("Tamaño Lote";"Tamaño Lote")
            {
            }
        }
    }

    actions
    {
        //-HEB.123
        addafter("Quantity Explosion of BOM")
        {
            action("Quantity Explosion of BOM Ext.")
            {
                Caption = 'Quantity Explosion of BOM';
                ToolTip = 'View an indented BOM listing for the item or items that you specify in the filters. The production BOM is completely exploded for all levels.';
                RunObject = report "Quantity Explosion of BOM Ext";
                Image = Report;
                ApplicationArea = Assembly;
            }
        }

        modify("Quantity Explosion of BOM"){
            Visible = false;
        }
        //+HEB.123
    }

}