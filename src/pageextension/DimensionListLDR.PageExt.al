/// <summary>
/// PageExtension Dimension List_LDR (ID 50086) extends Record Dimension List.
/// </summary>
pageextension 50086 "Dimension List_LDR" extends "Dimension List"
{
    layout
    {
        addafter(Name)
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
                Caption = 'Descripción';
                ToolTip = 'Descripción';
            }
        }
    }

}