/// <summary>
/// PageExtension Customer Bank Account List (ID 50075) extends Record Customer Bank Account List.
/// </summary>
pageextension 50075 "Customer Bank Account List" extends "Customer Bank Account List"
{
    layout
    {
        addafter(Code)
        {
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
                Caption = 'No de cliente.';
                ToolTip = 'No de cliente.';
            }
            field("CCC No."; Rec."CCC No.")
            {
                ApplicationArea = All;
                Caption = 'No de CCC';
                ToolTip = 'No de CCC';
            }
        }
    }
}