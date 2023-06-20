/// <summary>
/// tableextension 50019 "Sales Shipment Line_LDR"
/// </summary>
tableextension 50019 "Sales Shipment Line_LDR" extends "Sales Shipment Line"
{
    fields
    {
        field(50000; "Invoice Disc. Amount_LDR"; Decimal)
        {
            Caption = 'Importe Descuento Factura';
            DataClassification = ToBeClassified;
        }
        field(50001; "Pmt. Disc. Given Amoun_LDR"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Departamento P.P.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    local procedure CalculaMetodo2(SalesOrderLine: Record "Sales Line") Resultado: Decimal;
    var
        Currency: Record Currency;
    begin
        Resultado := Round(SalesOrderLine."Unit Price" * SalesOrderLine."Line Discount %" * SalesOrderLine.Quantity / 100,
            Currency."Amount Rounding Precision");
    end;
}