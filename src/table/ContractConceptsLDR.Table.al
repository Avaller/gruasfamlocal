/// <summary>
/// Table Contract Concepts_LDR (ID 50206)
/// </summary>
table 50206 "Contract Concepts_LDR"
{
    Caption = 'Contract Concept';

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
        }
        field(2; "Contract Type"; Option)
        {
            Caption = 'Contract Type';
            OptionCaption = 'Quote,Contract';
            OptionMembers = Quote,Contract;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            NotBlank = true;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            Editable = false;
            NotBlank = true;
            TableRelation = "G/L Account";
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Sales Amount';
            NotBlank = true;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            NotBlank = true;
        }
        field(8; Invoiced; BoolEAN)
        {
            Caption = 'Procesed';
        }
        field(9; Periodicity; Option)
        {
            Caption = 'Periodicity';
            InitValue = "Date expecific";
            OptionCaption = 'Service Contract,Date expecific';
            OptionMembers = "Service Contract","Date expecific";
        }
        field(10; "Concept No."; Code[20])
        {
            Caption = 'Concept No.';
            TableRelation = IF ("Source Table" = FILTER(= 5964 | 5965)) "Concept_LDR"."No." WHERE("Type" = CONST("External"))
            ELSE
            IF ("Source Table" = FILTER(= 7122021 | 7122022)) "Concept_LDR"."No." WHERE("Type" = CONST("Internal"));

            trigger OnValidate()
            var
                Concepto: Record "Concept_LDR";
            begin
                IF "Concept No." <> '' THEN BEGIN
                    CASE "Source Table" OF
                        DATABASE::"Service Contract Header":
                            Concepto.GET("Concept No.", Concepto.Type::External);
                        DATABASE::"Service Contract Line":
                            Concepto.GET("Concept No.", Concepto.Type::External);
                    /*DATABASE::Table70028: 
                        Concepto.GET("Concept No.", Concepto.Type::Internal);
                    DATABASE::Table70029: 
                        Concepto.GET("Concept No.", Concepto.Type::Internal);*/
                    END;
                    VALIDATE(Description, Concepto.Description);
                    VALIDATE("Account No.", Concepto."Account No.");
                    VALIDATE(Amount, Concepto."Unit Price");
                END ELSE BEGIN
                    VALIDATE(Description, '');
                    VALIDATE("Account No.", '');
                    VALIDATE(Amount, 0);
                END;
            end;
        }
        field(11; "Contract Line No."; Integer)
        {
            Caption = 'Contract Line No.';
        }
        field(12; "Source Table"; Integer)
        {
            Caption = 'Source Table';
        }
        field(13; "Cost Amount"; Decimal)
        {
            Caption = 'Cost Amount';
            NotBlank = true;
        }
        field(14; Grouper; Text[20])
        {
            Caption = 'Grouper';
        }
        field(15; "Created from Hours Control"; BoolEAN)
        {
            Caption = 'Created from Hours Control';
        }
        field(50001; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';

            trigger OnValidate()
            begin
                // Rellenar Cliente Explotacion
                FillExplotationCustomerNo();
            end;
        }
        field(7122022; Replicate; BoolEAN)
        {
            Caption = 'Replicate';
        }
        field(7122023; "Explotation Customer No."; Code[20])
        {
            Caption = 'Explotation Customer No.';
            TableRelation = "Customer"."No.";

            trigger OnValidate()
            var
                ServiceMgtSetup: Record "Service Mgt. Setup";
            begin
                // Marcar "Replicar" = TRUE si el Cliente Explotacion distinto del Cliente Interno
                ServiceMgtSetup.GET;
                IF "Explotation Customer No." <> ServiceMgtSetup."No. Internal Customer_LDR" THEN BEGIN
                    VALIDATE(Replicate, TRUE);
                END ELSE BEGIN
                    "Explotation Customer No." := '';
                    VALIDATE(Replicate, FALSE);
                END;
            end;
        }
        field(7122024; "Replicate Service Item"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Source Table", "Contract No.", "Contract Type", "Contract Line No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Source Table", "Contract No.", "Contract Type", "Contract Line No.", Periodicity, Date, Invoiced)
        {
            SumIndexFields = Amount, "Cost Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD(Invoiced, FALSE);
    end;

    trigger OnModify()
    begin
        //TESTFIELD(Invoiced,FALSE);
    end;

    trigger OnRename()
    begin
        TESTFIELD(Invoiced, FALSE);
    end;

    /// <summary>
    /// FillExplotationCustomerNo()
    /// </summary>
    local procedure FillExplotationCustomerNo()
    var
        ServiceLine: Record "Service Item Line";
        ServiceHeader: Record "Service Header";
        PostedServiceHeader: Record "Posted Service Header_LDR";
        PostedServiceLine: Record "Posted Service Item Line_LDR";
        ServiceItem: Record "Service Item";
    begin
        // Rellenar Cliente Explotacion
        IF ServiceHeader.GET(ServiceHeader."Document Type"::Order, "Service Order No.") THEN BEGIN
            CLEAR(ServiceLine);
            ServiceLine.SETRANGE("Document Type", ServiceLine."Document Type"::Order);
            ServiceLine.SETRANGE("Document No.", "Service Order No.");
            IF ServiceLine.FINDSET THEN
                REPEAT
                    CLEAR(ServiceItem);
                    ServiceItem.SETRANGE("No.", ServiceLine."Service Item No.");
                    ServiceItem.SETRANGE(IsTruck_LDR, TRUE);
                    IF ServiceItem.FINDFIRST THEN BEGIN
                        VALIDATE("Explotation Customer No.", ServiceItem."Explotation Customer No._LDR");
                        VALIDATE("Replicate Service Item", ServiceItem."No.");
                    END;
                UNTIL (ServiceLine.NEXT = 0);
        END ELSE
            IF PostedServiceHeader.GET("Service Order No.") THEN BEGIN
                CLEAR(PostedServiceLine);
                PostedServiceLine.SETRANGE("No.", "Service Order No.");
                IF PostedServiceLine.FINDSET THEN
                    REPEAT
                        CLEAR(ServiceItem);
                        ServiceItem.SETRANGE("No.", PostedServiceLine."Service Item No.");
                        ServiceItem.SETRANGE(IsTruck_LDR, TRUE);
                        IF ServiceItem.FINDFIRST THEN BEGIN
                            VALIDATE("Explotation Customer No.", ServiceItem."Explotation Customer No._LDR");
                            VALIDATE("Replicate Service Item", ServiceItem."No.");
                        END;
                    UNTIL (PostedServiceLine.NEXT = 0);
            END;
    end;
}