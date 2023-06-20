/// <summary>
/// tableextension 50100 "Customer Pmt. Address_LDR"
/// </summary>
tableextension 50100 "Customer Pmt. Address_LDR" extends "Customer Pmt. Address" //TODO: Revisar warning de la extends de la tableextension
{
    fields
    {
        field(50000; "Cust. Pmt. Address Predet._LDR"; BoolEAN)
        {
            Caption = 'Dirección Pago Predeterminada';
            DataClassification = ToBeClassified;
        }
    }
}