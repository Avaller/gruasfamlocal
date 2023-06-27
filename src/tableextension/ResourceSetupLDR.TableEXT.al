/// <summary>
/// tableextension 50050 "Resources Setup_LDR"
/// </summary>
tableextension 50050 "Resources Setup_LDR" extends "Resources Setup"
{
    fields
    {
        field(50000; "Work Type Code Mandatory_LDR"; Boolean)
        {
            Caption = 'Obligatorio Código Tipo Trabajo en Diario Recursos';
            DataClassification = ToBeClassified;
        }
        field(50001; "Effective Hours_LDR"; Integer)
        {
            Caption = 'Horas efectivas';
            DataClassification = ToBeClassified;
        }
        field(50002; "Attendance Hours_LDR"; Integer)
        {
            Caption = 'Horas de presencia';
            DataClassification = ToBeClassified;
        }
        field(50003; "Hours of Overtime_LDR"; Integer)
        {
            Caption = 'Horas Extra';
            DataClassification = ToBeClassified;
        }
        field(50004; "Structure Hours_LDR"; Integer)
        {
            Caption = 'Horas Estructurales';
            DataClassification = ToBeClassified;
        }
        field(50005; "Break Hours Weekdays_LDR"; Integer)
        {
            Caption = 'Horas Descanso Entre Semana';
            DataClassification = ToBeClassified;
        }
        field(50006; "Break Hours Weekend_LDR"; Integer)
        {
            Caption = 'Horas Descanso Fin de Semana';
            DataClassification = ToBeClassified;
        }
        field(50007; "Compensation Based On_LDR"; Option)
        {
            Caption = 'Compensación en Base a';
            DataClassification = ToBeClassified;
            OptionCaption = 'Fecha Más Reciente,Fecha Más Antigua';
            OptionMembers = "Most Recent Date","Oldest Date";
        }
        field(50008; "Calc. Time Weekday Due Date_LDR"; DateFormula)
        {
            Caption = 'Tiempo Cálculo para Fecha Expiración Entre Semana';
            DataClassification = ToBeClassified;
        }
        field(50009; "Calc. Time Weekend Due Date_LDR"; DateFormula)
        {
            Caption = 'Tiempo Cálculo para Fecha Expiración Fin de Semana';
            DataClassification = ToBeClassified;
        }
        field(50010; "Starting Process Date_LDR"; Date)
        {
            Caption = 'Fecha Inicial Proceso';
            DataClassification = ToBeClassified;
        }
        field(50011; "Last Process Date_LDR"; Date)
        {
            Caption = 'Última Fecha Proceso';
            DataClassification = ToBeClassified;
        }
        field(50012; "Process Delay_LDR"; DateFormula)
        {
            Caption = 'Retraso Proceso';
            DataClassification = ToBeClassified;
        }
        field(50013; "Absence Cause_LDR"; Code[10])
        {
            Caption = 'Causa Ausencia';
            DataClassification = ToBeClassified;
            TableRelation = "Cause of Absence".Code;
        }
    }
}