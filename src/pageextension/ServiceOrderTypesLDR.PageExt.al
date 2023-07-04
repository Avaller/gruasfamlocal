/// <summary>
/// PageExtension Service Order Types_LDR (ID 50119) extends Record Service Order Types.
/// </summary>
pageextension 50119 "Service Order Types_LDR" extends "Service Order Types"
{
    layout
    {
        addafter(Description)
        {
            field("Platform Delivery/Pickup_LDR"; Rec."Platform Delivery/Pickup_LDR")
            {
                ApplicationArea = All;
                Caption = 'Entrega/recogida en la plataforma';
                ToolTip = 'Entrega/recogida en la plataforma';
            }
        }
    }
}