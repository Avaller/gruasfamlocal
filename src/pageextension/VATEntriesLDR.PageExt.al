/// <summary>
/// PageExtension VAT Entries (ID 50065) extends Record VAT Entries.
/// </summary>
pageextension 50065 "VAT Entries" extends "VAT Entries"
{
    layout
    {
        addafter("Document Date")
        {
            field("No. Series"; Rec."No. Series")
            {
                ApplicationArea = All;
                Caption = 'Nº Serie';
                ToolTip = 'Nº Serie';
            }
        }
        addafter("Additional-Currency Base")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'No. de Documento Externo';
                ToolTip = 'No. de Documento Externo';
            }
        }
    }
}