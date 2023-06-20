/// <summary>
/// Page Serv. Item Operations Entry (ID 50057).
/// </summary>
page 50057 "Serv. Item Operations Entry"
{
    // version FAM

    CaptionML = ENU = 'Serv. Item Operations Entry',
                ESP = 'Movs. Operación Prod. Servicio';
    CardPageID = "Serv. Item Operations"; //TODO: No econtrado "Serv. Item Op. Entry Card", lo sustitui por lo mas similar
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Serv. Item Operat Entry_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Serv. Item Code"; Rec."Serv. Item Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo del Articulo de Servicio';
                    ToolTip = 'Codigo del Articulo de Servicio';
                    Visible = false;
                }
                field("Serv. Item Planner No"; Rec."Serv. Item Planner No")
                {
                    ApplicationArea = All;
                    Caption = 'No de Servicio de Aplicador de Articuloes';
                    ToolTip = 'No de Servicio de Aplicador de Articuloes';
                }
                field("Operation Code"; Rec."Operation Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Operación';
                    ToolTip = 'Codigo de Operación';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Operation Type"; Rec."Operation Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de Operación';
                    ToolTip = 'Tipo de Operación';
                }
                field("Period Type"; Rec."Period Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de Periodo';
                    ToolTip = 'Tipo de Periodo';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Creación';
                    ToolTip = 'Fecha de Creación';
                }
                field("Next Planned Date"; Rec."Next Planned Date")
                {
                    ApplicationArea = All;
                    Caption = 'Proxima Fecha Planeada';
                    ToolTip = 'Proxima Fecha Planeada';
                }
                field("Last Planned Date"; Rec."Last Planned Date")
                {
                    ApplicationArea = All;
                    Caption = 'Ultima Fecha Planeada';
                    ToolTip = 'Ultima Fecha Planeada';
                }
                field("Next Planned Hours"; Rec."Next Planned Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Proximas Horas Planeadas';
                    ToolTip = 'Proximas Horas Planeadas';
                }
                field("Actual Hours"; Rec."Actual Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas Actuales';
                    ToolTip = 'Horas Actuales';
                }
                field("Last Planned Hours"; Rec."Last Planned Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Ultimas Horas Planeadas';
                    ToolTip = 'Ultimas Horas Planeadas';
                }
                field("Self/External"; Rec."Self/External")
                {
                    ApplicationArea = All;
                    Caption = 'Interno/Externo';
                    ToolTip = 'Interno/Externo';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    Caption = 'Cerrado';
                    ToolTip = 'Cerrado';
                }
                field("Execution Date"; Rec."Execution Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Ejecución';
                    ToolTip = 'Fecha de Ejecución';
                }
                field("Serv. Order No."; Rec."Serv. Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Orden de Servicio';
                    Editable = false;
                    ToolTip = 'No de Orden de Servicio';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de entrada';
                    Editable = false;
                    ToolTip = 'No de entrada';
                }
                field("Requested Resource No."; Rec."Requested Resource No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Recursos Requeridos';
                    Editable = false;
                    ToolTip = 'No de Recursos Requeridos';
                }
            }
        }
    }
}

