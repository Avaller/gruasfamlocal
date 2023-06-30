/// <summary>
/// PageExtension GetReturnReceiptLines_LDR (ID 50106) extends Record Get Receipt Lines.
/// </summary>
pageextension 50106 "GetReturnReceiptLines_LDR" extends "Get Receipt Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                Caption = 'N º de pedido.';
                ToolTip = 'N º de pedido.';
            }
        }
        addafter(Description)
        {
            field("Service Order No._LDR"; Rec."Service Order No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de orden de servicio';
                ToolTip = 'Número de orden de servicio';
            }
            field("Vendor Shipment No._LDR"; Rec."Vendor Shipment No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de envío del proveedor';
                ToolTip = 'Número de envío del proveedor';
            }
        }
        addafter("Qty. Rcd. Not Invoiced")
        {
            field("Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                ApplicationArea = All;
                Caption = 'Costo unitario directo';
                ToolTip = 'Costo unitario directo';
            }
            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = All;
                Caption = 'Importe base del IVA';
                ToolTip = 'Importe base del IVA';
            }
        }
    }
}