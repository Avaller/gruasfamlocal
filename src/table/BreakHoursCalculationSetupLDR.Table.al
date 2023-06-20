/// <summary>
/// Table Break Hours Calculat Setup_LDR (ID 50228)
/// </summary>
table 50228 "Break Hours Calculat Setup_LDR"
{
    fields
    {
        field(1; Day; Option)
        {
            Caption = 'Day';
            DataClassification = ToBeClassified;
            OptionCaption = 'Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(2; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Break Hours,Break Hour Start';
            OptionMembers = "Break Hours","Break Hour Start";

            trigger OnValidate()
            begin
                "Break Hours" := 0;
                "Break Hour Start" := 0T;
            end;
        }
        field(3; "Break Hours"; Decimal)
        {
            Caption = 'Break Hours';
            DataClassification = ToBeClassified;
        }
        field(4; "Break Hour Start"; Time)
        {
            Caption = 'Break Hour Start';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Day)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}