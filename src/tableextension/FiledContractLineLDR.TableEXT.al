/// <summary>
/// tableextension 50082 "Filed Contract Line_LDR"
/// </summary>
tableextension 50082 "Filed Contract Line_LDR" extends "Filed Contract Line"
{
    fields
    {
        field(50000; "Month Amount_LDR"; Decimal)
        {
            Caption = 'Importe Mensual';
            DataClassification = ToBeClassified;
            Description = 'Permite Introducir un Importe Mensual a Facturar';
        }
        field(50001; "Day Amount_LDR"; Decimal)
        {
            Caption = 'Precio Venta Día';
            DataClassification = ToBeClassified;
            Description = 'Permite Introducir un Importe Diario a Facturar';
        }
        field(50002; "Day Unit Cost_LDR"; Decimal)
        {
            Caption = 'Coste Unitario Día';
            DataClassification = ToBeClassified;
            Description = 'Permite Introducir un Importe Coste Diario';
        }
        field(50003; "Exit Nº of Hours"; Integer)
        {
            Caption = 'Nº Horas Salida';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas Salida';
        }
        field(50004; "Total Nº of Hours"; Integer)
        {
            Caption = 'Nº Horas Totales';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas Totales';
        }
        field(50005; "Tires Change Hours_LDR"; Integer)
        {
            Caption = 'Horas Cambio Rueda';
            DataClassification = ToBeClassified;
            Description = 'Horas Cambio Rueda';
        }
        field(50006; "Shortcut Dimension 1 Code_LDR"; Code[20])
        {
            Caption = 'Código Dimensión Acceso Directo 1';
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            Description = 'Código Dimensión Acceso Directo 1';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(50007; "Shortcut Dimension 2 Code_LDR"; Code[20])
        {
            Caption = 'Código Dimensión Acceso Directo 2';
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            Description = 'Código Dimensión Acceso Directo 2';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));
        }
    }
}