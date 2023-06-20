/// <summary>
/// tableextension 50073 "Service Order Post Buffer_LDR"
/// </summary>
tableextension 50073 "Service Order Post Buffer_LDR" extends "Service Order Posting Buffer"
{
    fields
    {
        field(50000; "Service Item Line No._LDR"; Integer)
        {
            Caption = 'Línea Producto Servicio';
            DataClassification = ToBeClassified;
        }
        field(50001; Description_LDR; Text[50])
        {
            Caption = 'Descripción';
            DataClassification = ToBeClassified;
        }
    }
}