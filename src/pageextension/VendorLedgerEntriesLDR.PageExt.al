pageextension 50009 "Vendor Ledger Entries" extends "Vendor Ledger Entries"
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