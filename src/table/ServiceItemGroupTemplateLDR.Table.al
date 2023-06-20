/// <summary>
/// Table Service Item Group Templat_LDR (ID 50200)
/// </summary>
table 50200 "Service Item Group Templat_LDR"
{
    // CIC IALFONSO 20070308 Almacena la relacion grupo producto servicio - plantilla servicio

    Caption = 'Service Item Group Template';
    DataPerCompany = false;
    LookupPageID = "Service Item Group Templates";

    fields
    {
        field(1; "Service Item Group Code"; Code[20])
        {
            Caption = 'Service Item Group Code';
            NotBlank = true;
            TableRelation = "Service Item Group".Code;
        }
        field(2; "Service Template Code"; Code[20])
        {
            Caption = 'Service Template Code';
            NotBlank = true;
            //TableRelation = "Table70002"; 
        }
        field(3; "Service Template Description"; Text[50])
        {
            //CalcFormula = Lookup("Table70002"."Field2" WHERE("Field1" = FIELD("Service Template Code"))); 
            Caption = 'Service Template Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Service Item Group Code", "Service Template Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}