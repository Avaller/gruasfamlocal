/// <summary>
/// PageExtension Contact Card_LDR (ID 50089) extends Record Contact Card.
/// </summary>
pageextension 50089 "Contact Card_LDR" extends "Contact Card"
{
    layout
    {
        addafter("Date of Last Interaction")
        {
            field("Job Title_LDR"; Rec."Job Title")
            {
                ApplicationArea = All;
                Caption = 'Título profesional';
                ToolTip = 'Título profesional';
            }
        }
        addafter("E-Mail")
        {
            field("E-Mail 2"; Rec."E-Mail 2")
            {
                ApplicationArea = All;
                Caption = 'E-Mail';
                ToolTip = 'E-Mail';
            }
        }
    }
}