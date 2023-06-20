/// <summary>
/// tableextension 50002 "G/L Entry_LDR"
/// </summary>
tableextension 50002 "G/L Entry_LDR" extends "G/L Entry"
{
    fields
    {
        field(50000; "Leasing No._LDR"; Code[20])
        {
            Caption = 'Nº Leasing';
            DataClassification = ToBeClassified;
            Description = 'Almacena el Nº Leasing del movimiento';

            trigger OnLookup()
            begin
                Clear(ServOrderMgt);
                //ServOrderMgt.LeasingLookup("Leasing No.");
            end;
        }
        field(50001; "Leasing Line No._LDR"; Integer)
        {
            Caption = 'Nº Cuota Leasing';
            DataClassification = ToBeClassified;
            Description = 'Almacena el Nº Cuota Leasing del movimiento';
            //TableRelation = Table70011.Field2 WHERE(Field1 = FIELD("Leasing No.")); //TODO: Revisar si conservamos la tabla
        }
        field(50002; Dotted_LDR; BoolEAN)
        {
            Caption = 'Punteada';
            DataClassification = ToBeClassified;
        }
        field(50003; Hidden_LDR; BoolEAN)
        {
            Caption = 'Oculta';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key21; "Posting Date", "Bal. Account Type", "Bal. Account No.")
        {
        }
        key(Key22; "Document No.", "Document Date")
        {
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
    }

    var
        ServOrderMgt: Codeunit "ServOrderManagement";
}