/// <summary>
/// Page Serv. Contract Line Hours_LDR (ID 50029).
/// </summary>
page 50029 "Serv. Contract Line Hours_LDR"
{
    // UPG2016 20160120 1CF_SVD DIALOG WINDOW reimplemented
    // UPG2016 22/01/2016 1CF_MGF DIALOG WINDOW reimplemented

    Caption = 'Serv. Contract Line Hours';
    DeleteAllowed = true;
    InsertAllowed = false;
    ModIfyAllowed = true;
    PaGetype = List;
    SourceTable = "Serv. Contract Line Hours_LDR";


    layout
    {
        area(content)
        {
            Repeater(Contents)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de inicio';
                    Editable = false;
                    ToolTip = 'Fecha de inicio';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha final';
                    Editable = false;
                    ToolTip = 'Fecha final';
                }
                field("Contracted hours"; Rec."Contracted hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas contratadas';
                    ToolTip = 'Horas contratadas';
                }
                field("Beginning hours"; Rec."Beginning hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas de inicio';
                    ToolTip = 'Horas de inicio';
                }
                field("Ending hours"; Rec."Ending hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas de finalización';
                    ToolTip = 'Horas de finalización';
                }
                field("Completed hours"; Rec."Completed hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas completadas';
                    ToolTip = 'Horas completadas';
                }
                field("Contracted/Realized DIfference"; Rec."Contracted/Realized DIfference")
                {
                    ApplicationArea = All;
                    Caption = 'DIferencia Contratada / Realizada';
                    Style = Attention;
                    StyleExpr = styleContRealDIff;
                    ToolTip = 'DIferencia Contratada / Realizada';
                }
                field(PeriodoActivo; PeriodoActivo)
                {
                    ApplicationArea = All;
                    Caption = 'Período Activo';
                    Editable = false;
                    ToolTip = 'Período Activo';
                }
                field("Corrected Hour Price"; Rec."Corrected Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Hora Corregido';
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Precio Hora Corregido';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de contrato';
                    Editable = false;
                    ToolTip = 'Nº de contrato';
                    Visible = false;
                }
                field("Contract Line No."; Rec."Contract Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de línea de contrato';
                    Editable = false;
                    ToolTip = 'Nº de línea de contrato';
                    Visible = false;
                }
                field("Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de artículo de servicio';
                    Editable = false;
                    ToolTip = 'Número de artículo de servicio';
                    Visible = false;
                }
                field(Procesed; Rec.Procesed)
                {
                    ApplicationArea = All;
                    Caption = 'Procesada';
                    Editable = false;
                    ToolTip = 'Procesada';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Actions")
            {
                Caption = '&Actions';
                action(PlanIficate)
                {
                    Caption = 'PlanIficate';
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+p';

                    trigger OnAction()
                    Begin
                        CreatePlanIfication;
                    End;
                }
                action("Calc. Ending Hours")
                {
                    Caption = 'Calc. Ending Hours';
                    Image = CalculateCalendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+c';

                    trigger OnAction()
                    Begin
                        Rec.CalcEndingHours;
                    End;
                }
                action("Add to Invoicing")
                {
                    Caption = 'Add to Invoicing';
                    Image = Add;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    Begin
                        SetInvoicing;
                    End;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    Begin
        PeriodoActivo := false;

        If (Rec."Starting Date" <= WORKDATE) AND (Rec."End Date" >= WORKDATE) then
            PeriodoActivo := true;
        ContractedRealizedDIfferenceOn;
    End;

    trigger OnDeleteRecord(): Boolean
    var
        temprec: Record "Serv. Contract Line Hours_LDR";
    Begin
        temprec := Rec;
        temprec.COPYFILTERS(Rec);
        If temprec.FIND('>') then
            Exit(false);
    End;

    var
        PeriodoActivo: Boolean;
        gServContractLine: Record "Service Contract Line";
        Type: Option Internal,External;
        [InDataSet]
        styleContRealDIff: Boolean;

    procedure CreatePlanIfication()
    var
        bCompletado: Boolean;
        PeriodStart: Date;
        PeriodEnd: Date;
        Contador: Integer;
        Mensaje: Dialog;
        HorasContratadas: Integer;
        txtHorasContratadas: Label 'Enter contracted hours by %1 ';
        TempServContractLineHours: Record "Serv. Contract Line Hours_LDR";
    Begin
        Case Type Of
            Type::Internal:
                Begin

                    CLEAR(TempServContractLineHours);
                    TempServContractLineHours.SetRange(TempServContractLineHours.Type, TempServContractLineHours.Type::Internal);
                    If TempServContractLineHours.FindLast then Begin
                        HorasContratadas := TempServContractLineHours."Contracted hours";
                        PeriodStart := TempServContractLineHours."End Date" + 1;
                    End;
                    //UPG2016_SVD Start
                    //Mensaje.OPEN(STRSUBSTNO(txtHorasContratadas,gIntServContractLine."Hours Period Review"));
                    //If Mensaje.INPUT(2,HorasContratadas) = 0 then
                    //  Exit;
                    //EVALUATE(HorasContratadas,Window.InputBox(STRSUBSTNO(txtHorasContratadas,gIntServContractLine."Hours Period Review") ,'INPUT','',100,100));
                    CLEAR(HorasContratadas);
                    If HorasContratadas = 0 then
                        Exit;
                    //<< UPG2016 SVD End

                    bCompletado := false;
                    Contador := 1;

                    Repeat

                        Rec.Init;
                        Rec.Validate(Type, Type::Internal);
                        Rec.Validate("Starting Date", PeriodStart);
                        Rec.Validate("End Date", PeriodEnd);
                        Rec.Validate("Contracted hours", HorasContratadas);
                        Rec.Insert(true);

                        PeriodStart := PeriodEnd + 1;

                        Contador := Contador + 1;
                    UNTIL (bCompletado = true);


                End;
            Type::External:
                Begin
                    gServContractLine.TestField(gServContractLine."Starting Date");
                    gServContractLine.TestField(gServContractLine."Contract Expiration Date");
                    PeriodStart := gServContractLine."Starting Date";

                    CLEAR(TempServContractLineHours);
                    TempServContractLineHours.SetRange(TempServContractLineHours.Type, TempServContractLineHours.Type::External);
                    TempServContractLineHours.SetRange(TempServContractLineHours."Contract Type", gServContractLine."Contract Type");
                    TempServContractLineHours.SetRange(TempServContractLineHours."Contract No.", gServContractLine."Contract No.");
                    TempServContractLineHours.SetRange(TempServContractLineHours."Contract Line No.", gServContractLine."Line No.");
                    If TempServContractLineHours.FindLast then Begin
                        HorasContratadas := TempServContractLineHours."Contracted hours";
                        PeriodStart := TempServContractLineHours."End Date" + 1;
                        If PeriodStart > gServContractLine."Contract Expiration Date" then
                            Exit;
                    End;

                    //>> UPG2016_MGF Start
                    //Mensaje.OPEN(STRSUBSTNO(txtHorasContratadas,gServContractLine."Hours Period Review"));
                    //If Mensaje.INPUT(2,HorasContratadas) = 0 then
                    //  Exit;
                    CLEAR(HorasContratadas);
                    If HorasContratadas = 0 then
                        Exit;
                    //<< UPG2016_MGF End

                    bCompletado := false;
                    Contador := 1;

                    Repeat
                        Case gServContractLine."Hours Period Review_LDR" Of
                            gServContractLine."Hours Period Review_LDR"::Month:
                                Begin
                                    PeriodEnd := CalcDate('<1M-1D>', PeriodStart);
                                End;
                            gServContractLine."Hours Period Review_LDR"::"Two Months":
                                Begin
                                    PeriodEnd := CalcDate('<2M-1D>', PeriodStart);
                                End;
                            gServContractLine."Hours Period Review_LDR"::Quarter:
                                Begin
                                    PeriodEnd := CalcDate('<3M-1D>', PeriodStart);
                                End;
                            gServContractLine."Hours Period Review_LDR"::"Half Year":
                                Begin
                                    PeriodEnd := CalcDate('<6M-1D>', PeriodStart);
                                End;
                            gServContractLine."Hours Period Review_LDR"::Year:
                                Begin
                                    PeriodEnd := CalcDate('<12M-1D>', PeriodStart);
                                End;
                            gServContractLine."Hours Period Review_LDR"::None:
                                PeriodEnd := gServContractLine."Contract Expiration Date";
                        End;

                        If (PeriodEnd >= gServContractLine."Contract Expiration Date") then Begin
                            PeriodEnd := gServContractLine."Contract Expiration Date";
                            bCompletado := true;
                        End;

                        Rec.Init;
                        Rec.Validate(Type, Type::External);
                        Rec.Validate("Contract Type", gServContractLine."Contract Type");
                        Rec.Validate("Contract No.", gServContractLine."Contract No.");
                        Rec.Validate("Contract Line No.", gServContractLine."Line No.");
                        Rec.Validate("Service Item No.", gServContractLine."Service Item No.");
                        Rec.Validate("Starting Date", PeriodStart);
                        Rec.Validate("End Date", PeriodEnd);
                        Rec.Validate("Contracted hours", HorasContratadas);
                        If Rec."Starting Date" = gServContractLine."Starting Date" then
                            Rec.Validate("Beginning hours", gServContractLine."Exit No. of Hours_LDR");
                        Rec.Insert(true);

                        PeriodStart := PeriodEnd + 1;

                        Contador := Contador + 1;
                    UNTIL (bCompletado = true);

                End;
        End;
    End;

    /// <summary>
    /// SetServContractLine.
    /// </summary>
    /// <param name="TempServContractLine">Record "Service Contract Line".</param>
    procedure SetServContractLine(TempServContractLine: Record "Service Contract Line")
    Begin
        gServContractLine.Get(TempServContractLine."Contract Type", TempServContractLine."Contract No.",
                              TempServContractLine."Line No.");

        Type := Type::External;
    End;

    procedure SetInvoicing()
    var
        ServMgt: Record "Service Mgt. Setup";
        ContractConcepts: Record "Contract Concepts_LDR";
        txtTextoConcepto: Label 'Hours Control';
        LastContractConcepts: Record "Contract Concepts_LDR";
    Begin
        Rec.TestField(Procesed, false);
        Rec.TestField("Contracted hours");
        Rec.TestField("Ending hours");
        Rec.TestField("Corrected Hour Price");


        ServMgt.Get;

        CLEAR(LastContractConcepts);
        Case Type Of
            Type::External:
                Begin
                    LastContractConcepts.SetRange(LastContractConcepts."Source Table", DATABASE::"Service Contract Line");
                End;
            Type::Internal:
                Begin
                    //LastContractConcepts.SetRange(LastContractConcepts."Source Table", DATABASE::"Internal Serv. Contract Line"); //TODO: No encontrado DATABASE::"Internal Serv. Contract Line"
                End;
        End;
        LastContractConcepts.SetRange("Contract Type", Rec."Contract Type");
        LastContractConcepts.SetRange("Contract No.", Rec."Contract No.");
        LastContractConcepts.SetRange("Contract Line No.", Rec."Contract Line No.");
        If LastContractConcepts.FindLast then;


        CLEAR(ContractConcepts);
        Case Type Of
            Type::External:
                Begin
                    ServMgt.TestField(ServMgt."Ext.Hours Control Service Cost_LDR");
                    ContractConcepts.Validate(ContractConcepts."Source Table", DATABASE::"Service Contract Line");
                End;
            Type::Internal:
                Begin
                    ServMgt.TestField(ServMgt."Int.Hours Control Service Cost_LDR");
                    //ContractConcepts.Validate(ContractConcepts."Source Table", DATABASE::"Internal Serv. Contract Line"); //TODO: No encontrado DATABASE::"Internal Serv. Contract Line"
                End;
        End;


        ContractConcepts.Validate("Contract Type", Rec."Contract Type");
        ContractConcepts.Validate("Contract No.", Rec."Contract No.");
        ContractConcepts.Validate("Contract Line No.", Rec."Contract Line No.");
        ContractConcepts.Validate("Line No.", LastContractConcepts."Line No." + 10000);

        Case Type Of
            Type::External:
                ContractConcepts.Validate(ContractConcepts."Concept No.", ServMgt."Ext.Hours Control Service Cost_LDR");
            Type::Internal:
                ContractConcepts.Validate(ContractConcepts."Concept No.", ServMgt."Int.Hours Control Service Cost_LDR");
        End;

        ContractConcepts.Validate(ContractConcepts.Periodicity, ContractConcepts.Periodicity::"Date expecIfic");
        ContractConcepts.Validate(ContractConcepts.Date, Rec."End Date");
        ContractConcepts.Validate(ContractConcepts.Amount, ((Rec."Contracted/Realized DIfference" * -1) * Rec."Corrected Hour Price"));
        ContractConcepts.Validate(ContractConcepts."Created from Hours Control", true);
        ContractConcepts.Insert(true);

        Rec.Validate(Procesed, true);
        Rec.ModIfy(true);
    End;

    local procedure ContractedRealizedDIfferenceOn()
    Begin
        styleContRealDIff := (Rec."Contracted/Realized DIfference" < 0);
    End;
}