/// <summary>
/// tableextension 50068 "Service Order Type_LDR"
/// </summary>
tableextension 50068 "Service Order Type_LDR" extends "Service Order Type"
{
    fields
    {
        field(50001; "Platform Delivery/Pickup_LDR"; BoolEAN)
        {
            Caption = 'Entrega/Recogida Plataforma';
            DataClassification = ToBeClassified;
        }
    }
}