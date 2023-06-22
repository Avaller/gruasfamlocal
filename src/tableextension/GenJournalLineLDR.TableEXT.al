/// <summary>
/// tableextension 50014 "Gen. Journal Line_LDR"
/// </summary>
tableextension 50014 "Gen. Journal Line_LDR" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Forecast Code_LDR"; Code[20])
        {
            Caption = 'Código de Previsión';
            DataClassification = ToBeClassified;
        }
        field(50001; "Forecast Line_LDR"; Integer)
        {
            Caption = 'Línea de Previsión';
            DataClassification = ToBeClassified;
        }
        field(50002; "Register on Exploit Account_LDR"; Boolean)
        {
            Caption = 'Registro en Cuenta Explotación';
            DataClassification = ToBeClassified;
            Description = 'Determina si genera Movimiento de Servicio';
        }
        field(50003; "Leasing No._LDR"; Code[20])
        {
            Caption = 'Nº Leasing';
            DataClassification = ToBeClassified;
            Description = 'Almacena el Nº Leasing para generar Movimiento';
            //TableRelation = Table70010; //TODO: Revisar si conservamos la tabla

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                "Leasing Line No._LDR" := 0;

                // CreateDim(
                //   Database::Table70010, "Leasing No.",
                //   DimMgt.TypeToTableID1("Account Type"), "Account No.",
                //   DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
                //   Database::Job, "Job No.",
                //   Database::Campaign, "Campaign No.");
            end;
        }
        field(50004; "Leasing Line No._LDR"; Integer)
        {
            Caption = 'Nº Cuota Leasing';
            DataClassification = ToBeClassified;
            Description = 'Almacena el Nº Cuota Leasing para generar Movimiento';
            //TableRelation = Table70011.Field2 WHERE (Field1=FIELD("Leasing No.")); //TODO: Revisar si conservamos la tabla
        }
        field(50005; "Service Cost No._LDR"; Code[20])
        {
            Caption = 'Nº Coste Servicio';
            DataClassification = ToBeClassified;
            Description = 'Almacena el Nº Coste Servicio';
            TableRelation = "Service Cost";
        }
        field(50006; "Service Item Entry type_LDR"; Option)
        {
            Caption = 'Tipo Movimiento Leasing';
            DataClassification = ToBeClassified;
            Description = 'Especifica el Tipo de Movimiento Leasing';
            OptionCaption = 'Apertura,Cuota,Cancelación,VResidual';
            OptionMembers = Apertura,Cuota,Cancelacion,VResidual;
        }
    }

    trigger OnAfterInsert()
    var
        GenJnlBarch: Record "Gen. Journal Batch";
    begin
        if "Posting No. Series" = '' then
            "Posting No. Series" := GenJnlBarch."Posting No. Series";
    end;
}