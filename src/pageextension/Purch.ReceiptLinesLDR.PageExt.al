/// <summary>
/// PageExtension Purch.ReceiptLines_LDR (ID 50109) extends Record Purch. Receipt Lines.
/// </summary>
pageextension 50109 "Purch.ReceiptLines_LDR" extends "Purch. Receipt Lines"
{
    layout
    {
        addafter("Indirect Cost %")
        {
            field("Line Discount %"; Rec."Line Discount %")
            {
                ApplicationArea = All;
                Caption = '% de descuento de línea';
                ToolTip = '% de descuento de línea';
            }
        }
    }
}