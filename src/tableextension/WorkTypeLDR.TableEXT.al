/// <summary>
/// tableextension 50032 "Work Type_LDR"
/// </summary>
tableextension 50032 "Work Type_LDR" extends "Work Type"
{
    fields
    {
        field(50001; "Exported to Mobility_LDR"; Boolean)
        {
            Caption = 'Exportado a Movilidad';
            DataClassification = ToBeClassified;
        }
        field(50002; "NonWorktime Presence_LDR"; Boolean)
        {
            Caption = 'Fuera de Jornada - Presencia';
            DataClassification = ToBeClassified;
        }
        field(50003; Type_LDR; Option)
        {
            Caption = 'Tipo';
            DataClassification = ToBeClassified;
            OptionMembers = "External Invoice","Internal Production Invoice","Internal Not Production Invoice","Not Production Task";
            OptionCaption = 'Facturación Externa,Facturación Interna Productiva,Facturación Interna Improductiva,Tareas Improductivas';
        }
        field(50004; Nonfacturable_LDR; Boolean)
        {
            Caption = 'No Facturable';
            DataClassification = ToBeClassified;
        }
        field(50005; "Internal discount %_LDR"; Decimal)
        {
            Caption = '% Descuento Interno';
            DataClassification = ToBeClassified;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50006; "Res. Journal Type_LDR"; Boolean)
        {
            Caption = 'No Habilitado para Pedido Servicio';
            DataClassification = ToBeClassified;
        }
        field(50007; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50008; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key2; Type_LDR)
        {

        }
    }

    trigger OnBeforeInsert()
    begin
        "Created Date_LDR" := CurrentDateTime;
    end;

    trigger OnBeforeModify()
    begin
        "Modified Date_LDR" := CurrentDateTime;
        "Exported to Mobility_LDR" := false;
    end;

    trigger OnBeforeDelete()
    begin
        DigMgt.DeleteDefaultDim(Database::"Work Type", Code);
    end;

    var
        DigMgt: Codeunit "DimensionManagement";
}