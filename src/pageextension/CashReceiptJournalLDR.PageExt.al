/// <summary>
/// PageExtension Cash Receipt Journal_LDR (ID 50057) extends Record Cash Receipt Journal.
/// </summary>
pageextension 50057 "Cash Receipt Journal_LDR" extends "Cash Receipt Journal"
{
    layout
    {
        addafter("Direct Debit Mandate ID")
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Código de método de pago';
                ToolTip = 'Código de método de pago';
            }
            field("Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
                Caption = 'Código de condiciones de pago';
                ToolTip = 'Código de condiciones de pago';
            }
        }
    }
}