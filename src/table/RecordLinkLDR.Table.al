table 50234 "Record Link_LDR"
{
    Caption = 'Record Link';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        field(1; "Link ID"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Link ID';
        }
        field(50001; "Export to Ingestrel_LDR"; Boolean)
        {
            Caption = 'Exportar a Ingestrel';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(50002; "Ingestrel Export Date_LDR"; Date)
        {
            Caption = 'Fecha Exportación Ingestrel';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(50003; "Ingestrel Name_LDR"; Text[80])
        {
            Caption = 'Nombre';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(50004; "Ingestrel File Name_LDR"; Text[80])
        {
            Caption = 'Documento';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(50005; "Vehicle Book Document_LDR"; Boolean)
        {
            Caption = 'Documento Libro Historial Vehículo';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
    }

    keys
    {
        key(Key1; "Link ID")
        {
            Clustered = true;
        }
    }

    // trigger OnBeforeInsert()
    // var
    //     FileManagement: Codeunit "File Management";
    // begin
    //     if Rec.Type = Rec.Type::Link then begin
    //         "Ingestrel File Name_LDR" := FileManagement.GetFileName(URL1);
    //         "Ingestrel Name_LDR" := Description;
    //     end;
    // end;
}
