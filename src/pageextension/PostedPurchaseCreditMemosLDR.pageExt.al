/// <summary>
/// PageExtension PostedPurchaseCreditMemos_LDR (ID 50050) extends Record Posted Purchase Credit Memos.
/// </summary>
pageextension 50050 "PostedPurchaseCreditMemos_LDR" extends "Posted Purchase Credit Memos"
{
    layout
    {
        addafter("Ship-to Contact")
        {
            field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
            {
                ApplicationArea = All;
                Caption = 'No. de Nota de crédito del proveedor';
                ToolTip = 'No. de Nota de crédito del proveedor';
            }
        }
    }
}