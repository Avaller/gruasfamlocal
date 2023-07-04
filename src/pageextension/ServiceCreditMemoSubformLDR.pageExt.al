/// <summary>
/// PageExtension Service Credit Memo Subform (ID 50127) extends Record Service Credit Memo Subform.
/// </summary>
pageextension 50127 "Service Credit Memo Subform" extends "Service Credit Memo Subform"
{
    layout
    {
        addafter("Variant Code")
        {
            field("Gen. Prod. Posting Group_LDR"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Prod. gen. Grupo de contabilización';
                ToolTip = 'Prod. gen. Grupo de contabilización';
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            field(Grouper_LDR; Rec.Grouper_LDR)
            {
                ApplicationArea = All;
                Caption = 'Agrupador';
                ToolTip = 'Agrupador';
            }
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de publicación';
                ToolTip = 'Fecha de publicación';
            }
        }
    }
}