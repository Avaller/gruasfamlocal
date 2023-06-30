/// <summary>
/// PageExtension SalesShipmentLines_LDR (ID 50110) extends Record Sales Shipment Lines.
/// </summary>
pageextension 50110 "SalesShipmentLines_LDR" extends "Sales Shipment Lines"
{
    layout
    {
        addafter(Quantity)
        {
            field("Line Discount %"; Rec."Line Discount %")
            {
                ApplicationArea = All;
                Caption = '% de descuento de línea';
                ToolTip = '% de descuento de línea';
            }
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
                Caption = 'Precio unitario';
                ToolTip = 'Precio unitario';
            }
        }
    }
}