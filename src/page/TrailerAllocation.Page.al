/// <summary>
/// Page Trailer Allocation (ID 50012).
/// </summary>
page 50012 "Trailer Allocation"
{
    Caption = 'Trailer Allocation';
    PageType = List;
    SourceTable = "Trailer Allocation_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'No del Articulo de Servicio';
                    ToolTip = 'No del Articulo de Servicio';
                }
                field("Towing Code"; Rec."Towing Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de remolque';
                    ToolTip = 'Código de remolque';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Towing Description"; Rec."Towing Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción del Remolque';
                    ToolTip = 'Descripción del Remolque';
                }
            }
        }
    }

    actions
    {
    }
}