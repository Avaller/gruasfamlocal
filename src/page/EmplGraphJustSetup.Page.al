/// <summary>
/// Page Empl. Graph. Just. Setup (ID 50097).
/// </summary>
page 50097 "Empl. Graph. Just. Setup"
{
    Caption = 'Employee Graphic Justification Setup';
    PageType = List;
    SourceTable = "Empl. Graph. Just. Setup_LDR";

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    Caption = 'Activado';
                    ToolTip = 'Activado';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Tipo';
                    ToolTip = 'Tipo';
                }
                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                    ToolTip = 'Color';
                }
                field(TextColor; Rec.TextColor)
                {
                    ApplicationArea = All;
                    Caption = 'Color del Texto';
                    ToolTip = 'Color del Texto';
                }
            }
        }
    }
}