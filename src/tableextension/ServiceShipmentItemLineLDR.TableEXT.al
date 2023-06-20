/// <summary>
/// tableextension 50084 "Service Shipment Item Line_LDR"
/// </summary>
tableextension 50084 "Service Shipment Item Line_LDR" extends "Service Shipment Item Line"
{
    fields
    {
        field(50049; "Operation Code_LDR"; Code[20])
        {
            Caption = 'Código Operación';
            DataClassification = ToBeClassified;
        }
        field(50050; "Crane Service Quote No._LDR"; Code[20])
        {
            Caption = 'Código Oferta Servicio Grúa';
            DataClassification = ToBeClassified;
            //TableRelation = "Crane Service Quote Header"."Quote no." WHERE ("Historical"=CONST(false)); //TODO: Revisar si conservamos la tabla
        }
        field(50051; "Service Item Tariff No._LDR"; Code[20])
        {
            Caption = 'Código Tarifa Producto Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Rate Header"; //TODO: Revisar si conservamos la tabla
        }
        field(50054; "Requested Starting Date_LDR"; Date)
        {
            Caption = 'Fecha Inicio Solicitada';
            DataClassification = ToBeClassified;
        }
        field(50055; "Requested Starting Time_LDR"; Time)
        {
            Caption = 'Hora Inicio Solicitada';
            DataClassification = ToBeClassified;
        }
        field(50056; "Requested Ending Date_LDR"; Date)
        {
            Caption = 'Fecha Final Solicitada';
            DataClassification = ToBeClassified;
        }
        field(50057; "Requested Ending Time_LDR"; Time)
        {
            Caption = 'Hora Final Solicitada';
            DataClassification = ToBeClassified;
        }
        field(50058; "Service Inv. Group No._LDR"; Code[10])
        {
            Caption = 'Código Grupo Facturación';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Invoice Group"; //TODO: Revisar si conservamos la tabla
        }
        field(50059; "Crane Serv. Quote Op. Line No_LDR"; Integer)
        {
            Caption = 'Nº Línea Opción Oferta Servicio Grúa';
            DataClassification = ToBeClassified;
        }
        field(50065; "Service Inv. Group Description_LDR"; Text[50]) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Lookup("Service Item Invoice Group"."Description" WHERE ("Code"=FIELD("Service Inv. Group No."))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Descripción Grupo Facturación';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50069; "Old Worksheet No._LDR"; Code[20])
        {
            Caption = 'Nº Parte Antiguo';
            DataClassification = ToBeClassified;
        }
        field(50070; "Service Task Code_LDR"; Code[20])
        {
            Caption = 'Código Tarea Servicio';
            DataClassification = ToBeClassified;
            Description = 'Permite Almacenar la Tarea a Realizar';
        }
        field(50071; nonfacturable_LDR; BoolEAN)
        {
            Caption = 'Nº Facturable';
            DataClassification = ToBeClassified;
            Description = 'Indica si se Aplica 100% Descuento a la Hoja de Trabajo';
        }
        field(50072; "No of hours_LDR"; Integer)
        {
            Caption = 'Nº de Horas';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas de la Máquina';
        }
        field(50073; "Quote No._LDR"; Code[20])
        {
            Caption = 'Nº Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Oferta';
            Editable = false;
        }
        field(50074; "Quote Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Oferta';
            Editable = false;
        }
        field(50075; "Warranty Generated_LDR"; BoolEAN)
        {
            Caption = 'Garantía Tramitada';
            DataClassification = ToBeClassified;
            Description = 'Garantía Tramitada';
            Editable = false;
        }
        field(50076; "Warranty No._LDR"; Code[20])
        {
            Caption = 'Nº Garantía';
            DataClassification = ToBeClassified;
            Description = 'Nº Garantía';
            Editable = false;
        }
        field(50077; "Source Type_LDR"; Option)
        {
            Caption = 'Tipo Origen';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Transfer';
            OptionMembers = Transfer;
        }
        field(50078; "Service Order Description_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text
        {
            CalcFormula = Lookup("Service Shipment Header"."Description" WHERE("No." = FIELD("No.")));
            Caption = 'Descripción Pedido';
            Editable = false;
            Description = 'Descripción del PS';
            FieldClass = FlowField;
        }
        field(50079; "Service Order Shortcut Dim 1_LDR"; Code[20])
        {
            CalcFormula = Lookup("Service Shipment Header"."Shortcut Dimension 1 Code" WHERE("No." = FIELD("No.")));
            Caption = 'Código Dimensión Acceso Directo 1';
            CaptionClass = '1,2,1';
            Description = 'Código Dimensión Acceso Directo 1';
            FieldClass = FlowField;
        }
        field(50080; "Service Order Shortcut Dim 2_LDR"; Code[20])
        {
            CalcFormula = Lookup("Service Shipment Header"."Shortcut Dimension 2 Code" WHERE("No." = FIELD("No.")));
            Caption = 'Código Dimensión Acceso Directo 2';
            Editable = false;
            CaptionClass = '1,2,2';
            Description = 'Código Dimensión Acceso Directo 2';
            FieldClass = FlowField;
        }
        field(50081; "Existe Dto._LDR"; BoolEAN)
        {
            CalcFormula = Exist("Service Shipment Line" WHERE("Document No." = FIELD("No."),
            "Service Item Line No." = FIELD("Line No."), "Line Discount %" = FILTER(<> 0)));
            Caption = 'Existe Descuento';
            Description = 'Existe Descuento en la Hoja de Trabajo';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50082; "Warranty in effect_LDR"; BoolEAN)
        {
            Caption = 'Garantía en Vigor Fabricante';
            DataClassification = ToBeClassified;
            Description = 'Garantía en Vigor Fabricante';
            Editable = false;
        }
        field(50083; "Manuf. Warranty Initial Date_LDR"; Date)
        {
            Caption = 'Fecha Inicial Garantía Fabricante';
            DataClassification = ToBeClassified;
            Description = 'Fecha Inicial Garantía Fabricante';
            Editable = false;
        }
        field(50084; "Manuf. Warranty End Date_LDR"; Date)
        {
            Caption = 'Fecha Final Garantía Fabricante';
            DataClassification = ToBeClassified;
            Description = 'Fecha Final Garantía Fabricante';
            Editable = false;
        }
        field(50085; "Manuf. Warranty Type_LDR"; Option)
        {
            Caption = 'Tipo Garantía Fabricante';
            Description = 'Tipo Garantía Fabricante';
            DataClassification = ToBeClassified;
            OptionCaption = 'Garantía,Petición de Acuerdo';
            OptionMembers = "Warranty","According request";
        }
        field(50086; "Serive Order Type_LDR"; Code[10])
        {
            CalcFormula = Lookup("Service Shipment Header"."Service Order Type" WHERE("No." = FIELD("No.")));
            Caption = 'Tipo Pedido Servicio';
            Description = 'Tipo Pedido Servicio';
            FieldClass = FlowField;
        }
        field(50087; "Reval Service Item_LDR"; BoolEAN)
        {
            Caption = 'Revalorizar Máquina';
            DataClassification = ToBeClassified;
        }
        field(50088; "Service Zone Code_LDR"; Code[10])
        {
            CalcFormula = Lookup("Service Shipment Header"."Service Zone Code" WHERE("No." = FIELD("No.")));
            Caption = 'Código Zona Servicio';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50089; "No of Active Service Orders_LDR"; Integer)
        {
            CalcFormula = Count("Service Item Line" WHERE("Service Item No." = FIELD("Service Item No.")));
            Caption = 'Nº Pedidos Activos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50090; "Service Order Date_LDR"; Date)
        {
            CalcFormula = Lookup("Service Shipment Header"."Order Date" WHERE("No." = FIELD("No.")));
            Caption = 'Fecha Pedido';
            Description = 'Fecha Pedido';
            FieldClass = FlowField;
        }
        field(50091; "Actual Location Cust No._LDR"; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Customer No." WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Nº Cliente Ubicación Actual';
            FieldClass = FlowField;
        }
        field(50092; "Actual Location Ship to Code_LDR"; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Ship-to Code" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Código Dirección Envío Ubicación Actual';
            FieldClass = FlowField;
        }
        field(50093; "Default Invoice Lines Created_LDR"; BoolEAN)
        {
            DataClassification = ToBeClassified;
        }
    }
}