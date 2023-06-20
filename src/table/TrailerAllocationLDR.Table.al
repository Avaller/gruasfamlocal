/// <summary>
/// Table Trailer Allocation_LDR (ID 50012)
/// </summary>
table 50012 "Trailer Allocation_LDR"
{
    Caption = 'Towing Allocation';
    DataPerCompany = false;
    LookupPageID = "Trailer Allocation";

    fields
    {
        field(1; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item";

            trigger OnValidate()
            begin
                CALCFIELDS(Description);
            end;
        }
        field(2; "Towing Code"; Code[10])
        {
            Caption = 'Towing Code';
            TableRelation = Trailers_LDR;

            trigger OnValidate()
            begin
                CALCFIELDS("Towing Description");
            end;
        }
        field(3; Description; Text[50])
        {
            CalcFormula = Lookup("Service Item"."Description" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Service Item";
        }
        field(4; "Towing Description"; Text[50])
        {
            CalcFormula = Lookup("Trailers_LDR"."Description" WHERE("Code" = FIELD("Towing Code")));
            Caption = 'Towing Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Service Item No.", "Towing Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}