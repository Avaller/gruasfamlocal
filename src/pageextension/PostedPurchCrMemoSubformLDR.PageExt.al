/// <summary>
/// PageExtension PostedPurch.Cr.MemoSubform_LDR (ID 50045) extends Record Posted Purch. Cr. Memo Subform.
/// </summary>
pageextension 50045 "PostedPurch.Cr.MemoSubform_LDR" extends "Posted Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("Allow Invoice Disc.")
        {
            field("Vendor Contract No._LDR"; Rec."Vendor Contract No._LDR")
            {
                ApplicationArea = All;
                Caption = 'N.° de contrato de proveedor';
                ToolTip = 'N.° de contrato de proveedor';
            }
            field("Service Contract No._LDR"; Rec."Service Contract No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No. Contrato de Servicio';
                ToolTip = 'No. Contrato de Servicio';
            }
            field("Service Contract Line No._LDR"; Rec."Service Contract Line No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de línea del contrato de servicio';
                ToolTip = 'Número de línea del contrato de servicio';
            }
        }
    }
}