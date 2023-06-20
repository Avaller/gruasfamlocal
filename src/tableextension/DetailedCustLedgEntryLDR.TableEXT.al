/// <summary>
/// tableextension 50054 "Detailed Cust. Ledg. Entry_LDR"
/// </summary>
tableextension 50054 "Detailed Cust. Ledg. Entry_LDR" extends "Detailed Cust. Ledg. Entry"
{
    keys
    {
        key(Key18; "Customer No.", "Excluded from calculation")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
    }
}