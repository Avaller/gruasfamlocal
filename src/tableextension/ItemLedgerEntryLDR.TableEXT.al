/// <summary>
/// tableextension 50007 "Item Ledger Entry_LDR"
/// </summary>
tableextension 50007 "Item Ledger Entry_LDR" extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Consumed_LDR"; Boolean)
        {
            Caption = 'Consumido';
            DataClassification = ToBeClassified;
            Description = 'Determina si el Movimiento ha sido Consumido desde un PS';
        }
    }

    keys
    {
        key(Key22; "Document No.", "Posting Date")
        {
        }
        key(Key23; "Entry Type", "Item No.", "Posting Date")
        {
        }
    }
}