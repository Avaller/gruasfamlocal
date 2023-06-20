/// <summary>
/// tableextension 50040 "Item Journal Batch_LDR"
/// </summary>
tableextension 50040 "Item Journal Batch_LDR" extends "Item Journal Batch"
{
    fields
    {
        field(50000; "Open Service Order Test_LDR"; BoolEAN)
        {
            Caption = 'Comprobar Pedido Servicio Abierto';
            DataClassification = ToBeClassified;
        }
        field(50001; Mobility_LDR; BoolEAN)
        {
            Caption = 'Movilidad';
            DataClassification = ToBeClassified;
        }
    }
}