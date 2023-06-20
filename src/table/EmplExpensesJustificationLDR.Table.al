/// <summary>
/// Table Empl. Expenses Justificat_LDR (ID 50043)
/// </summary>
table 50043 "Empl. Expenses Justificat_LDR"
{
    Caption = 'Res. Expenses Justification';

    fields
    {
        field(1; "Document No."; Code[10])
        {
            Caption = 'Document No.';

            trigger OnValidate()
            begin
                IF "Document No." = '' THEN BEGIN
                    HumanResSetup.GET;
                    NoSeriesMgt.TestManual(HumanResSetup."Employee Expenses Nos._LDR");
                    NoSeriesMgt.InitSeries(HumanResSetup."Employee Expenses Nos._LDR", HumanResSetup."Employee Expenses Nos._LDR", 0D, "Document No.", HumanResSetup."Employee Expenses Nos._LDR");
                END;
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Resource: Record "Resource";
            begin
                IF Employee.GET("Employee No.") THEN BEGIN
                    "Employee Name" := Employee.Name + ' ' + Employee."First Family Name" + ' ' + Employee."Second Family Name";
                    "Resource No." := Employee."Resource No.";
                    VALIDATE("Document No.");
                END;
            end;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            NotBlank = true;
        }
        field(4; "Expense Type"; Code[10])
        {
            Caption = 'Expense Type';
            TableRelation = "Empl. Expenses Types_LDR"."Code" WHERE("Employee No." = FIELD("Employee No."));

            trigger OnValidate()
            var
                ExpensesTypes: Record "Empl. Expenses Types_LDR";
            begin
                ExpensesTypes.SETRANGE("Employee No.", "Employee No.");
                ExpensesTypes.SETRANGE(Code, "Expense Type");
                IF ExpensesTypes.FINDFIRST THEN BEGIN
                    Description := ExpensesTypes.Description;
                    IF Quantity = 0 THEN
                        Quantity := 1;
                    Price := ExpensesTypes.Price;
                    Amount := Quantity * Price;
                END;
            end;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                Amount := Quantity * Price;
            end;
        }
        field(7; Price; Decimal)
        {
            Caption = 'Price';

            trigger OnValidate()
            begin
                Amount := Quantity * Price;
            end;
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                IF Quantity > 0 THEN
                    Price := Amount / Quantity;
            end;
        }
        field(9; "Initial Time"; Time)
        {
            Caption = 'Initial Time';
        }
        field(10; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
        }
        field(11; "Employee Name"; Text[90])
        {
            Caption = 'Name';
        }
        field(13; "Resource No."; Code[10])
        {
            Caption = 'Resource No.';
        }
        field(14; "Paid Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(15; "Paid Document Amount"; Decimal)
        {
            Caption = 'Paid Amount';
        }
        field(16; "Paid Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,,,,,,,,,,,Bill';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,,,,,,,,,,,Bill;
        }
        field(17; "Paid Charges Amount"; Decimal)
        {
            Caption = 'Paid invoices amount';
        }
        field(18; "Paid Invoices Amount"; Decimal)
        {
            Caption = 'Debits';
        }
        field(19; IsPost; BoolEAN)
        {
            Caption = 'Post';
        }
    }

    keys
    {
        key(Key1; "Employee No.", Date, "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Expense Type", Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Document No." = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Employee Expenses Nos._LDR");
            NoSeriesMgt.InitSeries(HumanResSetup."Employee Expenses Nos._LDR", HumanResSetup."Employee Expenses Nos._LDR", 0D, "Document No.", HumanResSetup."Employee Expenses Nos._LDR");
        END;
    end;

    var
        Employee: Record "Employee";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        HumanResSetup: Record "Human Resources Setup";
}