/// <summary>
/// tableextension 50009 "Sales Line_LDR"
/// </summary>
tableextension 50009 "Sales Line_LDR" extends "Sales Line"
{
    fields
    {
        field(50000; "Warranty Service Code_LDR"; Code[20])
        {
            Caption = 'Servicio Garantía';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";

            trigger OnValidate()
            var
                ServCost: Record "Service Cost";
                TempWarrantyServiceCost: Code[20];
            begin
                TempWarrantyServiceCost := "Warranty Service Code_LDR";

                if "Warranty Service Code_LDR" <> '' then begin
                    ServCost.Get("Warranty Service Code_LDR");
                    ServCost.TestField(ServCost."Account No.");
                    Validate(Type, Type::"G/L Account");
                    Validate("No.", ServCost."Account No.");
                    "Warranty Service Code_LDR" := TempWarrantyServiceCost;
                end;
            end;
        }
        field(50001; "Warranty No._LDR"; Code[20])
        {
            Caption = 'Nº Garantía';
            DataClassification = ToBeClassified;
        }
        field(50002; "Warranty_LDR"; Boolean)
        {
            Caption = 'Garantía';
            DataClassification = ToBeClassified;
            Description = 'Determina si es una Garantía';
        }
    }
}