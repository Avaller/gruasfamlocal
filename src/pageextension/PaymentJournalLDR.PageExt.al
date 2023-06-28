/// <summary>
/// PageExtension Payment Journal_LDR (ID 50058) extends Record Payment Journal.
/// </summary>
pageextension 50058 "Payment Journal_LDR" extends "Payment Journal"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = All;
                Caption = '';
                ToolTip = '';
            }
        }
    }
}