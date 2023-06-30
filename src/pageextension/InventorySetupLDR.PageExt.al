/// <summary>
/// PageExtension Inventory Setup_LDR (ID 50080) extends Record Inventory Setup.
/// </summary>
pageextension 50080 "Inventory Setup_LDR" extends "Inventory Setup"
{
    layout
    {
        addafter("Item Group Dimension Code")
        {
            field("Inherit Item Dims. to Inv. Jnl_LDR"; Rec."Inherit Item Dims. to Inv. Jnl_LDR")
            {
                ApplicationArea = All;
                Caption = 'Heredar dimensiones del artículo. a inversión jnl';
                ToolTip = 'Heredar dimensiones del artículo. a inversión jnl';
            }
        }
        addafter("Item Nos.")
        {
            field("Item Nos. 2_LDR"; Rec."Item Nos. 2_LDR")
            {
                ApplicationArea = All;
                Caption = 'Números de artículo';
                ToolTip = 'Números de artículo';
            }
        }
    }
}