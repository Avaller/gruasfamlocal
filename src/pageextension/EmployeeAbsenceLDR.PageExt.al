/// <summary>
/// PageExtension Employee Absences_LDR (ID 50094) extends Record Employee Absences.
/// </summary>
pageextension 50094 "Employee Absences_LDR" extends "Employee Absences"
{
    layout
    {
        addafter("Employee No.")
        {
            field("Employee Full Name_LDR"; Rec."Employee Full Name_LDR")
            {
                ApplicationArea = All;
                Caption = '';
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
                Caption = '';
                ToolTip = '';
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