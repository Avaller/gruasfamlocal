/// <summary>
/// Table Performanc Profiler Archiv_LDR (ID 50056)
/// </summary>
table 50056 "Performanc Profiler Archiv_LDR"
{
    DataPerCompany = false;

    fields
    {
        field(1; Id; Integer)
        {
        }
        field(2; "Session ID"; Integer)
        {
        }
        field(3; Indentation; Integer)
        {
        }
        field(4; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionCaption = 'TableData,Table,Form,Report,Dataport,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,,,,,PageExtension';
            OptionMembers = TableData,"Table",Form,"Report",Dataport,"Codeunit","XMLport",MenuSuite,"Page","Query",System,FieldNumber,,,,,,,"PageExtension";
        }
        field(5; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = "Object"."ID" WHERE("Type" = FIELD("Object Type"));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(6; "Line No"; Integer)
        {
        }
        field(7; Statement; Text[250])
        {
        }
        field(8; Duration; Decimal)
        {
        }
        field(9; MinDuration; Decimal)
        {
        }
        field(10; MaxDuration; Decimal)
        {
        }
        field(11; LastActive; Decimal)
        {
        }
        field(12; HitCount; Integer)
        {
        }
        field(13; Total; Decimal)
        {
            FieldClass = Normal;
        }
        field(14; FullStatement; BLOB)
        {
        }
        field(20; "Session Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Session Code", Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}