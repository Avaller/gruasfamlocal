/// <summary>
/// PageExtension Purchase Lines_LDR (ID 50084) extends Record Purchase Lines.
/// </summary>
pageextension 50084 "Purchase Lines_LDR" extends "Purchase Lines"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2_LDR"; Rec."Description 2")
            {
                ApplicationArea = All;
                Caption = 'Descripción';
                ToolTip = 'Descripción';
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de orden';
                ToolTip = 'Fecha de orden';
            }
        }
        addafter("Outstanding Amount (LCY)")
        {
            field("Service Order No._LDR"; Rec."Service Order No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de orden de servicio';
                ToolTip = 'Número de orden de servicio';
            }
        }
        addafter("Amt. Rcd. Not Invoiced (LCY)")
        {
            field(Notas1_LDR; Rec.Notas1_LDR)
            {
                ApplicationArea = All;
                Caption = 'Notas 1';
                ToolTip = 'Notas 1';
            }
        }
    }
}