/// <summary>
/// tableextension 50093 "Warehouse Entry_LDR"
/// </summary>
tableextension 50093 "Warehouse Entry_LDR" extends "Warehouse Entry"
{
    keys
    {
        key(Key10; "Item No.", "Location Code", "Bin Code", "Source Document")
        {
            SumIndexFields = Quantity;
        }
    }
}