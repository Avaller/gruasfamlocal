/// <summary>
/// Page Service Item Pres. Group (ID 50004).
/// </summary>
page 50004 "Service Item Pres. Group"
{
    Caption = 'Group Pres. Service Item';
    PageType = List;
    SourceTable = "Service Item Pres. Group_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Codigo';
                    ToolTip = 'Codigo';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Group Type"; Rec."Group Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de Grupo';
                    ToolTip = 'Tipo de Grupo';
                }
                field("Planner Visible"; Rec."Planner Visible")
                {
                    ApplicationArea = All;
                    Caption = 'Planificador visible';
                    ToolTip = 'Planificador visible';
                }
                field("Planner Colour"; Rec."Planner Colour")
                {
                    ApplicationArea = All;
                    Caption = 'Color del planificador';
                    ToolTip = 'Color del planificador';
                }
            }
        }
    }
}