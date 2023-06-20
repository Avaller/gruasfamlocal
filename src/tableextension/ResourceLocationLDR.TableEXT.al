/// <summary>
/// tableextension 50076 "Resource Location_LDR"
/// </summary>
tableextension 50076 "Resource Location_LDR" extends "Resource Location"
{
    fields
    {
        field(50000; Main_LDR; BoolEAN)
        {
            Caption = 'Principal';
            DataClassification = ToBeClassified;
        }
        field(50001; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50002; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key2; "Resource No.", "Starting Date")
        {

        }
    }
}