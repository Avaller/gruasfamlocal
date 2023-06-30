/// <summary>
/// PageExtension ResourcesSetup_LDR (ID 50081) extends Record Resources Setup.
/// </summary>
pageextension 50081 "ResourcesSetup_LDR" extends "Resources Setup"
{
    layout
    {
        addafter("Resource Nos.")
        {
            field("Work Type Code Mandatory_LDR"; Rec."Work Type Code Mandatory_LDR")
            {
                ApplicationArea = All;
                Caption = 'Código de tipo de trabajo Obligatorio';
                ToolTip = 'Código de tipo de trabajo Obligatorio';
            }
        }
        addafter("Time Sheet by Job Approval")
        {
            group("Invoicing Hours")
            {
                Caption = 'Horas Facturación';
            }
            field("Effective Hours_LDR"; Rec."Effective Hours_LDR")
            {
                ApplicationArea = All;
                Caption = 'Horas efectivas';
                ToolTip = 'Horas efectivas';
            }
            field("Structure Hours_LDR"; Rec."Structure Hours_LDR")
            {
                ApplicationArea = All;
                Caption = 'Estructura Horas';
                ToolTip = 'Estructura Horas';
            }
            field("Hours of Overtime_LDR"; Rec."Hours of Overtime_LDR")
            {
                ApplicationArea = All;
                Caption = 'Horas de tiempo extra';
                ToolTip = 'Horas de tiempo extra';
            }
            field("Attendance Hours_LDR"; Rec."Attendance Hours_LDR")
            {
                ApplicationArea = All;
                Caption = 'Horas de asistencia';
                ToolTip = 'Horas de asistencia';
            }
            group("Employee Break Management")
            {
                Caption = 'Gesti¢n Descanso Empleados';
            }
            field("Compensation Based On_LDR"; Rec."Compensation Based On_LDR")
            {
                ApplicationArea = All;
                Caption = 'Compensación basada en';
                ToolTip = 'Compensación basada en';
            }
            field("Calc. Time Weekday Due Date_LDR"; Rec."Calc. Time Weekday Due Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Calcular tiempo Día de la semana Fecha de vencimiento';
                ToolTip = 'Calcular tiempo Día de la semana Fecha de vencimiento';
            }
            field("Calc. Time Weekend Due Date_LDR"; Rec."Calc. Time Weekend Due Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Calcular tiempo Fecha de vencimiento del fin de semana';
                ToolTip = 'Calcular tiempo Fecha de vencimiento del fin de semana';
            }
            field("Starting Process Date_LDR"; Rec."Starting Process Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Fecha de inicio del proceso';
                Editable = false;
                ToolTip = 'Fecha de inicio del proceso';
            }
            field("Last Process Date_LDR"; Rec."Last Process Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Fecha del último proceso';
                Editable = false;
                ToolTip = 'Fecha del último proceso';
            }
            field("Process Delay_LDR"; Rec."Process Delay_LDR")
            {
                ApplicationArea = All;
                Caption = 'Retraso del proceso';
                ToolTip = 'Retraso del proceso';
            }
            field("Absence Cause_LDR"; Rec."Absence Cause_LDR")
            {
                ApplicationArea = All;
                Caption = 'Ausencia Causa';
                ToolTip = 'Ausencia Causa';
            }
        }
    }
}