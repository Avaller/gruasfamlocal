/// <summary>
/// Table Suboperation_LDR (ID 50046)
/// </summary>
table 50046 Suboperation_LDR
{
    Caption = 'Suboperation';
    DataPerCompany = false;
    LookupPageID = "Suboperation List";

    fields
    {
        field(1; "Operation Code"; Code[20])
        {
            Caption = 'Cod. Operation';
            TableRelation = "Operations_LDR"."Code" WHERE("Operation Type" = FILTER("Technical"),
                                                   "Require Serv. Order" = FILTER(true));
        }
        field(2; "Suboperation Code"; Code[20])
        {
            Caption = 'Cod. Suboperation';
            NotBlank = true;
        }
        field(3; "Area"; Option)
        {
            Caption = 'Area';
            OptionCaption = 'Base,Structure';
            OptionMembers = Base,Structure;
        }
        field(4; Element; Code[50])
        {
            Caption = 'Element';
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(6; Active; BoolEAN)
        {
            Caption = 'Active';
        }
    }

    keys
    {
        key(Key1; "Operation Code", "Suboperation Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}