/// <summary>
/// PageExtension Repair Status Setup (ID 50128) extends Record Repair Status Setup.
/// </summary>
pageextension 50128 "Repair Status Setup" extends "Repair Status Setup"
{
    layout
    {
        addafter("Finished Status Allowed")
        {
            field("Not allow insert service lines_LDR"; Rec."Not allow insert service lines_LDR")
            {
                ApplicationArea = All;
                Caption = 'No permitir insertar líneas de servicio';
                ToolTip = 'No permitir insertar líneas de servicio';
            }
        }
        addafter("On Hold Status Allowed")
        {
            field("Mobile Index_LDR"; Rec."Mobile Index_LDR")
            {
                ApplicationArea = All;
                Caption = 'Índice móvil';
                ToolTip = 'Índice móvil';
            }
            field("Index of AMPLUS_LDR"; Rec."Index of AMPLUS_LDR")
            {
                ApplicationArea = All;
                Caption = 'Índice de AMPLUS';
                ToolTip = 'Índice de AMPLUS';
            }
            field("Planner Color_LDR"; Rec."Planner Color_LDR")
            {
                ApplicationArea = All;
                Caption = 'Color del planificador';
                ToolTip = 'Color del planificador';
            }
            field("Serv. Order Replication Status_LDR"; Rec."Serv. Order Replication Status_LDR")
            {
                ApplicationArea = All;
                Caption = 'serv. Estado de replicación de pedidos';
                ToolTip = 'serv. Estado de replicación de pedidos';
            }
        }
    }
}