page 50074 TruckList
{
    Caption = 'Truck List';
    PageType = List;
    SourceTable = "Service Item";
    SourceTableView = where("Cancelation Cause Code" = filter(''));

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
                field("Planner No"; Rec."Planner No")
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


        Rec.SETFILTER("Presentation Group Code", '%1', OrderPlannerSetup."Platform Trucks Pres. Code");
        Rec.SETFILTER("Explotation Customer No.", '%1', ServiceMgtSetup."No. Internal Customer");

        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Service Item Type", Rec."Service Item Type"::Crane);
        Rec.FILTERGROUP(0);
    end;

    var
        OrderPlannerSetup: Record "Order Planner Setup_LDR";
        ServiceMgtSetup: Record "Service Mgt. Setup";
}