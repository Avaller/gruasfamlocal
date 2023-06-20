/// <summary>
/// tableextension 50095 "Service Cue_LDR"
/// </summary>
tableextension 50095 "Service Cue_LDR" extends "Service Cue"
{
    fields
    {
        field(50000; "WorkDate Filter_LDR"; Date)
        {
            Caption = 'Filtro Fecha Trabajo';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50001; "Service Orders - to Plan_LDR"; Integer) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Count("Service Item Line" WHERE ("Requested Starting Date"=FIELD("WorkDate Filter"),"Service Item No."=FILTER(''),"Repair Status Code"=FIELD("Repair Status Filter"),"Role Center Filter"=CONST(true),"Repair Status Code"=CONST(INICIAL))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Pedidos Servicio - Pendientes de Planificar';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Repair Status Filter_LDR"; Code[20])
        {
            Caption = 'Filtro de Código Estado Reparación';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50003; "Service Orders - Resurce Pend._LDR"; Integer)
        {
            CalcFormula = Count("Service Item Line" WHERE("Requested Starting Date_LDR" = FIELD("WorkDate Filter_LDR"),
            "Service Item No." = FILTER(<> ''), "Repair Status Code" = FIELD("Repair Status Filter_LDR"),
            "Role Center Filter_LDR" = CONST(true)));
            Caption = 'Pedidos Servicio - Pendientes de Recurso';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Service Orders - Not sended_LDR"; Integer)
        {
            CalcFormula = Count("Service Item Line" WHERE("Requested Starting Date_LDR" = FIELD("WorkDate Filter_LDR"),
            "Sent to Device_LDR" = CONST(false), "Role Center Filter_LDR" = CONST(true)));
            Caption = 'Pedidos Servicio - No Comunicados';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Blocked Service Item_LDR"; Integer) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Count("Service Item" WHERE("Maintenance Block" = CONST(true), "Starting Date Filter" = FIELD("Starting Date Filter"), "Ending Date Filter" = FIELD("Ending Date Filter"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Productos de Servicio Bloqueados';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Service Orders - in Process 2_LDR"; Integer)
        {
            CalcFormula = Count("Service Header" WHERE("Document Type" = FILTER("Order"),
            "Status" = FILTER("In Process"), "Responsibility Center" = FIELD("Responsibility Center Filter"),
            "Role Center Filter 2_LDR" = CONST(true)));
            Caption = 'Pedidos Servicio - En Proceso';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Service Orders - Finished 2_LDR"; Integer) //TODO: Revisar warning del atributo CalcFormula del field
        {
            CalcFormula = Count("Service Header" WHERE("Document Type" = FILTER("Order"), "Status" = FILTER("Finished"),
            "Responsibility Center" = FIELD("Responsibility Center Filter"), "Role Center Filter 2_LDR" = CONST(true)));
            Caption = 'Pedidos Servicio - Finalizados';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Crane Quote - Open_LDR"; Integer) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Count("Crane Service Quote Header" WHERE("Historical" = CONST(false), "Quote Status" = CONST("Open"), "Platform Quote" = CONST(false))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Ofertas Grúa - Abiertas';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Crane Quote - Expired_LDR"; Integer) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Count("Crane Service Quote Header" WHERE("Historical" = CONST(false), "Ending Date" = FIELD("Date Filter"), "Platform Quote" = CONST(false))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Ofertas Grúa - Vencidas';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Ceded Service Items_LDR"; Integer) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Count("Service Item" WHERE("Owner Customer No." = FIELD("Customer No. Filter"), "Explotation Customer No." = FIELD("Customer No. Filter 2"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Productos de Servicio Cedidos';
            FieldClass = FlowField;
        }
        field(50011; "Customer No. Filter_LDR"; Code[10])
        {
            Caption = 'Filtro Nº Cliente';
            FieldClass = FlowFilter;
        }
        field(50012; "Customer No. Filter 2_LDR"; Code[10])
        {
            Caption = 'Filtro Nº Cliente 2';
            FieldClass = FlowFilter;
        }
        field(50013; "Retained Service Orders_LDR"; Integer)
        {
            CalcFormula = Count("Service Header" WHERE("Document Type" = FILTER("Order"), "Status" = FILTER("Finished"),
            "Responsibility Center" = FIELD("Responsibility Center Filter"), "Role Center Filter_LDR" = CONST(true),
            "Retained_LDR" = CONST(true)));
            Caption = 'Pedidos Servicio - Retenidos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50014; "Platform Quote - Open_LDR"; Integer) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Count("Crane Service Quote Header" WHERE ("Historical"=CONST(false),"Quote Status"=CONST("Open"),"Platform Quote"=CONST(true))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Ofertas Platform - Abiertas';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "Platform Quote - Expired_LDR"; Integer) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Count("Crane Service Quote Header" WHERE("Historical" = CONST(false), "Ending Date" = FIELD("Date Filter"), "Platform Quote" = CONST(true))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Ofertas Platform - Vencidas';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50028; "Starting Date Filter_LDR"; Date)
        {
            Caption = 'Filtro Fecha Inicio';
            FieldClass = FlowFilter;
        }
        field(50029; "Ending Date Filter_LDR"; Date)
        {
            Caption = 'Filtro Fecha Fin';
            FieldClass = FlowFilter;
        }
        field(7121996; "Open Service Contracts_LDR"; Integer)
        {
            CalcFormula = Count("Service Contract Header" WHERE("Contract Type" = CONST("Contract"),
            "Status" = CONST("Signed"), "Change Status" = CONST("Open"), Historical_LDR = CONST(false)));
            Caption = 'Contrato Servicio Abiertos';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}