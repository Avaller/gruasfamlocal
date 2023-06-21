page 50074 TruckList
{
    Caption = 'Truck List';
    PageType = List;
    SourceTable = "Service Item";
    SourceTableView = where("Cancelation Cause Code_LDR" = filter(''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                    ToolTip = 'No';
                }
                field("Planner No"; Rec."Planner No_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Planificador no';
                    ToolTip = 'Planificador no';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        OrderPlannerSetup.GET;
        ServiceMgtSetup.GET;


        Rec.SETFILTER("Presentation Group Code_LDR", '%1', OrderPlannerSetup."Platform Trucks Pres. Code");
        Rec.SETFILTER("Explotation Customer No._LDR", '%1', ServiceMgtSetup."No. Internal Customer_LDR");

        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Service Item Type_LDR", Rec."Service Item Type_LDR"::Crane);
        Rec.FILTERGROUP(0);
    end;

    var
        OrderPlannerSetup: Record "Order Planner Setup_LDR";
        ServiceMgtSetup: Record "Service Mgt. Setup";
}