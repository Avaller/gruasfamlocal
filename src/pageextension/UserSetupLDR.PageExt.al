pageextension 50032 "User Setup_LDR" extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("Order planner Res. Ctr. Filter_LDR"; Rec."Order planner Res. Ctr. Filter_LDR")
            {
                ApplicationArea = All;
                Caption = 'Orden planificador Res. centro Filtrar';
                ToolTip = 'Orden planificador Res. centro Filtrar';
            }
        }
    }
}