/// <summary>
/// tableextension 50069 "Service Comment Line_LDR"
/// </summary>
tableextension 50069 "Service Comment Line_LDR" extends "Service Comment Line"
{
    fields
    {
        field(50000; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50001; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
        field(50002; Time_LDR; Time)
        {
            Caption = 'Hora';
            DataClassification = ToBeClassified;
        }
        field(50003; "User ID_LDR"; Code[50])
        {
            Caption = 'ID Usuario';
            DataClassification = ToBeClassified;
        }
        field(50004; Separator_LDR; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Space","Carriage Return";
        }
        field(50005; CR_LDR; BoolEAN)
        {
            DataClassification = ToBeClassified;
        }
    }

    trigger OnBeforeInsert()
    begin
        if (Type in [1, 2, 3, 4]) and ("Table Subtype" <> "Table Subtype"::"0") then
            TestField("Table Line No.");

        "Created Date_LDR" := CurrentDateTime;
    end;

    trigger OnBeforeModify()
    begin
        "Modified Date_LDR" := CurrentDateTime;
    end;
}