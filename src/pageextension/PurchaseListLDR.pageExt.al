/// <summary>
/// PageExtension Purchase List (ID 50022) extends Record Purchase List.
/// </summary>
pageextension 50022 "Purchase List_LDR" extends "Purchase List"
{
    layout
    {
        addafter("Order Address Code")
        {
            field("Vendor Order No."; Rec."Vendor Order No.")
            {
                ApplicationArea = All;
                Caption = 'Número de pedido del proveedor';
                ToolTip = 'Número de pedido del proveedor';
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = All;
                Caption = 'Número de envío del proveedor';
                ToolTip = 'Número de envío del proveedor';
            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
                Caption = 'Número de factura del proveedor';
                ToolTip = 'Número de factura del proveedor';
            }
            field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
            {
                ApplicationArea = All;
                Caption = 'Número de memoria de crédito del proveedor';
                ToolTip = 'Número de memoria de crédito del proveedor';
            }
            field(Receive; Rec.Receive)
            {
                ApplicationArea = All;
                Caption = 'Recibir';
                ToolTip = 'Recibir';
            }
            field(Invoice; Rec.Invoice)
            {
                ApplicationArea = All;
                Caption = 'Factura';
                ToolTip = 'Factura';
            }
            field("Completely Received"; Rec."Completely Received")
            {
                ApplicationArea = All;
                Caption = 'Completamente recibido';
                ToolTip = 'Completamente recibido';
            }
            field(Notas1_LDR; Rec.Notas1_LDR)
            {
                ApplicationArea = All;
                Caption = 'Notas 1';
                ToolTip = 'Notas 1';
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("Buy-from Address 2"; Rec."Buy-from Address 2")
            {
                ApplicationArea = All;
                Caption = 'Dirección de compra';
                ToolTip = 'Dirección de compra';
            }
            field(Notas12_LDR; Rec.Notas1_LDR)
            {
                ApplicationArea = All;
                Caption = 'Notas';
                ToolTip = 'Notas';
            }
            field("Total Amount_LDR"; Rec."Total Amount_LDR")
            {
                ApplicationArea = All;
                Caption = 'Cantidad total';
                ToolTip = 'Cantidad total';
            }
        }
        addafter("Vendor Authorization No.")
        {
            field("Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de recepción prometida';
                ToolTip = 'Fecha de recepción prometida';
            }
            field("Vendor Order No.1"; Rec."Vendor Order No.")
            {
                ApplicationArea = All;
                Caption = 'Número de pedido del proveedor';
                ToolTip = 'Número de pedido del proveedor';
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de orden';
                ToolTip = 'Fecha de orden';
            }
        }
    }

    var
        DimMgt: Codeunit DimensionManagement;
}