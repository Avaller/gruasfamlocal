/// <summary>
/// Table Empl. Expenses Types_LDR (ID 50044)
/// </summary>
table 50044 "Empl. Expenses Types_LDR"
{
    Caption = 'Empl. Expenses Types';
    DataPerCompany = false;
    DrillDownPageID = "Empl. Expenses Types";
    LookupPageID = "Empl. Expenses Types";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = "Expenses Types_LDR";

            trigger OnValidate()
            var
                ExpensesTypes: Record "Expenses Types_LDR";
            begin
                ExpensesTypes.GET(Code);

                Description := ExpensesTypes.Description;
                Price := ExpensesTypes.Price;
                "Mobility Exp. Type" := ExpensesTypes."Mobility Exp. Type";
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; Price; Decimal)
        {
            Caption = 'Price';
        }
        field(5; "Mobility Exp. Type"; Option)
        {
            Caption = 'Mobility Exp. Type';
            OptionCaption = 'Accomodation,Breakfast,Food,Dinner,Complete Diet, ';
            OptionMembers = accomodation,breakfast,food,dinner,completeDiet," ";
        }
        field(6; "Reduced Bonus"; BoolEAN)
        {
            Caption = 'Reduced Bonus';
        }
        field(7; "Complete Bonus"; BoolEAN)
        {
            Caption = 'Complete Bonus';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}