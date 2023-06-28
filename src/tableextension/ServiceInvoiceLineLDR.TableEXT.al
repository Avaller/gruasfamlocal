/// <summary>
/// tableextension 50088 "Service Invoice Line_LDR"
/// </summary>
tableextension 50088 "Service Invoice Line_LDR" extends "Service Invoice Line"
{
    fields
    {
        field(50051; "Crane Quote No._LDR"; Code[20])
        {
            Caption = 'Código Oferta Grúa';
            DataClassification = ToBeClassified;
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
        field(50056; Replicated_LDR; Boolean)
        {
            Caption = 'Replicado';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50059; "Source Serv. Inv. No._LDR"; Code[20])
        {
            Caption = 'Nº Factura Servicio Origen';
            DataClassification = ToBeClassified;
        }
        field(50060; "Source Serv. Inv. Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Factura Servicio Origen';
            DataClassification = ToBeClassified;
        }
        field(50061; "Purchase Receipt No._LDR"; Code[20])
        {
            Caption = 'Nº Movimiento Producto';
            DataClassification = ToBeClassified;
            Description = 'Nº Movimiento Producto';
        }
        field(50062; "Purchase Receipt Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Albarán Compra';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Albarán Compra';
        }
        field(50063; "Opened (Quote)_LDR"; Boolean)
        {
            Caption = 'Abierto';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50064; "Quote No._LDR"; Code[20])
        {
            Caption = 'Nº Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Oferta';
        }
        field(50065; "Quote Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Oferta';
        }
        field(50066; "Quote Invoice Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Factura Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Factura Oferta';
        }
        field(50067; "Item Entry No._LDR"; Integer)
        {
            Caption = 'Nº Movimiento Producto';
            DataClassification = ToBeClassified;
            Description = 'Nº Movimiento Producto';
        }
        field(50068; "Initial Time_LDR"; Time)
        {
            Caption = 'Hora Inicio';
            DataClassification = ToBeClassified;
            Description = 'Hora Inicio';
        }
        field(50069; "End Time_LDR"; Time)
        {
            Caption = 'Hora Fin';
            DataClassification = ToBeClassified;
            Description = 'Hora Fin';
        }
        field(50070; "Internal Quantity_LDR"; Decimal)
        {
            Caption = 'Cantidad Teórica';
            DataClassification = ToBeClassified;
            Description = 'Cantidad Teórica';
            Editable = false;
        }
        field(50071; "EAN code_LDR"; Code[13])
        {
            Caption = 'Código EAN';
            DataClassification = ToBeClassified;
            Description = 'Código EAN';
        }
        field(50072; Revaluation_LDR; Boolean)
        {
            Caption = 'Revalorizar Máquina';
            DataClassification = ToBeClassified;
            Description = 'Para Generar Movimientos de Valor de Máquina';
        }
        field(50073; "Created from Transfer_LDR"; Boolean)
        {
            Caption = 'Creado desde Transferencia';
            DataClassification = ToBeClassified;
            Description = 'Indica que la Línea se ha Creado desde una Reclasificación';
        }
        field(50074; "Transfer Source Location Code_LDR"; Code[20])
        {
            Caption = 'Código Almacén Origen Transferencia';
            DataClassification = ToBeClassified;
            TableRelation = "Location";
        }
        field(50075; "Transfer Source Bin Code_LDR"; Code[20])
        {
            Caption = 'Código Ubicación Origen Transferencia';
            DataClassification = ToBeClassified;
            TableRelation = "Bin"."Code" WHERE("Location Code" = FIELD("Transfer Source Location Code_LDR"));
        }
        field(50076; "Convert to Order_LDR"; Boolean)
        {
            Caption = 'Convertir en Pedido';
            DataClassification = ToBeClassified;
        }
        field(50077; Chargeable_LDR; Boolean)
        {
            Caption = 'Generar Factura';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(50078; Grouper_LDR; Text[20])
        {
            Caption = 'Agrupador';
            DataClassification = ToBeClassified;
        }
        field(50079; "Service item Model_LDR"; Text[50])
        {
            Caption = 'Modelo';
            DataClassification = ToBeClassified;
            Description = 'Modelo';
        }
        field(50080; "Contract Hours Entry No._LDR"; Integer)
        {
            Caption = 'Nº Movimiento Contrato por Horas';
            DataClassification = ToBeClassified;
            //TableRelation = "Table7122055"; 
        }
        field(50081; "Service Price Version No._LDR"; Code[20])
        {
            Caption = 'Nº Versión Grupo Precio';
            DataClassification = ToBeClassified;
            //TableRelation = "Table7122009"."Field6" WHERE("Field1" = FIELD("Service Price Group Code")); 
        }
        field(50082; "Service Contract Period_LDR"; Text[50])
        {
            Caption = 'Período Contrato Servicio';
            DataClassification = ToBeClassified;
        }
        field(50083; "Concept No._LDR"; Code[20])
        {
            Caption = 'Nº Concepto';
            DataClassification = ToBeClassified;
            //TableRelation = "Table7122020"."Field1" WHERE("Field4" = CONST(1)); 
        }
        field(50084; "Charge Capacity_LDR"; Decimal)
        {
            Caption = 'Capacidad Carga (Kg)';
            DataClassification = ToBeClassified;
            Description = 'Indica la Capacidad de Carga de la Máquina en Kg';
        }
        field(50085; "Warranty Service Code_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Garantía';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";
        }
        field(50086; "Warranty No._LDR"; Code[20])
        {
            Caption = 'Nº Garantía';
            DataClassification = ToBeClassified;
        }
        field(50087; "Warranty_LDR"; Boolean)
        {
            Caption = 'Garantía';
            DataClassification = ToBeClassified;
            Description = 'Determina si es una Garantía';
        }
        field(50088; "Warranty Service Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Servicio';
            DataClassification = ToBeClassified;
        }
        field(50089; "Day Invoicing_LDR"; Boolean)
        {
            Caption = 'Facturar por Precio Día';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50090; "No of Days_LDR"; Integer)
        {
            Caption = 'Nº de Días';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50091; "Day Amount_LDR"; Decimal)
        {
            Caption = 'Precio Venta Día';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50092; Replicate_LDR; Boolean)
        {
            Caption = 'Replicar';
            DataClassification = ToBeClassified;
        }
        field(50093; "Replicate Company_LDR"; Text[30])
        {
            Caption = 'Empresa Réplica';
            DataClassification = ToBeClassified;
            TableRelation = "Company"."Name";
        }
        field(50094; "Replicate Service Item_LDR"; Code[20])
        {
            DataClassification = ToBeClassified;
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
        key(Key15; "Customer No.", "Type", "Document No.")
        {

        }
        key(Key16; "Contract Hours Entry No._LDR")
        {

        }
    }
}