/// <summary>
/// PageExtension Vendor Ledger Entries_LDR (ID 50009) extends Record Vendor Ledger Entries.
/// </summary>
pageextension 50009 "Vendor Ledger Entries_LDR" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Applies-to ID"; Rec."Applies-to ID")
            {
                ApplicationArea = All;
                Caption = 'Se aplica a la identificación';
                ToolTip = 'Se aplica a la identificación';
            }
        }
    }
}