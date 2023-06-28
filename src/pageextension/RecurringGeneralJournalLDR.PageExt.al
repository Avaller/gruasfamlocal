/// <summary>
/// PageExtension Recurring General Journal_LDR (ID 50061) extends Record Recurring General Journal.
/// </summary>
pageextension 50061 "Recurring General Journal_LDR" extends "Recurring General Journal"
{
    layout
    {
        addafter("Account No.")
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Metodo de Pago';
                ToolTip = 'Codigo de Metodo de Pago';
            }
            field("Bal. Account No."; Rec."Bal. Account No.")
            {
                ApplicationArea = All;
                Caption = 'Número de cuenta de saldo';
                ToolTip = 'Número de cuenta de saldo';
            }
            field("Bal. Account Type"; Rec."Bal. Account Type")
            {
                ApplicationArea = All;
                Caption = 'Tipo de cuenta de saldo';
                ToolTip = 'Tipo de cuenta de saldo';
            }
        }
    }
}