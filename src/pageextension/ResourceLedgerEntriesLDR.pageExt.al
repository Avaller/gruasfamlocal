/// <summary>
/// PageExtension Resource Ledger Entries_LDR (ID 50051) extends Record Resource Ledger Entries.
/// </summary>
pageextension 50051 "Resource Ledger Entries_LDR" extends "Resource Ledger Entries"
{
    layout
    {
        addafter("Resource No.")
        {
            field("Resource Name_LDR"; Rec."Resource Name_LDR")
            {
                ApplicationArea = All;
                Caption = 'Nombre del recurso';
                Editable = false;
                ToolTip = 'Nombre del recurso';
            }
        }
        addafter("Work Type Code")
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
        }
        addafter(Quantity)
        {
            field("Internal Quantity_LDR"; Rec."Internal Quantity_LDR")
            {
                ApplicationArea = All;
                Caption = 'Cantidad interna';
                ToolTip = 'Cantidad interna';
            }
        }
    }
}