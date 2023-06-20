/// <summary>
/// tableextension 50001 "G/L Account_LDR"
/// </summary>
tableextension 50001 "G/L Account_LDR" extends "G/L Account"
{
    fields
    {
        field(50001; Hidden_LDR; BoolEAN)
        {
            Caption = 'Filtro Seguridad';
            DataClassification = ToBeClassified;
        }
    }
}