/// <summary>
/// tableextension 50061 "Stockkeeping Unit_LDR"
/// </summary>
tableextension 50061 "Stockkeeping Unit_LDR" extends "Stockkeeping Unit"
{
    fields
    {
        field(50000; "New Maximum Inventory_LDR"; Decimal)
        {
            Caption = 'Stock Máximo (Calculado)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Maximun difference_LDR" := "New Maximum Inventory_LDR" - "Maximum Inventory";
            end;
        }
        field(50001; "New Safety Stock Quantity_LDR"; Decimal)
        {
            Caption = 'Stock de Seguridad (Calculado)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                "Minimun difference_LDR" := "New Safety Stock Quantity_LDR" - "Safety Stock Quantity";
            end;
        }
        field(50002; "Maximun difference_LDR"; Decimal)
        {
            Caption = 'Diferencia (Máximos)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Minimun difference_LDR"; Decimal)
        {
            Caption = 'Diferencia (Mínimos)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Apply change_LDR"; BoolEAN)
        {
            Caption = 'Aplicar Cambios';
            DataClassification = ToBeClassified;
        }
        field(50005; "Main Location Code_LDR"; Code[20])
        {
            CalcFormula = Lookup("Location"."Main Location Code_LDR" WHERE("Code" = FIELD("Location Code")));
            Caption = 'Código Almacén Principal';
            FieldClass = FlowField;
        }
        field(50006; "Main Location Inventory_LDR"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Quantity" WHERE("Item No." = FIELD("Item No."),
            "Location Code" = FIELD("Main Location Code_LDR"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
            "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
            "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Code")));
            Caption = 'Existencias Almacén PPal.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Total Inventory_LDR"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Quantity" WHERE("Item No." = FIELD("Item No."),
            "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
            "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
            "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Code")));
            Caption = 'Existencias Totales';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Out. Qty. on Purch. Order_LDR"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE
            ("Document Type" = CONST("Order"), "Type" = CONST("Item"), "No." = FIELD("Item No."), "Demand Location Code_LDR" = FIELD("Location Code"),
            "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
            "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Code"), "Expected Receipt Date" = FIELD("Date Filter")));
            Caption = 'Cdad. Pdte. Pedidos Compra';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Armopa Consuption_LDR"; Decimal)
        {
            CalcFormula = - Sum("Item Ledger Entry"."Quantity" WHERE("Item No." = FIELD("Item No."), "Entry Type" = CONST("Sale"),
            "Variant Code" = FIELD("Variant Code"), "Location Code" = FIELD("Location Code"), "Posting Date" = FIELD("Armopa Date Filter_LDR")));
            Caption = 'Consumo Armopa';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Armopa Date Filter_LDR"; Date)
        {
            Caption = 'Filtro fecha Armopa';
            FieldClass = FlowFilter;
        }
        field(50011; "Armopa Qty. to Order_LDR"; Decimal)
        {
            Caption = 'Armopa - Cantidad a Pedir';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                CalcFields("Main Location Inventory_LDR");

                if "Armopa Qty. to Order_LDR" > "Main Location Inventory_LDR" then
                    Error(StrSubstNo(Text50001, "Item No.", "Location Code"));
            end;
        }
        field(50012; "Armopa Generate_LDR"; BoolEAN)
        {
            Caption = 'Armopa - Generar';
            DataClassification = ToBeClassified;
        }
        field(50013; "Sales Exist_LDR"; BoolEAN)
        {
            CalcFormula = Exist("Item Ledger Entry" WHERE("Entry Type" = CONST("Sale"), "Item No." = FIELD("Item No."),
            "Variant Code" = FIELD("Variant Code"), "Location Code" = FIELD("Location Code"), "Posting Date" = FIELD("Armopa Date Filter_LDR")));
            Caption = 'Existen Ventas';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50014; "Exclude armopa_LDR"; BoolEAN)
        {
            Caption = 'Excluir Armopa';
            DataClassification = ToBeClassified;
        }
        field(50015; "Unified Armopa Consuption_LDR"; Decimal)
        {
            Caption = 'Consumo Armopa';
            DataClassification = ToBeClassified;
        }
        field(50016; "Unif. Armpa Qty. to Order_LDR"; Decimal)
        {
            Caption = 'Cantidad a Pedir';
            DataClassification = ToBeClassified;
        }
        field(50017; "Unif. Armopa Vendor No._LDR"; Code[20])
        {
            Caption = 'Nº Proveedor';
            DataClassification = ToBeClassified;
            TableRelation = "Vendor";

            trigger OnValidate()
            begin
                Vendor.Get("Unif. Armopa Vendor No._LDR");

                "Unif. Armopa Vendor Name_LDR" := Vendor.Name;
            end;
        }
        field(50018; "Unif Armopa Generate Purch._LDR"; BoolEAN)
        {
            Caption = 'Generar Compra';
            DataClassification = ToBeClassified;
        }
        field(50019; "Unif. Armopa Vendor Name_LDR"; Text[50])
        {
            Caption = 'Nombre Proveedor';
            DataClassification = ToBeClassified;
            FieldClass = Normal;
        }
        field(50020; "Qty. on Service Order All_LDR"; Decimal)
        {
            CalcFormula = Sum("Service Line"."Outstanding Qty. (Base)" WHERE
            ("Document Type" = CONST("Order"), "Type" = CONST("Item"), "No." = FIELD("Item No."), "Variant Code" = FIELD("Variant Code"),
            "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Cantidad en Pedido Servicio en Todos Almacenes';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "Qty. on Transfer Order_LDR"; Decimal)
        {
            CalcFormula = Sum("Transfer Line"."Outstanding Qty. (Base)" WHERE("Item No." = FIELD("Item No."),
            "Transfer-from Code" = FIELD("Location Code"), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
            "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Shipment Date" = FIELD("Date Filter")));
            Caption = 'Cantidad en Pedido Transferencia';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            Editable = false;
        }
        field(50022; "Armopa Real Qty. to Order_LDR"; Decimal)
        {
            Caption = 'Armopa - Cantidad a Pedir Real';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                CalcFields("Main Location Inventory_LDR");

                if "Armopa Qty. to Order_LDR" > "Main Location Inventory_LDR" then
                    Error(StrSubstNo(Text50001, "Item No.", "Location Code"));
            end;
        }
    }

    var
        Text50001: TextConst ENU = 'Qty. to Order can not be upper to Main Location Inventory for Item No. %1 Location Code %2', ESP = 'Cantidad a Pedir no puede ser superior a Stock en Almacén Principal para Producto %1 Almacén %2';
        Vendor: Record "Vendor";

    procedure CalcQtyToOrder();
    var
        cantidadTeorica: Decimal;
    begin
        CalcFields(Inventory, "Main Location Code_LDR",
                   "Main Location Inventory_LDR", "Out. Qty. on Purch. Order_LDR", "Qty. on Service Order", "Qty. on Sales Order",
                   "Qty. in Transit", "Trans. Ord. Receipt (Qty.)");

        cantidadTeorica := Inventory +
                           "Out. Qty. on Purch. Order_LDR" +
                           "Trans. Ord. Receipt (Qty.)" +
                           "Qty. in Transit" -
                           "Qty. on Sales Order" -
                           "Qty. on Service Order";

        "Armopa Qty. to Order_LDR" := "Maximum Inventory" - cantidadTeorica;

        "Armopa Real Qty. to Order_LDR" := "Armopa Qty. to Order_LDR";

        if "Armopa Qty. to Order_LDR" > "Main Location Inventory_LDR" then
            "Armopa Qty. to Order_LDR" := "Main Location Inventory_LDR";

        Validate("Armopa Qty. to Order_LDR");
        if "Armopa Qty. to Order_LDR" > 0 then
            Validate("Armopa Generate_LDR", true)
        else
            Validate("Armopa Generate_LDR", false);
    end;
}