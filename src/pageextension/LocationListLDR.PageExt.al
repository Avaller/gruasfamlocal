/// <summary>
/// PageExtension Location List_LDR (ID 50001) extends Record Location List.
/// </summary>
pageextension 50001 "Location List_LDR" extends "Location List"
{
    layout
    {
        addafter(Code)
        {
            field("Linked Machine Resource_LDR"; Rec."Linked Machine Resource_LDR")
            {
                ApplicationArea = All;
                Caption = 'Recurso de máquina vinculada';
                ToolTip = 'Recurso de máquina vinculada';
            }
        }
    }
}