/// <summary>
/// Table Serv.Item. Entry Journal_LDR (ID 50212)
/// </summary>
table 50212 "Serv.Item. Entry Journal_LDR"
{
    // UPG2016 23/12/2015 1CF_RPB Dimension functionality reimplemented

    Caption = 'Serv.Item. Entry Journal';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Serv Item Entr Journ Templ_LDR";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Serv.Item Entr Journ Batch_LDR"."Name" WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(5; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Delivery for Sale,Collection return,Delivery Rent Contract Start,Return Rent Contract Finish,Delivery repair finish,Repair start collection,Bin Movements,Purchase,Purch. Cr.Memo';
            OptionMembers = "Entrega por Venta","Recogida por Devolucion","Entrega Inicio Contrato Alquiler","Recogida Fin Contrato Alquiler","Entrega Fin Reparacion","Recogida Inicio Reparacion","Movimiento entre Ubicaciones",Compra,"Abono Compra";
        }
        field(6; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; "Service Item No."; Code[20])
        {
            Caption = 'Item Service No.';
            TableRelation = "Service Item";

            trigger OnValidate()
            var
                ServItem: Record "Service Item";
            begin
                IF ServItem.GET("Service Item No.") THEN;

                CALCFIELDS(Own);
                CALCFIELDS("Serial No.");

                VALIDATE("Originally Customer", ServItem."Customer No.");
                VALIDATE("Originally Cust Ship Address", ServItem."Ship-to Code");

                CreateDim(
                 DATABASE::"Service Item", "Service Item No.",
                 DATABASE::"Responsibility Center", "Responsibility Center");
            end;
        }
        field(9; "Serial No."; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Serial No." WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Serial No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(11; Own; BoolEAN)
        {
            CalcFormula = Lookup("Service Item".Own_LDR WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Own';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Originally Customer"; Code[20])
        {
            Caption = 'Originally Customer';
            Editable = true;
            FieldClass = Normal;
            TableRelation = Customer;

            trigger OnValidate()
            var
                Cliente: Record "Customer";
            begin
                IF Cliente.GET("Originally Customer") THEN BEGIN
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
                END;

                //MVARCE - PS17/000703
                // Se resetea "cod. direccion envio origen", para forzar a insertarlo y recoja el dato correctamente.
                VALIDATE("Originally Cust Ship Address", '');
            end;
        }
        field(13; "Originally Cust Ship Address"; Code[20])
        {
            Caption = 'Originally Cust Ship Address';
            Editable = true;
            TableRelation = "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Originally Customer"));

            trigger OnValidate()
            var
                Direccion: Record "Ship-to Address";
            begin
                IF Direccion.GET("Originally Customer", "Originally Cust Ship Address") THEN BEGIN
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
                END;
            end;
        }
        field(14; "Assignment Customer"; Code[20])
        {
            Caption = 'Assignment Customer';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Cliente: Record "Customer";
            begin
                IF Cliente.GET("Assignment Customer") THEN BEGIN
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
                END;
                //MVARCE - PS17/000703
                // Se resetea "cod. direccion envio destino", para forzar a insertarlo y recoja el dato correctamente.
                VALIDATE("Assignment Cust Ship Address", '');
            end;
        }
        field(15; "Assignment Cust Ship Address"; Code[20])
        {
            Caption = 'Assignment Cust Ship Address';
            TableRelation = "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Assignment Customer"));

            trigger OnValidate()
            var
                Direccion: Record "Ship-to Address";
            begin
                IF Direccion.GET("Assignment Customer", "Assignment Cust Ship Address") THEN BEGIN

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
                END;
            end;
        }
        field(16; Printed; BoolEAN)
        {
            Caption = 'Printed';
            Editable = false;
        }
        field(17; "CMR Necessary"; BoolEAN)
        {
            Caption = 'CMR Necessary';
        }
        field(19; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Setup Management";
                RespCenter: Record "Responsibility Center";
            begin
                IF NOT UserMgt.CheckRespCenter(2, "Responsibility Center") THEN
                    ERROR(
                      Text040,
                      RespCenter.TABLECAPTION, UserMgt.GetSalesFilter());

                VALIDATE("Global Dimension 1 Code");
                VALIDATE("Global Dimension 2 Code");

                CreateDim(
                  DATABASE::"Responsibility Center", "Responsibility Center",
                  DATABASE::"Service Item", "Service Item No.");
            end;
        }
        field(20; "User Id"; Code[50])
        {
            Caption = 'User Id';
            Editable = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                LoginMgt.DisplayUserInformation(Rec."User ID");
            end;
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(23; "Source Table Id"; Integer)
        {
            Caption = 'Source Table Id';
        }
        field(24; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(25; "Source Document No."; Code[20])
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
        field(73; "Fast Register"; BoolEAN)
        {
            Caption = 'Fast Register';
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
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry Type", "Service Item No.", "Originally Customer", "Posting Date")
        {
        }
        key(Key3; "Service Item No.", "Posting Date", "Entry Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //>> UPG2016_RPB Start
        ValidateShortcutDimCode(1, "Global Dimension 1 Code");
        ValidateShortcutDimCode(2, "Global Dimension 2 Code");
        //>> UPG2016_RPB End
    end;

    var
        ServiceJnlTemplate: Record "Serv Item Entr Journ Templ_LDR";
        ServiceJnlBatch: Record "Serv.Item Entr Journ Batch_LDR";
        ServiceJnlLine: Record "Serv.Item. Entry Journal_LDR";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        DimMgt: Codeunit "DimensionManagement";
        Text040: Label 'Your identification is set up to process from %1 %2 only.';

    /// <summary>
    /// SetUpNewLine()
    /// </summary>
    procedure SetUpNewLine(LastServiceJnlLine: Record "Serv.Item. Entry Journal_LDR")
    begin
        ServiceJnlTemplate.GET("Journal Template Name");
        ServiceJnlBatch.GET("Journal Template Name", "Journal Batch Name");
        ServiceJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        ServiceJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        IF ServiceJnlLine.FIND('-') THEN BEGIN
            "Posting Date" := LastServiceJnlLine."Posting Date";
            "Document No." := LastServiceJnlLine."Document No.";
        END ELSE BEGIN
            "Posting Date" := WORKDATE;
            IF ServiceJnlBatch."No. Series" <> '' THEN BEGIN
                CLEAR(NoSeriesMgt);
                "Document No." := NoSeriesMgt.TryGetNextNo(ServiceJnlBatch."No. Series", "Posting Date");
            END;
        END;
    end;

    /// <summary>
    /// EmptyLine()
    /// </summary>
    procedure EmptyLine(): BoolEAN
    begin
        EXIT("Service Item No." = '');
    end;

    /// <summary>
    /// CreateDim()
    /// </summary>
    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        SourceCodeSetup: Record "Source Code Setup";
        G1: Code[20];
        G2: Code[20];
    begin
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;

        //>> UPG2016_RPB Start
        "Global Dimension 1 Code" := '';
        "Global Dimension 2 Code" := '';
        "Dimension Set ID" :=
          DimMgt.GetDefaultDimID(
            TableID, No, SourceCodeSetup."Service Item Entry Journal_LDR",
            "Global Dimension 1 Code", "Global Dimension 2 Code", 0, 0);
        //>> UPG2016_RPB End
    end;

    /// <summary>
    /// ValidateShortcutDimCode()
    /// </summary>
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        //>> UPG2016_RPB Start
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        //>> UPG2016_RPB End
    end;

    /// <summary>
    /// ShowDimensions()
    /// </summary>
    procedure ShowDimensions()
    begin
        //>> UPG2016_RPB Start
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1 %2 %3', "Journal Template Name", "Journal Batch Name", "Line No."),
            "Global Dimension 1 Code", "Global Dimension 2 Code");
        //>> UPG2016_RPB End
    end;

    /// <summary>
    /// GetLastInternalShipCode()
    /// </summary>
    procedure GetLastInternalShipCode() ShipCode: Code[20]
    var
        JournalLine: Record "Serv.Item. Entry Journal_LDR";
        EntryLine: Record "Posted Serv Item Bin Entr_LDR";
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        ServMgtSetup.GET;
        ServMgtSetup.TESTFIELD("No. Internal Customer_LDR");

        TESTFIELD("Posting Date");

        CLEAR(JournalLine);
        JournalLine.SETCURRENTKEY("Entry Type", "Service Item No.", "Originally Customer", "Posting Date");

        CASE "Entry Type" OF
            "Entry Type"::"Recogida por Devolucion":
                JournalLine.SETRANGE(JournalLine."Entry Type", JournalLine."Entry Type"::"Entrega por Venta");
            "Entry Type"::"Recogida Fin Contrato Alquiler":
                JournalLine.SETRANGE(JournalLine."Entry Type", JournalLine."Entry Type"::"Entrega Inicio Contrato Alquiler");
        END;

        JournalLine.SETRANGE(JournalLine."Service Item No.", "Service Item No.");
        JournalLine.SETRANGE(JournalLine."Originally Customer", ServMgtSetup."No. Internal Customer_LDR");
        JournalLine.SETFILTER(JournalLine."Posting Date", '<=%1', "Posting Date");

        IF JournalLine.FINDLAST THEN BEGIN
            ShipCode := JournalLine."Originally Cust Ship Address";
        END ELSE BEGIN
            CLEAR(EntryLine);
            EntryLine.SETCURRENTKEY("Entry Type", "Service Item No.", "Originally Customer", "Posting Date");
            CASE "Entry Type" OF
                "Entry Type"::"Recogida por Devolucion":
                    EntryLine.SETRANGE(EntryLine."Entry Type", EntryLine."Entry Type"::"Delivery for Sale");
                "Entry Type"::"Recogida Fin Contrato Alquiler":
                    EntryLine.SETRANGE(EntryLine."Entry Type", EntryLine."Entry Type"::"Delivery Rent Contract Start");
            END;

            EntryLine.SETRANGE(EntryLine."Service Item No.", "Service Item No.");
            EntryLine.SETRANGE(EntryLine."Originally Customer", ServMgtSetup."No. Internal Customer_LDR");
            EntryLine.SETFILTER(EntryLine."Posting Date", '<=%1', "Posting Date");
            IF EntryLine.FINDLAST THEN
                ShipCode := EntryLine."Originally Cust Ship Address";
        END;
    end;
}