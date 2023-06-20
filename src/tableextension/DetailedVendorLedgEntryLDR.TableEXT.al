/// <summary>
/// tableextension 50055 "Detailed Vend Ledg. Entry_LDR"
/// </summary>
tableextension 50055 "Detailed Vend Ledg. Entry_LDR" extends "Detailed Vendor Ledg. Entry"
{
    keys
    {
        key(Key12; "Vendor No.", "Excluded from calculation")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
    }
}