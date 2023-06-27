/// <summary>
/// tableextension 50115 "Sales Cue_LDR"
/// </summary>
tableextension 50115 "Sales Cue_LDR" extends "Sales Cue"
{
    fields
    {
        field(50000; "LDR_Partially Shipped_LDR"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = const("Order"), "Status" = const("Released"), "Ship" = const(true),
            "Completely Shipped" = const(false), "Shipment Date" = FIELD("Date Filter2"), "Responsibility Center" = FIELD("Responsibility Center Filter")));
            FieldClass = FlowField;
        }
    }
}