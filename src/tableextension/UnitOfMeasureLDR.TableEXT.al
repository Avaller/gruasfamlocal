/// <summary>
/// tableextension 50035 "Unit of Measure_LDR"
/// </summary>
tableextension 50035 "Unit of Measure_LDR" extends "Unit of Measure"
{
    fields
    {
        field(50001; Mobility_LDR; BoolEAN)
        {
            Caption = 'Movilidad';
            DataClassification = ToBeClassified;
        }
        field(50002; "Invoicing UOM_LDR"; Code[10])
        {
            Caption = 'UM Facturación';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(50003; "Expenses Type_LDR"; Code[10])
        {
            Caption = 'Tipo de Gastos';
            DataClassification = ToBeClassified;
            //TableRelation = "Expenses Types"; //TODO: Revisar si conservamos la tabla
        }
        field(50004; "Time Measure Unit_LDR"; BoolEAN)
        {
            Caption = 'Unidad de Tiempo';
            DataClassification = ToBeClassified;
        }
        field(50005; "Invoicing Text_LDR"; Text[30])
        {
            Caption = 'Texto Factura';
            DataClassification = ToBeClassified;
        }
        field(50006; "Hour Type_LDR"; Option)
        {
            Caption = 'Tipo de hora';
            DataClassification = ToBeClassified;
            OptionCaption = 'Horas Normales,Horas Extra,Horas No Productivas';
            OptionMembers = "Normal hour","Extra hour","Non-productive";
        }
    }

    trigger OnAfterDelete()
    var
        DimMgt: Codeunit "DimensionManagement";
    begin
        DimMgt.DeleteDefaultDim(Database::"Unit of Measure", Code);
    end;
}