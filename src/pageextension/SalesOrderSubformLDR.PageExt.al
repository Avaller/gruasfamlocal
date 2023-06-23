pageextension 50017 "Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Gen. Bus. Posting Group_LDR"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo registro neg. gen.';
                ToolTip = 'Grupo registro neg. gen.';
            }
            field("Gen. Prod. Posting Group_LDR"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo registro prod. gen.';
                ToolTip = 'Grupo registro prod. gen.';
            }
        }
    }
}