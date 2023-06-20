/// <summary>
/// Table Posted Service Line_LDR (ID 50219)
/// </summary>
table 50219 "Posted Service Line_LDR"
{
    // CIC IALFONSO 20070308 Añadida funcion CheckServOrderLineDiscount que comprueba si la linea del pedido esta marcada como no factuable
    //                       y por lo tanto establecer 100% Descuento
    // CIC IALFONSO 20070320 Añadidos el campo 50007Initial TimeTime
    // CIC IALFONSO 20070320 Añadidos el campo 50008End TimeTime
    // 
    // UPG2016 23/12/2015 1CF_RPB Dimension functionality reimplemented

    Caption = 'Posted Service Line';
    PasteIsValid = false;

    fields
    {
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Posted Service Header_LDR";
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Item,Resource,Cost,G/L Account';
            OptionMembers = " ",Item,Resource,Cost,"G/L Account";
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF ("Type" = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Type" = CONST("Item")) "Item"
            ELSE
            IF ("Type" = CONST("Resource")) "Resource"
            ELSE
            IF ("Type" = CONST("Cost")) "Service Cost";

            trigger OnValidate()
            var
                ShowLocMessage: BoolEAN;
                bVentaSinCoste: BoolEAN;
            begin

            end;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(8; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group";
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                RecItem: Record "Item";
            begin
            end;
        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Qty. to Ship"; Decimal)
        {
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 6;
            MaxValue = 100;
            MinValue = 0;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(32; "Allow Invoice Disc."; BoolEAN)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 6;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 6;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 6;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 6;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
            end;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));
        }
        field(42; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            Editable = false;
            TableRelation = "Customer Price Group";
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = "Job"."No." WHERE("Bill-to Customer No." = FIELD("Bill-to Customer No."));

            trigger OnValidate()
            var
                Job: Record "Job";
            begin
            end;
        }
        field(46; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(47; "Job Line Type"; Option)
        {
            Caption = 'Job Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(52; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type" WHERE("Res. Journal Type_LDR" = CONST(false));

            trigger OnValidate()
            var
                ServHeader: Record "Service Header";
            begin
            end;
        }
        field(57; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record "Currency";
            begin
            end;
        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(59; "Shipped Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record "Currency";
            begin
            end;
        }
        field(60; "Quantity Shipped"; Decimal)
        {
            Caption = 'Quantity Shipped';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(63; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
        }
        field(64; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.';
            Editable = false;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            Editable = false;
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(77; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax,No Taxable VAT';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax","No Taxable VAT";
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;
            TableRelation = "Posted Service Line_LDR"."Line No." WHERE("Document No." = FIELD("Document No."));
        }
        field(81; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(86; "Tax Liable"; BoolEAN)
        {
            Caption = 'Tax Liable';
        }
        field(87; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(89; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
            Editable = false;
        }
        field(93; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced (LCY)';
            Editable = false;
        }
        field(96; Reserve; Option)
        {
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(101; "System-Created Entry"; BoolEAN)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            Editable = false;
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Editable = false;
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
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF ("Type" = CONST("Item")) "Item Variant"."Code" WHERE("Item No." = FIELD("No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';

            trigger OnLookup()
            var
                WMSManagement: Codeunit "WMS Management";
                BinCode: Code[20];
            begin
            end;

            trigger OnValidate()
            var
                WMSManagement: Codeunit "WMS Management";
            begin
            end;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF ("Type" = CONST("Item")) "Item Unit of Measure"."Code" WHERE("Item No." = FIELD("No."))
            ELSE
            IF ("Type" = CONST("Resource")) "Resource Unit of Measure"."Code" WHERE("Resource No." = FIELD("No."))
            ELSE
            "Unit of Measure";

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
                ResUnitofMeasure: Record "Resource Unit of Measure";
            begin
            end;
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5418; "Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5458; "Qty. Shipped Not Invd. (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invd. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5460; "Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(5702; "Substitution Available"; BoolEAN)
        {
            CalcFormula = Exist("Item Substitution" WHERE("Type" = CONST("Item"),
                                                           "No." = FIELD("No."),
                                                           "Substitute Type" = CONST("Item")));
            Caption = 'Substitution Available';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5709; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5710; Nonstock; BoolEAN)
        {
            Caption = 'Nonstock';
            Editable = false;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group"."Code" WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(5752; "Completely Shipped"; BoolEAN)
        {
            Caption = 'Completely Shipped';
            Editable = false;
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            Caption = 'Appl.-from Item Entry';
            MinValue = 0;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
            end;
        }
        field(5902; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item"."No.";
        }
        field(5903; "Appl.-to Service Entry"; Integer)
        {
            Caption = 'Appl.-to Service Entry';
            Editable = true;
        }
        field(5904; "Service Item Line No."; Integer)
        {
            Caption = 'Service Item Line No.';
            TableRelation = "Posted Service Item Line_LDR"."Line No." WHERE("No." = FIELD("Document No."));
        }
        field(5905; "Service Item Serial No."; Code[20])
        {
            Caption = 'Service Item Serial No.';
        }
        field(5906; "Service Item Line Description"; Text[30])
        {
            CalcFormula = Lookup("Posted Service Item Line_LDR"."Description" WHERE("No." = FIELD("Document No."),
                                                                               "Line No." = FIELD("Service Item Line No.")));
            Caption = 'Service Item Line Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5907; "Serv. Price Adjmt. Gr. Code"; Code[10])
        {
            Caption = 'Serv. Price Adjmt. Gr. Code';
            Editable = false;
            TableRelation = "Service Price Adjustment Group";
        }
        field(5908; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5909; "Order Date"; Date)
        {
            Caption = 'Order Date';
            Editable = false;
        }
        field(5916; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            Editable = false;
            TableRelation = "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Customer No."));
        }
        field(5917; "Qty. to Consume"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qty. to Consume';
            DecimalPlaces = 0 : 5;
        }
        field(5918; "Quantity Consumed"; Decimal)
        {
            Caption = 'Quantity Consumed';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5919; "Qty. to Consume (Base)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qty. to Consume (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5920; "Qty. Consumed (Base)"; Decimal)
        {
            Caption = 'Qty. Consumed (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5928; "Service Price Group Code"; Code[10])
        {
            Caption = 'Service Price Group Code';
            TableRelation = "Service Price Group";
        }
        field(5929; "Fault Area Code"; Code[10])
        {
            Caption = 'Fault Area Code';
            TableRelation = "Fault Area";
        }
        field(5930; "Symptom Code"; Code[10])
        {
            Caption = 'Symptom Code';
            TableRelation = "Symptom Code";
        }
        field(5931; "Fault Code"; Code[10])
        {
            Caption = 'Fault Code';
            TableRelation = "Fault Code"."Code" WHERE("Fault Area Code" = FIELD("Fault Area Code"),
                                                     "Symptom Code" = FIELD("Symptom Code"));
        }
        field(5932; "Resolution Code"; Code[10])
        {
            Caption = 'Resolution Code';
            TableRelation = "Resolution Code";
        }
        field(5933; "Exclude Warranty"; BoolEAN)
        {
            Caption = 'Exclude Warranty';
            Editable = true;
        }
        field(5934; "Warranty>"; BoolEAN)
        {
            Caption = 'Warranty';
            Editable = true;
        }
        field(5936; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST("Contract"));

            trigger OnValidate()
            var
                DestDocType: Option Invoice,"Credit Memo","Posted Invoice","Posted Credit Memo";
            begin
            end;
        }
        field(5938; "Contract Disc. %"; Decimal)
        {
            Caption = 'Contract Disc. %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5939; "Warranty Disc. %"; Decimal)
        {
            Caption = 'Warranty Disc. %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5965; "Component Line No."; Integer)
        {
            Caption = 'Component Line No.';
        }
        field(5966; "Spare Part Action"; Option)
        {
            Caption = 'Spare Part Action';
            OptionCaption = ' ,Permanent,Temporary,Component Replaced,Component Installed,Component Changed,Component Deleted';
            OptionMembers = " ",Permanent,"Temporary","Component Replaced","Component Installed","Component Changed","Component Deleted";
        }
        field(5967; "Fault Reason Code"; Code[10])
        {
            Caption = 'Fault Reason Code';
            TableRelation = "Fault Reason Code";

            trigger OnValidate()
            var
                NewWarranty: BoolEAN;
                OldExcludeContractDiscount: BoolEAN;
            begin
            end;
        }
        field(5968; "Replaced Item No."; Code[20])
        {
            Caption = 'Replaced Item No.';
            TableRelation = IF ("Replaced Item Type" = CONST("Item")) Item
            ELSE
            IF ("Replaced Item Type" = CONST("Service Item")) "Service Item";
        }
        field(5969; "Exclude Contract Discount"; BoolEAN)
        {
            Caption = 'Exclude Contract Discount';
            Editable = true;
        }
        field(5970; "Replaced Item Type"; Option)
        {
            Caption = 'Replaced Item Type';
            OptionCaption = ' ,Service Item,Item';
            OptionMembers = " ","Service Item",Item;
        }
        field(5994; "Price Adjmt. Status"; Option)
        {
            Caption = 'Price Adjmt. Status';
            Editable = false;
            OptionCaption = ' ,Adjusted,Modified';
            OptionMembers = " ",Adjusted,Modified;
        }
        field(5997; "Line Discount Type"; Option)
        {
            Caption = 'Line Discount Type';
            Editable = false;
            OptionCaption = ' ,Warranty Disc.,Contract Disc.,Line Disc.,Manual';
            OptionMembers = " ","Warranty Disc.","Contract Disc.","Line Disc.",Manual;
        }
        field(5999; "Copy Components From"; Option)
        {
            Caption = 'Copy Components From';
            OptionCaption = 'None,Item BOM,Old Service Item,Old Serv.Item w/o Serial No.';
            OptionMembers = "None","Item BOM","Old Service Item","Old Serv.Item w/o Serial No.";
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";

            trigger OnValidate()
            var
                ReturnReason: Record "Return Reason";
            begin
            end;
        }
        field(7001; "Allow Line Disc."; BoolEAN)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(7002; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(10700; "Pmt. Disc. Given Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Given Amount';
            Editable = false;
        }
        field(10701; "EC %"; Decimal)
        {
            Caption = 'EC %';
        }
        field(10702; "EC Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'EC Difference';
            Editable = false;
        }
        field(50000; "Purchase Receipt No."; Code[20])
        {
            Caption = 'Purchase Receipt No.';
            Description = 'Nº Albarán Compra';
        }
        field(50001; "Purchase Receipt Line No."; Integer)
        {
            Caption = 'Purchase Receipt Line No.';
            Description = 'Nº Línea Albarán Compra';
        }
        field(50002; "Opened (Quote)"; BoolEAN)
        {
            Caption = 'Opened (Quote)';
            Editable = false;
        }
        field(50003; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Description = 'Nº Oferta';
        }
        field(50004; "Quote Line No."; Integer)
        {
            Caption = 'Quote Line No.';
            Description = 'Nº Línea Oferta';
        }
        field(50005; "Quote Invoice Line No."; Integer)
        {
            Caption = 'Quote Invoice Line No.';
            Description = 'Nº Lín. Factura Oferta';
        }
        field(50006; "Item Entry No."; Integer)
        {
            Caption = 'Item Entry No.';
            Description = 'Nº Movimiento Producto';
        }
        field(50007; "Initial Time"; Time)
        {
            Caption = 'Initial Time';
            Description = 'Hora Inicio';
        }
        field(50008; "End Time"; Time)
        {
            Caption = 'End Time';
            Description = 'Hora Fin';
        }
        field(50009; "Internal Quantity"; Decimal)
        {
            Caption = 'Internal Quantity';
            Description = 'Cantidad Teórica';
            Editable = false;
        }
        field(50010; "Service Order Description"; Text[50])
        {
            CalcFormula = Lookup("Posted Service Header_LDR"."Description" WHERE("No." = FIELD("Document No.")));
            Caption = 'Service Order Description';
            Description = 'Descripción Pedido';
            FieldClass = FlowField;
        }
        field(50011; "Number of Hours"; Integer)
        {
            CalcFormula = Lookup("Posted Service Item Line_LDR"."No of hours" WHERE("No." = FIELD("Document No."),
                                                                                 "Line No." = FIELD("Service Item Line No.")));
            Caption = 'Number of Hours';
            Description = 'Nº Horas maquina';
            FieldClass = FlowField;
        }
        field(50012; "EAN code"; Code[13])
        {
            Caption = 'EAN code';
            Description = 'Código EAN';

            trigger OnLookup()
            var
                RecItem: Record "Item";
            begin
            end;

            trigger OnValidate()
            var
                RecItem: Record "Item";
            begin
            end;
        }
        field(50013; Revaluation; BoolEAN)
        {
            Caption = 'Reval Service Item';
            Description = 'Para generar movs. de valor de Maquina';

            trigger OnValidate()
            var
                ServiceMgtSetup: Record "Service Mgt. Setup";
                Serviceheader: Record "Service Header";
                ServItem: Record "Service Item";
            begin
            end;
        }
        field(50014; "Created from Transfer"; BoolEAN)
        {
            Caption = 'Created from Transfer';
            Description = 'Indica que la linea se ha creado desde una reclasificacion';
        }
        field(50015; "Transfer Source Location Code"; Code[20])
        {
            Caption = 'Transfer Source Location Code';
            TableRelation = Location;
        }
        field(50016; "Transfer Source Bin Code"; Code[20])
        {
            Caption = 'Transfer Source Bin Code';
            TableRelation = "Bin"."Code" WHERE("Location Code" = FIELD("Transfer Source Location Code"));
        }
        field(50017; "Convert to Order"; BoolEAN)
        {
            Caption = 'Convert to Order';
        }
        field(50020; Grouper; Text[20])
        {
            Caption = 'Grouper';
        }
        field(50021; "Service item Model"; Text[50])
        {
            Caption = 'Model';
            Description = 'Modelo';
        }
        field(50023; "Service Price Version No."; Code[20])
        {
            Caption = 'Service Price Version No.';
            TableRelation = "Service Item Price_LDR"."Version No." WHERE("Service Price Group" = FIELD("Service Price Group Code"));
        }
        field(50024; "Service Contract Period"; Text[50])
        {
            Caption = 'Service Contract Period';
        }
        field(50025; "Concept No."; Code[20])
        {
            Caption = 'Concept No.';
            TableRelation = "Concept_LDR"."No." WHERE("Type" = CONST("External"));

            trigger OnValidate()
            var
                Concepto: Record "Concept_LDR";
            begin
            end;
        }
        field(50026; "Charge Capacity"; Decimal)
        {
            Caption = 'Charge Capacity';
            Description = 'Indica la capacidad de carga de la maquina en Kg';
        }
        field(50050; "Invoicing UOM Code"; Code[10])
        {
            Caption = 'Invoicing Unit of Measure Code';
            Description = 'FAM';
            TableRelation = IF ("Type" = CONST("Item")) "Item Unit of Measure"."Code" WHERE("Item No." = FIELD("No."))
            ELSE
            IF ("Type" = CONST("Resource")) "Resource Unit of Measure"."Code" WHERE("Resource No." = FIELD("No."))
            ELSE
            "Unit of Measure";

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
                ResUnitofMeasure: Record "Resource Unit of Measure";
                WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
            begin
            end;
        }
        field(50051; "Crane Quote No."; Code[20])
        {
            Caption = 'Crane Quote No.';
        }
        field(50052; "Crane Quote Op. Line No."; Integer)
        {
            Caption = 'Crane Quote Op. Line No.';
        }
        field(50053; "Crane Quote Line No."; Integer)
        {
            Caption = 'Crane Quote Line No.';
        }
        field(50054; "Contract Line No."; Integer)
        {
            Caption = 'Contract Line No.';
        }
        field(50055; "Contract Concept Line No."; Integer)
        {
            Caption = 'Contract Concept Line No.';
        }
        field(50056; Replicated; BoolEAN)
        {
            Caption = 'Replicated';
            Editable = false;
        }
        field(50100; "Warranty Service Code"; Code[20])
        {
            Caption = 'Warranty Service Code';
            TableRelation = "Service Cost";

            trigger OnValidate()
            var
                ServCost: Record "Service Cost";
                TempWarrantyServiceCost: Code[20];
            begin
            end;
        }
        field(50101; "Warranty No."; Code[20])
        {
            Caption = 'Warranty No.';
        }
        field(50102; Warranty; BoolEAN)
        {
            Caption = 'Warranty';
            Description = 'Determina si es una garantia';
        }
        field(60000; "Historico ELESOFT"; BoolEAN)
        {
            Caption = 'ELESOFT Historial';
            Description = 'Historico ELESOFT';
        }
        field(7122505; "No. 2"; Code[20])
        {
            CalcFormula = Lookup("Item"."No. 2" WHERE("No." = FIELD("No.")));
            Caption = 'No. 2';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount Including VAT", "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)", "Line Amount";
        }
        key(Key2; Type, "No.", "Order Date")
        {
        }
        key(Key3; "Service Item No.", Type, "Posting Date")
        {
        }
        key(Key4; "Bill-to Customer No.", "Currency Code")
        {
            SumIndexFields = "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        }
        key(Key5; "Document No.", "Service Item No.")
        {
        }
        key(Key6; "Document No.", "Service Item Line No.", "Serv. Price Adjmt. Gr. Code")
        {
            SumIndexFields = "Line Amount";
        }
        key(Key7; "Document No.", "Service Item Line No.", Type, "No.")
        {
        }
        key(Key8; Type, "No.", "Variant Code", "Location Code", "Posting Date", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code")
        {
            SumIndexFields = "Quantity (Base)", "Outstanding Qty. (Base)";
        }
        key(Key9; "Appl.-to Service Entry")
        {
        }
        key(Key10; "Document No.", "Service Item Line No.", "Component Line No.")
        {
        }
        key(Key11; "Fault Reason Code")
        {
        }
        key(Key12; "Customer No.")
        {
        }
        key(Key13; "Purchase Receipt No.", "Purchase Receipt Line No.")
        {
        }
        key(Key14; "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ServiceLine2: Record "Service Line";
        txtOferta: Label 'It is not posible to delete Line because it is linked with a Quote. Unlock line by menu Line - Unlock.';
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlTemplate: Record "Item Journal Template";
        JnlLineNo: Integer;
        Almacenes: Record "Location";
        Ubicaciones: Record "Bin";
        bOk: BoolEAN;
    begin

    end;

    trigger OnModify()
    var
        txtOferta: Label 'You can''t modify the line because it comes from a quote. You have to unblock from the menu Line - Unblock';
        txtPedidoCompra: Label 'You can''t modify the line because it comes from a purchase order. You have to unblock from the menu Line - Unblock';
    begin

    end;

    var
        Text000: Label 'You cannot invoice more than %1 units.';
        Text001: Label 'You cannot invoice more than %1 base units.';
        Text002: Label 'You cannot rename a %1.';
        Text003: Label 'must not be less than %1';
        Text004: Label 'You must confirm %1 %2, because %3 is not equal to %4 in %5 %6.';
        Text005: Label 'The update has been interrupted to respect the warning.';
        Text006: Label 'Replace Component,New Component,Ignore';
        Text007: Label 'You must select a %1.';
        Text008: Label 'You cannot change the value of the %1 field because the %2 field in the Fault Reason Codes window contains a check mark for the %3 %4.';
        Text009: Label 'You have changed the value of the field %1.\Do you want to continue ?';
        Text010: Label '%1 cannot be less than %2.';
        Text011: Label 'When replacing a %1 the quantity must be 1.';
        Text012: Label 'Automatic reservation is not possible.\Reserve items manually?';
        Text013: Label ' must be 0 when %1 is %2.';
        Text015: Label 'You have already selected %1 %2 for replacement.';
        Text016: Label 'You cannot ship more than %1 units.';
        Text017: Label 'You cannot ship more than %1 base units.';
        Text018: Label '%1 %2 is greater than %3 and was adjusted to %4.';
        Text020: Label 'Change %1 from %2 to %3?';
        Text021: Label 'The %1 that you selected has already been replaced in %2 %3.';
        GLAcc: Record "G/L Account";
        ServMgtSetup: Record "Service Mgt. Setup";
        ServiceLine: Record "Posted Service Line_LDR";
        StdTxt: Record "Standard Text";
        ServHeader: Record "Posted Service Header_LDR";
        ServCost: Record "Service Cost";
        ServItem: Record "Service Item";
        ServItem2: Record "Service Item";
        ServItemLine: Record "Service Item Line";
        ServContract: Record "Service Contract Header";
        ContractGr: Record "Contract Group";
        Item: Record "Item";
        Resource: Record "Resource";
        Location: Record "Location";
        ItemVariant: Record "Item Variant";
        ResCost: Record "Resource Cost";
        FaultReasonCode: Record "Fault Reason Code";
        WorkType: Record "Work Type";
        ServItemComponent: Record "Service Item Component";
        Res: Record "Resource";
        ItemTranslation: Record "Item Translation";
        ContractDisc: Record "Contract/Service Discount";
        Currency: Record "Currency";
        CurrExchRate: Record "Currency Exchange Rate";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        UnitOfMeasure: Record "Unit of Measure";
        NonstockItem: Record "Nonstock Item";
        ReservEntry: Record "Reservation Entry";
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        SKU: Record "Stockkeeping Unit";
        ItemCategory: Record "Item Category";
        ServDocReg: Record "Service Document Register";
        ServContractHeader: Record "Service Contract Header";
        ServShptHeader: Record "Service Shipment Header";
        DimMgt: Codeunit "DimensionManagement";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        ContractDiscFind: Codeunit "ContractDiscount-Find";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        UOMMgt: Codeunit "Unit of Measure Management";
        ItemSubstitutionMgt: Codeunit "Item Subst.";
        NonstockItemMgt: Codeunit "Catalog Item Management";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ReservMgt: Codeunit "Reservation Management";
        ReserveServLine: Codeunit "Service Line-Reserve";
        CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
        ServOrderMgt: Codeunit "ServOrderManagement";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        Select: Integer;
        FullAutoReservation: BoolEAN;
        HideReplacementDialog: BoolEAN;
        Text022: Label 'The %1 cannot be greater than the %2 set on the %3.';
        Text023: Label 'You must enter a serial number.';
        ReplaceServItemAction: BoolEAN;
        Text025: Label 'The %1 could not be filled automatically.\You have to enter a %1 manually, where %2 is not enabled.';
        Text026: Label 'When replacing or creating a service item component you may only enter a whole number into the %1 field.';
        Text027: Label 'The %1 %2 with a check mark in the %3 field cannot be entered if the service line type is other than Item or Resource.';
        Text028: Label 'You cannot consume more than %1 units.';
        Text029: Label 'must be positive';
        Text030: Label 'must be negative';
        Text031: Label 'You must specify %1.';
        Text032: Label 'You cannot consume more than %1 base units.';
        Text033: Label 'The line you are trying to change has the adjusted price.\';
        Text034: Label 'Do you want to continue?';
        Text037: Label 'You cannot change %1 when %2 is %3 and %4 is positive.';
        Text038: Label 'You cannot change %1 when %2 is %3 and %4 is negative.';
        Text039: Label 'You cannot return more than %1 units for %2 %3.';
        Text040: Label 'You must use form %1 to enter %2, if item tracking is used.';
        Text042: Label 'When posting the Applied to Ledger Entry %1 will be opened first';
        HideCostWarning: BoolEAN;
        HideWarrantyWarning: BoolEAN;
        Text043: Label 'You cannot change the value of the %1 field manually if %2 for this line is %3';
        Text044: Label 'Do you want to split the resource line and use it to create resource lines\for the other service items with divided amounts?';
        Text045: Label 'You cannot delete this service line because one or more service entries exist for this line.';
        TxtHoraInicio: Label 'Starting Time is bigger than End Time';
        txtHoraFin: Label 'End Time is lower than Starting Time';
        ServOrderLine: Record "Service Item Line";
        ServiceItemLine: Record "Service Item Line";
        ServiceInvLine: Record "Service Line";
        txtErrorEAN: Label 'EAN %1 does not exist';
        txtTipoEAN: Label 'Type must be Item';
        txtRevaluar: Label 'You can not modify the value because the line has been posted';
        TextErrorMontaje: Label 'It is not posible to revaluate a machine on an assembly service order';
        TextNoespropia: Label 'It is not posible to revaluate a not own machine';
        TextTipoTrabajoDistinto: Label 'Service Order Work type code does not match Service Order Line Work type. Are you sure to continue ?';
        txtUbicacionPs: Label 'Service Item No. %1 is not placed on Customer. Are you sure to calculate by customer address ?';
        txtErrorDiario: Label 'It isn''t defined the journal book called TRANSFEREN';
        txtErrorSeccion: Label 'It isn''t defined the batch AJUSTES in the TRANSFEREN journal';
        txtErrorUbicacionGenerica: Label 'The location %1 hasn''t got a generic bin';
        txtLineaDiarioGenerada: Label 'There are lines to register in the Reclasif. Journal, Journal Book TRANSFEREN, batch AJUSTES';
        Text50001: Label 'You can not modify a product that comes from a Reclassification Diary.';
        Text50002: Label 'Dou you want creata a line in Serv.Item. Entry Journal';
        Text50011: Label 'You cannot delete this invoice line because a %1 exists for this line. Delete all invoice for reverse contract periodo.';
        Text50012: Label 'You cannot delete this invoice line because a %1 exists for this line and associated service order has been registered.';
        HideDialogBox: BoolEAN;
        ServLedgEntry: Record "Service Ledger Entry";
        ItemAvailByDate: Page "Item Availability by Periods";
        ItemAvailByLoc: Page "Item Availability by Location";
        ItemAvailByVar: Page "Item Availability by Variant";

    /// <summary>
    /// UpdateVATOnLines()
    /// </summary>
    procedure UpdateVATOnLines(QtyType: Option General,Invoicing,Shipping; var ServHeader: Record "Posted Service Header_LDR"; var ServiceLine: Record "Posted Service Line_LDR"; var VATAmountLine: Record "VAT Amount Line")
    var
        TempVATAmountLineRemainder: Record "VAT Amount Line" temporary;
        Currency: Record "Currency";
        ChangeLogMgt: Codeunit "Change Log Management";
        RecRef: RecordRef;
        xRecRef: RecordRef;
        NewAmount: Decimal;
        NewAmountIncludingVAT: Decimal;
        NewVATBaseAmount: Decimal;
        VATAmount: Decimal;
        VATDifference: Decimal;
        InvDiscAmount: Decimal;
        LineAmountToInvoice: Decimal;
        ECDifference: Decimal;
    begin
        IF QtyType = QtyType::Shipping THEN
            EXIT;
        IF ServHeader."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
        ELSE
            Currency.GET(ServHeader."Currency Code");

        TempVATAmountLineRemainder.DELETEALL;

        WITH ServiceLine DO BEGIN
            SETRANGE("Document No.", ServHeader."No.");
            SETFILTER(Type, '>0');
            SETFILTER(Quantity, '<>0');
            CASE QtyType OF
                QtyType::Invoicing:
                    SETFILTER("Qty. to Invoice", '<>0');
                QtyType::Shipping:
                    SETFILTER("Qty. to Ship", '<>0');
            END;
            LOCKTABLE;
            IF FIND('-') THEN
                REPEAT
                    VATAmountLine.GET("VAT Identifier", "VAT Calculation Type", "Tax Group Code", FALSE, "Line Amount" >= 0);
                    IF VATAmountLine.Modified THEN BEGIN
                        xRecRef.GETTABLE(ServiceLine);
                        IF NOT
                           TempVATAmountLineRemainder.GET(
                             "VAT Identifier",
                             "VAT Calculation Type",
                             "Tax Group Code",
                             FALSE, "Line Amount" >= 0)
                        THEN BEGIN
                            TempVATAmountLineRemainder := VATAmountLine;
                            TempVATAmountLineRemainder.INIT;
                            TempVATAmountLineRemainder.INSERT;
                        END;

                        IF QtyType = QtyType::General THEN
                            LineAmountToInvoice := "Line Amount"
                        ELSE
                            LineAmountToInvoice :=
                              ROUND("Line Amount" * "Qty. to Invoice" / CalcChargeableQty, Currency."Amount Rounding Precision");

                        IF "Allow Invoice Disc." THEN BEGIN
                            IF VATAmountLine."Inv. Disc. Base Amount" = 0 THEN
                                InvDiscAmount := 0
                            ELSE BEGIN
                                TempVATAmountLineRemainder."Invoice Discount Amount" :=
                                  TempVATAmountLineRemainder."Invoice Discount Amount" +
                                  VATAmountLine."Invoice Discount Amount" * LineAmountToInvoice /
                                  VATAmountLine."Inv. Disc. Base Amount";
                                InvDiscAmount :=
                                  ROUND(
                                    TempVATAmountLineRemainder."Invoice Discount Amount", Currency."Amount Rounding Precision");
                                TempVATAmountLineRemainder."Invoice Discount Amount" :=
                                  TempVATAmountLineRemainder."Invoice Discount Amount" - InvDiscAmount;
                            END;
                            IF QtyType = QtyType::General THEN BEGIN
                                "Inv. Discount Amount" := InvDiscAmount;
                                CalcInvDiscToInvoice;
                            END ELSE
                                "Inv. Disc. Amount to Invoice" := InvDiscAmount;
                        END ELSE
                            InvDiscAmount := 0;

                        IF QtyType = QtyType::General THEN
                            IF ServHeader."Prices Including VAT" THEN BEGIN
                                IF (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount" = 0) OR
                                   ("Line Amount" = 0)
                                THEN BEGIN
                                    VATAmount := 0;
                                    NewAmountIncludingVAT := 0;
                                END ELSE BEGIN
                                    VATAmount :=
                                      TempVATAmountLineRemainder."VAT Amount" +
                                      VATAmountLine."VAT Amount" *
                                      ("Line Amount" - "Inv. Discount Amount") /
                                      (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount") +
                                      VATAmountLine."EC Amount" *
                                      ("Line Amount" - "Inv. Discount Amount") /
                                      (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount");
                                    NewAmountIncludingVAT :=
                                      TempVATAmountLineRemainder."Amount Including VAT" +
                                      VATAmountLine."Amount Including VAT" *
                                      ("Line Amount" - "Inv. Discount Amount") /
                                      (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount");
                                END;
                                NewAmount :=
                                  ROUND(NewAmountIncludingVAT, Currency."Amount Rounding Precision") -
                                  ROUND(VATAmount, Currency."Amount Rounding Precision");
                                NewVATBaseAmount :=
                                  ROUND(
                                    NewAmount * (1 - ServHeader."VAT Base Discount %" / 100),
                                    Currency."Amount Rounding Precision");
                            END ELSE BEGIN
                                IF "VAT Calculation Type" = "VAT Calculation Type"::"Full VAT" THEN BEGIN
                                    VATAmount := "Line Amount" - "Inv. Discount Amount" - "Pmt. Disc. Given Amount";
                                    NewAmount := 0;
                                    NewVATBaseAmount := 0;
                                END ELSE BEGIN
                                    NewAmount := "Line Amount" - "Inv. Discount Amount" - "Pmt. Disc. Given Amount";
                                    NewVATBaseAmount :=
                                      ROUND(
                                        NewAmount * (1 - ServHeader."VAT Base Discount %" / 100),
                                        Currency."Amount Rounding Precision");
                                    IF VATAmountLine."VAT Base" = 0 THEN
                                        VATAmount := 0
                                    ELSE
                                        VATAmount :=
                                          TempVATAmountLineRemainder."VAT Amount" +
                                          VATAmountLine."VAT Amount" * NewAmount / VATAmountLine."VAT Base" +
                                          VATAmountLine."EC Amount" * NewAmount / VATAmountLine."VAT Base";
                                END;
                                NewAmountIncludingVAT := NewAmount + ROUND(VATAmount, Currency."Amount Rounding Precision");
                            END
                        ELSE BEGIN
                            IF (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount") = 0 THEN BEGIN
                                VATDifference := 0;
                                ECDifference := 0;
                            END ELSE BEGIN
                                VATDifference :=
                                  TempVATAmountLineRemainder."VAT Difference" +
                                  VATAmountLine."VAT Difference" * (LineAmountToInvoice - InvDiscAmount) /
                                  (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount");
                                ECDifference :=
                                  TempVATAmountLineRemainder."EC Difference" +
                                  VATAmountLine."EC Difference" * (LineAmountToInvoice - InvDiscAmount) /
                                  (VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount");
                            END;

                            IF LineAmountToInvoice = 0 THEN BEGIN
                                "VAT Difference" := 0;
                                "EC Difference" := 0;
                            END ELSE BEGIN
                                "VAT Difference" := ROUND(VATDifference, Currency."Amount Rounding Precision");
                                "EC Difference" := ROUND(ECDifference, Currency."Amount Rounding Precision");
                            END;
                        END;

                        IF QtyType = QtyType::General THEN BEGIN
                            Amount := NewAmount;
                            "Amount Including VAT" := ROUND(NewAmountIncludingVAT, Currency."Amount Rounding Precision");
                            "VAT Base Amount" := NewVATBaseAmount;
                        END;
                        InitOutstanding;
                        MODIFY;
                        RecRef.GETTABLE(ServiceLine);
                        ChangeLogMgt.LogModification(RecRef);

                        TempVATAmountLineRemainder."Amount Including VAT" :=
                          NewAmountIncludingVAT - ROUND(NewAmountIncludingVAT, Currency."Amount Rounding Precision");
                        TempVATAmountLineRemainder."VAT Amount" := VATAmount - NewAmountIncludingVAT + NewAmount;
                        TempVATAmountLineRemainder."VAT Difference" := VATDifference - "VAT Difference";
                        TempVATAmountLineRemainder."EC Difference" := ECDifference - "EC Difference";
                        TempVATAmountLineRemainder.MODIFY;
                    END;
                UNTIL NEXT = 0;
            SETRANGE(Type);
            SETRANGE(Quantity);
            SETRANGE("Qty. to Invoice");
            SETRANGE("Qty. to Ship");
        END;
    end;

    /// <summary>
    /// CalcInvDiscToInvoice()
    /// </summary>
    local procedure CalcInvDiscToInvoice()
    var
        OldInvDiscAmtToInv: Decimal;
    begin
        GetServHeader;
        OldInvDiscAmtToInv := "Inv. Disc. Amount to Invoice";
        IF (Quantity = 0) OR (CalcChargeableQty = 0) THEN
            VALIDATE("Inv. Disc. Amount to Invoice", 0)
        ELSE
            VALIDATE(
              "Inv. Disc. Amount to Invoice",
              ROUND(
                "Inv. Discount Amount" * "Qty. to Invoice" / CalcChargeableQty,
                Currency."Amount Rounding Precision"));

        IF OldInvDiscAmtToInv <> "Inv. Disc. Amount to Invoice" THEN BEGIN
            "Amount Including VAT" := "Amount Including VAT" - "VAT Difference";
            "VAT Difference" := 0;
            "EC Difference" := 0;
        END;
    end;

    /// <summary>
    /// GetServHeader()
    /// </summary>
    local procedure GetServHeader()
    begin
        TESTFIELD("Document No.");
        IF ("Document No." <> ServHeader."No.") THEN BEGIN
            ServHeader.GET("Document No.");
            IF ServHeader."Currency Code" = '' THEN
                Currency.InitRoundingPrecision
            ELSE BEGIN
                ServHeader.TESTFIELD("Currency Factor");
                Currency.GET(ServHeader."Currency Code");
                Currency.TESTFIELD("Amount Rounding Precision");
            END;
        END;
    end;

    /// <summary>
    /// CalcChargeableQty()
    /// </summary>
    procedure CalcChargeableQty(): Decimal
    begin
        EXIT(Quantity - "Quantity Consumed" - "Qty. to Consume");
    end;

    /// <summary>
    /// InitOutstanding()
    /// </summary>
    procedure InitOutstanding()
    begin
        "Outstanding Quantity" := Quantity - "Quantity Shipped";
        "Outstanding Qty. (Base)" := "Quantity (Base)" - "Qty. Shipped (Base)";
        "Qty. Shipped Not Invoiced" := "Quantity Shipped" - "Quantity Invoiced" - "Quantity Consumed";
        "Qty. Shipped Not Invd. (Base)" := "Qty. Shipped (Base)" - "Qty. Invoiced (Base)" - "Qty. Consumed (Base)";
        "Completely Shipped" := (Quantity <> 0) AND ("Outstanding Quantity" = 0);
        InitOutstandingAmount;
    end;

    /// <summary>
    /// InitOutstandingAmount()
    /// </summary>
    procedure InitOutstandingAmount()
    var
        AmountInclVAT: Decimal;
    begin
        IF (Quantity = 0) OR (CalcChargeableQty = 0) THEN BEGIN
            "Outstanding Amount" := 0;
            "Outstanding Amount (LCY)" := 0;
            "Shipped Not Invoiced" := 0;
            "Shipped Not Invoiced (LCY)" := 0;
        END ELSE BEGIN
            GetServHeader;
            AmountInclVAT := "Amount Including VAT";
            VALIDATE(
              "Outstanding Amount",
              ROUND(
                AmountInclVAT * "Outstanding Quantity" / Quantity,
                Currency."Amount Rounding Precision"));
            VALIDATE(
              "Shipped Not Invoiced",
              ROUND(
                AmountInclVAT * "Qty. Shipped Not Invoiced" / CalcChargeableQty,
                Currency."Amount Rounding Precision"));
        END;
    end;

    /// <summary>
    /// CalcVATAmountLines()
    /// </summary>
    procedure CalcVATAmountLines(QtyType: Option General,Invoicing,Shipping,Consuming; var ServHeader: Record "Posted Service Header_LDR"; var ServiceLine: Record "Posted Service Line_LDR"; var VATAmountLine: Record "VAT Amount Line"; isShip: BoolEAN)
    var
        PrevVatAmountLine: Record "VAT Amount Line";
        Currency: Record "Currency";
        SalesSetup: Record "Sales & Receivables Setup";
        ServLine2: Record "Posted Service Line_LDR";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        QtyFactor: Decimal;
        TotalVATAmount: Decimal;
        RoundingLineInserted: BoolEAN;
    begin
        IF ServHeader."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
        ELSE
            Currency.GET(ServHeader."Currency Code");

        VATAmountLine.DELETEALL;

        WITH ServiceLine DO BEGIN
            SETRANGE("Document No.", ServHeader."No.");
            SETFILTER(Type, '>0');
            SETFILTER(Quantity, '<>0');
            SalesSetup.GET;
            IF SalesSetup."Invoice Rounding" THEN BEGIN
                ServLine2.COPYFILTERS(ServiceLine);
                RoundingLineInserted := ServiceLine.COUNT <> ServLine2.COUNT;
            END;
            IF FINDSET THEN
                REPEAT
                    IF "VAT Calculation Type" IN
                       ["VAT Calculation Type"::"Reverse Charge VAT", "VAT Calculation Type"::"Sales Tax"]
                    THEN BEGIN
                        "VAT %" := 0;
                        "EC %" := 0;
                    END;
                    IF NOT
                       VATAmountLine.GET(
                         "VAT Identifier",
                         "VAT Calculation Type",
                         "Tax Group Code",
                         FALSE, "Line Amount" >= 0)
                    THEN BEGIN
                        VATAmountLine.INIT;
                        VATAmountLine."VAT Identifier" := "VAT Identifier";
                        VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                        VATAmountLine."Tax Group Code" := "Tax Group Code";
                        VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                        VATAmountLine."EC %" := VATPostingSetup."EC %";
                        VATAmountLine."VAT %" := VATPostingSetup."VAT %";
                        VATAmountLine.Modified := TRUE;
                        VATAmountLine.Positive := "Line Amount" >= 0;
                        VATAmountLine.INSERT;
                    END;
                    QtyFactor := 0;
                    CASE QtyType OF
                        QtyType::Invoicing:
                            BEGIN
                                CASE TRUE OF
                                    NOT isShip:
                                        BEGIN
                                            IF CalcChargeableQty <> 0 THEN
                                                QtyFactor := GetAbsMin("Qty. to Invoice", "Qty. Shipped Not Invoiced") / CalcChargeableQty;
                                            VATAmountLine.Quantity :=
                                              VATAmountLine.Quantity + GetAbsMin("Qty. to Invoice (Base)", "Qty. Shipped Not Invd. (Base)");
                                        END;
                                    ELSE BEGIN
                                        IF CalcChargeableQty <> 0 THEN
                                            QtyFactor := "Qty. to Invoice" / CalcChargeableQty;
                                        VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Invoice (Base)";
                                    END;
                                END;
                                VATAmountLine."Line Amount" :=
                                  VATAmountLine."Line Amount" +
                                  ROUND("Line Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                IF "Allow Invoice Disc." THEN
                                    VATAmountLine."Inv. Disc. Base Amount" :=
                                      VATAmountLine."Inv. Disc. Base Amount" +
                                      ROUND("Line Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                VATAmountLine."Invoice Discount Amount" :=
                                  VATAmountLine."Invoice Discount Amount" + "Inv. Disc. Amount to Invoice";
                                VATAmountLine."Pmt. Discount Amount" :=
                                  VATAmountLine."Pmt. Discount Amount" +
                                  ROUND("Pmt. Disc. Given Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                VATAmountLine."Line Discount Amount" := VATAmountLine."Line Discount Amount" + "Line Discount Amount";
                                VATAmountLine."VAT Difference" := VATAmountLine."VAT Difference" + "VAT Difference";
                                VATAmountLine."EC Difference" := VATAmountLine."EC Difference" + "EC Difference";
                                VATAmountLine.MODIFY;
                            END;
                        QtyType::Shipping:
                            BEGIN
                                QtyFactor := "Qty. to Ship" / Quantity;
                                VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Ship (Base)";
                                VATAmountLine."Line Amount" :=
                                  VATAmountLine."Line Amount" +
                                  ROUND("Line Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                IF "Allow Invoice Disc." THEN
                                    VATAmountLine."Inv. Disc. Base Amount" :=
                                      VATAmountLine."Inv. Disc. Base Amount" +
                                      ROUND("Line Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                VATAmountLine."Invoice Discount Amount" :=
                                  VATAmountLine."Invoice Discount Amount" +
                                  ROUND("Inv. Discount Amount" * QtyFactor, Currency."Amount Rounding Precision");
                                VATAmountLine."Pmt. Discount Amount" :=
                                  VATAmountLine."Pmt. Discount Amount" + "Pmt. Disc. Given Amount";
                                VATAmountLine."Line Discount Amount" := VATAmountLine."Line Discount Amount" + "Line Discount Amount";
                                VATAmountLine."VAT Difference" := VATAmountLine."VAT Difference" + "VAT Difference";
                                VATAmountLine."EC Difference" := VATAmountLine."EC Difference" + "EC Difference";
                                VATAmountLine.MODIFY;
                            END;
                        QtyType::Consuming:
                            BEGIN
                                CASE TRUE OF
                                    NOT isShip:
                                        BEGIN
                                            QtyFactor := GetAbsMin("Qty. to Consume", "Qty. Shipped Not Invoiced") / Quantity;
                                            VATAmountLine.Quantity :=
                                              VATAmountLine.Quantity + GetAbsMin("Qty. to Consume (Base)", "Qty. Shipped Not Invd. (Base)");
                                        END;
                                    ELSE BEGIN
                                        QtyFactor := "Qty. to Consume" / Quantity;
                                        VATAmountLine.Quantity := VATAmountLine.Quantity + "Qty. to Consume (Base)";
                                    END;
                                END;
                            END
                        ELSE BEGIN
                            VATAmountLine.Quantity := VATAmountLine.Quantity + "Quantity (Base)";
                            VATAmountLine."Line Amount" := VATAmountLine."Line Amount" + "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" :=
                                  VATAmountLine."Inv. Disc. Base Amount" + "Line Amount";
                            VATAmountLine."Invoice Discount Amount" :=
                              VATAmountLine."Invoice Discount Amount" + "Inv. Discount Amount";
                            VATAmountLine."Pmt. Discount Amount" :=
                              VATAmountLine."Pmt. Discount Amount" + "Pmt. Disc. Given Amount";
                            VATAmountLine."Line Discount Amount" := VATAmountLine."Line Discount Amount" + "Line Discount Amount";
                            VATAmountLine."VAT Difference" := VATAmountLine."VAT Difference" + "VAT Difference";
                            VATAmountLine."EC Difference" := VATAmountLine."EC Difference" + "EC Difference";
                            VATAmountLine.MODIFY;
                        END;
                    END;
                    IF RoundingLineInserted THEN
                        TotalVATAmount := TotalVATAmount + "Amount Including VAT" - Amount + "VAT Difference";
                UNTIL NEXT = 0;
            SETRANGE(Type);
            SETRANGE(Quantity);
        END;

        WITH VATAmountLine DO
            IF FIND('-') THEN
                REPEAT
                    IF (PrevVatAmountLine."VAT Identifier" <> "VAT Identifier") OR
                       (PrevVatAmountLine."VAT Calculation Type" <> "VAT Calculation Type") OR
                       (PrevVatAmountLine."Tax Group Code" <> "Tax Group Code") OR
                       (PrevVatAmountLine."Use Tax" <> "Use Tax")
                    THEN
                        PrevVatAmountLine.INIT;
                    IF ServHeader."Prices Including VAT" THEN BEGIN
                        CASE "VAT Calculation Type" OF
                            "VAT Calculation Type"::"Normal VAT",
                            "VAT Calculation Type"::"No taxable VAT":
                                BEGIN
                                    "VAT Base" :=
                                      ROUND(
                                        ("Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount") /
                                        (1 + ("VAT %" + "EC %") / 100),
                                        Currency."Amount Rounding Precision") - "VAT Difference";
                                    "VAT Amount" :=
                                      "VAT Difference" +
                                      ROUND(
                                        PrevVatAmountLine."VAT Amount" +
                                        ("Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount" -
                                        "VAT Base" - "VAT Difference") / ("VAT %" + "EC %") * "VAT %" *
                                        (1 - ServHeader."VAT Base Discount %" / 100),
                                        Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    "EC Amount" :=
                                      "EC Difference" +
                                      ROUND(
                                        ("Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount" -
                                        "VAT Base") / ("VAT %" + "EC %") * "EC %" * (1 - ServHeader."VAT Base Discount %" / 100),
                                        Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    "Amount Including VAT" := "VAT Base" + "VAT Amount" + "EC Amount";
                                    IF Positive THEN
                                        PrevVatAmountLine.INIT
                                    ELSE BEGIN
                                        PrevVatAmountLine := VATAmountLine;
                                        PrevVatAmountLine."VAT Amount" :=
                                          ("Line Amount" - "Invoice Discount Amount" - "VAT Base" - "VAT Difference") *
                                          (1 - ServHeader."VAT Base Discount %" / 100);
                                        PrevVatAmountLine."VAT Amount" :=
                                          PrevVatAmountLine."VAT Amount" -
                                          ROUND(PrevVatAmountLine."VAT Amount", Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    END;
                                END;
                            "VAT Calculation Type"::"Reverse Charge VAT":
                                BEGIN
                                    "VAT Base" :=
                                      ROUND(
                                        ("Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount"),
                                        Currency."Amount Rounding Precision");
                                    "VAT Amount" := 0;
                                    "EC Amount" := 0;
                                    "Amount Including VAT" := "VAT Base";
                                END;
                            "VAT Calculation Type"::"Full VAT":
                                BEGIN
                                    "VAT Base" := 0;
                                    "VAT Amount" := "VAT Difference" + "Line Amount" - "Invoice Discount Amount";
                                    "Amount Including VAT" := "VAT Amount";
                                END;
                            "VAT Calculation Type"::"Sales Tax":
                                BEGIN
                                    "Amount Including VAT" := "Line Amount" - "Invoice Discount Amount";
                                    "VAT Base" :=
                                      ROUND(
                                        SalesTaxCalculate.ReverseCalculateTax(
                                          ServHeader."Tax Area Code", "Tax Group Code", ServHeader."Tax Liable",
                                          ServHeader."Posting Date", "Amount Including VAT", Quantity, ServHeader."Currency Factor"),
                                        Currency."Amount Rounding Precision");
                                    "VAT Amount" := "VAT Difference" + "Amount Including VAT" - "VAT Base";
                                    IF "VAT Base" = 0 THEN BEGIN
                                        "VAT %" := 0;
                                        "EC %" := 0;
                                    END ELSE BEGIN
                                        "VAT %" := ROUND(100 * "VAT Amount" / "VAT Base", 0.000001);
                                        "EC %" := ROUND(100 * "EC Amount" / "VAT Base", 0.000001);
                                    END;
                                END;
                        END;
                    END ELSE BEGIN
                        CASE "VAT Calculation Type" OF
                            "VAT Calculation Type"::"Normal VAT",
                            "VAT Calculation Type"::"No taxable VAT":
                                BEGIN
                                    "VAT Base" := "Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount";
                                    "VAT Amount" :=
                                      "VAT Difference" +
                                      ROUND(
                                        PrevVatAmountLine."VAT Amount" +
                                        "VAT Base" * "VAT %" / 100 * (1 - ServHeader."VAT Base Discount %" / 100),
                                        Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    "EC Amount" :=
                                      "EC Difference" +
                                      ROUND(
                                         "VAT Base" * "EC %" / 100 * (1 - ServHeader."VAT Base Discount %" / 100),
                                         Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    "Amount Including VAT" := "Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount"
                                    + "VAT Amount" + "EC Amount";
                                    IF Positive THEN
                                        PrevVatAmountLine.INIT
                                    ELSE BEGIN
                                        PrevVatAmountLine := VATAmountLine;
                                        PrevVatAmountLine."VAT Amount" :=
                                          "VAT Base" * "VAT %" / 100 * (1 - ServHeader."VAT Base Discount %" / 100);
                                        PrevVatAmountLine."VAT Amount" :=
                                          PrevVatAmountLine."VAT Amount" -
                                          ROUND(PrevVatAmountLine."VAT Amount", Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                                    END;
                                END;
                            "VAT Calculation Type"::"Reverse Charge VAT":
                                BEGIN
                                    "VAT Base" := "Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount";
                                    "VAT Amount" := 0;
                                    "EC Amount" := 0;
                                    "Amount Including VAT" := "VAT Base";
                                END;
                            "VAT Calculation Type"::"Full VAT":
                                BEGIN
                                    "VAT Base" := 0;
                                    "VAT Amount" := "VAT Difference" + "Line Amount" - "Invoice Discount Amount";
                                    "Amount Including VAT" := "VAT Amount";
                                END;
                            "VAT Calculation Type"::"Sales Tax":
                                BEGIN
                                    "VAT Base" := "Line Amount" - "Invoice Discount Amount" - "Pmt. Discount Amount";
                                    "VAT Amount" :=
                                      SalesTaxCalculate.CalculateTax(
                                        ServHeader."Tax Area Code", "Tax Group Code", ServHeader."Tax Liable",
                                        ServHeader."Posting Date", "VAT Base", Quantity, ServHeader."Currency Factor");
                                    "Amount Including VAT" := "VAT Base" + "VAT Amount" + "EC Amount";
                                END;
                        END;
                    END;
                    IF RoundingLineInserted THEN
                        TotalVATAmount := TotalVATAmount - "VAT Amount";
                    "Calculated VAT Amount" := "VAT Amount" - "VAT Difference";
                    "Calculated EC Amount" := "EC Amount" - "EC Difference";
                    MODIFY;
                UNTIL NEXT = 0;

        IF RoundingLineInserted AND (TotalVATAmount <> 0) THEN
            IF VATAmountLine.GET(ServiceLine."VAT Identifier", ServiceLine."VAT Calculation Type",
                 ServiceLine."Tax Group Code", FALSE, ServiceLine."Line Amount" >= 0)
            THEN BEGIN
                VATAmountLine."VAT Amount" := VATAmountLine."VAT Amount" + TotalVATAmount;
                VATAmountLine."Amount Including VAT" := VATAmountLine."Amount Including VAT" + TotalVATAmount;
                VATAmountLine."Calculated VAT Amount" := VATAmountLine."Calculated VAT Amount" + TotalVATAmount;
                VATAmountLine.MODIFY;
            END;
    end;

    /// <summary>
    /// GetAbsMin()
    /// </summary>
    local procedure GetAbsMin(QTyToHandle: Decimal; QtyHandled: Decimal): Decimal
    begin
        IF QtyHandled = 0 THEN
            EXIT(QTyToHandle);
        IF ABS(QtyHandled) < ABS(QTyToHandle) THEN BEGIN
            EXIT(QtyHandled)
        END ELSE
            EXIT(QTyToHandle);
    end;

    /// <summary>
    /// MaxQtyToInvoice()
    /// </summary>
    procedure MaxQtyToInvoice(): Decimal
    begin
        EXIT("Quantity Shipped" + "Qty. to Ship" - "Quantity Invoiced" - "Quantity Consumed" - "Qty. to Consume");
    end;

    /// <summary>
    /// ShowDimensions()
    /// </summary>
    procedure ShowDimensions()
    begin
        TESTFIELD("No.");
        TESTFIELD("Line No.");
        //>> UPG2016_RPB Start
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2 %3', TABLECAPTION, "Document No.", "Line No."));
        //>> UPG2016_RPB End
    end;

    /// <summary>
    /// ItemAvailability()
    /// </summary>
    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        GetServHeader;
        TESTFIELD(Type, Type::Item);
        TESTFIELD("No.");
        Item.RESET;
        Item.GET("No.");
        Item.SETRANGE("No.", "No.");
        Item.SETRANGE("Date Filter", 0D, ServHeader."Response Date");

        CASE AvailabilityType OF
            AvailabilityType::Date:
                BEGIN
                    Item.SETRANGE("Variant Filter", "Variant Code");
                    Item.SETRANGE("Location Filter", "Location Code");
                    CLEAR(ItemAvailByDate);
                    ItemAvailByDate.SETRECORD(Item);
                    ItemAvailByDate.SETTABLEVIEW(Item);
                    ItemAvailByDate.RUNMODAL;
                END;
            AvailabilityType::Variant:
                BEGIN
                    Item.SETRANGE("Location Filter", "Location Code");
                    CLEAR(ItemAvailByVar);
                    ItemAvailByVar.LOOKUPMODE(TRUE);
                    ItemAvailByVar.SETRECORD(Item);
                    ItemAvailByVar.SETTABLEVIEW(Item);
                    IF ItemAvailByVar.RUNMODAL = ACTION::LookupOK THEN
                        IF "Variant Code" <> ItemAvailByVar.GetLastVariant THEN
                            IF
                               CONFIRM(
                                 Text020, TRUE, FIELDCAPTION("Variant Code"), "Variant Code",
                                 ItemAvailByVar.GetLastVariant)
                            THEN
                                VALIDATE("Variant Code", ItemAvailByVar.GetLastVariant);
                END;
            AvailabilityType::Location:
                BEGIN
                    Item.SETRANGE("Variant Filter", "Variant Code");
                    CLEAR(ItemAvailByLoc);
                    ItemAvailByLoc.LOOKUPMODE(TRUE);
                    ItemAvailByLoc.SETRECORD(Item);
                    ItemAvailByLoc.SETTABLEVIEW(Item);
                    IF ItemAvailByLoc.RUNMODAL = ACTION::LookupOK THEN
                        IF "Location Code" <> ItemAvailByLoc.GetLastLocation THEN
                            IF
                               CONFIRM(
                                 Text020, TRUE, FIELDCAPTION("Location Code"), "Location Code",
                                 ItemAvailByLoc.GetLastLocation)
                            THEN
                                VALIDATE("Location Code", ItemAvailByLoc.GetLastLocation);
                END;
        END;
    end;
}