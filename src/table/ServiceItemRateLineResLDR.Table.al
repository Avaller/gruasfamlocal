/// <summary>
/// Table Servic Item Rat Lin - Res_LDR (ID 50015)
/// </summary>
table 50015 "Servic Item Rat Lin - Res_LDR"
{
    Caption = 'Resource Lines';
    Description = 'ENU=Service Item Tariff Line - Resource;ESP=Linea de Tarifa de Producto de Servicio - Recurso';
    LookupPageID = "Serv. Item Rate Subform - Res.";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Resource Group No."; Code[10])
        {
            Caption = 'Resource Group No.';
            NotBlank = true;
            TableRelation = "Resource Group";
        }
        field(3; "Min Hours"; Decimal)
        {
            Caption = 'Min Hours';
            DecimalPlaces = 0 : 2;
        }
        field(4; "Price Hour"; Decimal)
        {
            Caption = 'Price Hour';

            trigger OnValidate()
            begin
                UpdatePrices();
            end;
        }
        field(5; "% Night Time Increase"; Decimal)
        {
            Caption = '% Night Time Increase';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices();
            end;
        }
        field(6; "Price Night Hour"; Decimal)
        {
            Caption = 'Price Night Hour';
            Editable = false;
        }
        field(7; "% Saturday Time Increase"; Decimal)
        {
            Caption = '% Saturday Time Increase';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices();
            end;
        }
        field(8; "Price Saturday Hour"; Decimal)
        {
            Caption = 'Price Saturday Hour';
            Editable = false;
        }
        field(9; "% Saturday Night Time Increase"; Decimal)
        {
            Caption = '% Saturday Night Time Increase';
            DecimalPlaces = 0 : 2;
        }
        field(10; "Price Saturday Night Hour"; Decimal)
        {
            Caption = 'Price Saturday Night Hour';
        }
        field(11; "% Holiday Time Increase"; Decimal)
        {
            Caption = '% Holiday Time Increase';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices();
            end;
        }
        field(12; "Price Holiday Hour"; Decimal)
        {
            Caption = 'Price Holiday Hour';
            Editable = false;
        }
        field(13; "% Holiday Night  Time Increase"; Decimal)
        {
            Caption = '% Holiday Night Time Increase';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                UpdatePrices();
            end;
        }
        field(14; "Price Holiday Night"; Decimal)
        {
            Caption = 'Price Holiday Night Hour';
            Editable = false;
        }
        field(15; "Header Valid Start Date"; Date)
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Valid Start Date" WHERE("Code" = FIELD("Code")));
            Caption = 'Header Valid Start Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Header Valid End Date"; Date)
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Valid End Date" WHERE("Code" = FIELD("Code")));
            Caption = 'Header Valid End Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Header Status"; Option)
        {
            CalcFormula = Lookup("Service Item Rate Header_LDR"."Status" WHERE("Code" = FIELD("Code")));
            Caption = 'Tariff Status';
            FieldClass = FlowField;
            OptionCaption = 'Open,Locked';
            OptionMembers = Open,Locked;
        }
        field(19; "Resource Group Description"; Text[50])
        {
            CalcFormula = Lookup("Resource Group"."Name" WHERE("No." = FIELD("Resource Group No.")));
            Caption = 'Resource Group Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", "Resource Group No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
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

        UpdatePrices;
    end;

    trigger OnModify()
    begin
        ServiceItemRateHeader.GET(Code);
        ServiceItemRateHeader.TESTFIELD(Status, ServiceItemRateHeader.Status::Open);

        UpdatePrices;
    end;

    var
        ServiceItemRateHeader: Record "Service Item Rate Header_LDR";

    /// <summary>
    /// UpdatePrices()
    /// </summary>
    local procedure UpdatePrices()
    begin
        IF "Price Hour" > 0 THEN BEGIN
            "Price Night Hour" := "Price Hour" + ("Price Hour" * "% Night Time Increase" / 100);
            "Price Saturday Hour" := "Price Hour" + ("Price Hour" * "% Saturday Time Increase" / 100);
            "Price Holiday Hour" := "Price Hour" + ("Price Hour" * "% Holiday Time Increase" / 100);

            "Price Saturday Night Hour" := "Price Night Hour" + ("Price Night Hour" * "% Saturday Night Time Increase" / 100);
            "Price Holiday Night" := "Price Night Hour" + ("Price Night Hour" * "% Holiday Night  Time Increase" / 100);
        END;
    end;
}