/// <summary>
/// PageExtension BankAccountCard_LDR (ID 50069) extends Record Bank Account Card.
/// </summary>
pageextension 50069 "BankAccountCard_LDR" extends "Bank Account Card"
{
    layout
    {
        addafter("Las E-Pay File Creation No.")
        {
            field("Bank Payment No. in IOU_LDR"; Rec."Bank Payment No. in IOU_LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de pago bancario en pagaré';
                ToolTip = 'Número de pago bancario en pagaré';
            }
            field("Next Bank Payment No._LDR"; Rec."Next Bank Payment No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Siguiente Pago Bancario No.';
                ToolTip = 'Siguiente Pago Bancario No.';
            }
        }
        addafter("Last E-Pay Export File Name")
        {
            field("Confirming Control Digits_LDR"; Rec."Confirming Control Digits_LDR")
            {
                ApplicationArea = All;
                Caption = 'Confirmación de dígitos de control';
                ToolTip = 'Confirmación de dígitos de control';
            }
            field("Confirming Bank Account No._LDR"; Rec."Confirming Bank Account No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Confirmación de la cuenta bancaria No.';
                ToolTip = 'Confirmación de la cuenta bancaria No.';
            }
        }
    }
}