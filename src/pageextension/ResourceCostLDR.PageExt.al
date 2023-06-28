/// <summary>
/// PageExtension Resource Costs_LDR (ID 50052) extends Record Resource Costs.
/// </summary>
pageextension 50052 "Resource Costs_LDR" extends "Resource Costs"
{
    layout
    {
        addafter("Work Type Code")
        {
            field("Unit of Measure Code_LDR"; Rec."Unit of Measure Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Unidad de Medida';
                ToolTip = 'Codigo de Unidad de Medida';
            }
        }
    }
}