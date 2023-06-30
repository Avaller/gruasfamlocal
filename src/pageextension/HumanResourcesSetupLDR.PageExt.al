/// <summary>
/// PageExtension HumanResourcesSetup_LDR (ID 50096) extends Record Human Resources Setup.
/// </summary>
pageextension 50096 "HumanResourcesSetup_LDR" extends "Human Resources Setup"
{
    layout
    {
        addafter("Employee Nos.")
        {
            field("Employee Expenses Nos._LDR"; Rec."Employee Expenses Nos._LDR")
            {
                ApplicationArea = All;
                Caption = 'Números de gastos de los empleados';
                ToolTip = 'Números de gastos de los empleados';
            }
        }
        addafter("Base Unit of Measure")
        {
            group(Integration)
            {
                Caption = 'Integración';
            }
            field("Route File Marking_LDR"; Rec."Route File Marking_LDR")
            {
                ApplicationArea = All;
                Caption = 'Marcado de archivo de ruta';
                ToolTip = 'Marcado de archivo de ruta';
            }
            field("Route File Marking Backup_LDR"; Rec."Route File Marking Backup_LDR")
            {
                ApplicationArea = All;
                Caption = 'Copia de seguridad de marcado de archivos de ruta';
                ToolTip = 'Copia de seguridad de marcado de archivos de ruta';
            }
        }
    }
}