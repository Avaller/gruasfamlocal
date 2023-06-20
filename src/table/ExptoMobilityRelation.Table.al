/// <summary>
/// Table Exp. to Mobility Relation_LDR (ID 50055)
/// </summary>
table 50055 "Exp. to Mobility Relation_LDR"
{

    fields
    {
        field(1; "Table Id"; Integer)
        {
        }
        field(2; "Code"; Code[20])
        {
            TableRelation = IF ("Table Id" = CONST(156)) "Resource"."No."
            ELSE
            IF ("Table Id" = CONST(5940)) "Service Item"."No."
            ELSE
            IF ("Table Id" = CONST(50011)) "Service Item Counter_LDR"."Code"
            ELSE
            IF ("Table Id" = CONST(50044)) "Empl. Expenses Types_LDR"."Employee No.";
        }
        field(4; "Code Int"; Integer)
        {
            TableRelation = IF ("Table Id" = CONST(50011)) "Service Item Counter_LDR"."Counter No." WHERE("Code" = FIELD("Code"));
        }
        field(6; "Exported to Mobility"; BoolEAN)
        {
        }
    }

    keys
    {
        key(Key1; "Table Id", "Code", "Code Int")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}