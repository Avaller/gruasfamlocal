/// <summary>
/// Page Employee Marking Entries (ID 50000).
/// </summary>
page 50000 "Employee Marking Entries"
{
    Caption = 'Employee Marking';
    Editable = false;
    PageType = List;
    SourceTable = "Employee Marking Entries_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Entrada';
                    ToolTip = 'No de Entrada';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de Entrada';
                    ToolTip = 'Tipo de Entrada';
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Entrada';
                    ToolTip = 'Fecha de Entrada';
                }
                field("Entry Time"; Rec."Entry Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de Entrada';
                    ToolTip = 'Tiempo de Entrada';
                }
                field("Door Operation Code"; Rec."Door Operation Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Puerta de Operación';
                    ToolTip = 'Codigo de Puerta de Operación';
                }
                field("No Operation Card"; Rec."No Operation Card")
                {
                    ApplicationArea = All;
                    Caption = 'No de Tarjeta de Operación';
                    ToolTip = 'No de Tarjeta de Operación';
                }
                field("Operation Employee Code"; Rec."Operation Employee Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Operación de Empleado';
                    ToolTip = 'Codigo de Operación de Empleado';
                }
                field("Operation Resource Code"; Rec."Operation Resource Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Recurso de Operación';
                    ToolTip = 'Codigo de Recurso de Operación';
                }
            }
        }
    }
}