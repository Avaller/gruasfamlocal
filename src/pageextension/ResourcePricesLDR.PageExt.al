/// <summary>
/// PageExtension Resource Prices_LDR (ID 50053) extends Record Resource Prices.
/// </summary>
pageextension 50053 "Resource Prices_LDR" extends "Resource Prices"
{
    layout
    {
        addafter("Work Type Code")
        {
            field("Unit of Measure Code_LDR"; Rec."Unit of Measure Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Unidad de Nedida';
                ToolTip = 'Codigo de Unidad de Nedida';
            }
        }
    }
}