/// <summary>
/// tableextension 50094 "Base Calendar Change_LDR"
/// </summary>
tableextension 50094 "Base Calendar Change_LDR" extends "Base Calendar Change"
{
    fields
    {
        field(50001; "Local Holiday_LDR"; Boolean)
        {
            Caption = 'Festivo Local';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Nonworking);
            end;
        }
        field(50002; LDR_Nonworking_LDR; Boolean)
        {
            trigger OnValidate()
            begin
                if not Nonworking then
                    "Local Holiday_LDR" := false;
            end;
        }
    }
}