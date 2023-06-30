/// <summary>
/// PageExtension Stockkeeping Unit Card (ID 50102) extends Record Stockkeeping Unit Card.
/// </summary>
pageextension 50102 "Stockkeeping Unit Card" extends "Stockkeeping Unit Card"
{
    layout
    {
        addafter("Reordering Policy")
        {
            field("Exclude armopa_LDR"; Rec."Exclude armopa_LDR")
            {
                ApplicationArea = All;
                Caption = 'Excluir armopa';
                ToolTip = 'Excluir armopa';
            }
        }
    }
}