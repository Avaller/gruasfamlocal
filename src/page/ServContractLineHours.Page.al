page 50152 "Serv. Contract Line Hours"
{
    // UPG2016 20160120 1CF_SVD DIALOG WINDOW reimplemented
    // UPG2016 22/01/2016 1CF_MGF DIALOG WINDOW reimplemented

    /*Caption = 'Serv. Contract Line Hours';
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Serv. Contract Line Hours_LDR";

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Starting Date"; "Starting Date")
                {
                    Editable = false;
                }
                field("End Date"; "End Date")
                {
                    Editable = false;
                }
                field("Contracted hours"; "Contracted hours")
                {
                }
                field("Beginning hours"; "Beginning hours")
                {
                }
                field("Ending hours"; "Ending hours")
                {
                }
                field("Completed hours"; "Completed hours")
                {
                }
                field("Contracted/Realized Difference"; "Contracted/Realized Difference")
                {
                    Style = Attention;
                    StyleExpr = styleContRealDiff;
                }
                field(PeriodoActivo; PeriodoActivo)
                {
                    Caption = 'Active Period';
                    Editable = false;
                }
                field("Corrected Hour Price"; "Corrected Hour Price")
                {
                    DecimalPlaces = 2 : 5;
                }
                field("Contract No."; "Contract No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Contract Line No."; "Contract Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Service Item No."; "Service Item No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Procesed; Procesed)
                {
                    Editable = false;
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
                action(Planificate)
                {
                    Caption = 'Planificate';
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+p';

                    trigger OnAction()
                    begin
                        CreatePlanification;
                    end;
                }
                action("Calc. Ending Hours")
                {
                    Caption = 'Calc. Ending Hours';
                    Image = CalculateCalendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+c';

                    trigger OnAction()
                    begin
                        CalcEndingHours;
                    end;
                }
                action("Add to Invoicing")
                {
                    Caption = 'Add to Invoicing';
                    Image = Add;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        SetInvoicing;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PeriodoActivo := FALSE;

        IF ("Starting Date" <= WORKDATE) AND ("End Date" >= WORKDATE) THEN
            PeriodoActivo := TRUE;
        ContractedRealizedDifferenceOn;
    end;

    trigger OnDeleteRecord(): BoolEAN
    var
        temprec: Record "50232";
    begin
        temprec := Rec;
        temprec.COPYFILTERS(Rec);
        IF temprec.FIND('>') THEN
            EXIT(FALSE);
    end;

    var
        PeriodoActivo: BoolEAN;
        gServContractLine: Record "5964";
        gIntServContractLine: Record "70029";
        Type: Option Internal,External;
        [InDataSet]
        styleContRealDiff: BoolEAN;

    [Scope('Internal')]
    procedure CreatePlanification()
    var
        bCompletado: BoolEAN;
        PeriodStart: Date;
        PeriodEnd: Date;
        Contador: Integer;
        Mensaje: Dialog;
        HorasContratadas: Integer;
        txtHorasContratadas: Label 'Enter contracted hours by %1 ';
        TempServContractLineHours: Record "50232";
        DialogInput: Page "70096";
    begin
        CASE Type OF
            Type::Internal:
                BEGIN
                    gIntServContractLine.TESTFIELD(gIntServContractLine."Starting Date");
                    gIntServContractLine.TESTFIELD(gIntServContractLine."Expiration Date");
                    PeriodStart := gIntServContractLine."Starting Date";

                    CLEAR(TempServContractLineHours);
                    TempServContractLineHours.SETRANGE(TempServContractLineHours.Type, TempServContractLineHours.Type::Internal);
                    TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract Type", gIntServContractLine."Contract Type");
                    TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract No.", gIntServContractLine."Contract No.");
                    TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract Line No.", gIntServContractLine."Line No.");
                    IF TempServContractLineHours.FINDLAST THEN BEGIN
                        HorasContratadas := TempServContractLineHours."Contracted hours";
                        PeriodStart := TempServContractLineHours."End Date" + 1;
                        IF PeriodStart > gIntServContractLine."Expiration Date" THEN
                            EXIT;
                    END;
                    //UPG2016_SVD Start
                    //Mensaje.OPEN(STRSUBSTNO(txtHorasContratadas,gIntServContractLine."Hours Period Review"));
                    //IF Mensaje.INPUT(2,HorasContratadas) = 0 THEN
                    //  EXIT;
                    //EVALUATE(HorasContratadas,Window.InputBox(STRSUBSTNO(txtHorasContratadas,gIntServContractLine."Hours Period Review") ,'INPUT','',100,100));
                    CLEAR(HorasContratadas);
                    DialogInput.CAPTION('INPUT');
                    DialogInput.SetInputText(STRSUBSTNO(txtHorasContratadas, gIntServContractLine."Hours Period Review"));
                    DialogInput.LOOKUPMODE(TRUE);
                    IF DialogInput.RUNMODAL = ACTION::LookupOK THEN
                        EVALUATE(HorasContratadas, DialogInput.GetValue);
                    IF HorasContratadas = 0 THEN
                        EXIT;
                    //<< UPG2016 SVD End

                    bCompletado := FALSE;
                    Contador := 1;

                    REPEAT
                        CASE gIntServContractLine."Hours Period Review" OF
                            gIntServContractLine."Hours Period Review"::Month:
                                BEGIN
                                    PeriodEnd := CALCDATE('<1M-1D>', PeriodStart);
                                END;
                            gIntServContractLine."Hours Period Review"::"Two Months":
                                BEGIN
                                    PeriodEnd := CALCDATE('<2M-1D>', PeriodStart);
                                END;
                            gIntServContractLine."Hours Period Review"::Quarter:
                                BEGIN
                                    PeriodEnd := CALCDATE('<3M-1D>', PeriodStart);
                                END;
                            gIntServContractLine."Hours Period Review"::"Half Year":
                                BEGIN
                                    PeriodEnd := CALCDATE('<6M-1D>', PeriodStart);
                                END;
                            gIntServContractLine."Hours Period Review"::Year:
                                BEGIN
                                    PeriodEnd := CALCDATE('<12M-1D>', PeriodStart);
                                END;
                            gIntServContractLine."Hours Period Review"::None:
                                PeriodEnd := gIntServContractLine."Expiration Date";
                        END;

                        IF (PeriodEnd >= gIntServContractLine."Expiration Date") THEN BEGIN
                            PeriodEnd := gIntServContractLine."Expiration Date";
                            bCompletado := TRUE;
                        END;

                        INIT;
                        VALIDATE(Type, Type::Internal);
                        VALIDATE("Contract Type", gIntServContractLine."Contract Type");
                        VALIDATE("Contract No.", gIntServContractLine."Contract No.");
                        VALIDATE("Contract Line No.", gIntServContractLine."Line No.");
                        VALIDATE("Service Item No.", gIntServContractLine."Service Item No.");
                        VALIDATE("Starting Date", PeriodStart);
                        VALIDATE("End Date", PeriodEnd);
                        VALIDATE("Contracted hours", HorasContratadas);
                        IF "Starting Date" = gIntServContractLine."Starting Date" THEN
                            VALIDATE("Beginning hours", gIntServContractLine."Exit N´Š¢ of Hours");
                        INSERT(TRUE);

                        PeriodStart := PeriodEnd + 1;

                        Contador := Contador + 1;
                    UNTIL (bCompletado = TRUE);


                END;
            Type::External:
                BEGIN
                    gServContractLine.TESTFIELD(gServContractLine."Starting Date");
                    gServContractLine.TESTFIELD(gServContractLine."Contract Expiration Date");
                    PeriodStart := gServContractLine."Starting Date";

                    CLEAR(TempServContractLineHours);
                    TempServContractLineHours.SETRANGE(TempServContractLineHours.Type, TempServContractLineHours.Type::External);
                    TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract Type", gServContractLine."Contract Type");
                    TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract No.", gServContractLine."Contract No.");
                    TempServContractLineHours.SETRANGE(TempServContractLineHours."Contract Line No.", gServContractLine."Line No.");
                    IF TempServContractLineHours.FINDLAST THEN BEGIN
                        HorasContratadas := TempServContractLineHours."Contracted hours";
                        PeriodStart := TempServContractLineHours."End Date" + 1;
                        IF PeriodStart > gServContractLine."Contract Expiration Date" THEN
                            EXIT;
                    END;

                    //>> UPG2016_MGF Start
                    //Mensaje.OPEN(STRSUBSTNO(txtHorasContratadas,gServContractLine."Hours Period Review"));
                    //IF Mensaje.INPUT(2,HorasContratadas) = 0 THEN
                    //  EXIT;
                    CLEAR(HorasContratadas);
                    DialogInput.CAPTION('INPUT');
                    DialogInput.SetInputText(STRSUBSTNO(txtHorasContratadas, gServContractLine."Hours Period Review"));
                    DialogInput.LOOKUPMODE(TRUE);
                    IF DialogInput.RUNMODAL = ACTION::LookupOK THEN
                        EVALUATE(HorasContratadas, DialogInput.GetValue);
                    IF HorasContratadas = 0 THEN
                        EXIT;
                    //<< UPG2016_MGF End

                    bCompletado := FALSE;
                    Contador := 1;

                    REPEAT
                        CASE gServContractLine."Hours Period Review" OF
                            gServContractLine."Hours Period Review"::Month:
                                BEGIN
                                    PeriodEnd := CALCDATE('<1M-1D>', PeriodStart);
                                END;
                            gServContractLine."Hours Period Review"::"Two Months":
                                BEGIN
                                    PeriodEnd := CALCDATE('<2M-1D>', PeriodStart);
                                END;
                            gServContractLine."Hours Period Review"::Quarter:
                                BEGIN
                                    PeriodEnd := CALCDATE('<3M-1D>', PeriodStart);
                                END;
                            gServContractLine."Hours Period Review"::"Half Year":
                                BEGIN
                                    PeriodEnd := CALCDATE('<6M-1D>', PeriodStart);
                                END;
                            gServContractLine."Hours Period Review"::Year:
                                BEGIN
                                    PeriodEnd := CALCDATE('<12M-1D>', PeriodStart);
                                END;
                            gServContractLine."Hours Period Review"::None:
                                PeriodEnd := gServContractLine."Contract Expiration Date";
                        END;

                        IF (PeriodEnd >= gServContractLine."Contract Expiration Date") THEN BEGIN
                            PeriodEnd := gServContractLine."Contract Expiration Date";
                            bCompletado := TRUE;
                        END;

                        INIT;
                        VALIDATE(Type, Type::External);
                        VALIDATE("Contract Type", gServContractLine."Contract Type");
                        VALIDATE("Contract No.", gServContractLine."Contract No.");
                        VALIDATE("Contract Line No.", gServContractLine."Line No.");
                        VALIDATE("Service Item No.", gServContractLine."Service Item No.");
                        VALIDATE("Starting Date", PeriodStart);
                        VALIDATE("End Date", PeriodEnd);
                        VALIDATE("Contracted hours", HorasContratadas);
                        IF "Starting Date" = gServContractLine."Starting Date" THEN
                            VALIDATE("Beginning hours", gServContractLine."Exit No. of Hours");
                        INSERT(TRUE);

                        PeriodStart := PeriodEnd + 1;

                        Contador := Contador + 1;
                    UNTIL (bCompletado = TRUE);

                END;
        END;
    end;

    [Scope('Internal')]
    procedure SetServContractLine(TempServContractLine: Record "5964")
    begin
        gServContractLine.GET(TempServContractLine."Contract Type", TempServContractLine."Contract No.",
                              TempServContractLine."Line No.");

        Type := Type::External;
    end;

    [Scope('Internal')]
    procedure SetIntServContractLine(TempServContractLine: Record "70029")
    begin
        gIntServContractLine.GET(TempServContractLine."Contract Type", TempServContractLine."Contract No.",
                              TempServContractLine."Line No.");

        Type := Type::Internal;
    end;

    [Scope('Internal')]
    procedure SetInvoicing()
    var
        ServMgt: Record "5911";
        ContractConcepts: Record "50206";
        txtTextoConcepto: Label 'Hours Control';
        LastContractConcepts: Record "50206";
    begin
        TESTFIELD(Procesed, FALSE);
        TESTFIELD("Contracted hours");
        TESTFIELD("Ending hours");
        TESTFIELD("Corrected Hour Price");


        ServMgt.GET;

        CLEAR(LastContractConcepts);
        CASE Type OF
            Type::External:
                BEGIN
                    LastContractConcepts.SETRANGE(LastContractConcepts."Source Table", DATABASE::"Service Contract Line");
                END;
            Type::Internal:
                BEGIN
                    LastContractConcepts.SETRANGE(LastContractConcepts."Source Table", DATABASE::"Internal Serv. Contract Line");
                END;
        END;
        LastContractConcepts.SETRANGE("Contract Type", "Contract Type");
        LastContractConcepts.SETRANGE("Contract No.", "Contract No.");
        LastContractConcepts.SETRANGE("Contract Line No.", "Contract Line No.");
        IF LastContractConcepts.FINDLAST THEN;


        CLEAR(ContractConcepts);
        CASE Type OF
            Type::External:
                BEGIN
                    ServMgt.TESTFIELD(ServMgt."Ext.Hours Control Service Cost");
                    ContractConcepts.VALIDATE(ContractConcepts."Source Table", DATABASE::"Service Contract Line");
                END;
            Type::Internal:
                BEGIN
                    ServMgt.TESTFIELD(ServMgt."Int.Hours Control Service Cost");
                    ContractConcepts.VALIDATE(ContractConcepts."Source Table", DATABASE::"Internal Serv. Contract Line");
                END;
        END;


        ContractConcepts.VALIDATE("Contract Type", "Contract Type");
        ContractConcepts.VALIDATE("Contract No.", "Contract No.");
        ContractConcepts.VALIDATE("Contract Line No.", "Contract Line No.");
        ContractConcepts.VALIDATE("Line No.", LastContractConcepts."Line No." + 10000);

        CASE Type OF
            Type::External:
                ContractConcepts.VALIDATE(ContractConcepts."Concept No.", ServMgt."Ext.Hours Control Service Cost");
            Type::Internal:
                ContractConcepts.VALIDATE(ContractConcepts."Concept No.", ServMgt."Int.Hours Control Service Cost");
        END;

        ContractConcepts.VALIDATE(ContractConcepts.Periodicity, ContractConcepts.Periodicity::"Date expecific");
        ContractConcepts.VALIDATE(ContractConcepts.Date, "End Date");
        ContractConcepts.VALIDATE(ContractConcepts.Amount, (("Contracted/Realized Difference" * -1) * "Corrected Hour Price"));
        ContractConcepts.VALIDATE(ContractConcepts."Created from Hours Control", TRUE);
        ContractConcepts.INSERT(TRUE);

        VALIDATE(Procesed, TRUE);
        MODIFY(TRUE);
    end;

    local procedure ContractedRealizedDifferenceOn()
    begin
        styleContRealDiff := ("Contracted/Realized Difference" < 0);
    end;*/
}