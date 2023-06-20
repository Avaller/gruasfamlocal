/// <summary>
/// Table Company Relation_LDR (ID 50040)
/// </summary>
table 50040 "Company Relation_LDR"
{
    Caption = 'Company Relation';

    fields
    {
        field(2; "Related Company"; Text[30])
        {
            Caption = 'Related Company';
            TableRelation = Company;

            trigger OnValidate()
            begin
                IF "Related Company" = COMPANYNAME THEN
                    ERROR(Text001);
            end;
        }
        field(3; "Customer Code"; Code[20])
        {
            Caption = 'Customer Code';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Customer: Record "Customer";
                ServiceMgtSetup: Record "Service Mgt. Setup";
            begin
                ServiceMgtSetup.GET;

                IF "Customer Code" = ServiceMgtSetup."No. Internal Customer_LDR" THEN
                    ERROR(Text002, "Customer Code", ServiceMgtSetup.FIELDCAPTION("No. Internal Customer_LDR"), ServiceMgtSetup.TABLECAPTION);

                IF Customer.GET("Customer Code") THEN
                    "Customer Name" := Customer.Name;
            end;
        }
        field(4; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
        }
        field(7; "Billing Percentage"; Decimal)
        {
            Caption = 'Billing Percentage';
        }
    }

    keys
    {
        key(Key1; "Related Company")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'You cant assign the own Company Name';
        Text002: Label 'You can''t select the Customer No %1, because it''s already assigned as %2 on %3';
}