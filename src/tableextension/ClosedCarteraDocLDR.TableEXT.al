/// <summary>
/// tableextension 50099 "Closed Cartera Doc._LDR"
/// </summary>
tableextension 50099 "Closed Cartera Doc._LDR" extends "Closed Cartera Doc."
{
    fields
    {
        field(50001; "Promissory Note Printed_LDR"; BoolEAN)
        {
            Caption = 'Pagaré Impreso';
            DataClassification = ToBeClassified;
        }
        field(7121997; "IOU No._LDR"; Code[20])
        {
            Caption = 'Nº Pagaré';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key10; "Document No.")
        {

        }
    }
}