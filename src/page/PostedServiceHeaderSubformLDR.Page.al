/// <summary>
/// 
/// 
/// </summary>
Page 50204 "Posted Service Header Subform"
{
    // version ALQUINTA9.00

    AutoSplitKey = true;
    CaptionML = ENU = 'Lines',
                ESP = 'Líneas';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Posted Service Item Line_LDR";

    /*
    layout
    {
        area(content)
        {
            repeater(Fields)
            {
                Field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Linea';
                    ToolTip = 'No de Linea';
                    Visible = false;
                }
                Field("Service Inv. Group No."; Rec."Service Inv. Group No.")
                {
                    ApplicationArea = All;
                    Caption = 'Inversión de servicio grupo no.';
                    ToolTip = 'Inversión de servicio grupo no.';
                }
                Field("Crane Service Quote No."; Rec."Crane Service Quote No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cotización de servicio de grúa No.';
                    ToolTip = 'Cotización de servicio de grúa No.';
                }
                Field("Service Item Tariff No."; Rec."Service Item Tariff No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de tarifa del artículo de servicio';
                    ToolTip = 'Número de tarifa del artículo de servicio';
                }
                Field("Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de artículo de servicio';
                    ToolTip = 'Número de artículo de servicio';
                }
                Field("Serv. Item Planner No"; Rec."Serv. Item Planner No")
                {
                    ApplicationArea = All;
                    Caption = 'Planificador de artículos de servicio No';
                    ToolTip = 'Planificador de artículos de servicio No';
                }
                Field("Service Item Group Code"; Rec."Service Item Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de grupo de artículo de servicio';
                    ToolTip = 'Código de grupo de artículo de servicio';
                }
                Field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de serie';
                    ToolTip = 'Número de serie';
                }
                Field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                Field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción 2';
                    ToolTip = 'Descripción 2';
                    Visible = false;
                }
                Field("Fault Comment"; Rec."Fault Comment")
                {
                    ApplicationArea = All;
                    Caption = 'Comentario de falla';
                    ToolTip = 'Comentario de falla';
                    Visible = false;

                    trigger OnDrillDown();
                    begin
                        Rec.ShowComments(1);
                    end;
                }
                Field("Resolution Comment"; Rec."Resolution Comment")
                {
                    ApplicationArea = All;
                    Caption = 'Resolución Comentario';
                    ToolTip = 'Resolución Comentario';
                    Visible = false;

                    trigger OnDrillDown();
                    begin
                        Rec.ShowComments(2);
                    end;
                }
                Field("Service Shelf No."; Rec."Service Shelf No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Estante de servicio';
                    ToolTip = 'No de Estante de servicio';
                    Visible = false;
                }
                Field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de contrato';
                    ToolTip = 'Nº de contrato';
                }
                Field("Fault Reason Code"; Rec."Fault Reason Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de motivo de falla';
                    ToolTip = 'Código de motivo de falla';
                    Visible = false;
                }
                Field("Service Price Group Code"; Rec."Service Price Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de grupo de precio de servicio';
                    ToolTip = 'Código de grupo de precio de servicio';
                    Visible = false;
                }
                Field("Fault Area Code"; Rec."Fault Area Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de área de falla';
                    ToolTip = 'Código de área de falla';
                    Visible = false;
                }
                Field("Symptom Code"; Rec."Symptom Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de síntoma';
                    ToolTip = 'Código de síntoma';
                    Visible = false;
                }
                Field("Fault Code"; Rec."Fault Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de fallo';
                    ToolTip = 'Código de fallo';
                    Visible = false;
                }
                Field("Resolution Code"; Rec."Resolution Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de resolución';
                    ToolTip = 'Código de resolución';
                    Visible = false;
                }
                Field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    Caption = 'Prioridad';
                    ToolTip = 'Prioridad';
                }
                Field("Response Time (Hours)"; Rec."Response Time (Hours)")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de respuesta (horas)';
                    ToolTip = 'Tiempo de respuesta (horas)';
                }
                Field("Response Date"; Rec."Response Date")
                {
                    ApplicationArea = All;
                    Caption = 'Response Date';
                    ToolTip = 'Response Date';
                }
                Field("Response Time"; Rec."Response Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de respuesta';
                    ToolTip = 'Tiempo de respuesta';
                }
                Field("No of hours"; Rec."No of hours")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de horas';
                    ToolTip = 'Nº de horas';
                }
                Field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de inicio';
                    ToolTip = 'Fecha de inicio';
                    Visible = false;
                }
                Field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de empezar';
                    ToolTip = 'Tiempo de empezar';
                    Visible = false;
                }
                Field("Finishing Date"; Rec."Finishing Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de finalización';
                    ToolTip = 'Fecha de finalización';
                    Visible = false;
                }
                Field("Finishing Time"; Rec."Finishing Time")
                {
                    ApplicationArea = All;
                    Caption = 'Hora de finalización';
                    ToolTip = 'Hora de finalización';
                    Visible = false;
                }
                Field("Warranty No."; Rec."Warranty No.")
                {
                    ApplicationArea = All;
                    Caption = 'número de garantía';
                    ToolTip = 'número de garantía';
                }
                Field("Requested Starting Date"; Rec."Requested Starting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de inicio solicitada';
                    ToolTip = 'Fecha de inicio solicitada';
                }
                Field("Requested Starting Time"; Rec."Requested Starting Time")
                {
                    ApplicationArea = All;
                    Caption = 'Hora de inicio solicitada';
                    ToolTip = 'Hora de inicio solicitada';
                }
                Field("Requested Ending Date"; Rec."Requested Ending Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de finalización solicitada';
                    ToolTip = 'Fecha de finalización solicitada';
                }
                Field("Requested Ending Time"; Rec."Requested Ending Time")
                {
                    ApplicationArea = All;
                    Caption = 'Hora de finalización solicitada';
                    ToolTip = 'Hora de finalización solicitada';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                            ESP = '&Línea';
                Image = Line;
                action("Resource &Allocations")
                {
                    CaptionML = ENU = 'Resource &Allocations',
                                ESP = 'Asignaciones &recurso';
                    Image = ResourcePlanning;
                    RunObject = Page "Service Order Allocations";
                    RunPageLink = "Document Type" = Const(Order),
                                  "Document No." = Field("No.");
                    RunPageView = SORTING(Status, "Document Type", "Document No.", "Service Item Line No.", "Allocation Date", "Starting Time", Posted);
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    CaptionML = ENU = 'Dimensions',
                                ESP = 'Dimensiones';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                group("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                ESP = 'C&omentarios';
                    Image = ViewComments;
                    action(Faults)
                    {
                        CaptionML = ENU = 'Faults',
                                    ESP = 'Defectos';
                        Image = Error;

                        trigger OnAction();
                        begin
                            ShowComments(1);
                        end;
                    }
                    action(Resolutions)
                    {
                        CaptionML = ENU = 'Resolutions',
                                    ESP = 'Resoluciones';
                        Image = Completed;

                        trigger OnAction();
                        begin
                            ShowComments(2);
                        end;
                    }
                    action(Internal)
                    {
                        CaptionML = ENU = 'Internal',
                                    ESP = 'Interno';
                        Image = Comment;

                        trigger OnAction();
                        begin
                            ShowComments(4);
                        end;
                    }
                    action(Accessories)
                    {
                        CaptionML = ENU = 'Accessories',
                                    ESP = 'Accesorios';
                        Image = ServiceAccessories;

                        trigger OnAction();
                        begin
                            ShowComments(3);
                        end;
                    }
                    action("Lent Loaners")
                    {
                        CaptionML = ENU = 'Lent Loaners',
                                    ESP = 'Prod. prestados';

                        trigger OnAction();
                        begin
                            ShowComments(5);
                        end;
                    }
                }
            }
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            ESP = 'Funci&ones';
                Image = "Action";
                action("Mark warranty as rechazed")
                {
                    CaptionML = ENU = 'Mark warranty as rechazed',
                                ESP = 'Marcar Garantía como Rechazada';
                    Image = Reject;

                    trigger OnAction();
                    begin
                        RejectWarranty;
                    end;
                }
                action("Unmark warranty as rechazed")
                {
                    CaptionML = ENU = 'Unmark warranty as rechazed',
                                ESP = 'Desmarcar Garantía como Rechazada';
                    Image = Undo;

                    trigger OnAction();
                    begin
                        UnrejectWarranty;
                    end;
                }
            }
            group("O&rder")
            {
                CaptionML = ENU = 'O&rder',
                            ESP = '&Pedido';
                Image = "Order";
                action("Service Shipment Lines")
                {
                    CaptionML = ENU = 'Service Shipment Lines',
                                ESP = 'Líneas factura servicio';
                    Image = ServiceLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction();
                    begin
                        ShowServInvLines;
                    end;
                }
            }
        }
    }

    var
        ServLoanerMgt: Codeunit ServLoanerManagement;
        Text000: TextConst ENU = 'You can view the Service Item Log only for service item lines with the specified Service Item No.', ESP = 'Sólo puede ver el registro prod. servicio para líns. prod. servicio con el nº prod. servicio especificado.';

    procedure ShowComments(Type: Option General,Fault,Resolution,Accessory,Internal,"Service Item Loaner");
    begin
        Rec.ShowComments(Type);
    end;

    procedure ShowServShipmentLines();
    var
        ServShipmentLine: Record "Service Shipment Line";
        ServShipmentLines: Page "Posted Service Shipment Lines";
    begin
        Rec.TestField("No.");
        Clear(ServShipmentLine);
        ServShipmentLine.SetRange("Order No.", Rec."No.");
        ServShipmentLine.FilterGroup(2);
        Clear(ServShipmentLines);
        ServShipmentLines.Initialize(Rec."Line No.");
        ServShipmentLines.SetTableView(ServShipmentLine);
        ServShipmentLines.RunModal;
        ServShipmentLine.FilterGroup(0);
    end;

    procedure ShowServInvLines();
    var
        ServInvLine: Record "Posted Service Line_LDR";
        ServInvLines: Page "Posted Service Lines";
    begin
        Rec.TestField("No.");
        Clear(ServInvLine);
        ServInvLine.SetRange("Document No.", Rec."No.");
        ServInvLine.FilterGroup(2);
        Clear(ServInvLines);
        ServInvLines.Initialize(Rec."Line No.");
        ServInvLines.SetTableView(ServInvLine);
        ServInvLines.RunModal;
        ServInvLine.FilterGroup(0);
    end;

    procedure ShowServItemEventLog();
    var
        ServItemLog: Record "Service Item Log";
    begin
        if Rec."Service Item No." = '' Then
            Error(Text000);
        Clear(ServItemLog);
        ServItemLog.SetRange("Service Item No.", Rec."Service Item No.");
        Page.RunModal(Page::"Service Item Log", ServItemLog);
    end;

    procedure RejectWarranty();
    var
        cduReject: Codeunit 70009; //TODO: No se encuentra
    begin
        cduReject.Run(Rec);
        CurrPage.UpDate(false);
    end;

    procedure UnrejectWarranty();
    var
        cduunreject: Codeunit 70012; //TODO: No se encuentra
    begin
        cduunreject.Run(Rec);
        CurrPage.UpDate(false);
    end;
    */
}

