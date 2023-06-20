/// <summary>
/// Table Servic Contra Invoic Group_LDR (ID 50207)
/// </summary>
table 50207 "Servic Contra Invoic Group_LDR"
{
    Caption = 'Service Contract Invoice Group';
    LookupPageID = "Serv. Contract Inv. Group List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                CALCFIELDS("Customer Name");

                IF xRec."Customer No." <> "Customer No." THEN BEGIN
                    IF CheckIfContractExist THEN
                        ERROR(txtHayContratos, FIELDCAPTION("Customer No."));
                END;
            end;
        }
        field(4; "Customer Name"; Text[50])
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(82; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50001; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Customer No."));
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF CheckIfContractExist THEN
            ERROR(txtHayContratosDelete);
    end;

    trigger OnInsert()
    begin
        ServMgtSetup.GET;
        IF "No." = '' THEN BEGIN
            ServMgtSetup.TESTFIELD(ServMgtSetup."Serv. Contract Inv. Group Nos._LDR");
            NoSeriesMgt.InitSeries(ServMgtSetup."Serv. Contract Inv. Group Nos._LDR", xRec."No. Series", 0D,
               "No.", "No. Series");
        END;

        "Creation Date" := WORKDATE;
    end;

    trigger OnRename()
    begin
        IF CheckIfContractExist THEN
            ERROR(txtHayContratosRename);
    end;

    var
        ServMgtSetup: Record "Service Mgt. Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        txtHayContratos: Label 'It is not posible modify field %1 because exist associated Service Contracts';
        txtHayContratosRename: Label 'It is not posible rename Service Contract Invoice Group because exist associated Service Contracts.';
        txtHayContratosDelete: Label 'It is not posible to delete Service Contract Invoice Group because exist associated Service Contracts';

    /// <summary>
    /// CheckIfContractExist()
    /// </summary>
    procedure CheckIfContractExist(): BoolEAN
    var
        ServContractHeader: Record "Service Contract Header";
    begin
        CLEAR(ServContractHeader);
        ServContractHeader.SETRANGE(ServContractHeader."Serv. Contract Inv. Group_LDR", "No.");
        IF ServContractHeader.FIND('-') THEN
            EXIT(TRUE);
    end;
}