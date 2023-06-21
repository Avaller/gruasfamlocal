/// <summary>
/// tableextension 50049 "Inventory Setup_LDR"
/// </summary>
tableextension 50049 "Inventory Setup_LDR" extends "Inventory Setup"
{
    fields
    {
        field(50000; "Item Nos. 2"; Code[10])
        {
            Caption = 'Nº Serie Referencia 2 Producto';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Inherit Item Dims. to Inv. Jnl"; Boolean)
        {
            Caption = 'Heredar Dimensiones Producto a Diario Inventario';
            DataClassification = ToBeClassified;
        }
        field(50002; "Central Warehouse"; Code[10])
        {
            Caption = 'Almacén Central';
            DataClassification = ToBeClassified;
            TableRelation = "Location";
        }
    }
}