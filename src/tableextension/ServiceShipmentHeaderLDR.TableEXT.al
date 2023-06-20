/// <summary>
/// tableextension 50085 "Service Shipment Header_LDR"
/// </summary>
tableextension 50085 "Service Shipment Header_LDR" extends "Service Shipment Header"
{
    fields
    {
        field(50050; "Crane Service Quote No._LDR"; Code[20])
        {
            Caption = 'Código Oferta Servicio Grúa';
            DataClassification = ToBeClassified;
            //TableRelation = "Crane Service Quote Header"."Quote no." WHERE ("Historical"=CONST(false)); //TODO: Revisar si conservamos la tabla
        }
        field(50051; "Service Item Rate No._LDR"; Code[20])
        {
            Caption = 'Código Tarifa Producto Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Rate Header"; //TODO: Revisar si conservamos la tabla
        }
        field(50052; "Serv. Item Operation Entry No._LDR"; Integer)
        {
            Caption = 'Nº Movimiento Operación Producto Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Serv. Item Operations Entry"."Entry No."; //TODO: Revisar si conservamos la tabla
        }
        field(50055; "Crane Serv. Quote Op. Line No_LDR"; Integer)
        {
            Caption = 'Nº Línea Opción Oferta Servicio Grúa';
            DataClassification = ToBeClassified;
        }
        field(50056; Retained_LDR; BoolEAN)
        {
            Caption = 'Retenido';
            DataClassification = ToBeClassified;
        }
        field(50057; "Customer Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Cliente';
            DataClassification = ToBeClassified;
        }
        field(7121994; "Quote No._LDR"; Code[20])
        {
            Caption = 'Nº Oferta';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7121995; "Converted to Order_LDR"; BoolEAN)
        {
            Caption = 'Convertida en Pedido';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7121996; "Customer Comment_LDR"; BoolEAN)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST("Customer"), "No." = FIELD("Customer No.")));
            Caption = 'Comentario Cliente';
            FieldClass = FlowField;
            Editable = false;
        }
        field(7121997; "Invoice No. Series_LDR"; Code[20])
        {
            Caption = 'Nº Serie Facturas';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(7121998; "Contract group Code_LDR"; Code[10])
        {
            CalcFormula = Lookup("Service Contract Header"."Contract Group Code" WHERE("Contract No." = FIELD("Contract No.")));
            Caption = 'Código Grupo Contrato';
            FieldClass = FlowField;
            Editable = false;
        }
        field(7122000; "Source Type_LDR"; Option)
        {
            Caption = 'Tipo Origen';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Transfer';
            OptionMembers = Transfer;
        }
        field(7122001; "Default Work Type Code_LDR"; Code[20])
        {
            Caption = 'Código Tipo Trabajo por Defecto';
            DataClassification = ToBeClassified;
            TableRelation = "Work Type" WHERE("Res. Journal Type_LDR" = FILTER(false));
        }
        field(7122002; "Internal Contract No._LDR"; Code[20])
        {
            Caption = 'Nº Contrato Interno';
            DataClassification = ToBeClassified;
            //TableRelation = "Table7122021"."Field1" WHERE("Field2" = CONST(1)); //TODO: Revisar si conservamos la tabla
        }
        field(7122003; "Review No._LDR"; Integer)
        {
            Caption = 'Nº Revisión';
            DataClassification = ToBeClassified;
        }
        field(7122004; "Review Contract Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Contrato Revisión';
            DataClassification = ToBeClassified;
        }
        field(7122005; "Review Template No._LDR"; Code[20])
        {
            Caption = 'Nº Plantilla Revisión';
            DataClassification = ToBeClassified;
            //TableRelation = "Table7121995"; //TODO: Revisar si conservamos la tabla
        }
        /*field(7122006; "Shipping Agent Code_LDR"; Code[10])
        {
            Caption = 'Código Transportista';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
        }*/
    }
}