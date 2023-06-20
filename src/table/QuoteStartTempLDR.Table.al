/// <summary>
/// Table Quote Start Temp_LDR (ID 50023)
/// </summary>
table 50023 "Quote Start Temp_LDR"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Machine Quote Type"; Option)
        {
            Caption = 'Machine Quote Type';
            OptionCaption = 'Crane,Platform';
            OptionMembers = Crane,Platform;
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(5; "Customer Name"; Text[50])
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record "Contact";
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                IF "Customer No." <> '' THEN
                    IF Cont.GET("Contact No.") THEN
                        Cont.SETRANGE("Company No.", Cont."Company No.")
                    ELSE BEGIN
                        ContBusinessRelation.RESET;
                        ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                        ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
                        ContBusinessRelation.SETRANGE("No.", "Customer No.");
                        IF ContBusinessRelation.FINDFIRST THEN
                            Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.")
                        ELSE
                            Cont.SETRANGE("No.", '');
                    END;

                IF "Contact No." <> '' THEN
                    IF Cont.GET("Contact No.") THEN;
                IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                    xRec := Rec;
                    VALIDATE("Contact No.", Cont."No.");
                END;
            end;

            trigger OnValidate()
            var
                Cont: Record "Contact";
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                IF ("Customer No." <> '') AND ("Contact No." <> '') THEN BEGIN
                    Cont.GET("Contact No.");
                    ContBusinessRelation.RESET;
                    ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                    ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
                    ContBusinessRelation.SETRANGE("No.", "Customer No.");
                    IF ContBusinessRelation.FINDFIRST AND
                       (ContBusinessRelation."Contact No." <> Cont."Company No.")
                    THEN
                        ERROR(Text038, Cont."No.", Cont.Name, "Customer No.");
                END;

                UpdateCust("Contact No.");
            end;
        }
        field(7; "Contact Name"; Text[50])
        {
            Caption = 'Contact Name';
            FieldClass = Normal;
        }
        field(8; "Ship-to Address Code"; Code[10])
        {
            Caption = 'Ship-to Address Code';
            TableRelation = "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Customer No."));
        }
        field(9; "Ship-to Address Name"; Text[50])
        {
            CalcFormula = Lookup("Ship-to Address"."Name" WHERE("Customer No." = FIELD("Customer No."),
                                                               "Code" = FIELD("Ship-to Address Code")));
            Caption = 'Ship-to Address Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Quote Type"; Option)
        {
            Caption = 'Quote Type';
            OptionCaption = 'General,Tariff,,Forfait';
            OptionMembers = General,Tariff,"Special Operations",Forfait;

            trigger OnValidate()
            begin
                IF "Quote Type" = "Quote Type"::General THEN BEGIN
                    TESTFIELD("Customer No.");
                    IF "Machine Quote Type" = "Machine Quote Type"::Crane THEN
                        CheckExistGeneralQuote
                    ELSE
                        //CheckExistGeneralContractOLD;
                        CheckExistGeneralPlatfQuote;

                END;
            end;
        }
        field(11; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(12; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text038: Label 'Contact %1 %2 is related to a different company than customer %3.', Comment = '%1=Contact number;%2=Contact name;%3=Customer number;';
        Text037: Label 'Contact %1 %2 is not related to customer %3.', Comment = '%1=Contact number;%2=Contact name;%3=Customer number;';
        Text039: Label 'Contact %1 %2 is not related to a customer.', Comment = '%1=Contact number;%2=Contact name;';
        SkipContact: BoolEAN;
        TextErrorExistsQuote: Label 'There is already a General offer for this client';
        Text001: Label 'There can only be one General Type Quote by Customer';

    /// <summary>
    /// UpdateCust()
    /// </summary>
    local procedure UpdateCust(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Cust: Record "Customer";
        Cont: Record "Contact";
    begin
        IF Cont.GET(ContactNo) THEN BEGIN
            "Contact No." := Cont."No.";
        END ELSE BEGIN
            "Contact Name" := '';
            EXIT;
        END;

        IF Cont.Type = Cont.Type::Person THEN
            "Contact Name" := Cont.Name
        ELSE
            IF Cust.GET("Customer No.") THEN
                "Contact Name" := Cust.Contact
            ELSE
                "Contact Name" := '';

        ContBusinessRelation.RESET;
        ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
        ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
        ContBusinessRelation.SETRANGE("Contact No.", Cont."Company No.");
        IF ContBusinessRelation.FINDFIRST THEN BEGIN
            IF ("Customer No." <> '') AND
               ("Customer No." <> ContBusinessRelation."No.")
            THEN
                ERROR(Text037, Cont."No.", Cont.Name, "Customer No.");

            IF "Customer No." = '' THEN BEGIN
                SkipContact := TRUE;
                VALIDATE("Customer No.", ContBusinessRelation."No.");
                SkipContact := FALSE;
            END;
        END ELSE
            ERROR(Text039, Cont."No.", Cont.Name);
    end;

    /// <summary>
    /// CheckExistGeneralQuote()
    /// </summary>
    procedure CheckExistGeneralQuote()
    var
        CraneServiceQuote: Record "Crane Service Quote Header_LDR";
    begin
        CLEAR(CraneServiceQuote);
        CraneServiceQuote.SETRANGE("Customer No.", "Customer No.");
        CraneServiceQuote.SETRANGE("Quote Type", "Quote Type"::General);
        CraneServiceQuote.SETRANGE(Historical, FALSE);
        CraneServiceQuote.SETRANGE("Platform Quote", FALSE);
        IF NOT CraneServiceQuote.ISEMPTY THEN
            ERROR(Text001);
    end;

    /// <summary>
    /// CheckExistGeneralPlatfQuote()
    /// </summary>
    procedure CheckExistGeneralPlatfQuote()
    var
        CraneServiceQuote: Record "Crane Service Quote Header_LDR";
    begin
        CLEAR(CraneServiceQuote);
        CraneServiceQuote.SETRANGE("Customer No.", "Customer No.");
        CraneServiceQuote.SETRANGE("Quote Type", "Quote Type"::General);
        CraneServiceQuote.SETRANGE(Historical, FALSE);
        CraneServiceQuote.SETRANGE("Platform Quote", TRUE);
        IF NOT CraneServiceQuote.ISEMPTY THEN
            ERROR(Text001);
    end;

    /// <summary>
    /// CheckExistGeneralContractOLD()
    /// </summary>
    procedure CheckExistGeneralContractOLD()
    var
        ServiceContractHeader: Record "Service Contract Header";
    begin
        CLEAR(ServiceContractHeader);
        ServiceContractHeader.SETRANGE("Customer No.", "Customer No.");
        ServiceContractHeader.SETRANGE("Service Quote Type_LDR", ServiceContractHeader."Service Quote Type_LDR"::General);
        ServiceContractHeader.SETRANGE(Historical_LDR, FALSE);
        IF NOT ServiceContractHeader.ISEMPTY THEN
            ERROR(Text001);
    end;
}