/// <summary>
/// PageExtension Item Journal Batches (ID 50059) extends Record Item Journal Batches.
/// </summary>
pageextension 50059 "Item Journal Batches" extends "Item Journal Batches"
{
    layout
    {
        addafter("Posting No. Series")
        {
            field("Open Service Order Test_LDR"; Rec."Open Service Order Test_LDR")
            {
                ApplicationArea = All;
                Caption = 'Prueba de orden de servicio abierta';
                ToolTip = 'Prueba de orden de servicio abierta';
            }
            field(Mobility_LDR; Rec.Mobility_LDR)
            {
                ApplicationArea = All;
                Caption = 'Movilidad';
                ToolTip = 'Movilidad';
            }
        }
    }
}