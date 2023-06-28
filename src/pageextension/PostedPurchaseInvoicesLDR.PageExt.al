/// <summary>
/// PageExtension Posted Purchase Invoices_LDR (ID 50049) extends Record Posted Purchase Invoices.
/// </summary>
pageextension 50049 "Posted Purchase Invoices_LDR" extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;
                Caption = 'Descripción de la publicación';
                ToolTip = 'Descripción de la publicación';
            }
            field("Vendor Order No."; Rec."Vendor Order No.")
            {
                ApplicationArea = All;
                Caption = 'Número de pedido del proveedor';
                ToolTip = 'Número de pedido del proveedor';
            }
        }
    }
}