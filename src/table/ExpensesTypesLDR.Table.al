/// <summary>
/// Table Expenses Types_LDR (ID 50049)
/// </summary>
table 50049 "Expenses Types_LDR"
{
    Caption = 'Expenses Types';
    DataPerCompany = false;
    DrillDownPageID = "Expenses Types";
    LookupPageID = "Expenses Types";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';

            trigger OnValidate()
            var
                EmplExpensesTypes: Record "Empl. Expenses Types_LDR";
            begin
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Price; Decimal)
        {
            Caption = 'Price';
        }
        field(4; "Mobility Exp. Type"; Option)
        {
            Caption = 'Mobility Exp. Type';
            OptionCaption = 'Accomodation,Breakfast,Food,Dinner,Complete Diet, ';
            OptionMembers = accomodation,breakfast,food,dinner,completeDiet," ";
        }
        field(5; "Reduced Bonus"; BoolEAN)
        {
            Caption = 'Reduced Bonus';
        }
        field(6; "Complete Bonus"; BoolEAN)
        {
            Caption = 'Complete Bonus';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}