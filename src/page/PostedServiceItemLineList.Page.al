/// <summary>
/// Page Posted Service Item Line List (ID 50020).
/// </summary>
page 50020 "Posted Service Item Line List"
{
    Caption = 'Posted Service Shpt. Item Line List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Posted Service Item Line_LDR";

    layout
    {
        area(content)
        {
            repeater(Fields)
            {
                field("Serive Order Type"; Rec."Serive Order Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de orden de servicio';
                    ToolTip = 'Tipo de orden de servicio';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                    ToolTip = 'No';
                }
                field("Service Order Description"; Rec."Service Order Description")
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
                    Caption = 'Ningún cliente.';
                    ToolTip = 'Ningún cliente.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de línea';
                    ToolTip = 'Nº de línea';
                }
                field("Repair Status Code"; Rec."Repair Status Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de estado de reparación';
                    ToolTip = 'Código de estado de reparación';
                }
                field("Service Inv. Group No."; Rec."Service Inv. Group No.")
                {
                    ApplicationArea = All;
                    Caption = 'Inversión de servicio grupo no.';
                    ToolTip = 'Inversión de servicio grupo no.';
                }
                field("Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de artículo de servicio';
                    ToolTip = 'Número de artículo de servicio';
                }
                field("Serv. Item Planner No"; Rec."Serv. Item Planner No")
                {
                    ApplicationArea = All;
                    Caption = 'Serv. Item Planner No';
                    ToolTip = 'Serv. Item Planner No';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de serie';
                    ToolTip = 'Número de serie';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de contrato';
                    ToolTip = 'Nº de contrato';
                }
                field("Crane Service Quote No."; Rec."Crane Service Quote No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cotización de servicio de grúa No.';
                    ToolTip = 'Cotización de servicio de grúa No.';
                }
                field("Requested Starting Date"; Rec."Requested Starting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de inicio solicitada';
                    ToolTip = 'Fecha de inicio solicitada';
                }
                field("Requested Starting Time"; Rec."Requested Starting Time")
                {
                    ApplicationArea = All;
                    Caption = 'Hora de inicio solicitada';
                    ToolTip = 'Hora de inicio solicitada';
                    Visible = false;
                }
                field("Requested Ending Date"; Rec."Requested Ending Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de finalización solicitada';
                    ToolTip = 'Fecha de finalización solicitada';
                }
                field("Requested Ending Time"; Rec."Requested Ending Time")
                {
                    ApplicationArea = All;
                    Caption = 'Hora de finalización solicitada';
                    ToolTip = 'Hora de finalización solicitada';
                    Visible = false;
                }
                field("Sent to Device"; Rec."Sent to Device")
                {
                    ApplicationArea = All;
                    Caption = 'Enviado al dispositivo';
                    ToolTip = 'Enviado al dispositivo';
                    Visible = false;
                }
                field("Closed by Device"; Rec."Closed by Device")
                {
                    ApplicationArea = All;
                    Caption = 'Cerrado por dispositivo';
                    ToolTip = 'Cerrado por dispositivo';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("<Page Posted Service HeaSder>")
                {
                    Caption = '&Show Document';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Posted Service Header";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}