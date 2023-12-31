/// <summary>
/// tableextension 50047 "Sales & Receivables Setup_LDR" 
/// </summary>
tableextension 50047 "Sales & Receivables Setup_LDR" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "CIF/NIF Obligatory_LDR"; Boolean)
        {
            Caption = 'Obligatorio CIF/NIF';
            DataClassification = ToBeClassified;
        }
        field(50001; "Create Payment Days_LDR"; Boolean)
        {
            Caption = 'Crear Codígo Días de Pago y de No Pago';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
    }
}