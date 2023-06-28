pageextension 50035 "Posted Sales Shpt. Subform_LDR" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("Return Reason Code")
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