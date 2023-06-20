/// <summary>
/// tableextension 50077 "Service Contract Line_LDR"
/// </summary>
tableextension 50077 "Service Contract Line_LDR" extends "Service Contract Line"
{
    fields
    {
        field(50000; "Dimension Set ID_LDR"; Integer)
        {
            Caption = 'ID Grupo Dimensiones';
            DataClassification = ToBeClassified;
            Description = 'UPG2016';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(50001; "Service Item Tariff No._LDR"; Code[20])
        {
            Caption = 'Código Tarifa Producto Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Rate Line - Platf"."Code" WHERE("Invoice Group No." = FIELD("Serv. Item Invoice Group Code")); //TODO: Revisar si conservamos la tabla
        }
        field(50002; "Serv. Item Invoice Group Code_LDR"; Code[10])
        {
            Caption = 'Código Grupo Facturación Producto Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Invoice Group"."Code" WHERE("Group Type" = CONST("Platform")); //TODO: Revisar si conservamos la tabla
        }
        field(50003; "Serv. Item Invoice Group Desc_LDR"; Text[50]) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Lookup("Service Item Invoice Group"."Description" WHERE("Code" = FIELD("Serv. Item Invoice Group Code"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Descripción Grupo Facturación Producto Servicio';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50004; "Deliver/Pickup Price_LDR"; Decimal)
        {
            Caption = 'Precio Entrega/Recogida';
            DataClassification = ToBeClassified;
        }
        field(50005; "Use Saturdays_LDR"; BoolEAN)
        {
            Caption = 'Utilizar Sábados';
            DataClassification = ToBeClassified;
        }
        field(50006; "Use Sundays_LDR"; BoolEAN)
        {
            Caption = 'Utilizar Domingos';
            DataClassification = ToBeClassified;
        }
        field(50007; "Service Quote no._LDR"; Code[20])
        {
            Caption = 'Código Oferta';
            DataClassification = ToBeClassified;
            //TableRelation = "Crane Service Quote Header"."Quote no." WHERE("Platform Quote" = CONST(true)); //TODO: Revisar si conservamos la tabla
        }
        field(50008; "Serv. Item Planner No_LDR"; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Planner No_LDR" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Nº Planificador';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50009; "No of Days_LDR"; Integer) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Count("Service Contract Planning" WHERE("Source Table" = CONST(5964), "Contract Type" = FIELD("Contract Type"), "Contract No." = FIELD("Contract No."), "Line No." = FIELD("Line No."), "Service Item No." = FIELD("Service Item No."))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Nº de días';
            Description = 'Campo Calculado con el Nº Días Planificados';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50010; "Month Amount_LDR"; Decimal)
        {
            Caption = 'Importe Mensual';
            DataClassification = ToBeClassified;
            Description = 'Permite Introducir un Importe Mensual a Facturar';
        }
        field(50011; "Day Amount_LDR"; Decimal)
        {
            Caption = 'Precio Venta Día';
            DataClassification = ToBeClassified;
            Description = 'Permite Introducir un Importe Diario a Facturar';
        }
        field(50012; "Day Unit Cost_LDR"; Decimal)
        {
            Caption = 'Coste Unitario Día';
            DataClassification = ToBeClassified;
            Description = 'Permite Introducir un Importe Coste Diario';
        }
        field(50013; "Exit No. of Hours_LDR"; Integer)
        {
            Caption = 'Nº Horas Salida';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas Salida';
        }
        field(50014; "Total No. of Hours_LDR"; Integer)
        {
            Caption = 'Nº Horas Totales';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas Totales';
        }
        field(50015; "Tires Change Hours_LDR"; Integer)
        {
            Caption = 'Horas Cambio Rueda';
            DataClassification = ToBeClassified;
            Description = 'Horas Cambio Rueda';
        }
        field(50016; "Shortcut Dimension 1 Code_LDR"; Code[20])
        {
            Caption = 'Código Dimensión Acceso Directo 1';
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            Description = 'Código Dimensión Acceso Directo 1';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(50017; "Shortcut Dimension 2 Code_LDR"; Code[20])
        {
            Caption = 'Código Dimensión Acceso Directo 2';
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            Description = 'Código Dimensión Acceso Directo 2';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));
        }
        field(50018; "Revisions number contracted_LDR"; Integer)
        {
            Caption = 'Nº Revisiones Contratadas';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(50019; "Service Template No._LDR"; Code[20])
        {
            Caption = 'Nº Plantilla Servicios';
            DataClassification = ToBeClassified;
            //TableRelation = Table70002; //TODO: Revisar si conservamos la tabla
        }
        field(50020; "Hired No. Of Hours_LDR"; Integer)
        {
            Caption = 'Nº Horas Contratadas';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas Contratadas';
            Editable = false;
        }
        field(50021; "Delivery Planified_LDR"; BoolEAN)
        {
            Caption = 'Entrega Planificada';
            DataClassification = ToBeClassified;
        }
        field(50022; "Collection Planified_LDR"; BoolEAN)
        {
            Caption = 'Recogida Planificada';
            DataClassification = ToBeClassified;
        }
        field(50023; "Delivery Realiced_LDR"; BoolEAN)
        {
            Caption = 'Entrega Realizada';
            DataClassification = ToBeClassified;
        }
        field(50024; "Collection Realiced_LDR"; BoolEAN)
        {
            Caption = 'Recogida Realizada';
            DataClassification = ToBeClassified;
        }
        field(50025; "Total No. of Hours Calc._LDR"; Decimal)
        {
            Caption = 'Nº Horas Totales';
            DataClassification = ToBeClassified;
            Description = 'Utilizado para Poder Meter Fórmulas al Calcular Nº de Horas Totales. Se Copia su Contenido en Nº Horas Totales.';
        }
        field(50026; "Service Price Group Code_LDR"; Code[10])
        {
            Caption = 'Código Grupo Precio Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Price Group";
        }
        field(50027; "Service Price Version No._LDR"; Code[20])
        {
            Caption = 'Nº Versión Grupo Precio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Price"."Version No." WHERE("Service Price Group" = FIELD("Service Price Group Code")); //TODO: Revisar si conservamos la tabla
        }
        field(50028; Grouper_LDR; Text[20])
        {
            Caption = 'Agrupador';
            DataClassification = ToBeClassified;
        }
        field(50029; "Service item Model_LDR"; Text[50])
        {
            Caption = 'Modelo';
            DataClassification = ToBeClassified;
            Description = 'Modelo';
        }
        field(50030; "Charge Capacity_LDR"; Decimal)
        {
            Caption = 'Capacidad Carga (Kg)';
            DataClassification = ToBeClassified;
            Description = 'Indica la Capacidad de Carga de la Máquina en Kg';
        }
        field(50031; "Hours Period Review_LDR"; Option)
        {
            Caption = 'Revisión Horas Período';
            DataClassification = ToBeClassified;
            InitValue = "Year";
            OptionCaption = 'Mes,Dos Meses,Trimestre,Medio Año,Año,Ninguno';
            OptionMembers = "Month","Two Months","Quarter","Half Year","Year","None";
        }
        field(50032; "Contracted Hours_LDR"; Decimal) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Sum("Serv. Contract Line Hours"."Contracted hours" WHERE("Type" = CONST(External), "Contract Type" = FIELD("Contract Type"), "Contract No." = FIELD("Contract No."), "Contract Line No." = FIELD("Line No."))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Nº Horas Contratadas';
            DecimalPlaces = 0 : 0;
            Description = 'Nº Horas Contratadas';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50033; "Calculate Maint. Type_LDR"; Option)
        {
            Caption = 'Tipo Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Tipo de Cálculo que se utilizará para Sacar las Horas/Día de una Máquina';
            NotBlank = true;
            OptionCaption = 'Según Configuración,Según Contrato,Por Período,Por Nº Pedidos';
            OptionMembers = "Según configuración","Según Contrato","Por Período","Por Nº Pedidos";
        }
        field(50034; "Calculate Maint. Type Period_LDR"; DateFormula)
        {
            Caption = 'Período Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Período que se utilizará para el Cálculo de Horas/Día de una Máquina por Período';
        }
        field(50035; "Calculate Maint. Type Order_LDR"; Integer)
        {
            Caption = 'Nº Pedidos Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Número de Pedidos que se utilizarán para el Cálculo de Horas/Día de una Máquina por Pedidos Servicio';
            MinValue = 0;
            NotBlank = true;
        }
        field(50036; Historical_LDR; BoolEAN)
        {
            Caption = 'Histórico';
            DataClassification = ToBeClassified;
        }
        field(50037; Replicate_LDR; BoolEAN)
        {
            Caption = 'Replicar';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50038; "Explotation Customer No._LDR"; Code[20])
        {
            Caption = 'Nº Cliente Explotación';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Customer"."No.";
        }
    }
}