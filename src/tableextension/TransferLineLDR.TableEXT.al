/// <summary>
/// tableextension 50063 "Transfer Line_LDR"
/// </summary>
tableextension 50063 "Transfer Line_LDR" extends "Transfer Line"
{
    fields
    {
        field(50000; "Nº EAN labels"; Integer)
        {
            Caption = 'Nº Etiquetas EAN';
            DataClassification = ToBeClassified;
            Description = 'Especifica el Número de Etiquetas a Imprimir';
            InitValue = 0;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key7; "Transfer-to Code", "Status", "Derived From Line No.", "Item No.", "Variant Code", "Shortcut Dimension 1 Code",
        "Shortcut Dimension 2 Code", "Shipment Date", "In-Transit Code")
        {
            SumIndexFields = "Outstanding Qty. (Base)";
        }
    }
}