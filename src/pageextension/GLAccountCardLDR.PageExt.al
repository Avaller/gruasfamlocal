/// <summary>
/// PageExtension G/L Account Card_LDR (ID 50002) extends Record G/L Account Card.
/// </summary>
pageextension 50002 "G/L Account Card_LDR" extends "G/L Account Card"
{
    layout
    {
        addafter("Exchange Rate Adjustment")
        {
            field(Hidden_LDR; Rec.Hidden_LDR)
            {
                ApplicationArea = All;
                Caption = 'Oculto';
                ToolTip = 'Oculto';

                trigger OnValidate()
                var
                    GlEntry: Record "G/L Entry";
                begin
                end;
            }
        }
    }
    local procedure GLAccountEdit()
    var
        GlEntry: Record 17;
    begin
        Clear(GlEntry);
        GlEntry.SetRange("G/L Account No.", Rec."No.");
        GlEntry.ModifyAll(Hidden, Rec.Hidden_LDR, false);

        Clear(GlEntry);
        GlEntry.SetRange("Bal. Account No.", Rec."No.");
        GlEntry.ModifyAll(Hidden, Rec.Hidden_LDR, false);
    end;
}