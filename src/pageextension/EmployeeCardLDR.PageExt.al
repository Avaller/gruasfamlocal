/// <summary>
/// PageExtension Employee Card_LDR (ID 50091) extends Record Employee Card.
/// </summary>
pageextension 50091 "Employee Card_LDR" extends "Employee Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(PayEmployee)
        {
            group(History_)
            {
                Caption = 'Historial';
            }
            action("Employee Marking Entries")
            {
                ApplicationArea = All;
                Caption = 'Marcajes de empleado';
                Image = EmployeeAgreement;

                RunObject = Page "Employee Marking Entries";
                RunPageLink = "Operation Employee Code" = field("No.");
            }
            action("Displacement Entries")
            {
                ApplicationArea = All;
                Caption = 'Movimientos Desplazamiento';
                Image = WIPEntries;

                //RunObject = Page "Displacement Entry";
                //RunPageLink = "Employee No." = FIELD("No.");
            }
            group(Expenses)
            {
                Caption = 'Gastos';
                Image = Planning;
            }
            action("Expenses Types")
            {
                ApplicationArea = All;
                Caption = 'Tipos de Gasto';

                RunObject = Page "Empl. Expenses Types";
                RunPageLink = "Employee No." = FIELD("No.");
            }
        }
    }

    var
        myInt: Integer;
}