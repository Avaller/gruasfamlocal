/// <summary>
/// tableextension 50046 "Shipping Agent_LDR"
/// </summary>
tableextension 50046 "Shipping Agent_LDR" extends "Shipping Agent"
{
    fields
    {
        field(50000; Enrollment_LDR; Text[10])
        {
            Caption = 'Matrícula';
            DataClassification = ToBeClassified;
        }
        field(50001; "VAT Registration No._LDR"; Text[20])
        {
            Caption = 'CIF/NIF';
            DataClassification = ToBeClassified;
        }
    }
}