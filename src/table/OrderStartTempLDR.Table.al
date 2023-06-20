/// <summary>
/// Table Order Start Temp_LDR (ID 50027)
/// </summary>
table 50027 "Order Start Temp_LDR"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Machine Order Type"; Option)
        {
            Caption = 'Machine Order Type';
            OptionCaption = 'Crane,Platform';
            OptionMembers = Crane,Platform;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Cust: Record "Customer";
            begin
                "Ship-to Address Code" := '';
                Cust.GET("Customer No.");
                Address := Cust.Address;
                "Address 2" := Cust."Address 2";
                City := Cust.City;
                "Post Code" := Cust."Post Code";
                County := Cust.County;
                "Country/Region Code" := Cust."Country/Region Code";

                "Source City" := Cust.City;
                "Source Post Code" := Cust."Post Code";
                "Source County" := Cust.County;
                "Source Country/Region Code" := Cust."Country/Region Code";

                "Destination City" := Cust.City;
                "Destination Post Code" := Cust."Post Code";
                "Destination County" := Cust.County;
                "Dest. Country/Region Code" := Cust."Country/Region Code";
            end;
        }
        field(5; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record "Contact";
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                IF "Customer No." <> '' THEN BEGIN
                    IF Cont.GET("Contact No.") THEN
                        Cont.SETRANGE("Company No.", Cont."Company No.")
                    ELSE BEGIN
                        ContBusinessRelation.RESET;
                        ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                        ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
                        ContBusinessRelation.SETRANGE("No.", "Customer No.");
                        IF ContBusinessRelation.FINDFIRST THEN
                            Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.")
                        ELSE
                            Cont.SETRANGE("No.", '');
                    END;

                    IF "Contact No." <> '' THEN
                        IF Cont.GET("Contact No.") THEN;
                    IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                        xRec := Rec;
                        VALIDATE("Contact No.", Cont."No.");
                    END;
                END;
            end;

            trigger OnValidate()
            var
                Cont: Record "Contact";
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                IF ("Customer No." <> '') AND ("Contact No." <> '') THEN BEGIN
                    Cont.GET("Contact No.");
                    ContBusinessRelation.RESET;
                    ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                    ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
                    ContBusinessRelation.SETRANGE("No.", "Customer No.");
                    IF ContBusinessRelation.FINDFIRST AND
                       (ContBusinessRelation."Contact No." <> Cont."Company No.")
                    THEN
                        ERROR(Text038, Cont."No.", Cont.Name, "Customer No.");
                END;

                UpdateCust("Contact No.");
            end;
        }
        field(7; "Contact Name"; Text[50])
        {
            Caption = 'Contact Name';
        }
        field(8; "Ship-to Address Code"; Code[10])
        {
            Caption = 'Ship-to Address Code';
            TableRelation = "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Customer No."));

            trigger OnValidate()
            var
                ShipTo: Record "Ship-to Address";
            begin
                IF ShipTo.GET("Customer No.", "Ship-to Address Code") THEN BEGIN

                    Address := ShipTo.Address;
                    "Address 2" := ShipTo."Address 2";
                    City := ShipTo.City;
                    "Post Code" := ShipTo."Post Code";
                    County := ShipTo.County;
                    "Country/Region Code" := ShipTo."Country/Region Code";

                    "Source City" := ShipTo.City;
                    "Source Post Code" := ShipTo."Post Code";
                    "Source County" := ShipTo.County;
                    "Source Country/Region Code" := ShipTo."Country/Region Code";

                    "Destination City" := ShipTo.City;
                    "Destination Post Code" := ShipTo."Post Code";
                    "Destination County" := ShipTo.County;
                    "Dest. Country/Region Code" := ShipTo."Country/Region Code";

                END;
            end;
        }
        field(9; "Ship-to Address Name"; Text[50])
        {
            CalcFormula = Lookup("Ship-to Address"."Name" WHERE("Customer No." = FIELD("Customer No."),
                                                               "Code" = FIELD("Ship-to Address Code")));
            Caption = 'Ship-to Address Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                ValidateDatesAndTimes(FIELDNO("Starting Date"));
            end;
        }
        field(11; "Starting Time"; Time)
        {
            Caption = 'Starting Time';

            trigger OnValidate()
            begin
                ValidateDatesAndTimes(FIELDNO("Starting Time"));
            end;
        }
        field(12; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                ValidateDatesAndTimes(FIELDNO("Ending Date"));
            end;
        }
        field(13; "Ending Time"; Time)
        {
            Caption = 'Ending Time';

            trigger OnValidate()
            begin
                ValidateDatesAndTimes(FIELDNO("Ending Time"));
            end;
        }
        field(14; "Platform Serv. Order Type"; Code[10])
        {
            Caption = 'Platform Serv. Order Type';
            TableRelation = "Service Order Type" WHERE("Platform Delivery/Pickup_LDR" = CONST(true));
        }
        field(15; "Single Task"; BoolEAN)
        {
            Caption = 'Single Task';

            trigger OnValidate()
            begin

                IF "Starting Date" = "Ending Date" THEN
                    ERROR(Text005);

                IF "Ending Date" - "Starting Date" > 1 THEN
                    MESSAGE(Text006);
            end;
        }
        field(16; "Leave Open Tasks"; BoolEAN)
        {
            Caption = 'Leave Open Tasks';
        }
        field(17; "Comment 1"; Text[250])
        {
            Caption = 'Comment 1';
        }
        field(18; "Comment 2"; Text[250])
        {
            Caption = 'Comment 2';
        }
        field(19; "Comment 3"; Text[250])
        {
            Caption = 'Comment 3';
        }
        field(20; "Comment 4"; Text[250])
        {
            Caption = 'Comment 4';
        }
        field(23; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(24; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(25; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code"."City"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code"."City" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(26; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(27; County; Text[30])
        {
            Caption = 'County';
        }
        field(28; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(29; "Source City"; Text[30])
        {
            Caption = 'Source City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code"."City"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code"."City" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Source City", "Source Post Code", "Source County", "Source Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(30; "Source Post Code"; Code[20])
        {
            Caption = 'Source Post Code';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Source City", "Source Post Code", "Source County", "Source Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(31; "Destination City"; Text[30])
        {
            Caption = 'Destination City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code"."City" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Destination City", "Destination Post Code", "Destination County", "Dest. Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(32; "Destination Post Code"; Code[20])
        {
            Caption = 'Destination Post Code';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Destination City", "Destination Post Code", "Destination County", "Dest. Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(33; "Source County"; Text[30])
        {
            Caption = 'Source County';
        }
        field(34; "Destination County"; Text[30])
        {
            Caption = 'Destination County';
        }
        field(35; "Source Country/Region Code"; Code[10])
        {
            Caption = 'Source Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(36; "Dest. Country/Region Code"; Code[10])
        {
            Caption = 'Destination Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(37; "Use Saturdays"; BoolEAN)
        {
            Caption = 'Use Saturdays';
        }
        field(38; "Use Sundays"; BoolEAN)
        {
            Caption = 'Use Sundays';
        }
        field(39; "Travel Type"; Option)
        {
            OptionCaption = 'Simple,Complex';
            OptionMembers = Simple,Complex;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text038: Label 'Contact %1 %2 is related to a different company than customer %3.', Comment = '%1=Contact number;%2=Contact name;%3=Customer number;';
        Text037: Label 'Contact %1 %2 is not related to customer %3.', Comment = '%1=Contact number;%2=Contact name;%3=Customer number;';
        Text039: Label 'Contact %1 %2 is not related to a customer.', Comment = '%1=Contact number;%2=Contact name;';
        SkipContact: BoolEAN;
        PostCode: Record "Post Code";
        Text001: Label '%1 must be lesser than %2';
        Text002: Label '%1 must be greater than %2';
        Text003: Label 'Invalid %1, %2 must be lesser than %3';
        Text004: Label 'Invalid %1, %2 must be greater than %3';
        Text005: Label 'A single task can only occurr between different days';
        Text006: Label 'There is more than one day between the start and the end. Please, consider the possibilty of planning additional tasks';
        Text007: Label 'The starting date/time and ending date/time, is only possible for single tasks.';

    /// <summary>
    /// UpdateCust()
    /// </summary>
    local procedure UpdateCust(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Cust: Record "Customer";
        Cont: Record "Contact";
    begin
        IF Cont.GET(ContactNo) THEN BEGIN
            "Contact No." := Cont."No.";
        END ELSE BEGIN
            "Contact Name" := '';
            EXIT;
        END;

        IF Cont.Type = Cont.Type::Person THEN
            "Contact Name" := Cont.Name
        ELSE
            IF Cust.GET("Customer No.") THEN
                "Contact Name" := Cust.Contact
            ELSE
                "Contact Name" := '';

        ContBusinessRelation.RESET;
        ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
        ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
        ContBusinessRelation.SETRANGE("Contact No.", Cont."Company No.");
        IF ContBusinessRelation.FINDFIRST THEN BEGIN
            IF ("Customer No." <> '') AND
               ("Customer No." <> ContBusinessRelation."No.")
            THEN
                ERROR(Text037, Cont."No.", Cont.Name, "Customer No.");

            IF "Customer No." = '' THEN BEGIN
                SkipContact := TRUE;
                VALIDATE("Customer No.", ContBusinessRelation."No.");
                SkipContact := FALSE;
            END;
        END ELSE
            ERROR(Text039, Cont."No.", Cont.Name);
    end;

    /// <summary>
    /// ValidateDatesAndTimes()
    /// </summary>
    local procedure ValidateDatesAndTimes(pFieldNo: Integer)
    begin

        CASE pFieldNo OF
            FIELDNO("Starting Date"):
                BEGIN
                    //StartingDate
                    //      IF ("Starting Date" = "Ending Date") AND ("Starting Time" >= "Ending Time") THEN
                    //        ERROR(Text003,FIELDCAPTION("Starting Date"),FIELDCAPTION("Starting Time"),FIELDCAPTION("Ending Time"));

                    IF ("Starting Date" = "Ending Date") THEN BEGIN
                        //TEMPORAL PARA PRUEBAS
                        EVALUATE("Starting Time", '08:00');
                        EVALUATE("Ending Time", '18:00');
                    END;

                    IF "Starting Date" > "Ending Date" THEN
                        "Ending Date" := "Starting Date";

                END;
            FIELDNO("Ending Date"):
                BEGIN
                    //Ending Date
                    IF ("Starting Date" = "Ending Date") AND ("Ending Time" <= "Starting Time") THEN
                        ERROR(Text004, FIELDCAPTION("Ending Date"), FIELDCAPTION("Ending Time"), FIELDCAPTION("Starting Time"));

                    IF "Ending Date" < "Starting Date" THEN
                        ERROR(Text002, FIELDCAPTION("Ending Date"), FIELDCAPTION("Starting Date"));
                END;
            FIELDNO("Starting Time"):
                BEGIN
                    //Starting Time
                    IF ("Starting Date" = "Ending Date") AND ("Starting Time" >= "Ending Time") THEN
                        ERROR(Text001, FIELDCAPTION("Starting Time"), FIELDCAPTION("Ending Time"));
                END;
            FIELDNO("Ending Time"):
                BEGIN
                    //Ending Time
                    IF ("Starting Date" = "Ending Date") AND ("Ending Time" <= "Starting Time") THEN
                        ERROR(Text002, FIELDCAPTION("Ending Time"), FIELDCAPTION("Starting Time"));
                END;
        END;

        IF (("Starting Date" < "Ending Date") AND ("Starting Time" > "Ending Time")) THEN BEGIN
            VALIDATE("Single Task", TRUE);
            MESSAGE(Text007);
        END;
    end;
}