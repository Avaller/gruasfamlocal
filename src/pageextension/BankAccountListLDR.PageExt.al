/// <summary>
/// PageExtension Bank Account List_LDR (ID 50070) extends Record Bank Account List.
/// </summary>
pageextension 50070 "Bank Account List_LDR" extends "Bank Account List"
{
    layout
    {
        addafter(Name)
        {
            field("CCC No."; Rec."CCC No.")
            {
                ApplicationArea = All;
                Caption = 'No. de CCC';
                ToolTip = 'No. de CCC';
            }
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Saldo (LCY)';
                ToolTip = 'Saldo (LCY)';
            }
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
                Caption = 'Cambio neto';
                ToolTip = 'Cambio neto';
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Cambio neto (LCY)';
                ToolTip = 'Cambio neto (LCY)';
            }
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
                Caption = 'Balance';
                ToolTip = 'Balance';
            }
            field("Debit Amount"; Rec."Debit Amount")
            {
                ApplicationArea = All;
                Caption = 'Monto de débito';
                ToolTip = 'Monto de débito';
            }
            field("Credit Amount"; Rec."Credit Amount")
            {
                ApplicationArea = All;
                Caption = 'Monto de crédito';
                ToolTip = 'Monto de crédito';
            }
        }
        addafter("Post Code")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
        }
        addafter(IBAN)
        {
            field(IBAN2; Rec.IBAN)
            {
                ApplicationArea = All;
                Caption = 'IBAN';
                ToolTip = 'IBAN';
            }
            field("SWIFT Code2"; Rec."SWIFT Code")
            {
                ApplicationArea = All;
                Caption = 'Código SWIFT';
                ToolTip = 'Código SWIFT';
            }
        }
    }
}