/// <summary>
/// tableextension 50079 "Contract Group_LDR"
/// </summary>
tableextension 50079 "Contract Group_LDR" extends "Contract Group"
{
    fields
    {
        field(50000; "Impresion type_LDR"; Option)
        {
            Caption = 'Tipo Impresión Factura';
            DataClassification = ToBeClassified;
            OptionCaption = 'Alquiler,Mantenimiento';
            OptionMembers = Rent,Maintenance;
        }
        field(50001; Internal_LDR; BoolEAN)
        {
            Caption = 'Interno';
            DataClassification = ToBeClassified;
        }
    }
}