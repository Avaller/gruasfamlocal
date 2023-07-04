/// <summary>
/// tableextension 50070 "Service Ledger Entry_LDR"
/// </summary>
tableextension 50070 "Service Ledger Entry_LDR" extends "Service Ledger Entry"
{
    fields
    {
        field(50000; "Purchase Receipt No._LDR"; Code[20])
        {
            Caption = 'Nº Albarán Compra';
            DataClassification = ToBeClassified;
        }
        field(50001; "Purchase Receipt Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Albarán Compra';
            DataClassification = ToBeClassified;
        }
        field(50002; "Service Contract Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Contrato Servicio';
            DataClassification = ToBeClassified;
        }
        field(50003; "ELESOFT Contract No_LDR"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "ELESOFT Historial_LDR"; Boolean)
        {
            Caption = 'Histórico Elesoft';
            DataClassification = ToBeClassified;
        }
        field(50005; "Initial Time_LDR"; Time)
        {
            Caption = 'Hora Inicio';
            DataClassification = ToBeClassified;
        }
        field(50006; "End Time_LDR"; Time)
        {
            Caption = 'Hora Fin';
            DataClassification = ToBeClassified;
        }
        field(50007; "Internal Quantity_LDR"; Decimal)
        {
            Caption = 'Cantidad Teórica';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "ELESOFT Order No._LDR"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Undo Serv. Contract Inv. Date_LDR"; Date)
        {
            Caption = 'Fecha Deshacer Factura Contrato Servicio';
            DataClassification = ToBeClassified;
        }
        field(50010; "Service Contract Concept Entry_LDR"; Boolean)
        {
            Caption = 'Movimiento Origen Concepto Contrato';
            DataClassification = ToBeClassified;
        }
        field(50011; "Service Contract Concept Line_LDR"; Integer)
        {
            Caption = 'Nº Línea Concepto Contrato';
            DataClassification = ToBeClassified;
        }
        field(50012; "Internal Service Contract No._LDR"; Code[20])
        {
            Caption = 'Nº Contrato Servicio Interno';
            DataClassification = ToBeClassified;
        }
        field(50013; "Review No._LDR"; Integer)
        {
            Caption = 'Nº Revisión';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50014; "Amount without Discounts_LDR"; Decimal)
        {
            Caption = 'Importe Sin Descuentos';
            DataClassification = ToBeClassified;
        }
        field(50015; AC_LDR; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; AD_LDR; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Internal Discount %_LDR"; Decimal)
        {
            Caption = '% Descuento Interno';
            DataClassification = ToBeClassified;
        }
        field(50018; "Buy Payment Discount %_LDR"; Decimal)
        {
            Caption = 'Descuento P.P. Compra';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(50019; "Buy Line Discount_LDR"; Decimal)
        {
            Caption = 'Descuento Línea Compra';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(50020; "uy Invoice Discount_LDR"; Decimal)
        {
            Caption = 'Descuento Factura Compra';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50021; "Warranty Document Type_LDR"; Option)
        {
            Caption = 'Tipo Documento Garantía';
            DataClassification = ToBeClassified;
            OptionCaption = 'Factura,Abono';
            OptionMembers = "Invoice","Credit Memo";
        }
        field(50022; "Vendor Service Contract No._LDR"; Code[20])
        {
            Caption = 'Nº Contrato Servicio Proveedor';
            DataClassification = ToBeClassified;
        }
        field(50023; "Day Invoicing_LDR"; Boolean)
        {
            Caption = 'Facturar por Precio Día';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50024; "No of Days_LDR"; Integer)
        {
            Caption = 'Nº de Días';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50025; "Day Amount_LDR"; Decimal)
        {
            Caption = 'Precio Venta Día';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key9; "Service Item No. (Serviced)", "Posting Date", "Service Contract No.", "Service Order No.", "Entry Type")
        {

        }
        key(Key10; "Purchase Receipt No._LDR", "Purchase Receipt Line No._LDR")
        {

        }
        key(Key11; "Posting Date")
        {
            MaintainSiftIndex = false;
            MaintainSqlIndex = false;
        }
        key(Key12; "Service Item No. (Serviced)", "Entry Type", "Type", "Service Contract No.", "Posting Date",
        "Service Order No.", "Document No.")
        {
            SumIndexFields = Amount;
        }
        key(Key13; "Service Order No.", "Service Item No. (Serviced)", "Entry Type", "Document No.", "Type", "No.")
        {
            MaintainSiftIndex = false;
            MaintainSqlIndex = false;
        }
        key(Key14; "Service Order No.", "Entry Type", "Posting Date", "Work Type Code", "Type", "Unit of Measure Code")
        {
            SumIndexFields = Quantity;
        }
    }
}