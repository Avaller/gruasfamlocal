/// <summary>
/// PageExtension Comment Sheet (ID 50033) extends Record Comment Sheet.
/// </summary>
pageextension 50033 "Comment Sheet_LDR" extends "Comment Sheet"
{
    layout
    {
        addafter(Date)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
                Caption = 'No';
                ToolTip = 'No';
            }
        }
    }
}