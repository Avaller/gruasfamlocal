/// <summary>
/// tableextension 50050 "Resources Setup_LDR"
/// </summary>
tableextension 50050 "Resources Setup_LDR" extends "Resources Setup"
{
    fields
    {
        field(50000; "Work Type Code Mandatory"; BoolEAN)
        {
            Caption = 'Obligatorio Código Tipo Trabajo en Diario Recursos';
            DataClassification = ToBeClassified;
        }
        field(50001; "Effective Hours"; Integer)
        {
            Caption = 'Horas efectivas';
            DataClassification = ToBeClassified;
        }
        field(50002; "Attendance Hours"; Integer)
        {
            Caption = 'Horas de presencia';
            DataClassification = ToBeClassified;
        }
        field(50003; "Hours of Overtime"; Integer)
        {
            Caption = 'Horas Extra';
            DataClassification = ToBeClassified;
        }
        field(50004; "Structure Hours"; Integer)
        {
            Caption = 'Horas Estructurales';
            DataClassification = ToBeClassified;
        }
        field(50005; "Break Hours Weekdays"; Integer)
        {
            Caption = 'Horas Descanso Entre Semana';
            DataClassification = ToBeClassified;
        }
        field(50006; "Break Hours Weekend"; Integer)
        {
            Caption = 'Horas Descanso Fin de Semana';
            DataClassification = ToBeClassified;
        }
        field(50007; "Compensation Based On"; Option)
        {
            Caption = 'Compensación en Base a';
            DataClassification = ToBeClassified;
            OptionCaption = 'Fecha Más Reciente,Fecha Más Antigua';
            OptionMembers = "Most Recent Date","Oldest Date";
        }
        field(50008; "Calc. Time Weekday Due Date"; DateFormula)
        {
            Caption = 'Tiempo Cálculo para Fecha Expiración Entre Semana';
            DataClassification = ToBeClassified;
        }
        field(50009; "Calc. Time Weekend Due Date"; DateFormula)
        {
            Caption = 'Tiempo Cálculo para Fecha Expiración Fin de Semana';
            DataClassification = ToBeClassified;
        }
        field(50010; "Starting Process Date"; Date)
        {
            Caption = 'Fecha Inicial Proceso';
            DataClassification = ToBeClassified;
        }
        field(50011; "Last Process Date"; Date)
        {
            Caption = 'Última Fecha Proceso';
            DataClassification = ToBeClassified;
        }
        field(50012; "Process Delay"; DateFormula)
        {
            Caption = 'Retraso Proceso';
            DataClassification = ToBeClassified;
        }
        field(50013; "Absence Cause"; Code[10])
        {
            Caption = 'Causa Ausencia';
            DataClassification = ToBeClassified;
            TableRelation = "Cause of Absence".Code;
        }
    }
}