/// <summary>
/// tableextension 50000 "Location_LDR"
/// </summary>
tableextension 50000 "Location_LDR" extends "Location"
{
    fields
    {
        field(50000; "Main Location Code_LDR"; Code[20])
        {
            Caption = 'Cód Almacén Principal';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50001; "Linked Machine Resource_LDR"; Code[20])
        {
            Caption = 'Recurso Máquina Asociado';
            DataClassification = ToBeClassified;
            TableRelation = Resource;
        }
        field(50002; "Responsibility Center_LDR"; Code[10])
        {
            Caption = 'Centro Responsabilidad';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(50003; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50004; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
        field(50005; "Show in Warehouse Device_LDR"; BoolEAN)
        {
            Caption = 'Mostrar En Dispositivo Almacén';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key4; "Responsibility Center_LDR")
        {
        }
    }

    trigger OnBeforeInsert()
    begin
        Rec."Created Date_LDR" := CurrentDateTime();
    end;

    trigger OnBeforeModify()
    begin
        Rec."Modified Date_LDR" := CurrentDateTime();
    end;
}