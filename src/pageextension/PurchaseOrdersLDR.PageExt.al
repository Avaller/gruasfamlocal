/// <summary>
/// PageExtension Purchase Orders (ID 50025) extends Record Purchase Orders.
/// </summary>
pageextension 50025 "Purchase Orders_LDR" extends "Purchase Orders"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Line Amount"; Rec."Line Amount")
            {
                ApplicationArea = All;
                Caption = 'Cantidad de línea';
                ToolTip = 'Cantidad de línea';
            }
        }

    }
}