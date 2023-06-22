/// <summary>
/// tableextension 50025 "Purch. Rcpt. Line_LDR"
/// </summary>
tableextension 50025 "Purch. Rcpt. Line_LDR" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50000; "No. EAN Labels_LDR"; Integer)
        {
            Caption = 'Nº Etiquetas EAN';
            DataClassification = ToBeClassified;
            Description = 'Incluye el Número de Copias de Etiquetas EAN por Línea de Pedido';
        }
        field(50001; "Service Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Servicio';
            DataClassification = ToBeClassified;
            Description = 'Indica el Número de Pedido de Servicio al que se imputará el Material al ser Recibido';
        }
        field(50002; "Service Item Line No._LDR"; Integer)
        {
            BlankZero = true;
            Caption = 'Nº Línea Pedido Servicio';
            DataClassification = ToBeClassified;
            Description = 'Indica el Número de Línea del Pedido de Servicio, para los casos de Multilínea de Pedido de Servicio';
        }
        field(50003; "Demand Location Code_LDR"; Code[20])
        {
            Caption = 'Código Almacén Demanda';
            DataClassification = ToBeClassified;
            TableRelation = "Location";
        }
        field(50004; "Demand Bin Code_LDR"; Code[20])
        {
            Caption = 'Código Ubicación Demanda';
            DataClassification = ToBeClassified;
        }
        field(50005; Reclasified_LDR; Boolean)
        {
            Caption = 'Reclasificado';
            DataClassification = ToBeClassified;
        }
        field(50006; "Vendor Shipment No._LDR"; Code[35])
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Vendor Shipment No." WHERE("No." = FIELD("Document No.")));
            Caption = 'Nº Albarán Proveedor';
            Description = 'Nº Albarán Proveedor';
            FieldClass = FlowField;
        }
        field(50007; "Invoice Disc. Amount_LDR"; Decimal)
        {
            Caption = 'Importe Documento Factura';
            DataClassification = ToBeClassified;
        }
        field(50008; "Pmt. Disc. Given Amount_LDR"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Departamento P.P.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; Notas1_LDR; Text[100])
        {
            Caption = 'Notas';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key8; "Document No.", "Pay-to Vendor No.", "Buy-from Vendor No.", "Line No.",
        "Qty. Rcd. Not Invoiced", "Order No.")
        {

        }
    }

    procedure CambiarEstadoReclasificacion(boolEstado: BoolEAN)
    var
        Text001: TextConst ENU = 'Line has been marked as reclasified.', ESP = 'La línea ha sido marcada como reclasificada.';
        Text002: TextConst ENU = 'Line has been marked as not reclasified.', ESP = 'La línea ha sido marcada como no reclasificada.';
    begin
        Reclasified_LDR := boolEstado;
        Modify();
    end;
}