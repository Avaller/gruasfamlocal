/// <summary>
/// tableextension 50059 "Human Resources Setup_LDR"
/// </summary>
tableextension 50059 "Human Resources Setup_LDR" extends "Human Resources Setup"
{
    fields
    {
        field(50000; "Route File Marking_LDR"; Text[250])
        {
            Caption = 'Ruta Fichero Marcajes';
            DataClassification = ToBeClassified;
        }
        field(50001; "Route File Marking Backup_LDR"; Text[250])
        {
            Caption = 'Ruta Fichero Marcajes Backup';
            DataClassification = ToBeClassified;
        }
        field(50002; "Employee Expenses Nos._LDR"; Code[10])
        {
            Caption = 'Nº Serie Gastos de Empleados';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}