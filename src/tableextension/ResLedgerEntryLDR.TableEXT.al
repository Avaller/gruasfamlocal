/// <summary>
/// tableextension 50034 "Res. Ledger Entry_LDR"
/// </summary>
tableextension 50034 "Res. Ledger Entry_LDR" extends "Res. Ledger Entry"
{
    fields
    {
        field(50000; Replicated_LDR; Boolean)
        {
            Caption = 'Replicado';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Company Dependence_LDR"; Code[20])
        {
            CalcFormula = Lookup(Resource."Company Dependence_LDR" WHERE("No." = FIELD("Resource No.")));
            Caption = 'Empresa Pertenencia';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Company";
        }
        field(50002; "Resource Name_LDR"; Text[50])
        {
            Caption = 'Nombre Recurso';
            DataClassification = ToBeClassified;
        }
        field(50003; "Initial Time_LDR"; Time)
        {
            Caption = 'Hora Inicio';
            DataClassification = ToBeClassified;
        }
        field(50004; "End Time_LDR"; Time)
        {
            Caption = 'Hora Fin';
            DataClassification = ToBeClassified;
        }
        field(50005; "Internal Quantity_LDR"; Decimal)
        {
            Caption = 'Cantidad Teórica';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key7; "Resource No.", "Work Type Code", "Posting Date")
        {

        }
    }
}