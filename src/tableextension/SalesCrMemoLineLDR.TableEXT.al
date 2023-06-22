/// <summary>
/// tableextension 50023 "Sales Cr.Memo Line_LDR"
/// </summary>
tableextension 50023 "Sales Cr.Memo Line_LDR" extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50000; "Service Contract No."; Code[20])
        {
            Caption = 'Nº Contrato Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract));
        }
        field(50001; "Service Order No."; Code[20])
        {
            Caption = 'Nº Pedido Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Posted Service Header_LDR";
        }
        field(50002; "Service Item No."; Code[20])
        {
            Caption = 'Nº Producto Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item";
        }
        field(50003; "Appl.-to Service Entry"; Integer)
        {
            Caption = 'Liquidar a Movimiento Servicio';
            DataClassification = ToBeClassified;
        }
        field(50004; "Grouper"; Text[20])
        {
            Caption = 'Agrupador';
            DataClassification = ToBeClassified;
        }
        field(50005; "Service item Model"; Text[50])
        {
            Caption = 'Modelo';
            DataClassification = ToBeClassified;
            Description = 'Modelo';
        }
        field(50006; "Service Price Group Code"; Code[10])
        {
            Caption = 'Código Grupo Precio Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Price Group";
        }
        field(50007; "Service Price Version No."; Code[20])
        {
            Caption = 'Nº Versión Grupo Precio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Price_LDR"."Version No." WHERE("Service Price Group" = FIELD("Service Price Group Code"));
        }
        field(50008; "Service Contract Period"; Text[50])
        {
            Caption = 'Período Contrato Servicio';
            DataClassification = ToBeClassified;
        }
        field(50009; "Concept No."; Code[20])
        {
            Caption = 'Nº Concepto';
            DataClassification = ToBeClassified;
            TableRelation = Concept_LDR."No." WHERE(Type = CONST(External));
        }
        field(50010; "Charge Capacity"; Decimal)
        {
            Caption = 'Capacidad Carga (Kg)';
            DataClassification = ToBeClassified;
            Description = 'Indica la Capacidad de Carga de la Máquina en Kg';
        }
        field(50011; "Warranty Service Code"; Code[20])
        {
            Caption = 'Coste Servicio Garantía';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";
        }
        field(50012; "Warranty No."; Code[20])
        {
            Caption = 'Nº Garantía';
            DataClassification = ToBeClassified;
        }
        field(50013; "Warranty"; Boolean)
        {
            Caption = 'Garantía';
            DataClassification = ToBeClassified;
            Description = 'Determina si es una Garantía';
        }

    }

    keys
    {
        key(Key9; "Grouper", "Concept No.")
        {

        }
    }
}