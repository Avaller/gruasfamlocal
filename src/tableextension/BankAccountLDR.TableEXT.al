/// <summary>
/// tableextension 50044 "Bank Account_LDR"
/// </summary>
tableextension 50044 "Bank Account_LDR" extends "Bank Account"
{
    fields
    {
        field(50000; "Bank Payment No. in IOU_LDR"; BoolEAN)
        {
            Caption = 'Utilizar Nº de Pago de Banco en Pagaré';
            DataClassification = ToBeClassified;
        }
        field(50001; "Next Bank Payment No._LDR"; Integer)
        {
            Caption = 'Nº Siguente de Pago de Banco';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(50002; "Confirming Control Digits_LDR"; Text[2])
        {
            Caption = 'Confirming Dígito Control';
            DataClassification = ToBeClassified;
        }
        field(50003; "Confirming Bank Account No._LDR"; Text[10])
        {
            Caption = 'Confirming Nº Cuenta';
            DataClassification = ToBeClassified;
        }
    }
}