/// <summary>
/// Table Serv. Item Operations_LDR (ID 50036)
/// </summary>
table 50036 "Serv. Item Operations_LDR"
{
    Caption = 'Serv. Item Operations';
    DataPerCompany = false;
    LookupPageID = "Serv. Item Operations";

    fields
    {
        field(1; "Serv. Item Code"; Code[20])
        {
            Caption = 'Service Item Code';
            TableRelation = "Service Item";
        }
        field(2; "Operation Code"; Code[20])
        {
            Caption = 'Operation Code';
            TableRelation = Operations_LDR;

            trigger OnValidate()
            begin
                IF ("Operation Code" <> '') AND ("Operation Code" <> xRec."Operation Code") THEN BEGIN
                    FillOpData;
                    FillSubOpData;
                END;
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Operation Type"; Option)
        {
            Caption = 'Operation Type';
            Editable = false;
            OptionCaption = 'Administrative,Technical';
            OptionMembers = Administrative,Technical;
        }
        field(5; "Period Type"; Option)
        {
            Caption = 'Period Type';
            Editable = false;
            OptionCaption = 'Time,Hours';
            OptionMembers = Time,Hours;
        }
        field(6; "Period Value - Date"; DateFormula)
        {
            Caption = 'Periodicity';
        }
        field(7; "Period Value - Hours"; Integer)
        {
            Caption = 'Periodicity';
        }
        field(8; "Self/External"; Option)
        {
            Caption = 'Self/External';
            OptionCaption = 'Self,External';
            OptionMembers = Self,External;
        }
        field(9; "Disp. Warning Period - Date"; DateFormula)
        {
            Caption = 'Display Warning Period';

            trigger OnValidate()
            begin
                IF COPYSTR(FORMAT("Disp. Warning Period - Date"), 1, 1) <> '-' THEN
                    ERROR(Text002, FIELDCAPTION("Disp. Warning Period - Date"));
            end;
        }
        field(10; "Disp. Warning Period - Hours"; Integer)
        {
            Caption = 'Display Warning Period';
        }
        field(11; "Serv. Item Counter Code"; Integer)
        {
            Caption = 'Serv. Item Counter Code';
            TableRelation = "Service Item Counter_LDR"."Counter No." WHERE("Code" = FIELD("Serv. Item Code"));
        }
        field(12; "Serv. Item Counter Description"; Text[50])
        {
            CalcFormula = Lookup("Service Item Counter_LDR"."Description" WHERE("Code" = FIELD("Serv. Item Code"),
                                                                           "Counter No." = FIELD("Serv. Item Counter Code")));
            Caption = 'Serv. Item Counter Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Inactive,Active';
            OptionMembers = inactive,active;
        }
        field(14; "Next Planned Date"; Date)
        {
            CalcFormula = Lookup("Serv. Item Operat Entry_LDR"."Next Planned Date" WHERE("Serv. Item Code" = FIELD("Serv. Item Code"),
                                                                                          "Operation Code" = FIELD("Operation Code"),
                                                                                          "Closed" = CONST(false)));
            Caption = 'Next Planned Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Next Planned Hours"; Integer)
        {
            CalcFormula = Lookup("Serv. Item Operat Entry_LDR"."Next Planned Hours" WHERE("Serv. Item Code" = FIELD("Serv. Item Code"),
                                                                                           "Operation Code" = FIELD("Operation Code"),
                                                                                           "Closed" = CONST(false)));
            Caption = 'Next Planned Hours';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Serv. Item Code", "Operation Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ServItemOperationsEntry: Record "Serv. Item Operat Entry_LDR";
    begin
        ServItemOperationsEntry.SETRANGE("Serv. Item Code", "Serv. Item Code");
        ServItemOperationsEntry.SETRANGE("Operation Code", "Operation Code");
        ServItemOperationsEntry.SETRANGE(Closed, FALSE);
        IF ServItemOperationsEntry.FINDFIRST THEN
            ERROR(Text001, TABLECAPTION, "Operation Code", ServItemOperationsEntry.TABLECAPTION);
    end;

    var
        Text001: Label '%1 %2 can''t be deleted because there are open %3 related.';
        Text002: Label '%1 must be negative';
        Text003: Label 'Do you want to create the Initial Serv. Item Operation Entry?';

    /// <summary>
    /// FillOpData()
    /// </summary>
    local procedure FillOpData()
    var
        Operations: Record "Operations_LDR";
    begin
        Operations.GET("Operation Code");

        Description := Operations.Description;
        "Operation Type" := Operations."Operation Type";
        "Period Type" := Operations."Period Type";
        "Self/External" := Operations."Self/External";
    end;

    /// <summary>
    /// Deactivate()
    /// </summary>
    procedure Deactivate()
    begin
        Status := Status::inactive;
        MODIFY;
    end;

    /// <summary>
    /// Activate()
    /// </summary>
    procedure Activate()
    var
        CalcServItemOperations: Report "Calc. Serv. Item Operations";
        ServiceItemCounter: Record "Service Item Counter_LDR";
    begin
        Status := Status::active;
        MODIFY;

        IF CONFIRM(Text003, FALSE) THEN BEGIN

            IF "Period Type" = "Period Type"::Hours THEN BEGIN
                ServiceItemCounter.GET("Serv. Item Code", "Serv. Item Counter Code");
                CalcServItemOperations.CreateServItemHoursOpEntry(Rec, ServiceItemCounter."KM/H Actual", ServiceItemCounter."KM/H Actual", ServiceItemCounter."KM/H Actual")
            END ELSE
                CalcServItemOperations.CreateServItemDateOpEntry(Rec, WORKDATE, WORKDATE);
        END;
    end;

    /// <summary>
    /// Activate()
    /// </summary>
    local procedure FillSubOpData()
    var
        SubOperation: Record "Suboperation_LDR";
        ServItemSuboperation: Record "Serv. Item Suboperation_LDR";
    begin
        //JLPINEIRO - Traer todas las suboperaciones de producto de esa suboperacion en caso de estar activas.
        CLEAR(SubOperation);
        SubOperation.SETRANGE("Operation Code", "Operation Code");
        SubOperation.SETRANGE(Active, TRUE);
        IF SubOperation.FINDSET THEN BEGIN
            CLEAR(ServItemSuboperation);
            ServItemSuboperation.SETRANGE("Operation Code", "Operation Code");
            ServItemSuboperation.SETRANGE("Serv. Item Code", "Serv. Item Code");
            IF ServItemSuboperation.FINDFIRST THEN
                IF CONFIRM('Ya hay algo, ¿desea sobreescribir', FALSE) THEN
                    ServItemSuboperation.DELETEALL(TRUE)
                ELSE
                    ERROR('Me paro');

            REPEAT
                CLEAR(ServItemSuboperation);
                ServItemSuboperation."Serv. Item Code" := "Serv. Item Code";
                ServItemSuboperation."Operation Code" := SubOperation."Operation Code";
                ServItemSuboperation."Suboperation Code" := SubOperation."Suboperation Code";
                ServItemSuboperation.Area := SubOperation.Area;
                ServItemSuboperation.Element := SubOperation.Element;
                ServItemSuboperation.Description := SubOperation.Description;
                ServItemSuboperation.INSERT(TRUE);
            UNTIL SubOperation.NEXT = 0;
        END;
    end;
}