/// <summary>
/// tableextension 50058 "Employee Absence_LDR"
/// </summary>
tableextension 50058 "Employee Absence_LDR" extends "Employee Absence"
{
    fields
    {
        modify("Employee No.")
        {
            trigger OnAfterValidate()
            var
                Employee: Record Employee;
            begin
                if "Employee No." <> '' then begin
                    if Resource.get(Employee."Resource No.") then
                        Validate("Company Dependence_LDR", Resource."Company Dependence_LDR");
                    "Employee Full Name_LDR" := Employee.FullName();
                end;
            end;
        }
        modify("From Date")
        {
            trigger OnAfterValidate()
            begin
                ValidateDatesandTimes(FieldNo("From Date"));
            end;
        }
        modify("To Date")
        {
            trigger OnAfterValidate()
            begin
                ValidateDatesAndTimes(FieldNo("To Date"));
            end;
        }
        field(50001; "From Time_LDR"; Time)
        {
            Caption = 'Desde Hora';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ValidateDatesAndTimes(FieldNo("From Time_LDR"));
            end;
        }
        field(50002; "To Time_LDR"; Time)
        {
            Caption = 'Hasta hora';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ValidateDatesAndTimes(FieldNo("To Time_LDR"));
            end;
        }
        field(50003; "Company Dependence_LDR"; Code[20])
        {
            Caption = 'Empresa Pertenencia';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Company";
        }
        field(50004; "Employee Full Name_LDR"; Text[100])
        {
            Caption = 'Nombre Empleado';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Accumulated Hours Entry No._LDR"; Integer)
        {
            Caption = 'Nº Movimiento Horas Acumuladas';
            DataClassification = ToBeClassified;
            Editable = false;
            //TableRelation = "Accumulated Employee Hours"."Entry No."; //TODO: Revisar si conservamos la tabla
        }
        field(50006; "Accumulated Hour Date_LDR"; Date) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Lookup("Accumulated Employee Hours"."Date" WHERE ("Entry No."=FIELD("Accumulated Hours Entry No."))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Fecha Horas Acumuladas';
            FieldClass = FlowField;
        }
    }

    var
        Text50001: TextConst ENU = '%1 must be lesser than %2', ESP = '%1 debe ser menor que %2';
        Text50002: TextConst ENU = '%1 must be greater than %2', ESP = '%1 debe ser mayor que %2';
        Text50003: TextConst ENU = 'Invalid %1, %2 must be lesser than %3', ESP = '%1 no válida, %2 debe ser menor que %3';
        Text50004: TextConst ENU = 'Invalid %1, %2 must be greater than %3', ESP = '%1 no válida, %2 debe ser mayor que %3';
        Resource: Record "Resource";

    local procedure ValidateDatesandTimes(pFieldNo: Integer);
    begin
        case pFieldNo of
            FieldNo("From Date"):
                begin
                    if ("From Time_LDR" <> 0T) and ("To Time_LDR" <> 0T) then begin
                        if ("From Date" = "To Date") and ("From Time_LDR" >= "To Time_LDR") then
                            Error(Text50003, FieldCaption("From Date"), FieldCaption("From Time_LDR"), FieldCaption("To Time_LDR"));
                    end else
                        if "To Date" < "From Date" then
                            "To Date" := "From Date";
                end;
            FieldNo("To Date"):
                begin
                    if ("From Time_LDR" <> 0T) and ("To Time_LDR" <> 0T) then begin
                        if ("From Date" = "To Date") and ("To Time_LDR" <= "From Time_LDR") then
                            Error(Text50004, FieldCaption("To Date"), FieldCaption("To Time_LDR"), FieldCaption("From Time_LDR"));
                    end;

                    if "To Date" < "From Date" then
                        Error(Text50002, FieldCaption("To Date"), FieldCaption("From Date"));
                end;
            FieldNo("From Time_LDR"):
                begin
                    if ("From Time_LDR" <> 0T) or ("To Time_LDR" <> 0T) then begin
                        if ("From Date" = "To Date") and ("From Time_LDR" >= "To Time_LDR") then
                            Error(Text50001, FieldCaption("From Time_LDR"), FieldCaption("To Time_LDR"));
                    end;
                end;
            FieldNo("To Time_LDR"):
                begin
                    if ("From Time_LDR" <> 0T) or ("To Time_LDR" <> 0T) then begin
                        if ("From Date" = "To Date") and ("To Time_LDR" <= "From Time_LDR") then
                            Error(Text50002, FieldCaption("To Time_LDR"), FieldCaption("From Time_LDR"));
                    end;
                end;
        end;
    end;
}