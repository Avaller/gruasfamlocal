/// <summary>
/// PageExtension PostedPurchaseCreditMemo_LDR (ID 50044) extends Record Posted Purchase Credit Memo.
/// </summary>
pageextension 50044 "PostedPurchaseCreditMemo_LDR" extends "Posted Purchase Credit Memo"
{
    layout
    {
        addafter("Corrected Invoice No.")
        {
            field("Vendor Contract No._LDR"; Rec."Vendor Contract No._LDR")
            {
                ApplicationArea = All;
                Caption = 'N.° de contrato de proveedor';
                ToolTip = 'N.° de contrato de proveedor';
            }
        }
    }
}