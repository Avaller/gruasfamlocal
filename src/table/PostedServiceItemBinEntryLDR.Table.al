/// <summary>
/// Table Posted Serv Item Bin Entr_LDR (ID 50213)
/// </summary>
table 50213 "Posted Serv Item Bin Entr_LDR"
{
    // UPG2016 23/12/2015 1CF_RPB Dimension functionality reimplemented
    //                            Field 'User Id' Code20 -> Code50

    Caption = 'Posted Service Item Bin Entry';
    DrillDownPageID = "Service Item Bin Entry";
    LookupPageID = "Service Item Bin Entry";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Delivery for Sale,Collection return,Delivery Rent Contract Start,Return Rent Contract Finish,Delivery repair finish,Repair start collection,Bin Movements,Purchase,Purch. Cr.Memo';
            OptionMembers = "Delivery for Sale","Collection return","Delivery Rent Contract Start","Return Rent Contract Finish","Delivery repair finish","Repair start collection","Bin Movements",Purchase,"Purch. Cr.Memo";
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Service Item No."; Code[20])
        {
            Caption = 'Item Service No.';
            TableRelation = "Service Item";

            trigger OnValidate()
            var
                ServItem: Record "Service Item";
            begin
            end;
        }
        field(6; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; Own; BoolEAN)
        {
            Caption = 'Own';
        }
        field(9; "Originally Customer"; Code[20])
        {
            Caption = 'Originally Customer';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Cliente: Record "Customer";
            begin
                IF Cliente.GET("Originally Customer") THEN;
                "Originally Name" := Cliente.Name;
                "Originally Name 2" := Cliente."Name 2";
                "Originally Address" := Cliente.Address;
                "Originally Address 2" := Cliente."Address 2";
                "Originally City" := Cliente.City;
                "Originally Post Code" := Cliente."Post Code";
                "Originally County" := Cliente.County;
                "Originally Country Code" := Cliente."Country/Region Code";
                "Originally Contact" := Cliente.Contact;
                "Originally Phone No." := Cliente."Phone No.";
                "Original VAT Registration No." := Cliente."VAT Registration No.";
            end;
        }
        field(10; "Originally Cust Ship Address"; Code[20])
        {
            Caption = 'Originally Cust Ship Address';
            TableRelation = "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Originally Customer"));

            trigger OnValidate()
            var
                Direccion: Record "Ship-to Address";
            begin
                IF Direccion.GET("Originally Customer", "Originally Cust Ship Address") THEN;

                "Originally Ship-to Name" := Direccion.Name;
                "Originally Ship-to Name 2" := Direccion."Name 2";
                "Originally Ship-to Address" := Direccion.Address;
                "Originally Ship-to Address 2" := Direccion."Address 2";
                "Originally Ship-to City" := Direccion.City;
                "Originally Ship-to Post Code" := Direccion."Post Code";
                "Originally Ship-to County" := Direccion.County;
                "Originally Ship-to Country Cod" := Direccion."Country/Region Code";
                "Originally Ship-to Contact" := Direccion.Contact;
                "Originally Ship-to Phone No." := Direccion."Phone No.";
            end;
        }
        field(11; "Assignment Customer"; Code[20])
        {
            Caption = 'Assignment Customer';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Cliente: Record "Customer";
            begin
                IF Cliente.GET("Assignment Customer") THEN;
                "Assignment Name" := Cliente.Name;
                "Assignment Name 2" := Cliente."Name 2";
                "Assignment Address" := Cliente.Address;
                "Assignment Address 2" := Cliente."Address 2";
                "Assignment City" := Cliente.City;
                "Assignment Post Code" := Cliente."Post Code";
                "Assignment County" := Cliente.County;
                "Assignment Country Code" := Cliente."Country/Region Code";
                "Assignment Contact" := Cliente.Contact;
                "Assignment Phone No." := Cliente."Phone No.";
                "Assign. VAT Registration No." := Cliente."VAT Registration No.";
            end;
        }
        field(12; "Assignment Cust Ship Address"; Code[20])
        {
            Caption = 'Assignment Cust Ship Address';
            TableRelation = "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Assignment Customer"));

            trigger OnValidate()
            var
                Direccion: Record "Ship-to Address";
            begin
                IF Direccion.GET("Assignment Customer", "Assignment Cust Ship Address") THEN;

                "Assignment Ship-to Name" := Direccion.Name;
                "Assignment Ship-to Name 2" := Direccion."Name 2";
                "Assignment Ship-to Address" := Direccion.Address;
                "Assignment Ship-to Address 2" := Direccion."Address 2";
                "Assignment Ship-to City" := Direccion.City;
                "Assignment Ship-to Post Code" := Direccion."Post Code";
                "Assignment Ship-to County" := Direccion.County;
                "Assignment Ship-to Country Cod" := Direccion."Country/Region Code";
                "Assignment Ship-to Contact" := Direccion.Contact;
                "Assignment Ship-to Phone No." := Direccion."Phone No.";
            end;
        }
        field(13; Printed; BoolEAN)
        {
            Caption = 'Printed';
        }
        field(14; "CMR Necessary"; BoolEAN)
        {
            Caption = 'CMR Necessary';
        }
        field(15; Posted; BoolEAN)
        {
            Caption = 'Posted';
        }
        field(16; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(17; "User Id"; Code[50])
        {
            Caption = 'User Id';
            Description = 'UPG2016';
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                LoginMgt.DisplayUserInformation(Rec."User ID");
            end;
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));
        }
        field(20; "Source Table Id"; Integer)
        {
            Caption = 'Source Table Id';
        }
        field(21; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(22; "Source Document No."; Code[20])
        {
            Caption = 'Source Document No.';
        }
        field(26; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(27; "No. of hours"; Decimal)
        {
            Caption = 'No. of hours';
        }
        field(28; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
        }
        field(30; "Originally Name"; Text[50])
        {
            Caption = 'Originally Name';
        }
        field(31; "Originally Name 2"; Text[50])
        {
            Caption = 'Originally Name 2';
        }
        field(32; "Originally Address"; Text[50])
        {
            Caption = 'Originally Address';
        }
        field(33; "Originally Address 2"; Text[50])
        {
            Caption = 'Originally Address 2';
        }
        field(34; "Originally City"; Text[30])
        {
            Caption = 'Originally City';
        }
        field(35; "Originally Post Code"; Code[20])
        {
            Caption = 'Originally Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(36; "Originally County"; Text[30])
        {
            Caption = 'Originally County';
        }
        field(37; "Originally Country Code"; Code[10])
        {
            Caption = 'Originally Country Code';
            TableRelation = "Country/Region";
        }
        field(38; "Originally Ship-to Name"; Text[50])
        {
            Caption = 'Originally Ship-to Name';
        }
        field(39; "Originally Ship-to Name 2"; Text[50])
        {
            Caption = 'Originally Ship-to Name 2';
        }
        field(40; "Originally Ship-to Address"; Text[50])
        {
            Caption = 'Originally Ship-to Address';
        }
        field(41; "Originally Ship-to Address 2"; Text[50])
        {
            Caption = 'Originally Ship-to Address 2';
        }
        field(42; "Originally Ship-to City"; Text[30])
        {
            Caption = 'Originally Ship-to City';
        }
        field(43; "Originally Ship-to Post Code"; Code[20])
        {
            Caption = 'Originally Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(44; "Originally Ship-to County"; Text[30])
        {
            Caption = 'Originally Ship-to County';
        }
        field(45; "Originally Ship-to Country Cod"; Code[10])
        {
            Caption = 'Originally Ship-to Country Code';
            TableRelation = "Country/Region";
        }
        field(46; "Assignment Name"; Text[50])
        {
            Caption = 'Assignment Name';
        }
        field(47; "Assignment Name 2"; Text[50])
        {
            Caption = 'Assignment Name 2';
        }
        field(48; "Assignment Address"; Text[50])
        {
            Caption = 'Assignment Address';
        }
        field(49; "Assignment Address 2"; Text[50])
        {
            Caption = 'Assignment Address 2';
        }
        field(50; "Assignment City"; Text[30])
        {
            Caption = 'Assignment City';
        }
        field(51; "Assignment Post Code"; Code[20])
        {
            Caption = 'Assignment Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(52; "Assignment County"; Text[30])
        {
            Caption = 'Assignment County';
        }
        field(53; "Assignment Country Code"; Code[10])
        {
            Caption = 'Assignment Country Code';
            TableRelation = "Country/Region";
        }
        field(54; "Assignment Ship-to Name"; Text[50])
        {
            Caption = 'Assignment Ship-to Name';
        }
        field(55; "Assignment Ship-to Name 2"; Text[50])
        {
            Caption = 'Assignment Ship-to Name 2';
        }
        field(56; "Assignment Ship-to Address"; Text[50])
        {
            Caption = 'Assignment Ship-to Address';
        }
        field(57; "Assignment Ship-to Address 2"; Text[50])
        {
            Caption = 'Assignment Ship-to Address 2';
        }
        field(58; "Assignment Ship-to City"; Text[30])
        {
            Caption = 'Assignment Ship-to City';
        }
        field(59; "Assignment Ship-to Post Code"; Code[20])
        {
            Caption = 'Assignment Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(60; "Assignment Ship-to County"; Text[30])
        {
            Caption = 'Assignment Ship-to County';
        }
        field(61; "Assignment Ship-to Country Cod"; Code[10])
        {
            Caption = 'Assignment Ship-to Country Code';
            TableRelation = "Country/Region";
        }
        field(62; "Originally Contact"; Text[50])
        {
            Caption = 'Source Contact';
        }
        field(63; "Originally Phone No."; Text[30])
        {
            Caption = 'Source Phone No.';
        }
        field(64; "Original VAT Registration No."; Text[20])
        {
            Caption = 'Source VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
            end;
        }
        field(65; "Originally Ship-to Contact"; Text[50])
        {
            Caption = 'Source Ship-to Contact';
        }
        field(66; "Originally Ship-to Phone No."; Text[30])
        {
            Caption = 'Source Ship-to Phone No.';
        }
        field(67; "Assignment Contact"; Text[50])
        {
            Caption = 'Destination Contact';
        }
        field(68; "Assignment Phone No."; Text[30])
        {
            Caption = 'Destination Phone No.';
        }
        field(69; "Assign. VAT Registration No."; Text[20])
        {
            Caption = 'Destination VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
            end;
        }
        field(70; "Assignment Ship-to Contact"; Text[50])
        {
            Caption = 'Destination Ship-to Contact';
        }
        field(71; "Assignment Ship-to Phone No."; Text[30])
        {
            Caption = 'Destination Ship-to Phone No.';
        }
        field(72; "Service Item Model"; Text[50])
        {
            Caption = 'Service Item Model';
            Description = 'Modelo';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Description = 'UPG2016';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(50001; "Service Order No"; Code[20])
        {
            Caption = 'Service Order No';
        }
        field(50002; "Service Item Line No"; Integer)
        {
            Caption = 'Service Item Line No';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.", "Posting Date")
        {
        }
        key(Key3; "Entry Type", "Service Item No.", "Originally Customer", "Posting Date")
        {
        }
        key(Key4; "Service Item No.", "Posting Date", "Entry Type")
        {
        }
    }

    fieldgroups
    {
    }

    /// <summary>
    /// ShowDimensions()
    /// </summary>
    procedure ShowDimensions()
    var
        DimMgt: Codeunit "DimensionManagement";
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', TABLECAPTION, "Entry No."));
    end;
}