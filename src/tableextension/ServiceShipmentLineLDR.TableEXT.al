/// <summary>
/// tableextension 50086 "Service Shipment Line_LDR"
/// </summary>
tableextension 50086 "Service Shipment Line_LDR" extends "Service Shipment Line"
{
    fields
    {
        field(50050; "Invoicing UOM Code_LDR"; Code[10])
        {
            Caption = 'Código Unidad Medida Facturación';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Type" = CONST("Item")) "Item Unit of Measure"."Code" WHERE("Item No." = FIELD("No.")) ELSE
            IF ("Type" = CONST("Resource")) "Resource Unit of Measure"."Code" WHERE("Resource No." = FIELD("No.")) ELSE
            "Unit of Measure";
        }
        field(50051; "Crane Quote No._LDR"; Code[20])
        {
            Caption = 'Código Oferta Grúa';
            DataClassification = ToBeClassified;
            //TableRelation = "Crane Service Quote Header"."Quote no."; //TODO: Revisar si conservamos la tabla
        }
        field(50052; "Crane Quote Op. Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Operación Oferta Grúa';
            DataClassification = ToBeClassified;
        }
        field(50053; "Crane Quote Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Oferta Grúa';
            DataClassification = ToBeClassified;
        }
        field(50054; "Contract Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Contrato';
            DataClassification = ToBeClassified;
        }
        field(50055; "Contract Concept Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Concepto Contrato';
            DataClassification = ToBeClassified;
        }
        field(50057; "Customer Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Cliente';
            DataClassification = ToBeClassified;
        }
        field(50058; "Service Order Retained_LDR"; BoolEAN)
        {
            CalcFormula = Lookup("Service Header"."Retained_LDR" WHERE("No." = FIELD("Order No.")));
            Caption = 'Pedido Servicio Retenido';
            FieldClass = FlowField;
        }
        field(7121993; "Purchase Receipt No._LDR"; Code[20])
        {
            Caption = 'Nº Albarán Compra';
            DataClassification = ToBeClassified;
            Description = 'Nº Albarán Compra';
        }
        field(7121994; "Purchase Receipt Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Albarán Compra';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Albarán Compra';
        }
        field(7121995; "Opened (Quote)_LDR"; BoolEAN)
        {
            Caption = 'Abierto';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7121996; "Quote No._LDR"; Code[20])
        {
            Caption = 'Nº Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Oferta';
        }
        field(7121997; "Quote Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Oferta';
        }
        field(7121998; "Quote Invoice Line No_LDR"; Integer)
        {
            Caption = 'Nº Línea Factura Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Factura Oferta';
        }
        field(7121999; "Item Entry No._LDR"; Integer)
        {
            Caption = 'Nº Movimiento Producto';
            DataClassification = ToBeClassified;
            Description = 'Nº Movimiento Producto';
        }
        field(7122000; "Initial Time_LDR"; Time)
        {
            Caption = 'Hora Inicio';
            DataClassification = ToBeClassified;
            Description = 'Hora Inicio';
        }
        field(7122001; "End Time_LDR"; Time)
        {
            Caption = 'Hora Fin';
            DataClassification = ToBeClassified;
            Description = 'Hora Fin';
        }
        field(7122002; "Internal Quantity_LDR"; Decimal)
        {
            Caption = 'Cantidad Teórica';
            DataClassification = ToBeClassified;
            Description = 'Cantidad Teórica';
            Editable = false;
        }
        field(7122003; "Service Order Description_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text
        {
            CalcFormula = Lookup("Service Shipment Header"."Description" WHERE("No." = FIELD("Document No.")));
            Caption = 'Descripción Pedido';
            Description = 'Descripción Pedido';
            FieldClass = FlowField;
        }
        field(7122004; "Number of Hours_LDR"; Integer)
        {
            CalcFormula = Lookup("Service Shipment Item Line"."No of hours_LDR" WHERE("No." = FIELD("Document No."),
            "Line No." = FIELD("Service Item Line No.")));
            Caption = 'Nº Horas';
            Description = 'Nº Horas Máquina';
            FieldClass = FlowField;
        }
        field(7122005; "EAN code_LDR"; Code[13])
        {
            Caption = 'Código EAN';
            DataClassification = ToBeClassified;
            Description = 'Código EAN';
        }
        field(7122006; Revaluation_LDR; BoolEAN)
        {
            Caption = 'Revalorizar Máquina';
            DataClassification = ToBeClassified;
            Description = 'Para Generar Movimientos de Valor de Máquina';
        }
        field(7122007; "Created from Transfer_LDR"; BoolEAN)
        {
            Caption = 'Creado desde Transferencia';
            DataClassification = ToBeClassified;
            Description = 'Indica que la Línea se ha Creado desde una Reclasificación';
        }
        field(7122008; "Transfer Source Location Code_LDR"; Code[20])
        {
            Caption = 'Código Almacén Origen Transferencia';
            DataClassification = ToBeClassified;
            TableRelation = "Location";
        }
        field(7122009; "Transfer Source Bin Code_LDR"; Code[20])
        {
            Caption = 'Código Ubicación Origen Transferencia';
            DataClassification = ToBeClassified;
            TableRelation = "Bin"."Code" WHERE("Location Code" = FIELD("Transfer Source Location Code_LDR"));
        }
        field(7122010; "Convert to Order_LDR"; BoolEAN)
        {
            Caption = 'Convertir en Pedido';
            DataClassification = ToBeClassified;
        }
        field(7122011; Chargeable_LDR; BoolEAN)
        {
            Caption = 'Generar Factura';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(7122013; Grouper_LDR; Text[20])
        {
            Caption = 'Agrupador';
            DataClassification = ToBeClassified;
        }
        field(7122014; "Service item Model_LDR"; Text[50])
        {
            Caption = 'Modelo';
            DataClassification = ToBeClassified;
            Description = 'Modelo';
        }
        field(7122016; "Service Price Version No._LDR"; Code[20])
        {
            Caption = 'Nº Versión Grupo Precio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Price"."Version No." WHERE("Service Price Group" = FIELD("Service Price Group Code")); //TODO: Revisar si conservamos la tabla
        }
        field(7122017; "Service Contract Period_LDR"; Text[50])
        {
            Caption = 'Período Contrato Servicio';
            DataClassification = ToBeClassified;
        }
        field(7122018; "Concept No._LDR"; Code[20])
        {
            Caption = 'Nº Concepto';
            DataClassification = ToBeClassified;
            //TableRelation = "Concept"."No." WHERE("Type" = CONST("External")); //TODO: Revisar si conservamos la tabla
        }
        field(7122019; "Charge Capacity_LDR"; Decimal)
        {
            Caption = 'Capacidad Carga (Kg)';
            DataClassification = ToBeClassified;
            Description = 'Indica la Capacidad de Carga de la Máquina en Kg';
        }
        field(7122093; "Warranty Service Code_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Garantía';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";
        }
        field(7122094; "Warranty No._LDR"; Code[20])
        {
            Caption = 'Nº Garantía';
            DataClassification = ToBeClassified;
        }
        /*field(7122095; Warranty_LDR; BoolEAN)
        {
            Caption = 'Garantía';
            DataClassification = ToBeClassified;
            Description = 'Determina si es una Garantía';
        }*/
    }

    keys
    {
        key(Key9; "Order No.", "Line No.")
        {

        }
        key(Key10; "Purchase Receipt No._LDR", "Purchase Receipt Line No._LDR")
        {

        }
        key(Key11; "Posting Date")
        {

        }
        key(Key12; "Currency Code", "Qty. Shipped Not Invoiced", "Bill-to Customer No.", "Order No.")
        {

        }
        key(Key13; "Customer No.", "Ship-to Code")
        {

        }
    }
}