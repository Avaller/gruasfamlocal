/// <summary>
/// tableextension 50081 "Filed Serv Contract Header_LDR"
/// </summary>
tableextension 50081 "Filed Serv Contract Header_LDR" extends "Filed Service Contract Header"
{
    fields
    {
        field(50000; "Day Invoicing_LDR"; Boolean)
        {
            Caption = 'Facturar por Precio Día';
            DataClassification = ToBeClassified;
            Description = 'Permite Especificar si se Factura por Precio Día';
        }
        field(50001; "Invoice Day of Month_LDR"; Integer)
        {
            Caption = 'Facturar a Día';
            DataClassification = ToBeClassified;
            MaxValue = 31;
            MinValue = 0;
        }
        field(50002; Lineal_LDR; Boolean)
        {
            Caption = 'Lineal';
            DataClassification = ToBeClassified;
        }
        field(50003; "Next Inv. Lineal Period Start_LDR"; Date)
        {
            Caption = 'Inicio Siguiente Período Factura Lineal';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Next Inv. Lineal Period End_LDR"; Date)
        {
            Caption = 'Fin Siguiente Período Factura Lineal';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Serv. Contract Inv. Group_LDR"; Code[20])
        {
            Caption = 'Código Grupo Facturación Contrato Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Table7122019" WHERE ("Field3"=FIELD("Bill-to Customer No.")); //TODO: Revisar si conservamos la tabla
        }
        field(50006; "Payment Method Code_LDR"; Code[10])
        {
            Caption = 'Código Forma Pago';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(50007; "ELESOFT Contract Amount_LDR"; Decimal)
        {
            Caption = 'Importe Contrato ELESOFT';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "LDR_Invoice Period_LDR"; Option)
        {
            Caption = 'Invoice Period';
            OptionCaption = 'Month,Two Months,Quarter,Half Year,Year,None,Third of a year';
            OptionMembers = Month,"Two Months",Quarter,"Half Year",Year,"None","Third of a year";
        }
    }
}