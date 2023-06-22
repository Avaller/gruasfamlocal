/// <summary>
/// tableextension 50090 "Service Cr.Memo Line_LDR"
/// </summary>
tableextension 50090 "Service Cr.Memo Line_LDR" extends "Service Cr.Memo Line"
{
    fields
    {
        field(50000; "Purchase Receipt No._LDR"; Code[20])
        {
            Caption = 'Nº Albarán Compra';
            DataClassification = ToBeClassified;
            Description = 'Nº Albarán Compra';
        }
        field(50001; "Purchase Receipt Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Albarán Compra';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Albarán Compra';
        }
        field(50002; "Opened (Quote)_LDR"; Boolean)
        {
            Caption = 'Abierto';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Quote No._LDR"; Code[20])
        {
            Caption = 'Nº Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Oferta';
        }
        field(50004; "Quote Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Oferta';
        }
        field(50005; "Quote Invoice Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Factura Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Factura Oferta';
        }
        field(50006; "Item Entry No._LDR"; Integer)
        {
            Caption = 'Nº Movimiento Producto';
            DataClassification = ToBeClassified;
            Description = 'Nº Movimiento Producto';
        }
        field(50007; "Initial Time_LDR"; Time)
        {
            Caption = 'Hora Inicio';
            DataClassification = ToBeClassified;
            Description = 'Hora Inicio';
        }
        field(50008; "End Time_LDR"; Time)
        {
            Caption = 'Hora Fin';
            DataClassification = ToBeClassified;
            Description = 'Hora Fin';
        }
        field(50009; "Internal Quantity_LDR"; Decimal)
        {
            Caption = 'Cantidad Teórica';
            DataClassification = ToBeClassified;
            Description = 'Cantidad Teórica';
            Editable = false;
        }
        field(50010; "EAN code_LDR"; Code[13])
        {
            Caption = 'Código EAN';
            DataClassification = ToBeClassified;
            Description = 'Código EAN';
        }
        field(50011; Revaluation_LDR; Boolean)
        {
            Caption = 'Revalorizar Máquina';
            DataClassification = ToBeClassified;
            Description = 'Para Generar Movimientos de Valor de Máquina';
        }
        field(50012; "Created from Transfer_LDR"; Boolean)
        {
            Caption = 'Creado desde Transferencia';
            DataClassification = ToBeClassified;
            Description = 'Indica que la Línea se ha Creado desde una Reclasificación';
        }
        field(50013; "Transfer Source Location Code_LDR"; Code[20])
        {
            Caption = 'Código Almacén Origen Transferencia';
            DataClassification = ToBeClassified;
            TableRelation = "Location";
        }
        field(50014; "Transfer Source Bin Code_LDR"; Code[20])
        {
            Caption = 'Código Ubicación Origen Transferencia';
            DataClassification = ToBeClassified;
            TableRelation = "Bin"."Code" WHERE("Location Code" = FIELD("Transfer Source Location Code_LDR"));
        }
        field(50015; "Convert to Order_LDR"; Boolean)
        {
            Caption = 'Convertir en Pedido';
            DataClassification = ToBeClassified;
        }
        field(50016; Chargeable_LDR; Boolean)
        {
            Caption = 'Generar Factura';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(50017; Grouper_LDR; Text[20])
        {
            Caption = 'Agrupador';
            DataClassification = ToBeClassified;
        }
        field(50018; "Service item Model_LDR"; Text[50])
        {
            Caption = 'Modelo';
            DataClassification = ToBeClassified;
            Description = 'Modelo';
        }
        field(50019; "Service Price Version No._LDR"; Code[20])
        {
            Caption = 'Nº Versión Grupo Precio';
            DataClassification = ToBeClassified;
            //TableRelation = "Table7122009"."Field6" WHERE("Field1" = FIELD("Service Price Group Code")); //TODO: Revisar si conservamos la tabla
        }
        field(50020; "Service Contract Period_LDR"; Text[50])
        {
            Caption = 'Período Contrato Servicio';
            DataClassification = ToBeClassified;
        }
        field(50021; "Concept No._LDR"; Code[20])
        {
            Caption = 'Nº Concepto';
            DataClassification = ToBeClassified;
            //TableRelation = "Table7122020"."Field1" WHERE("Field4" = CONST(1)); //TODO: Revisar si conservamos la tabla
        }
        field(50022; "Charge Capacity_LDR"; Decimal)
        {
            Caption = 'Capacidad Carga (Kg)';
            DataClassification = ToBeClassified;
            Description = 'Indica la Capacidad de Carga de la Máquina en Kg';
        }
        field(50023; "Warranty Service Code_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Garantía';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";
        }
        field(50024; "Warranty No._LDR"; Code[20])
        {
            Caption = 'Nº Garantía';
            DataClassification = ToBeClassified;
        }
        field(50025; Warranty_LDR; Boolean)
        {
            Caption = 'Garantía';
            DataClassification = ToBeClassified;
            Description = 'Determina si es una Garantía';
        }
        field(50026; "Warranty Service Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Servicio';
            DataClassification = ToBeClassified;
        }
        field(50027; "Day Invoicing_LDR"; Boolean)
        {
            Caption = 'Facturar por Precio Día';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "No of Days_LDR"; Integer)
        {
            Caption = 'Nº de Días';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50029; "Day Amount_LDR"; Decimal)
        {
            Caption = 'Precio Venta Día';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key13; "Shipment No.", "Service Item No.", "Type", "Unit of Measure Code", "Unit Price", "Line Discount %")
        {

        }
        key(Key14; Grouper_LDR, "Concept No._LDR")
        {

        }
    }
}