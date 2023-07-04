/// <summary>
/// PageExtension StockkeepingUnitList_LDR (ID 50103) extends Record Stockkeeping Unit List.
/// </summary>
pageextension 50103 "StockkeepingUnitList_LDR" extends "Stockkeeping Unit List"
{
    layout
    {
        addafter("Item No.")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                Caption = 'Número de proveedor';
                ToolTip = 'Número de proveedor';
            }
        }
        addafter("Replenishment System")
        {
            field("Reordering Policy"; Rec."Reordering Policy")
            {
                ApplicationArea = All;
                Caption = 'Política de reordenamiento';
                ToolTip = 'Política de reordenamiento';
            }
        }
        addafter(Inventory)
        {
            field("Exclude armopa_LDR"; Rec."Exclude armopa_LDR")
            {
                ApplicationArea = All;
                Caption = 'Excluir armopa';
                ToolTip = 'Excluir armopa';
            }
        }
        addafter("Reorder Point")
        {
            field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
            {
                ApplicationArea = All;
                Caption = 'Cantidad de existencias de seguridad';
                ToolTip = 'Cantidad de existencias de seguridad';
            }
        }
        addafter("Assembly Policy")
        {
            field("Transfer-from Code"; Rec."Transfer-from Code")
            {
                ApplicationArea = All;
                Caption = 'Código de transferencia';
                ToolTip = 'Código de transferencia';
            }
        }
    }
}