/// <summary>
/// Table TempInvoiceResume_LDR (ID 50230)
/// </summary>
table 50230 TempInvoiceResume_LDR
{
    fields
    {
        field(1; Descripcion; Text[100])
        {
            Caption = 'Description';
        }
        field(2; Cantidad; Decimal)
        {
            Caption = 'Quantity';
        }
        field(3; "Precio Unitario"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(4; "Importe Bruto"; Decimal)
        {
            Caption = 'Net Amount';
        }
        field(5; Importe; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; TipoTexto; BoolEAN)
        {
            Caption = 'TextType';
        }
        field(7; "Nº Linea"; Integer)
        {
            Caption = 'Line No.';
        }
        field(8; DescuentoLinea; Decimal)
        {
            Caption = 'Line Discount';
        }
        field(9; Agrupador; Text[80])
        {
        }
        field(10; OrderNo; Code[20])
        {
        }
        field(11; UnitOfMeasure; Code[20])
        {
        }
        field(12; TipoTotal; BoolEAN)
        {
        }
        field(13; "No. 2"; Code[20])
        {
            Caption = 'No. 2';
        }
        field(14; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(15; "Cost Amount"; Decimal)
        {
        }
        field(16; OrderNo2; Code[20])
        {
        }
        field(17; LineNo2; Integer)
        {
        }
        field(18; TipoDetallePedido; BoolEAN)
        {
        }
    }

    keys
    {
        key(Key1; "Nº Linea")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}