/// <summary>
/// PageExtension Resource Journal_LDR (ID 50054) extends Record Resource Journal.
/// </summary>
pageextension 50054 "Resource Journal_LDR" extends "Resource Journal"
{
    layout
    {
        addafter(Quantity)
        {
            field("Initial Time_LDR"; Rec."Initial Time_LDR")
            {
                ApplicationArea = All;
                Caption = 'Tiempo Inicial';
                ToolTip = 'Tiempo Inicial';
            }
            field("End Time_LDR"; Rec."End Time_LDR")
            {
                ApplicationArea = All;
                Caption = 'Hora de finalización';
                ToolTip = 'Hora de finalización';
            }
            field("Internal Quantity_LDR"; Rec."Internal Quantity_LDR")
            {
                ApplicationArea = All;
                Caption = 'Cantidad interna';
                ToolTip = 'Cantidad interna';
            }
        }
    }

    actions
    {
        addafter("Ledger E&ntries")
        {
            group(ActionGroup)
            {

            }
            action("Show Graphic Data")
            {
                ApplicationArea = All;
                Caption = 'Mostrar Datos Graficos';
                Image = ShowChart;

                trigger OnAction()
                var
                    EmployeeExpensesGraphic: Page "Employee Expenses Graphic";
                    Employee: Record Employee;
                begin
                    Clear(Employee);
                    Employee.SetRange("Resource No.", Rec."Resource No.");
                    Employee.FindFirst();

                    Clear(EmployeeExpensesGraphic);
                    EmployeeExpensesGraphic.SetParams(Employee."No.", Rec."Posting Date");
                    EmployeeExpensesGraphic.RunModal();
                end;
            }
        }
    }
}