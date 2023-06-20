/// <summary>
/// Table Servic Item Breakd Detail_LDR (ID 50026)
/// </summary>
table 50026 "Servic Item Breakd Detail_LDR"
{
    Caption = 'Service Item Breakdown Detail';
    DataPerCompany = false;
    DrillDownPageID = "BreakDown Item Tree Detail";
    LookupPageID = "BreakDown Item Tree Detail";

    fields
    {
        field(1; "Manufacturer Code"; Code[10])
        {
            Caption = 'Manufacturer Code';
            TableRelation = Manufacturer;
        }
        field(2; "Model Code"; Code[10])
        {
            Caption = 'Model No.';
            TableRelation = "Service Item Model_LDR"."Model Code" WHERE("Code" = FIELD("Manufacturer Code"));
        }
        field(3; "Breakdown Category Code"; Code[10])
        {
            Caption = 'Breakdown Category No.';
            TableRelation = "Breakdown Category_LDR";
        }
        field(4; "Breakdown SubCategory Code"; Code[10])
        {
            Caption = 'Breakdown SubCategory No.';
            TableRelation = "Breakdown Subcategory_LDR"."Subcategory" WHERE("Code" = FIELD("Breakdown Category Code"));
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            var
                item: Record "Item";
            begin
                IF "Breakdown SubCategory Code" = '' THEN
                    ERROR('');

                IF item.GET("Item No.") THEN BEGIN
                    item.TESTFIELD(Blocked, FALSE);
                END;
            end;
        }
        field(6; "Item Description"; Text[50])
        {
            CalcFormula = Lookup("Item"."Description" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Manufacturer Name"; Text[50])
        {
            CalcFormula = Lookup("Manufacturer"."Name" WHERE("Code" = FIELD("Manufacturer Code")));
            Caption = 'Manufacturer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Vendor No."; Code[20])
        {
            CalcFormula = Lookup("Item"."Vendor No." WHERE("No." = FIELD("Item No.")));
            Caption = 'Vendor No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Quantity" WHERE("Item No." = FIELD("Item No.")));
            Caption = 'Actual Stock';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Identation; Integer)
        {
        }
        field(11; "BreakDown Category Name"; Text[50])
        {
            CalcFormula = Lookup("Breakdown Category_LDR"."Description" WHERE("Code" = FIELD("Breakdown Category Code")));
            Caption = 'BreakDown Category Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "BreakDown Subcategory Name"; Text[50])
        {
            CalcFormula = Lookup("Breakdown Subcategory_LDR"."Description" WHERE("Subcategory" = FIELD("Breakdown SubCategory Code"),
                                                                             "Code" = FIELD("Breakdown Category Code")));
            Caption = 'BreakDown Subcategory Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Breakdown complete name"; Text[100])
        {
        }
        field(14; "Item Manufacturer Code"; Code[20])
        {
            CalcFormula = Lookup("Item"."Manufacturer Code" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Manufacturer Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Item Manufacturer Name"; Text[50])
        {
            CalcFormula = Lookup("Manufacturer"."Name" WHERE("Code" = FIELD("Item Manufacturer Code")));
            Caption = 'Item Manufacturer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Item No. 2"; Text[50])
        {
            CalcFormula = Lookup("Item"."No. 2" WHERE("No." = FIELD("Item No.")));
            Caption = 'Item No. 2';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Manufacturer Code", "Model Code", "Breakdown Category Code", "Breakdown SubCategory Code", "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        CALCFIELDS("Item Description");
        CALCFIELDS("Manufacturer Name");

        SetIndentation;
    end;

    trigger OnModify()
    begin
        SetIndentation;
    end;

    trigger OnRename()
    begin
        SetIndentation;
    end;

    /// <summary>
    /// SetIndentation()
    /// </summary>
    local procedure SetIndentation()
    begin
        IF "Breakdown SubCategory Code" = '' THEN
            Identation := 0
        ELSE
            IF "Item No." = '' THEN
                Identation := 1
            ELSE
                Identation := 2;
    end;
}