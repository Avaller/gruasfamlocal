/// <summary>
/// PageExtension Get Shipment Lines_LDR (ID 50105) extends Record Get Shipment Lines.
/// </summary>
pageextension 50105 "Get Shipment Lines_LDR" extends "Get Shipment Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                Caption = '';
                ToolTip = '';
            }
        }
    }
}