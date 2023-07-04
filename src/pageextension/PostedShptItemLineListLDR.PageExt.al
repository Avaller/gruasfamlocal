/// <summary>
/// PageExtension PostedShpt.ItemLineList_LDR (ID 50130) extends Record Posted Shpt. Item Line List.
/// </summary>
pageextension 50130 "PostedShpt.ItemLineList_LDR" extends "Posted Shpt. Item Line List"
{
    layout
    {
        addafter("No.")
        {
            field("Serive Order Type_LDR"; Rec."Serive Order Type_LDR")
            {
                ApplicationArea = All;
                Caption = 'Tipo de orden de servicio';
                ToolTip = 'Tipo de orden de servicio';
            }
            field("Service Order Description_LDR"; Rec."Service Order Description_LDR")
            {
                ApplicationArea = All;
                Caption = 'Descripción de la orden de servicio';
                ToolTip = 'Descripción de la orden de servicio';
            }
            field("Ship-to Code"; Rec."Ship-to Code")
            {
                ApplicationArea = All;
                Caption = 'Código de envío';
                ToolTip = 'Código de envío';
            }
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
                Caption = 'No de cliente';
                ToolTip = 'No de cliente';
            }
        }
        addafter("Service Item No.")
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
                Caption = 'Descripción';
                ToolTip = 'Descripción';
            }
        }
    }
}