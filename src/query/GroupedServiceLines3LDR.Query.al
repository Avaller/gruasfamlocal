/// <summary>
/// Query GroupedServiceLines3_LDR (ID 50003)
/// </summary>
query 50003 GroupedServiceLines3_LDR
{
    elements
    {
        dataitem(QueryElement1000000000; "Service Line")
        {
            DataItemTableFilter = "Type" = FILTER("Resource");

            filter("Document_Type"; "Document Type")
            {
            }
            filter("Document_No"; "Document No.")
            {
            }
            filter("Work_Type_Code"; "Work Type Code")
            {
            }
            column("Sum_Quantity"; "Quantity")
            {
                Method = Sum;
            }
        }
    }
}