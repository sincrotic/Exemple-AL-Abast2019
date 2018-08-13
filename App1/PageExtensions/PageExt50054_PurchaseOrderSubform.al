pageextension 50054 PurchaseOrderSubformExt extends "Purchase Order Subform"{
   layout
   {
       //-HEB.506
       addafter("Cross-Reference No.")
       {
           field("Tariff No.";"Tariff No.")
           {
               ApplicationArea = All;
           }
       }
       //+HEB.506
       modify("IC Partner Code"){
           Visible = false;
       }
       modify("IC Partner Ref. Type"){
           Visible = false;
       }
       modify("IC Partner Reference"){
           Visible = false;
       }
       addafter("IC Partner Code"){
           field("Sales Order No.";"Sales Order No."){
               Visible = true;
           }
       }
   }
}