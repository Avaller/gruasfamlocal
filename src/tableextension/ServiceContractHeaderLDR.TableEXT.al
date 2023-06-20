/// <summary>
/// tableextension 50078 "Service Contract Header_LDR"
/// </summary>
tableextension 50078 "Service Contract Header_LDR" extends "Service Contract Header"
{
    fields
    {
        field(50000; "Service Item Tariff No._LDR"; Code[20])
        {
            Caption = 'Código Tarifa Producto de Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Rate Header"; //TODO: Revisar si conservamos la tabla
        }
        field(50001; "Service Quote Type_LDR"; Option)
        {
            Caption = 'Tipo Oferta';
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Tarifa';
            OptionMembers = General,Tariff;
        }
        field(50002; Retained_LDR; BoolEAN)
        {
            Caption = 'Retenido';
            DataClassification = ToBeClassified;
        }
        field(50003; "Customer Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Cliente';
            DataClassification = ToBeClassified;
        }
        field(50004; "Invoicing Type_LDR"; Option)
        {
            Caption = 'Tipo Facturación';
            DataClassification = ToBeClassified;
            OptionCaption = 'Obra,Oferta,Independiente,Pedido';
            OptionMembers = Work,Offer,Standalone,Order;
        }
        field(50005; "Service Quote no._LDR"; Code[20])
        {
            Caption = 'Código Oferta';
            DataClassification = ToBeClassified;
            //TableRelation = "Crane Service Quote Header"."Quote no." WHERE ("Platform Quote"=CONST(true)); //TODO: Revisar si conservamos la tabla 
        }
        field(50006; "Old Worksheet No._LDR"; Code[20])
        {
            Caption = 'Nº Parte Antiguo';
            DataClassification = ToBeClassified;
        }
        field(50007; "Day Invoicing_LDR"; BoolEAN)
        {
            Caption = 'Facturar por Precio Día';
            DataClassification = ToBeClassified;
            Description = 'Permite Especificar si se Factura por Precio Día';
        }
        field(50008; "Invoice Day of Month_LDR"; Integer)
        {
            Caption = 'Facturar a Día';
            DataClassification = ToBeClassified;
            MaxValue = 31;
            MinValue = 0;
        }
        field(50009; Lineal_LDR; BoolEAN)
        {
            Caption = 'Lineal';
            DataClassification = ToBeClassified;
        }
        field(50010; "Next Inv. Lineal Period Start_LDR"; Date)
        {
            Caption = 'Inicio Siguiente Período Factura Lineal';
            DataClassification = ToBeClassified;
        }
        field(50011; "Next Inv. Lineal Period End_LDR"; Date)
        {
            Caption = 'Fin Siguiente Período Factura Lineal';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50012; "Serv. Contract Inv. Group_LDR"; Code[20])
        {
            Caption = 'Código Grupo Facturación Contrato Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Contract Invoice Group" WHERE ("Customer No."=FIELD("Bill-to Customer No.")); //TODO: Revisar si conservamos la tabla 
        }
        /*field(50013; "Payment Method Code_LDR"; Code[10])
        {
            Caption = 'Código Forma Pago';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }*/
        field(50014; "Internal Contract No._LDR"; Code[20])
        {
            Caption = 'Contrato Interno Relacionado';
            DataClassification = ToBeClassified;
            //TableRelation = "Table70028"."Field1" WHERE(Field2 = CONST(1)); //TODO: Revisar si conservamos la tabla 
        }
        field(50015; "Pay-at Code_LDR"; Code[20])
        {
            Caption = 'Pago en Código';
            DataClassification = ToBeClassified;
            TableRelation = "Customer Pmt. Address"."Code" WHERE("Customer No." = FIELD("Bill-to Customer No.")); //TODO: Revisar si conservamos la tabla 
        }
        field(50016; Historical_LDR; BoolEAN)
        {
            Caption = 'Histórico';
            DataClassification = ToBeClassified;
        }
        field(50017; "ELESOFT Contract Amount_LDR"; Decimal)
        {
            Caption = 'Importe Contrato ELESOFT';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50018; "Invoice Series No._LDR"; Code[10])
        {
            Caption = 'Nº Serie Facturas';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50019; "Shipping Agent Code_LDR"; Code[10])
        {
            Caption = 'Código Transportista';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
        }
        field(50020; "Renting Contract_LDR"; BoolEAN)
        {
            Caption = 'Contrato de Renting';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key12; Historical_LDR)
        {

        }
    }
}