pageextension 50006 "Customer Ledger Entries_LDR" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Document Status")
        {
            field("Payment Method Code_LDR"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Metodo de Pago';
                ToolTip = 'Codigo de Metodo de Pago';
            }
            field("External Document No._LDr"; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'No. de Documento Externo';
                ToolTip = 'No. de Documento Externo';
            }
            field("Applies-to ID_LDR"; Rec."Applies-to ID")
            {
                ApplicationArea = All;
                Caption = 'Se aplica a la identificación';
                ToolTip = 'Se aplica a la identificación';
            }
        }
        addafter("Entry No.")
        {
            field(Accepted; Rec.Accepted_LDR)
            {
                ApplicationArea = All;
                Caption = 'Aceptado';
                ToolTip = 'Aceptado';
            }
        }
    }
}