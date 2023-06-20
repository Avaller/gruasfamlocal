/// <summary>
/// Table Serv. Contract Line Hours_LDR (ID 50232)
/// </summary>
table 50232 "Serv. Contract Line Hours_LDR"
{
    Caption = 'Serv. Contract Line Hours';
    DrillDownPageID = "Serv. Contract Line Hours_LDR";
    LookupPageID = "Serv. Contract Line Hours_LDR";

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(2; "Contract Type"; Option)
        {
            Caption = 'Contract Type';
            NotBlank = true;
            OptionCaption = 'Quote,Contract';
            OptionMembers = Quote,Contract;
        }
        field(3; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            NotBlank = true;
            TableRelation = IF ("Type" = CONST("External")) "Service Contract Header"."Contract No." WHERE("Contract Type" = FIELD("Contract Type"));
            //IF ("Type" = CONST("Internal")) "Table70028"."Field1" WHERE("Field2" = FIELD("Contract Type")); 
        }
        field(4; "Contract Line No."; Integer)
        {
            Caption = 'Line No.';
            NotBlank = true;
        }
        field(5; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            NotBlank = true;
            TableRelation = "Service Item";
        }
        field(6; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;
        }
        field(7; "End Date"; Date)
        {
            Caption = 'End Date';
            NotBlank = true;
        }
        field(8; "Contracted hours"; Decimal)
        {
            Caption = 'Period contracted hours';
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                TESTFIELD(Procesed, FALSE);
                UpdateCompletedHours;
            end;
        }
        field(9; "Beginning hours"; Integer)
        {
            Caption = 'Beginning hours';

            trigger OnValidate()
            begin
                TESTFIELD(Procesed, FALSE);
                CheckHours;
                UpdateCompletedHours;
            end;
        }
        field(10; "Ending hours"; Integer)
        {
            Caption = 'Ending hours';

            trigger OnValidate()
            begin
                TESTFIELD(Procesed, FALSE);
                CheckHours;
                UpdateCompletedHours;
                UpdateNextRecord;
            end;
        }
        field(11; "Completed hours"; Integer)
        {
            Caption = 'Completed hours';
            Editable = false;

            trigger OnValidate()
            begin
                TESTFIELD(Procesed, FALSE);
                IF "Completed hours" <> 0 THEN
                    "Contracted/Realized Difference" := "Contracted hours" - "Completed hours"
                ELSE
                    "Contracted/Realized Difference" := 0;
            end;
        }
        field(12; "Contracted/Realized Difference"; Integer)
        {
            Caption = 'Contracted/Realized Difference';
            Editable = false;
        }
        field(13; Procesed; BoolEAN)
        {
            Caption = 'Procesed';
        }
        field(14; "Corrected Hour Price"; Decimal)
        {
            Caption = 'Corrected Hour Price';
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; Type, "Contract Type", "Contract No.", "Contract Line No.", "Starting Date")
        {
            Clustered = true;
            SumIndexFields = "Contracted hours";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD(Procesed, FALSE);
    end;

    var
        txtErrorHoras: Label 'Ending Hours can not be lower than Starting Hours for Period %1 to %2. Service Contract No.: %3. Service Contract Line No.: %4. Service Item No.: %5';

    /// <summary>
    /// UpdateCompletedHours()
    /// </summary>
    procedure UpdateCompletedHours()
    begin
        IF "Ending hours" <> 0 THEN
            VALIDATE("Completed hours", "Ending hours" - "Beginning hours")
        ELSE
            VALIDATE("Completed hours", 0);
    end;

    /// <summary>
    /// UpdateNextRecord()
    /// </summary>
    procedure UpdateNextRecord()
    var
        ServContractlineHours: Record "Serv. Contract Line Hours_LDR";
    begin
        CLEAR(ServContractlineHours);
        ServContractlineHours.SETRANGE(ServContractlineHours.Type, Type);
        ServContractlineHours.SETRANGE("Contract Type", "Contract Type");
        ServContractlineHours.SETRANGE("Contract No.", "Contract No.");
        ServContractlineHours.SETRANGE("Contract Line No.", "Contract Line No.");
        ServContractlineHours.SETRANGE("Starting Date", "End Date" + 1);
        IF ServContractlineHours.FINDSET THEN BEGIN
            ServContractlineHours.VALIDATE(ServContractlineHours."Beginning hours", "Ending hours");
            ServContractlineHours.MODIFY(TRUE);
        END;
    end;

    /// <summary>
    /// CalcEndingHours()
    /// </summary>
    procedure CalcEndingHours()
    var
        Log: Record "Service Item Log";
        nHoras: Integer;
        txtSinHoras: Label 'There is not hours change for Service Item No. %1 Starting Date %2 End Date %3';
    begin
        TESTFIELD(Procesed, FALSE);
        TESTFIELD("Service Item No.");
        TESTFIELD("Starting Date");
        TESTFIELD("End Date");
        // Buscamos el ultimo cambio de horas para el periodo en el log del producto de servicio

        CLEAR(Log);
        Log.SETRANGE(Log."Service Item No.", "Service Item No.");
        Log.SETRANGE(Log."Event No.", 50001);
        Log.SETFILTER(Log."Change Date", '<=%1', "End Date");
        IF Log.FINDLAST THEN BEGIN
            EVALUATE(nHoras, Log.After);
            IF nHoras <> 0 THEN BEGIN
                VALIDATE("Ending hours", nHoras);
                MODIFY(TRUE);
            END;
        END ELSE BEGIN
            ERROR(txtSinHoras, "Service Item No.", "End Date");
        END;
    end;

    /// <summary>
    /// CheckHours()
    /// </summary>
    procedure CheckHours()
    begin
        IF "Ending hours" <> 0 THEN
            IF "Ending hours" < "Beginning hours" THEN
                ERROR(txtErrorHoras, "Starting Date", "End Date", "Contract No.", "Contract Line No.", "Service Item No.");
    end;
}