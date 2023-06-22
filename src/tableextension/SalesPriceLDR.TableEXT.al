/// <summary>
/// tableextension 50113 "Sales Price_LDR"
/// </summary>
tableextension 50113 "Sales Price_LDR" extends "Sales Price"
{
    fields
    {
        field(50000; "LDR_Sales Code_LDR"; Code[20])
        {
            TableRelation = IF ("Sales Type" = CONST("Customer Price Group")) "Customer Price Group"
            ELSE
            IF ("Sales Type" = CONST("Customer")) "Customer"
            ELSE
            IF ("Sales Type" = CONST("Campaign")) "Campaign";
            ValidateTableRelation = false;
        }
        field(50001; "LDR_Minimum Quantity_LDR"; Decimal)
        {
            Caption = 'Minimum Quantity';
            MinValue = 0;
        }
    }
}