/// <summary>
/// Page Branches (ID 50235).
/// </summary>
page 50235 Branches
{
    Caption = 'Ramas';
    PageType = List;
    SourceTable = "Branch_LDR";

    layout
    {
        area(content)
        {
            repeater(fields)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                    ToolTip = 'No';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'codigo de Envio';
                    ToolTip = 'codigo de Envio';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Caption = 'Ciudad';
                    Editable = false;
                    ToolTip = 'Ciudad';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    Caption = 'Pais';
                    Editable = false;
                    ToolTip = 'Pais';
                }
                field("Fixed value"; Rec."Fixed value")
                {
                    ApplicationArea = All;
                    Caption = 'Valor Reparado';
                    ToolTip = 'Valor Reparado';
                }
                field(Fuel; Rec.Fuel)
                {
                    ApplicationArea = All;
                    Caption = 'Combustible';
                    ToolTip = 'Combustible';
                }
                field(Maintenance; Rec.Maintenance)
                {
                    ApplicationArea = All;
                    Caption = 'Mantenimiento';
                    ToolTip = 'Mantenimiento';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Brach")
            {
                Caption = '&Brach';
                action(Distances)
                {
                    Caption = 'Distances';
                    Image = Delivery;
                    RunObject = Page "Kilometric distances";
                    RunPageLink = "From Post Code" = field("Post Code"),
                                  "From City" = field("City");
                    RunPageView = Sorting("From City", "From Post Code", "To City", "To Post Code");
                }
            }
        }
    }
}