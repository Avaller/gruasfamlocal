/// <summary>
/// tableextension 50114 "Purchase Price_LDR"
/// </summary>
tableextension 50114 "Purchase Price_LDR" extends "Purchase Price"
{
    fields
    {
        field(50000; "LDR_Minimum Quantity_LDR"; Decimal)
        {
            Caption = 'Minimum Quantity';
            MinValue = 0;
        }
    }
}