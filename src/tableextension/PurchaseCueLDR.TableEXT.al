/// <summary>
/// tableextension 50096 "Purchase Cue_LDR"
/// </summary>
tableextension 50096 "Purchase Cue_LDR" extends "Purchase Cue"
{
    fields
    {
        field(7121993; "Transfer Orders Upcoming_LDR"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Completely Shipped" = CONST(false)));
            Caption = 'Próximos Pedidos Transferencia';
            Description = 'Pedido Transferencia cuando Enviado Completamente = NO';
            FieldClass = FlowField;
        }
        field(7121994; "Transfer Orders Shipped_LDR"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Status" = CONST("Released"),
            "Completely Shipped" = CONST(true), "Completely Received" = CONST(false)));
            Caption = 'Pedido Transferencia Enviados No Recibidos';
            Description = 'Pedido Transferencia cuando Estado = Lanzado, Enviado Completamente = SI y Recibido Completamente = NO';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7121995; "Transfer Orders Received_LDR"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Completely Received" = CONST(true)));
            Caption = 'Pedido Transferencia Recibidos';
            Description = 'Pedido Transferencia cuando Estado = Lanzado, Enviado Completamente = SI y Recibido Completamente = SI';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7121996; "Sales Quotes - Open_LDR"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Quote"), "Status" = FILTER("Open"),
            "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Ofertas Venta - Abiertas';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7121997; "Sales Orders - Open_LDR"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Order"), "Status" = FILTER("Open"),
            "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Pedidos Venta - Abiertos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7121998; "Ready to Ship_LDR"; Integer) //TODO: Revisar warning del atributo CalcFormula del field
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            //CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Order"), "Status" = FILTER("Released"), "Completely Shipped" = CONST(false), "Shipment Date" = FIELD("Date Filter2"), "Responsibility Center" = FIELD("Responsibility Center Filter"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Listos para Enviar';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7121999; Delayed_LDR; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Order"), "Status" = FILTER("Released"),
            "Completely Shipped" = CONST(false), "Shipment Date" = FIELD("Date Filter"),
            "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Retrasados';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7122000; "Date Filter2_LDR"; Date)
        {
            Caption = 'Filtro Fecha 2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(7122001; "Partially Shipped_LDR"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Order"), "Status" = FILTER("Released"),
            "Ship" = FILTER(true), "Completely Shipped" = FILTER(false), "Shipment Date" = FIELD("Date Filter2_LDR"),
            "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Enviados Parcialmente';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}