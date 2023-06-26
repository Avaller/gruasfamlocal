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

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
                ResUnitofMeasure: Record "Resource Unit of Measure";
                WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
            begin

            end;
        }
        field(50051; "Crane Quote No._LDR"; Code[20])
        {
            Caption = 'Código Oferta Grúa';
            DataClassification = ToBeClassified;
            TableRelation = "Crane Service Quote Header_LDR"."Quote no.";
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
        field(50058; "Service Order Retained_LDR"; Boolean)
        {
            CalcFormula = Lookup("Service Header"."Retained_LDR" WHERE("No." = FIELD("Order No.")));
            Caption = 'Pedido Servicio Retenido';
            FieldClass = FlowField;
        }
        field(50059; "Purchase Receipt No._LDR"; Code[20])
        {
            Caption = 'Nº Albarán Compra';
            DataClassification = ToBeClassified;
            Description = 'Nº Albarán Compra';
        }
        field(50060; "Purchase Receipt Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Albarán Compra';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Albarán Compra';
        }
        field(50061; "Opened (Quote)_LDR"; Boolean)
        {
            Caption = 'Abierto';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50062; "Quote No._LDR"; Code[20])
        {
            Caption = 'Nº Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Oferta';
        }
        field(50063; "Quote Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Oferta';
        }
        field(50064; "Quote Invoice Line No_LDR"; Integer)
        {
            Caption = 'Nº Línea Factura Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Factura Oferta';
        }
        field(50065; "Item Entry No._LDR"; Integer)
        {
            Caption = 'Nº Movimiento Producto';
            DataClassification = ToBeClassified;
            Description = 'Nº Movimiento Producto';
        }
        field(50066; "Initial Time_LDR"; Time)
        {
            Caption = 'Hora Inicio';
            DataClassification = ToBeClassified;
            Description = 'Hora Inicio';
        }
        field(50067; "End Time_LDR"; Time)
        {
            Caption = 'Hora Fin';
            DataClassification = ToBeClassified;
            Description = 'Hora Fin';
        }
        field(50068; "Internal Quantity_LDR"; Decimal)
        {
            Caption = 'Cantidad Teórica';
            DataClassification = ToBeClassified;
            Description = 'Cantidad Teórica';
            Editable = false;
        }
        field(50069; "Service Order Description_LDR"; Text[50])
        {
            CalcFormula = Lookup("Service Shipment Header"."Description" WHERE("No." = FIELD("Document No.")));
            Caption = 'Descripción Pedido';
            Description = 'Descripción Pedido';
            FieldClass = FlowField;
        }
        field(50070; "Number of Hours_LDR"; Integer)
        {
            CalcFormula = Lookup("Service Shipment Item Line"."No of hours_LDR" WHERE("No." = FIELD("Document No."),
            "Line No." = FIELD("Service Item Line No.")));
            Caption = 'Nº Horas';
            Description = 'Nº Horas Máquina';
            FieldClass = FlowField;
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
        field(50080; "Service Price Version No._LDR"; Code[20])
        {
            Caption = 'Nº Versión Grupo Precio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Price_LDR"."Version No." WHERE("Service Price Group" = FIELD("Service Price Group Code"));
        }
        field(50081; "Service Contract Period_LDR"; Text[50])
        {
            Caption = 'Período Contrato Servicio';
            DataClassification = ToBeClassified;
        }
        field(50082; "Concept No._LDR"; Code[20])
        {
            Caption = 'Nº Concepto';
            DataClassification = ToBeClassified;
            TableRelation = Concept_LDR."No." WHERE("Type" = CONST("External"));
        }
        field(50083; "Charge Capacity_LDR"; Decimal)
        {
            Caption = 'Capacidad Carga (Kg)';
            DataClassification = ToBeClassified;
            Description = 'Indica la Capacidad de Carga de la Máquina en Kg';
        }
        field(50084; "Warranty Service Code_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Garantía';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";
        }
        field(50085; "Warranty No._LDR"; Code[20])
        {
            Caption = 'Nº Garantía';
            DataClassification = ToBeClassified;
        }
        field(50086; Warranty_LDR; Boolean)
        {
            Caption = 'Garantía';
            DataClassification = ToBeClassified;
            Description = 'Determina si es una Garantía';
        }
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