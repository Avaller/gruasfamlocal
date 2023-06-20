/// <summary>
/// Table Service Item Counter_LDR (ID 50011)
/// </summary>
table 50011 "Service Item Counter_LDR"
{
    Caption = 'Service Item Counter';
    DataPerCompany = false;
    DrillDownPageID = "Service Item Counter";
    LookupPageID = "Service Item Counter";
    Permissions = TableData "Service Item" = rimd;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = "Service Item";
        }
        field(2; "Counter No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Counter No.';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "KM/H Buy"; Decimal)
        {
            Caption = 'KM/H Buy';
        }
        field(5; "KM/H Start"; Decimal)
        {
            Caption = 'KM/H Start';
        }
        field(6; "KM/H Actual"; Decimal)
        {
            Caption = 'KM/H Actual';

            trigger OnValidate()
            begin
                "KM/H Effective" := "KM/H Accumulated" + "KM/H Actual";
            end;
        }
        field(7; "KM/H Accumulated"; Decimal)
        {
            Caption = 'KM/H Accumulated';

            trigger OnValidate()
            begin
                "KM/H Effective" := "KM/H Accumulated" + "KM/H Actual";
            end;
        }
        field(8; "KM/H Effective"; Decimal)
        {
            Caption = 'KM/H Effective';
        }
        field(9; "Terminal Code"; Code[10])
        {
            Caption = 'Terminal Code';
        }
        field(10; "Average Consumption"; Decimal)
        {
            Caption = 'Average Consumption';
        }
        field(11; "Unit Measure"; Option)
        {
            Caption = 'Unit Measure';
            OptionCaption = 'Kilometros,Hours';
            OptionMembers = Kilometros,Hours;
        }
        field(12; "Consumption Type"; Option)
        {
            Caption = 'Consumption Type';
            OptionCaption = 'Electric, Diesel';
            OptionMembers = Electric," Diesel";
        }
        field(13; "Exported to Mobility"; BoolEAN)
        {
            CalcFormula = Lookup("Exp. to Mobility Relation_LDR"."Exported to Mobility" WHERE("Table Id" = CONST(50011),
                                                                                           "Code" = FIELD("Code"),
                                                                                           "Code Int" = FIELD("Counter No.")));
            Caption = 'Exported to Mobility';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code", "Counter No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        ServiceItem: Record "Service Item";
        ErrorCount: Label 'Number of counters is greater than number of engines.';
    begin
        //Si el numero de contadores es mayor que el numero de motores que tiene service item tiene que dar error.
        ServiceItem.GET(Code);
        //Pendiente de sustituir el 2 cuando se tenga la variable numero de motores.
        IF "Counter No." > ServiceItem."Engines Counter_LDR" THEN
            ERROR(ErrorCount);
        "Modified Date" := CURRENTDATETIME;
    end;

    trigger OnModify()
    begin
        "Modified Date" := CURRENTDATETIME;
    end;
}