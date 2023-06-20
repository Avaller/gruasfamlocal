/// <summary>
/// Table Posted Service Item Line_LDR (ID 50218)
/// </summary>
table 50218 "Posted Service Item Line_LDR"
{
    // CIC IALFONSO 20070308 Añadido el campo 50000Service Task CodeCode20Permite almacenar la tarea a realizar
    // CIC IALFONSO 20070308  Añadido el campo 50001nonfacturableBoolEANIndica si se aplica 100% descuento a la hoja de trabajo
    // 
    // UPG2016 23/12/2015 1CF_RPB Dimension functionality reimplemented

    Caption = 'Posted Service Item Line';
    DrillDownPageID = "Posted Service Item Line List";
    LookupPageID = "Posted Service Item Line List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            TableRelation = "Posted Service Header_LDR";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item";
        }
        field(4; "Service Item Group Code"; Code[10])
        {
            Caption = 'Service Item Group Code';
            TableRelation = "Service Item Group";
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(6; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(9; "Repair Status Code"; Code[10])
        {
            Caption = 'Repair Status Code';
            TableRelation = "Repair Status";
        }
        field(10; Priority; Option)
        {
            Caption = 'Priority';
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low,Medium,High;
        }
        field(11; "Response Time (Hours)"; Decimal)
        {
            Caption = 'Response Time (Hours)';
            DecimalPlaces = 0 : 5;
        }
        field(12; "Response Date"; Date)
        {
            Caption = 'Response Date';
        }
        field(13; "Response Time"; Time)
        {
            Caption = 'Response Time';
        }
        field(14; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            Editable = false;
        }
        field(15; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            Editable = false;
        }
        field(16; "Finishing Date"; Date)
        {
            Caption = 'Finishing Date';
            Editable = false;
        }
        field(17; "Finishing Time"; Time)
        {
            Caption = 'Finishing Time';
            Editable = false;
        }
        field(18; "Service Shelf No."; Code[10])
        {
            Caption = 'Service Shelf No.';
            TableRelation = "Service Shelf";
        }
        field(19; "Warranty Starting Date (Parts)"; Date)
        {
            Caption = 'Warranty Starting Date (Parts)';
        }
        field(20; "Warranty Ending Date (Parts)"; Date)
        {
            Caption = 'Warranty Ending Date (Parts)';
        }
        field(21; Warranty; BoolEAN)
        {
            Caption = 'Warranty';
        }
        field(22; "Warranty % (Parts)"; Decimal)
        {
            Caption = 'Warranty % (Parts)';
            DecimalPlaces = 0 : 5;
        }
        field(23; "Warranty % (Labor)"; Decimal)
        {
            Caption = 'Warranty % (Labor)';
            DecimalPlaces = 0 : 5;
        }
        field(24; "Warranty Starting Date (Labor)"; Date)
        {
            Caption = 'Warranty Starting Date (Labor)';
        }
        field(25; "Warranty Ending Date (Labor)"; Date)
        {
            Caption = 'Warranty Ending Date (Labor)';
        }
        field(26; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            Editable = false;
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST("Contract"));
        }
        field(27; "Location of Service Item"; Text[30])
        {
            CalcFormula = Lookup("Service Item"."Location of Service Item" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Location of Service Item';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Loaner No."; Code[20])
        {
            Caption = 'Loaner No.';
            TableRelation = Loaner;
        }
        field(29; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(30; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
        }
        field(31; "Fault Reason Code"; Code[10])
        {
            Caption = 'Fault Reason Code';
            TableRelation = "Fault Reason Code";
        }
        field(32; "Service Price Group Code"; Code[10])
        {
            Caption = 'Service Price Group Code';
            TableRelation = "Service Price Group";
        }
        field(33; "Fault Area Code"; Code[10])
        {
            Caption = 'Fault Area Code';
            TableRelation = "Fault Area";
        }
        field(34; "Symptom Code"; Code[10])
        {
            Caption = 'Symptom Code';
            TableRelation = "Symptom Code";
        }
        field(35; "Fault Code"; Code[10])
        {
            Caption = 'Fault Code';
            TableRelation = "Fault Code"."Code" WHERE("Fault Area Code" = FIELD("Fault Area Code"),
                                                     "Symptom Code" = FIELD("Symptom Code"));
        }
        field(36; "Resolution Code"; Code[10])
        {
            Caption = 'Resolution Code';
            TableRelation = "Resolution Code";
        }
        field(37; "Fault Comment"; BoolEAN)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST(50217),
                                                              "Table Subtype" = CONST(0),
                                                              "No." = FIELD("No."),
                                                              "Type" = CONST("Fault"),
                                                              "Table Line No." = FIELD("Line No.")));
            Caption = 'Fault Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Resolution Comment"; BoolEAN)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST(50217),
                                                              "Table Subtype" = CONST(0),
                                                              "No." = FIELD("No."),
                                                              "Type" = CONST("Resolution"),
                                                              "Table Line No." = FIELD("Line No.")));
            Caption = 'Resolution Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Accessory Comment"; BoolEAN)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST(50217),
                                                              "Table Subtype" = CONST(0),
                                                              "No." = FIELD("No."),
                                                              "Type" = CONST("Accessory"),
                                                              "Table Line No." = FIELD("Line No.")));
            Caption = 'Accessory Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant"."Code" WHERE("Item No." = FIELD("Item No."));
        }
        field(42; "Actual Response Time (Hours)"; Decimal)
        {
            Caption = 'Actual Response Time (Hours)';
            DecimalPlaces = 0 : 5;
        }
        field(44; "Service Price Adjmt. Gr. Code"; Code[10])
        {
            Caption = 'Service Price Adjmt. Gr. Code';
            Editable = false;
            TableRelation = "Service Price Adjustment Group";
        }
        field(45; "Adjustment Type"; Option)
        {
            Caption = 'Adjustment Type';
            Editable = false;
            OptionCaption = 'Fixed,Maximum,Minimum';
            OptionMembers = "Fixed",Maximum,Minimum;
        }
        field(46; "Base Amount to Adjust"; Decimal)
        {
            Caption = 'Base Amount to Adjust';
            Editable = false;
        }
        field(60; "No. of Active/Finished Allocs"; Integer)
        {
            CalcFormula = Count("Service Order Allocation" WHERE("Document Type" = CONST("Order"),
                                                                  "Document No." = FIELD("No."),
                                                                  "Service Item Line No." = FIELD("Line No."),
                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                  "Allocation Date" = FIELD("Allocation Date Filter"),
                                                                  "Status" = FILTER("Active" | "Finished")));
            Caption = 'No. of Active/Finished Allocs';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "No. of Previous Services"; Integer)
        {
            CalcFormula = Count("Posted Service Item Line_LDR" WHERE("Service Item No." = FIELD("Service Item No.")));
            Caption = 'No. of Previous Services';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Contract Line No."; Integer)
        {
            Caption = 'Contract Line No.';
            TableRelation = "Service Contract Line"."Line No." WHERE("Contract Type" = CONST("Contract"),
                                                                      "Contract No." = FIELD("Contract No."));
        }
        field(64; "Ship-to Code"; Code[20])
        {
            Caption = 'Ship-to Code';
            Editable = false;
            TableRelation = "Ship-to Address".Code;
        }
        field(65; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
            TableRelation = "Customer"."No.";
        }
        field(91; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(92; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(93; "Allocation Date Filter"; Date)
        {
            Caption = 'Allocation Date Filter';
            FieldClass = FlowFilter;
        }
        field(95; "Resource Group Filter"; Code[20])
        {
            Caption = 'Resource Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
        field(97; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Description = 'UPG2016';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(50000; "Service Task Code"; Code[20])
        {
            Caption = 'Service Task Code';
            Description = 'Permite almacenar la tarea a realizar';
            //TableRelation = "Table70001"."Field1"; 
        }
        field(50001; nonfacturable; BoolEAN)
        {
            Caption = 'nonfacturable';
            Description = 'Indica si se aplica 100% descuento a la hoja de trabajo';

            trigger OnValidate()
            var
                ServInvLine: Record "Service Line";
                txtHayLineas: Label 'It is not posible to modify %1 value because exist worksheet lines with discount not equal to %2 %.';
            begin
            end;
        }
        field(50002; "No of hours"; Integer)
        {
            Caption = 'No of hours';
            Description = 'Nº Horas de la maquina';
        }
        field(50003; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Description = 'Nº Oferta';
            Editable = false;
        }
        field(50004; "Quote Line No."; Integer)
        {
            Caption = 'Quote Line No.';
            Description = 'Nº Linea Oferta';
            Editable = false;
        }
        field(50005; "Warranty Generated"; BoolEAN)
        {
            Caption = 'Warranty Generated';
            Description = 'Garantia tramitada';
            Editable = false;
        }
        field(50006; "Warranty No."; Code[20])
        {
            Caption = 'Warranty No.';
            Description = 'Nº garantia';
            Editable = false;
        }
        field(50008; "Warranty Rejected"; BoolEAN)
        {
            Caption = 'Warranty Rejected';
            Description = 'Garantía Tramitada';
        }
        field(50010; "Service Order Description"; Text[50])
        {
            CalcFormula = Lookup("Posted Service Header_LDR"."Description" WHERE("No." = FIELD("No.")));
            Caption = 'Service Order Description';
            Description = 'Descripcion del PS';
            FieldClass = FlowField;
        }
        field(50011; "Service Order Shortcut Dim 1"; Code[20])
        {
            CalcFormula = Lookup("Posted Service Header_LDR"."Shortcut Dimension 1 Code" WHERE("No." = FIELD("No.")));
            CaptionClass = '1,2,1';
            Caption = 'Service Order Shortcut Dim 1';
            Description = 'Cód. Dimension acceso Dir. 1';
            FieldClass = FlowField;
        }
        field(50012; "Service Order Shortcut Dim 2"; Code[20])
        {
            CalcFormula = Lookup("Posted Service Header_LDR"."Shortcut Dimension 2 Code" WHERE("No." = FIELD("No.")));
            CaptionClass = '1,2,2';
            Caption = 'Service Order Shortcut Dim 2';
            Description = 'Cód. Dimension acceso Dir 2';
            FieldClass = FlowField;
        }
        field(50013; "Existe Dto."; BoolEAN)
        {
            CalcFormula = Exist("Posted Service Line_LDR" WHERE("Document No." = FIELD("No."),
                                                             "Service Item Line No." = FIELD("Line No."),
                                                             "Line Discount %" = FILTER(<> 0)));
            Caption = 'Discount Exist';
            Description = 'Existe Descuento en la Hoja de Trabajo';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50014; "Warranty in effect"; BoolEAN)
        {
            Caption = 'Warranty in effect';
            Description = 'Garantía en vigor fabricante';
            Editable = false;
        }
        field(50015; "Manuf. Warranty Initial Date"; Date)
        {
            Caption = 'Manuf. Warranty Initial Date';
            Description = 'Fecha Inicial Garantía Fabricante';
            Editable = false;
        }
        field(50016; "Manuf. Warranty End Date"; Date)
        {
            Caption = 'Manuf. Warranty End Date';
            Description = 'Fecha Final Garantía Fabricante';
            Editable = false;
        }
        field(50017; "Manuf. Warranty Type"; Option)
        {
            Caption = 'Manuf. Warranty Type';
            Description = 'Tipo Garantía fabricante';
            OptionCaption = ' ,Warranty,According request';
            OptionMembers = " ",Warranty,"According request";
        }
        field(50018; "Serive Order Type"; Code[10])
        {
            CalcFormula = Lookup("Posted Service Header_LDR"."Service Order Type" WHERE("No." = FIELD("No.")));
            Caption = 'Serive Order Type';
            Description = 'Tipo Pedido Servicio';
            FieldClass = FlowField;
        }
        field(50019; "Reval Service Item"; BoolEAN)
        {
            Caption = 'Reval Service Item';

            trigger OnValidate()
            var
                ServiceMgtSetup: Record "Service Mgt. Setup";
                Serviceheader: Record "Service Header";
                ServItem: Record "Service Item";
            begin

            end;
        }
        field(50020; "Service Zone Code"; Code[10])
        {
            CalcFormula = Lookup("Posted Service Header_LDR"."Service Zone Code" WHERE("No." = FIELD("No.")));
            Caption = 'Service Zone Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "No of Active Service Orders"; Integer)
        {
            CalcFormula = Count("Service Item Line" WHERE("Service Item No." = FIELD("Service Item No.")));
            Caption = 'No of Active Service Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50022; "Service Order Date"; Date)
        {
            CalcFormula = Lookup("Posted Service Header_LDR"."Order Date" WHERE("No." = FIELD("No.")));
            Caption = 'Service Order Date';
            Description = 'Fecha Pedido';
            FieldClass = FlowField;
        }
        field(50023; "Actual Location Cust No."; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Customer No." WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Actual Location Cust No.';
            FieldClass = FlowField;
        }
        field(50024; "Actual Location Ship to Code"; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Ship-to Code" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Actual Location Ship to Code';
            FieldClass = FlowField;
        }
        field(50025; "Default Invoice Lines Created"; BoolEAN)
        {
        }
        field(50030; "Service Item Type"; Option)
        {
            CalcFormula = Lookup("Service Item"."Service Item Type_LDR" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Service Item Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Crane,Platform';
            OptionMembers = Crane,Platform;
        }
        field(50049; "Operation Code"; Code[20])
        {
            Caption = 'Operation Code';
        }
        field(50050; "Crane Service Quote No."; Code[20])
        {
            Caption = 'Crane Service Quote No.';
            TableRelation = "Crane Service Quote Header_LDR"."Quote no." WHERE("Historical" = CONST(false));
        }
        field(50051; "Service Item Tariff No."; Code[20])
        {
            Caption = 'Service Item Tariff No.';
            TableRelation = "Service Item Rate Header_LDR";
        }
        field(50052; "Sent to Device"; BoolEAN)
        {
            Caption = 'Sent to Device';
        }
        field(50053; "Closed by Device"; BoolEAN)
        {
            Caption = 'Closed by Device';
        }
        field(50054; "Requested Starting Date"; Date)
        {
            Caption = 'Requested Starting Date';
        }
        field(50055; "Requested Starting Time"; Time)
        {
            Caption = 'Requested Starting Time';
        }
        field(50056; "Requested Ending Date"; Date)
        {
            Caption = 'Requested Ending Date';
        }
        field(50057; "Requested Ending Time"; Time)
        {
            Caption = 'Requested Ending Time';
        }
        field(50058; "Service Inv. Group No."; Code[10])
        {
            Caption = 'Invoice Group No.';
            TableRelation = "Service Item Invoice Group_LDR";
        }
        field(50059; "Crane Serv. Quote Op. Line No"; Integer)
        {
            Caption = 'Crane Serv. Quote Op. Line No';
        }
        field(50061; "Exported to Device"; BoolEAN)
        {
            Caption = 'Exported to Device';
        }
        field(50063; "Use Saturdays"; BoolEAN)
        {
            Caption = 'Use Saturdays';
        }
        field(50064; "Use Sundays"; BoolEAN)
        {
            Caption = 'Use Sundays';
        }
        field(50065; "Service Inv. Group Description"; Text[50])
        {
            CalcFormula = Lookup("Service Item Invoice Group_LDR"."Description" WHERE("Code" = FIELD("Service Inv. Group No.")));
            Caption = 'Service Inv. Group Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50067; "Explotation Customer No."; Code[20])
        {
            Caption = 'Explotation Customer No.';
            TableRelation = Customer;
        }
        field(50068; "Serv. Item Planner No"; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Planner No_LDR" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Planner No';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50070; "Serv. Item Counter Code"; Integer)
        {
            Caption = 'Serv. Item Counter Code';
            TableRelation = "Service Item Counter_LDR"."Counter No." WHERE("Code" = FIELD("Service Item No."));
        }
        field(50071; "Serv. Item Counter Description"; Text[50])
        {
            CalcFormula = Lookup("Service Item Counter_LDR"."Description" WHERE("Code" = FIELD("Service Item No."),
                                                                           "Counter No." = FIELD("Serv. Item Counter Code")));
            Caption = 'Serv. Item Counter Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60000; "Historico ELESOFT"; BoolEAN)
        {
            Caption = 'ELESOFT Historial';
            Description = 'Historico ELESOFT';
        }
        field(60001; "Warranty Print Date"; Date)
        {
            Caption = 'Warranty Print Date';
            Description = 'Fecha impresión garantía';
        }
        field(7122000; "Source Type"; Option)
        {
            Caption = 'Source Type';
            Editable = false;
            OptionCaption = ' ,Transfer';
            OptionMembers = ,Transfer;
        }
        field(7122026; "Order Type"; Option)
        {
            CalcFormula = Lookup("Posted Service Header_LDR"."Order Type" WHERE("No." = FIELD("No.")));
            Caption = 'Tipo Ordine Assistenza';
            FieldClass = FlowField;
            OptionMembers = FSI,FSIEC,FS,FSEC,FE,OFF;
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Service Item No.")
        {
        }
        key(Key3; "Item No.", "Serial No.", "Loaner No.")
        {
        }
        key(Key4; "Service Price Group Code", "Adjustment Type", "Base Amount to Adjust", "Customer No.")
        {
        }
        key(Key5; "Finishing Date")
        {
        }
        key(Key6; "Warranty No.")
        {
        }
    }

    fieldgroups
    {
    }

    /// <summary>
    /// ShowComments()
    /// </summary>
    procedure ShowComments(Type: Option General,Fault,Resolution,Accessory,Internal,"Service Item Loaner")
    var
        PostedServHeader: Record "Posted Service Header_LDR";
        ServCommentLine: Record "Service Comment Line";
    begin
        PostedServHeader.GET("No.");
        PostedServHeader.TESTFIELD("Customer No.");
        TESTFIELD("Line No.");

        ServCommentLine.SETRANGE("Table Name", ServCommentLine."Table Name"::"Service Header");
        ServCommentLine.SETRANGE("Table Subtype", 0);
        ServCommentLine.SETRANGE("No.", "No.");
        CASE Type OF
            Type::Fault:
                ServCommentLine.SETRANGE(Type, ServCommentLine.Type::Fault);
            Type::Resolution:
                ServCommentLine.SETRANGE(Type, ServCommentLine.Type::Resolution);
            Type::Accessory:
                ServCommentLine.SETRANGE(Type, ServCommentLine.Type::Accessory);
            Type::Internal:
                ServCommentLine.SETRANGE(Type, ServCommentLine.Type::Internal);
            Type::"Service Item Loaner":
                ServCommentLine.SETRANGE(Type, ServCommentLine.Type::"Service Item Loaner");
        END;
        ServCommentLine.SETRANGE("Table Line No.", "Line No.");
        PAGE.RUNMODAL(PAGE::"Service Comment Sheet", ServCommentLine);
    end;

    /// <summary>
    /// ShowDimensions()
    /// </summary>
    procedure ShowDimensions()
    var
        DimMgt: Codeunit "DimensionManagement";
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', TABLECAPTION, "No."));
    end;
}