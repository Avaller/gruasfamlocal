/// <summary>
/// PageExtension Absence Registration_LDR (ID 50095) extends Record Absence Registration.
/// </summary>
pageextension 50095 "Absence Registration_LDR" extends "Absence Registration"
{
    layout
    {
        addafter("Employee No.")
        {
            field("Employee Full Name_LDR"; Rec."Employee Full Name_LDR")
            {
                ApplicationArea = All;
                Caption = 'Nombre Completo del Empleado';
                ToolTip = '';
            }
        }
        addafter("From Date")
        {
            field("From Time_LDR"; Rec."From Time_LDR")
            {
                ApplicationArea = All;
                Caption = '';
                ToolTip = '';
            }
        }
        addafter("To Date")
        {
            field("To Time_LDR"; Rec."To Time_LDR")
            {
                ApplicationArea = All;
                Caption = 'a tiempo';
                ToolTip = 'a tiempo';
            }
        }
        addafter(Comment)
        {
            field("Company Dependence_LDR"; Rec."Company Dependence_LDR")
            {
                ApplicationArea = All;
                Caption = 'Dependencia de la empresa';
                ToolTip = 'Dependencia de la empresa';
            }
            field("Accumulated Hours Entry No._LDR"; Rec."Accumulated Hours Entry No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de entrada de horas acumuladas';
                ToolTip = 'Número de entrada de horas acumuladas';
            }
            field("Accumulated Hour Date_LDR"; Rec."Accumulated Hour Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Hora acumulada Fecha';
                ToolTip = 'Hora acumulada Fecha';
            }
        }

    }

    actions
    {
        addafter("Overview by &Periods")
        {
            action("Print Document")
            {
                ApplicationArea = All;
                Caption = 'Mostrar Documento';
                Image = Print;

                trigger OnAction()
                begin
                    Report.Run(50035, TRUE, TRUE);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Employee.Get(Rec."Employee No.") then;
    end;

    var
        Employee: Record Employee;
}