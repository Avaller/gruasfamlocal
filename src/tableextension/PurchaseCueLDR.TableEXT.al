/// <summary>
/// tableextension 50096 "Purchase Cue_LDR"
/// </summary>
tableextension 50096 "Purchase Cue_LDR" extends "Purchase Cue"
{
    fields
    {
        field(50000; "Transfer Orders Upcoming_LDR"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Completely Shipped" = CONST(false)));
            Caption = 'Próximos Pedidos Transferencia';
            Description = 'Pedido Transferencia cuando Enviado Completamente = NO';
            FieldClass = FlowField;
        }
        field(50001; "Transfer Orders Shipped_LDR"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Status" = CONST("Released"),
            "Completely Shipped" = CONST(true), "Completely Received" = CONST(false)));
            Caption = 'Pedido Transferencia Enviados No Recibidos';
            Description = 'Pedido Transferencia cuando Estado = Lanzado, Enviado Completamente = SI y Recibido Completamente = NO';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Transfer Orders Received_LDR"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Completely Received" = CONST(true)));
            Caption = 'Pedido Transferencia Recibidos';
            Description = 'Pedido Transferencia cuando Estado = Lanzado, Enviado Completamente = SI y Recibido Completamente = SI';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Sales Quotes - Open_LDR"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Quote"), "Status" = FILTER("Open"),
            "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Ofertas Venta - Abiertas';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Sales Orders - Open_LDR"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Order"), "Status" = FILTER("Open"),
            "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Pedidos Venta - Abiertos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Ready to Ship_LDR"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Order"), "Status" = FILTER("Released"), "Completely Shipped" = CONST(false), "Shipment Date" = FIELD("Date Filter2_LDR"), "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Listos para Enviar';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; Delayed_LDR; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Order"), "Status" = FILTER("Released"),
            "Completely Shipped" = CONST(false), "Shipment Date" = FIELD("Date Filter"),
            "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Retrasados';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Date Filter2_LDR"; Date)
        {
            Caption = 'Filtro Fecha 2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50008; "Partially Shipped_LDR"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Order"), "Status" = FILTER("Released"),
            "Ship" = FILTER(true), "Completely Shipped" = FILTER(false), "Shipment Date" = FIELD("Date Filter2_LDR"),
            "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Enviados Parcialmente';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "LDR_To Send or Confirm_LDR"; Integer)
        {
            Description = 'Pedido Compra cuando Estado = Abierto';
        }
        field(50010; "LDR_Upcoming Orders_LDR"; Integer)
        {
            Description = 'Pedido Compra cuando Estado = Lanzado y Fecha Recepción = Filtro Fecha';
        }
        field(50011; "LDR_Outstanding Purchase Orders_LDR"; Integer)
        {
            Description = 'Pedido Compra cuando Estado = Lanzado, Recibido Completamente = NO y Fecha Recepción = Filtro Fecha';
        }
        field(50012; "LDR_Purchase Return Orders - All_LDR"; Integer)
        {
            Description = 'Devolución Compra';
        }
        field(50013; "LDR_Not Invoiced_LDR"; Integer)
        {
            Description = 'Pedido Compra cuando Recibido Completamente = SI, Facturado = NO';
        }
        field(50014; "LDR_Partially Invoiced_LDR"; Integer)
        {
            Description = 'Pedido Compra cuando Recibido Completamente = SI, Facturado = SI';
        }
    }

    procedure CalculateAverageDaysDelayed() AverageDays: Decimal;
    var
        SalesHeader: Record "Sales Header";
        SumDelayDays: Integer;
        CountDelayedInvoices: Integer;
    begin
        FilterSalesOrders(SalesHeader, FieldNo(Delayed_LDR));
        if SalesHeader.FindSet() then begin
            repeat
                SumDelayDays += WorkDate - SalesHeader."Shipment Date";
                CountDelayedInvoices += 1;
            until SalesHeader.Next() = 0;
            AverageDays := SumDelayDays / CountDelayedInvoices;
        end;
    end;

    procedure CountSalesOrders(FieldNumber: Integer): Integer;
    var
        CountSalesOrdersQuery: Query "Count Sales Orders";
        SalesOrderWithBlankShipmentDateCount: Integer;
    begin
        CountSalesOrdersQuery.SetRange(Status, CountSalesOrdersQuery.Status::Released);
        CountSalesOrdersQuery.SetRange(Completely_Shipped, false);
        FilterGroup(2);
        CountSalesOrdersQuery.SetFilter(Responsibility_Center, GetFilter("Responsibility Center Filter"));
        FilterGroup(0);

        case FieldNumber of
            FieldNo("Ready to Ship_LDR"):
                begin
                    CountSalesOrdersQuery.SetRange(Ship);
                    CountSalesOrdersQuery.SetFilter(Shipment_Date, GetFilter("Date Filter2_LDR"));
                end;
            FieldNo("Partially Shipped_LDR"):
                begin
                    CountSalesOrdersQuery.SetRange(Ship, true);
                    CountSalesOrdersQuery.SetFilter(Shipment_Date, GetFilter("Date Filter2_LDR"));
                end;
            FieldNo(Delayed_LDR):
                begin
                    CountSalesOrdersQuery.SetRange(Ship);
                    CountSalesOrdersQuery.SetRange(Shipment_Date, 0D);
                    CountSalesOrdersQuery.Open();
                    CountSalesOrdersQuery.Read();
                    SalesOrderWithBlankShipmentDateCount := CountSalesOrdersQuery.Count_Orders;
                    CountSalesOrdersQuery.SetFilter(Shipment_Date, GetFilter("Date Filter"));
                end;
        end;
        CountSalesOrdersQuery.Open();
        CountSalesOrdersQuery.Read();
        exit(CountSalesOrdersQuery.Count_Orders - SalesOrderWithBlankShipmentDateCount);
    end;

    local procedure FilterSalesOrders(var SalesHeader: Record "Sales Header"; FieldNumber: Integer);
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange(Status, SalesHeader.Status::Released);
        SalesHeader.SetRange("Completely Shipped", false);

        case FieldNumber of
            FieldNo("Ready to Ship_LDR"):
                begin
                    SalesHeader.SetRange(Ship);
                    SalesHeader.SetFilter("Shipment Date", GetFilter("Date Filter2_LDR"));
                end;
            FieldNo("Partially Shipped_LDR"):
                begin
                    SalesHeader.SetRange(Ship, true);
                    SalesHeader.SetFilter("Shipment Date", GetFilter("Date Filter2_LDR"));
                end;
            FieldNo(Delayed_LDR):
                begin
                    SalesHeader.SetRange(Ship);
                    SalesHeader.SetFilter("Shipment Date", GetFilter("Date Filter"));
                    SalesHeader.FilterGroup(2);
                    SalesHeader.SetFilter("Shipment Date", '<>%1', 0D);
                    SalesHeader.FilterGroup(0);
                end;
        end;
        FilterGroup(2);
        SalesHeader.SetFilter("Responsibility Center", GetFilter("Responsibility Center Filter"));
        FilterGroup(0);
    end;

    procedure ShowSalesOrders(FieldNumber: Integer);
    var
        SalesHeader: Record "Sales Header";
    begin
        FilterSalesOrders(SalesHeader, FieldNumber);
        Page.Run(Page::"Sales Order List", SalesHeader);
    end;
}