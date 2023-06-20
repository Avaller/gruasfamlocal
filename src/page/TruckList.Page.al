page 50074 TruckList
{
    /*Caption = 'Truck List';
    PageType = List;
    SourceTable = "Service Item";
    SourceTableView = where("Cancelation Cause Code" = filter(''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Planner No"; "Planner No")
                {
                }
                field(Description; Description)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = false;
            }
            systempart(; Notes)
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


        SETFILTER("Presentation Group Code", '%1', OrderPlannerSetup."Platform Trucks Pres. Code");
        SETFILTER("Explotation Customer No.", '%1', ServiceMgtSetup."No. Internal Customer");

        FILTERGROUP(2);
        SETRANGE("Service Item Type", "Service Item Type"::Crane);
        FILTERGROUP(0);
    end;

    var
        OrderPlannerSetup: Record "50229";
        ServiceMgtSetup: Record "5911"; */
}