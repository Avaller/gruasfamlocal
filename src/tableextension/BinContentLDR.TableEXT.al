/// <summary>
/// tableextension 50092 "Bin Content_LDR"
/// </summary>
tableextension 50092 "Bin Content_LDR" extends "Bin Content"
{
    fields
    {
        field(50000; "Item Description_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text
        {
            CalcFormula = Lookup("Item"."Description" WHERE("No." = FIELD("Item No.")));
            Caption = 'Descripción Producto';
            FieldClass = FlowField;
        }
        field(50001; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50002; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
        field(50003; "Item EAN_LDR"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    trigger OnAfterInsert()
    begin
        "Created Date_LDR" := CurrentDateTime;
    end;

    trigger OnAfterModify()
    begin
        "Modified Date_LDR" := CurrentDateTime;
    end;
}