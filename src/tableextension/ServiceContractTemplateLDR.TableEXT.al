/// <summary>
/// tableextension 50080 "Service Contract Template_LDR"
/// </summary>
tableextension 50080 "Service Contract Template_LDR" extends "Service Contract Template"
{
    fields
    {
        field(50000; "Day Invoicing_LDR"; BoolEAN)
        {
            Caption = 'Facturar por Precio Día';
            DataClassification = ToBeClassified;
            Description = 'Permite Especificar si se Factura por Precio Día';
        }
        field(50001; Lineal_LDR; BoolEAN)
        {
            DataClassification = ToBeClassified;
            Description = 'Permite Especificar si se Factura Linealmente en Fechas';
        }
        field(50002; "Responsibility Center_LDR"; Code[10])
        {
            Caption = 'Centro Responsabilidad';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(50003; "Invoice Series No._LDR"; Code[10])
        {
            Caption = 'Nº Serie Facturas';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}