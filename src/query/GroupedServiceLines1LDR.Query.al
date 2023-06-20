/// <summary>
/// Query GroupedServiceLines1_LDR (ID 50001)
/// </summary>
query 50001 GroupedServiceLines1_LDR
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
            column("Invoicing_UOM_Code"; "Invoicing UOM Code_LDR")
            {
            }
            column("Sum_Quantity"; "Quantity")
            {
                Method = Sum;
            }
        }
    }
}