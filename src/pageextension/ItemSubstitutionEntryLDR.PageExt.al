/// <summary>
/// PageExtension ItemSubstitutionEntry_LDR (ID 50107) extends Record Item Substitution Entry.
/// </summary>
pageextension 50107 "ItemSubstitutionEntry_LDR" extends "Item Substitution Entry"
{
    layout
    {
        addafter("Substitute Variant Code")
        {
            field("Substitution Date_LDR"; Rec."Substitution Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Fecha de sustitución';
                ToolTip = 'Fecha de sustitución';
            }
        }
    }
}