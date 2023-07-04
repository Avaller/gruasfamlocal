pageextension 50129 "Posted Serv. Shpt. Line List" extends "Posted Serv. Shpt. Line List"
{
    layout
    {
        addafter("Document No.")
        {
            field("Service Order Description_LDR"; Rec."Service Order Description_LDR")
            {
                ApplicationArea = All;
                Caption = 'Descripción de la orden de servicio';
                ToolTip = 'Descripción de la orden de servicio';
            }
            field("Number of Hours_LDR"; Rec."Number of Hours_LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de horas';
                ToolTip = 'Número de horas';
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
    }
}