/// <summary>
/// PageExtension General Ledger Entries_LDR (ID 50003) extends Record General Ledger Entries.
/// </summary>
pageextension 50003 "General Ledger Entries_LDR" extends "General Ledger Entries"
{
    layout
    {
        addbefore("Posting Date")
        {
            field("Leasing No._LDR"; Rec."Leasing No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Nro. de arrendamiento';
                ToolTip = 'Nro. de arrendamiento';
            }
        }
        addafter("Document Type")
        {
            field("External Document No._LDR"; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'Documento externo No.';
                ToolTip = 'Documento externo No.';
            }
        }
        addafter("Document No.")
        {
            field("Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;
                Caption = 'número de transacción';
                ToolTip = 'número de transacción';
            }
        }
        addafter(Description)
        {
            field("Source Type_LDR"; Rec."Source Type")
            {
                ApplicationArea = All;
                Caption = 'tipo de fuente';
                ToolTip = 'tipo de fuente';
            }
            field("Source No._LDR"; Rec."Source No.")
            {
                ApplicationArea = All;
                Caption = 'Fuente No.';
                ToolTip = 'Fuente No.';
            }
        }
    }
}