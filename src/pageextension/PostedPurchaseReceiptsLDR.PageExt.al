/// <summary>
/// PageExtension Posted Purchase Receipts_LDR (ID 50048) extends Record Posted Purchase Receipts.
/// </summary>
pageextension 50048 "Posted Purchase Receipts_LDR" extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("No.")
        {
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = All;
                Caption = 'Número de envío del proveedor';
                ToolTip = 'Número de envío del proveedor';
            }
        }
        addafter("Order Address Code")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                Caption = 'N º de pedido.';
                ToolTip = 'N º de pedido.';
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;
                Caption = 'Descripción de la publicación';
                ToolTip = 'Descripción de la publicación';
            }
        }
        addafter("Ship-to Contact")
        {
            field("Machine Purchase Document_LDR"; Rec."Machine Purchase Document_LDR")
            {
                ApplicationArea = All;
                Caption = 'Documento de compra de la máquina';
                ToolTip = 'Documento de compra de la máquina';
            }
            field("Machine Status_LDR"; Rec."Machine Status_LDR")
            {
                ApplicationArea = All;
                Caption = 'Estado de la máquina';
                ToolTip = 'Estado de la máquina';
            }
        }

    }
}