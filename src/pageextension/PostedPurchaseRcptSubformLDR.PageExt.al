/// <summary>
/// PageExtension PostedPurchaseRcpt.Subform_LDR (ID 50040) extends Record Posted Purchase Rcpt. Subform.
/// </summary>
pageextension 50040 "PostedPurchaseRcpt.Subform_LDR" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter(Description)
        {
            field(Description2; Rec."Description 2")
            {
                ApplicationArea = All;
                Caption = 'Descripción';
                ToolTip = 'Descripción';
            }
            field(Notas1_LDR; Rec.Notas1_LDR)
            {
                ApplicationArea = All;
                Caption = 'Notas';
                ToolTip = 'Notas';
            }
        }
        addafter(Quantity)
        {
            field("Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                ApplicationArea = All;
                Caption = 'Costo unitario directo';
                ToolTip = 'Costo unitario directo';
            }
        }
        addafter("Unit of Measure")
        {
            field("Line Discount %"; Rec."Line Discount %")
            {
                ApplicationArea = All;
                Caption = '% de descuento de línea';
                ToolTip = '% de descuento de línea';
            }
        }
        addafter(Correction)
        {
            field("Service Order No._LDR"; Rec."Service Order No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de orden de servicio';
                ToolTip = 'Número de orden de servicio';
            }
            field("No. EAN Labels_LDR"; Rec."No. EAN Labels_LDR")
            {
                ApplicationArea = All;
                Caption = 'Nº Etiquetas EAN';
                ToolTip = 'Nº Etiquetas EAN';
            }
        }
    }
}