/// <summary>
/// PageExtension Service Tasks_LDR (ID 50122) extends Record Service Tasks.
/// </summary>
pageextension 50122 "Service Tasks_LDR" extends "Service Tasks"
{
    layout
    {
        addafter(ResourceGroupFilter)
        {
            field(CustomFilter; CustomFilter)
            {
                ApplicationArea = All;
                Caption = 'Filtro de clientes';
                ToolTip = 'Filtro de clientes';

                trigger OnValidate()
                begin
                    SetCustFilter;
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Cust.RESET;
                    IF PAGE.RUNMODAL(0, Cust) = ACTION::LookupOK THEN BEGIN
                        Text := Cust."No.";
                        EXIT(TRUE);
                    END;
                end;
            }

            field(OrderTypeFilter; OrderTypeFilter)
            {
                ApplicationArea = All;
                Caption = 'Filtro de tipo de pedido';
                ToolTip = 'Filtro de tipo de pedido';

                trigger OnValidate()
                begin
                    SetOrderTypeFilter;
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    servOrderType: Record "Service Order Type";
                begin
                    servOrderType.RESET;
                    IF PAGE.RUNMODAL(0, servOrderType) = ACTION::LookupOK THEN BEGIN
                        Text := servOrderType.Code;
                        EXIT(true);
                    END;
                end;
            }
        }
        addafter(RepairStatusFilter)
        {
            field(ServItemFilter; ServItemFilter)
            {
                ApplicationArea = All;
                Caption = '';

                trigger OnValidate()
                begin
                    Rec.FILTERGROUP(2);
                    TempTextFilter := Rec.GetFilter("Service Item Code Filter_LDR");
                    Rec.FILTERGROUP(0);
                    SetServItemFilter;
                    IF NOT TestFilter THEN BEGIN
                        ServItemFilter := TempTextFilter;
                        SetServItemFilter;
                        ERROR(Text000, Rec.TABLECAPTION);
                    END;
                    ServItemFilterOnAfterValidate;
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    ServItem: Record "Service Item";
                begin
                    ServItem.RESET;
                    ServItem.SETRANGE("Cancelation Cause Code_LDR", '');
                    IF PAGE.RUNMODAL(0, ServItem) = ACTION::LookupOK THEN BEGIN
                        Text := ServItem."No.";
                        EXIT(TRUE);
                    END;
                end;
            }
        }
        addafter("Response Date")
        {
            field("Service Order Date_LDR"; Rec."Service Order Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Fecha de orden de servicio';
                ToolTip = 'Fecha de orden de servicio';
            }
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
            field("Service Order Shortcut Dim 1_LDR"; Rec."Service Order Shortcut Dim 1_LDR")
            {
                ApplicationArea = All;
                Caption = 'Acceso directo de orden de servicio Dim 1';
                ToolTip = 'Acceso directo de orden de servicio Dim 1';
            }
            field("Service Order Shortcut Dim 2_LDR"; Rec."Service Order Shortcut Dim 2_LDR")
            {
                ApplicationArea = All;
                Caption = 'Acceso directo de orden de servicio Dim 2';
                ToolTip = 'Acceso directo de orden de servicio Dim 2';
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
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                Caption = 'Descripción';
                ToolTip = 'Descripción';
            }
        }
        addafter("No. of Allocations")
        {
            field("Allocated Date_LDR"; Rec."Allocated Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'No. de Cotización de servicio de grúa';
                ToolTip = 'No. de Cotización de servicio de grúa';
            }
            field("Crane Service Quote No._LDR"; Rec."Crane Service Quote No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No. de Cotización de servicio de grúa';
                ToolTip = 'No. de Cotización de servicio de grúa';
            }
            field("Service Item Tariff No._LDR"; Rec."Service Item Tariff No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Núm. de tarifa del artículo de servicio';
                ToolTip = 'Núm. de tarifa del artículo de servicio';
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
            field("Service Inv. Group No._LDR"; Rec."Service Inv. Group No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No. de Inversión de servicio grupo';
                ToolTip = 'No. de Inversión de servicio grupo';
            }
        }
    }

    actions
    {
        addafter("&Item Worksheet")
        {
            action("Service Lin&es")
            {
                ApplicationArea = All;
                Caption = 'Lineas servicio';
                Image = ServiceLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ServInvLine: Record "Service Line";
                    ServInvLines: Page "Service Lines";
                begin
                    Clear(ServInvLine);
                    ServInvLine.SetRange("Document Type", Rec."Document Type");
                    ServInvLine.SetRange("Document No.", Rec."Document No.");
                    ServInvLine.FilterGroup(2);
                    Clear(ServInvLines);
                    ServInvLines.SetTableView(ServInvLine);
                    ServInvLines.RunModal();
                    ServInvLine.FilterGroup(0);
                end;
            }
            action(ChgRepStatus)
            {
                ApplicationArea = All;
                Caption = 'Cambiar estado reparación';
                Image = ServiceSetup;

                trigger OnAction()
                var
                    ChangeServItemLine: Record "Service Item Line";
                    formEstados: Page "Repair Status";
                    recEstados: Record "Repair Status";
                begin
                    Clear(recEstados);
                    Clear(formEstados);
                    recEstados.Get(Rec."Repair Status Code");
                    formEstados.LookupMode := true;
                    formEstados.SetTableView(recEstados);
                    formEstados.SetRecord(recEstados);
                    if formEstados.RunModal() = ACTION::LookupOK then begin
                        formEstados.GetRecord(recEstados);
                        Rec.Validate("Repair Status Code", recEstados.Code);
                        Rec.Modify(true);
                    end;
                end;
            }
        }
        addbefore("&Print")
        {
            action(ResAlloc)
            {
                ApplicationArea = All;
                Caption = 'Asignaciones recurso';
                Image = ItemAvailbyLoc;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                RunObject = Page "Resource Allocations";
                RunPageView = SORTING("Status", "Document Type", "Document No.", "Service Item Line No.", "Allocation Date", "Starting Time", Posted)
                                  WHERE("Status" = FILTER(<> Canceled));
                RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("Document No.");
            }
            action(MultResAlloc)
            {
                ApplicationArea = All;
                Caption = 'Asignaci¢n multiple recurso';
                Image = Allocate;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    SelectedServItemLine: Record "Service Item Line";
                //MultipleAllocation: Page 7122111; //TODO: No encontrado
                begin
                    CurrPage.SETSELECTIONFILTER(SelectedServItemLine);
                    //Clear(MultipleAllocation);
                    //MultipleAllocation.SetDocs(SelectedServItemLine);
                    //MultipleAllocation.RUNMODAL;
                end;
            }
        }
    }

    /// <summary>
    /// SetServItemFilter.
    /// </summary>
    procedure SetServItemFilter()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Service Item No.", ServItemFilter);
        ServItemFilter := Rec.GETFILTER("Service Item No.");
        Rec.FILTERGROUP(0);
    end;

    /// <summary>
    /// ServItemFilterOnAfterValidate.
    /// </summary>
    procedure ServItemFilterOnAfterValidate()
    begin
        CurrPage.UPDATE(FALSE);
    end;

    PROCEDURE SetContractFilter();
    BEGIN
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Contract No.", ContractFilter);
        ContractFilter := Rec.GETFILTER("Contract No.");
        Rec.FILTERGROUP(0);
    END;

    PROCEDURE SetCustFilter();
    BEGIN
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Customer No.", CustomFilter);
        CustomFilter := Rec.GETFILTER("Customer No.");
        Rec.FILTERGROUP(0);
    END;

    PROCEDURE SetZoneFilter();
    BEGIN
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Service Zone Code_LDR", ZoneFilter);
        ZoneFilter := Rec.GETFILTER("Service Zone Code_LDR");
        Rec.FILTERGROUP(0);
    END;

    PROCEDURE SetRespCenterFilter();
    BEGIN
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Responsibility Center", RespCenterFilter);
        RespCenterFilter := Rec.GETFILTER("Responsibility Center");
        Rec.FILTERGROUP(0);
    END;

    PROCEDURE SetOrderTypeFilter();
    BEGIN
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Serive Order Type_LDR", OrderTypeFilter);
        OrderTypeFilter := Rec.GETFILTER("Serive Order Type_LDR");
        Rec.FILTERGROUP(0);
    END;

    LOCAL PROCEDURE TestFilter(): Boolean;
    BEGIN
        IF ServOrderFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            IF Rec.GETRANGEMIN("Document No.") = Rec.GETRANGEMAX("Document No.") THEN
                IF Rec.ISEMPTY THEN BEGIN
                    Rec.FILTERGROUP(0);
                    EXIT(true);
                END;
            Rec.FILTERGROUP(0);
        END;
        EXIT(TRUE);
    END;

    var
        Cust: Record Customer;
        TempTextFilter: Text;
        Text000: Label 'No hay %1 dentro del filtro.';
        ContractFilter: Text[250];
        CustomFilter: Text[250];
        ZoneFilter: Text[250];
        RespCenterFilter: Text[250];
        OrderTypeFilter: Text[250];
        ServItemFilter: Text[250];
}