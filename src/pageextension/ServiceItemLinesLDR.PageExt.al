/// <summary>
/// PageExtension Service Item Lines_LDR (ID 50114) extends Record Service Item Lines.
/// </summary>
pageextension 50114 "Service Item Lines_LDR" extends "Service Item Lines"
{
    layout
    {
        addafter("Document Type")
        {
            field("Serive Order Type_LDR"; Rec."Serive Order Type_LDR")
            {
                ApplicationArea = All;
                Caption = 'Tipo de orden de servicio';
                ToolTip = 'Tipo de orden de servicio';
            }
        }
        addafter("Document No.")
        {
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
                Caption = 'No de Cliente';
                ToolTip = 'No de Cliente';
            }
        }
        addafter("Service Item Group Code")
        {
            field("Repair Status Code"; Rec."Repair Status Code")
            {
                ApplicationArea = All;
                Caption = 'Código de estado de reparación';
                ToolTip = 'Código de estado de reparación';
            }
            field("Service Inv. Group No._LDR"; Rec."Service Inv. Group No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No de Inversión de servicio grupo';
                ToolTip = 'No de Inversión de servicio grupo';
            }
        }
        addafter("Service Item No.")
        {
            field("Serv. Item Planner No_LDR"; Rec."Serv. Item Planner No_LDR")
            {
                ApplicationArea = All;
                Caption = 'No de Planificador de artículo de servicio';
                ToolTip = 'No de Planificador de artículo de servicio';
            }
        }
        addafter("Contract No.")
        {
            field("Crane Service Quote No._LDR"; Rec."Crane Service Quote No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No de Cotización de servicio de grúa';
                ToolTip = 'No de Cotización de servicio de grúa';
            }
            field("Requested Starting Date_LDR"; Rec."Requested Starting Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Fecha de inicio solicitada';
                ToolTip = 'Fecha de inicio solicitada';
            }
            field("Requested Starting Time_LDR"; Rec."Requested Starting Time_LDR")
            {
                ApplicationArea = All;
                Caption = 'Hora de inicio solicitada';
                ToolTip = 'Hora de inicio solicitada';
            }
            field("Requested Ending Date_LDR"; Rec."Requested Ending Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Fecha de finalización solicitada';
                ToolTip = 'Fecha de finalización solicitada';
            }
            field("Requested Ending Time_LDR"; Rec."Requested Ending Time_LDR")
            {
                ApplicationArea = All;
                Caption = 'Hora de finalización solicitada';
                ToolTip = 'Hora de finalización solicitada';
            }
            field("Sent to Device_LDR"; Rec."Sent to Device_LDR")
            {
                ApplicationArea = All;
                Caption = 'Enviado al dispositivo';
                ToolTip = 'Enviado al dispositivo';
            }
            field("Closed by Device_LDR"; Rec."Closed by Device_LDR")
            {
                ApplicationArea = All;
                Caption = 'Cerrado por dispositivo';
                ToolTip = 'Cerrado por dispositivo';
            }
            field("Serv. Item Counter Code_LDR"; Rec."Serv. Item Counter Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Código de contador de artículo de servicio';
                ToolTip = 'Código de contador de artículo de servicio';
            }
            field("Serv. Item Counter Description_LDR"; Rec."Serv. Item Counter Description_LDR")
            {
                ApplicationArea = All;
                Caption = 'Descripción del contador de elementos de servicio';
                ToolTip = 'Descripción del contador de elementos de servicio';
            }
            field("No of hours_LDR"; Rec."No of hours_LDR")
            {
                ApplicationArea = All;
                Caption = 'Nº de horas';
                ToolTip = 'Nº de horas';
            }
        }
    }

    actions
    {
        addafter("Service Item Worksheet")
        {
            action(ShowDoc)
            {
                ApplicationArea = All;
                Caption = 'Mostrar Docuemnto';
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ServiceOrder: Page "Service Order";
                    //PostedServiceQuote: Page 70057;
                    ServHeader: Record "Service Header";
                begin
                    CASE Rec."Historical Quote_LDR" OF
                        TRUE:
                            BEGIN
                                ServHeader.GET(Rec."Document Type", Rec."Document No.");
                                //PAGE.RUNMODAL(PAGE::Page70057, ServHeader);//TODO: No reconoce Page700057
                            END;
                        FALSE:
                            BEGIN
                                ServHeader.GET(Rec."Document Type", Rec."Document No.");
                                CASE Rec."Document Type" OF
                                    Rec."Document Type"::Order:
                                        PAGE.RUNMODAL(PAGE::"Service Order", ServHeader);
                                    Rec."Document Type"::Quote:
                                        PAGE.RUNMODAL(PAGE::"Service Quote", ServHeader);
                                END;
                            END;
                    END;
                end;
            }
        }
    }

    var
        myInt: Integer;
}