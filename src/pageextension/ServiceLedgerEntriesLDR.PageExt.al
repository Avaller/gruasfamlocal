/// <summary>
/// PageExtension Service Ledger Entries_LDR (ID 50121) extends Record Service Ledger Entries.
/// </summary>
pageextension 50121 "Service Ledger Entries_LDR" extends "Service Ledger Entries"
{
    layout
    {
        addafter("Service Order Type")
        {
            field("Service Item No. (Serviced)2"; Rec."Service Item No. (Serviced)")
            {
                ApplicationArea = All;
                Caption = 'Número de artículo de servicio (revisado)';
                ToolTip = 'Número de artículo de servicio (revisado)';
            }
        }
        addafter("Service Contract No.")
        {
            field("Internal Service Contract No._LDR"; Rec."Internal Service Contract No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No. de Contrato de Servicio Interno';
                ToolTip = 'No. de Contrato de Servicio Interno';
            }
            field("Vendor Service Contract No._LDR"; Rec."Vendor Service Contract No._LDR")
            {
                ApplicationArea = All;
                Caption = 'N.° de contrato de servicio del proveedor';
                ToolTip = 'N.° de contrato de servicio del proveedor';
            }
        }
        addafter("Document Type")
        {
            field("Amount without Discounts_LDR"; Rec."Amount without Discounts_LDR")
            {
                ApplicationArea = All;
                Caption = 'Monto sin Descuentos';
                ToolTip = 'Monto sin Descuentos';
            }
        }
        addafter("Document No.")
        {
            field("Buy Payment Discount %_LDR"; Rec."Buy Payment Discount %_LDR")
            {
                ApplicationArea = All;
                Caption = '% de descuento de pago de compra';
                ToolTip = '% de descuento de pago de compra';
            }
            field("Buy Line Discount_LDR"; Rec."Buy Line Discount_LDR")
            {
                ApplicationArea = All;
                Caption = 'Comprar línea de descuento';
                ToolTip = 'Comprar línea de descuento';
            }
            field("uy Invoice Discount_LDR"; Rec."uy Invoice Discount_LDR")
            {
                ApplicationArea = All;
                Caption = 'Descuento de factura de compra';
                ToolTip = 'Descuento de factura de compra';
            }
            field("Work Type Code"; Rec."Work Type Code")
            {
                ApplicationArea = All;
                Caption = 'Código de tipo de trabajo';
                ToolTip = 'Código de tipo de trabajo';
            }
            field("Unit of Measure Code"; Rec."Unit of Measure Code")
            {
                ApplicationArea = All;
                Caption = 'Código de unidad de medida';
                ToolTip = 'Código de unidad de medida';
            }
        }
        addafter("Unit Cost")
        {
            field("Initial Time_LDR"; Rec."Initial Time_LDR")
            {
                ApplicationArea = All;
                Caption = 'Tiempo inicial';
                ToolTip = 'Tiempo inicial';
            }
            field("End Time_LDR"; Rec."End Time_LDR")
            {
                ApplicationArea = All;
                Caption = 'Hora de finalización';
                ToolTip = 'Hora de finalización';
            }
            field("Internal Quantity_LDR"; Rec."Internal Quantity_LDR")
            {
                ApplicationArea = All;
                Caption = 'Cantidad interna';
                ToolTip = 'Cantidad interna';
            }
        }
        addafter("Applies-to Entry No.")
        {
            field(AC_LDR; Rec.AC_LDR)
            {
                ApplicationArea = All;
                Caption = 'AC';
                ToolTip = 'AC';
            }
            field(AD_LDR; Rec.AD_LDR)
            {
                ApplicationArea = All;
                Caption = 'AD';
                ToolTip = 'AD';
            }
            field("Internal Discount %_LDR"; Rec."Internal Discount %_LDR")
            {
                ApplicationArea = All;
                Caption = '% de descuento interno';
                ToolTip = '% de descuento interno';
            }
        }
    }
}