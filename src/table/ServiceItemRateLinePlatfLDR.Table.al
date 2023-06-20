/// <summary>
/// Table Servic Item Rat Lin - Plat_LDR (ID 50017)
/// </summary>
table 50017 "Servic Item Rat Lin - Plat_LDR"
{
    Caption = 'Platform Lines';
    Description = 'ENU=Service Item Tariff Line - Platform;ESP=Linea de Tarifa de Producto de Servicio - Plataforma';
    LookupPageID = "Serv. Item Rate Subfo. - Platf";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Invoice Group No."; Code[10])
        {
            Caption = 'Invoice Group No.';
            NotBlank = true;
            TableRelation = "Service Item Invoice Group_LDR"."Code" WHERE("Group Type" = CONST("Platform"));

            trigger OnValidate()
            var
                ServInvGroup: Record "Service Item Invoice Group_LDR";
            begin
                ServInvGroup.GET("Invoice Group No.");
                "Print Order" := ServInvGroup."Print Order";
            end;
        }
        field(3; "KM Price"; Decimal)
        {
            Caption = 'KM Price';
        }
        field(4; "Day Cost"; Decimal)
        {
            Caption = 'Day Cost';
        }
        field(5; "Mouth Cost"; Decimal)
        {
            Caption = 'Mouth Cost';
        }
        field(6; "Year Cost"; Decimal)
        {
            Caption = 'Year Cost';
        }
        field(7; "Header Valid Start Date"; Date)
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Valid Start Date" WHERE("Code" = FIELD("Code")));
            Caption = 'Header Valid Start Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Header Valid End Date"; Date)
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Valid End Date" WHERE("Code" = FIELD("Code")));
            Caption = 'Header Valid End Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Header Status"; Option)
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Status" WHERE("Code" = FIELD("Code")));
            Caption = 'Tariff Status';
            FieldClass = FlowField;
            OptionCaption = 'Open,Locked';
            OptionMembers = Open,Locked;
        }
        field(10; "Invoice Group Description"; Text[50])
        {
            CalcFormula = Lookup("Service Item Invoice Group_LDR"."Description" WHERE("Code" = FIELD("Invoice Group No.")));
            Caption = 'Invoice Group Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Print Order"; Integer)
        {
            BlankZero = true;
            Caption = 'Print Order';
            MinValue = 0;
        }
        field(12; "Header Description"; Text[50])
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Description" WHERE("Code" = FIELD("Code")));
            Caption = 'Rate Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", "Invoice Group No.")
        {
            Clustered = true;
        }
        key(Key2; "Print Order")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Header Description", "Invoice Group No.", "Day Cost", "Mouth Cost", "Year Cost")
        {
        }
    }

    trigger OnDelete()
    begin
        ServiceItemRateHeader.GET(Code);
        ServiceItemRateHeader.TESTFIELD(Status, ServiceItemRateHeader.Status::Open);
    end;

    trigger OnInsert()
    begin
        ServiceItemRateHeader.GET(Code);
        ServiceItemRateHeader.TESTFIELD(Status, ServiceItemRateHeader.Status::Open);

        "Header Valid Start Date" := ServiceItemRateHeader."Valid Start Date";
        "Header Valid End Date" := ServiceItemRateHeader."Valid End Date";
    end;

    trigger OnModify()
    var
        ServiceItemRateHeader: Record "Service Item Rate Header_LDR";
    begin
        ServiceItemRateHeader.GET(Code);
        ServiceItemRateHeader.TESTFIELD(Status, ServiceItemRateHeader.Status::Open);
    end;

    var
        ServiceItemRateHeader: Record "Service Item Rate Header_LDR";
}