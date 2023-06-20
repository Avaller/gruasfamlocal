/// <summary>
/// Table Crane Mgt. Setup_LDR (ID 50028)
/// </summary>
table 50028 "Crane Mgt. Setup_LDR"
{
    Caption = 'Crane Mgt. Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Crane Quote Nos."; Code[10])
        {
            Caption = 'Crane Quote Nos.';
            TableRelation = "No. Series";
        }
        field(11; "General Rate No"; Code[10])
        {
            Caption = 'General Rate No';
            TableRelation = "Service Item Rate Header_LDR";
        }
        field(12; "Route File Refills"; Text[250])
        {
            Caption = 'Route File Refills';
        }
        field(13; "Route File Refills Backup"; Text[250])
        {
            Caption = 'Route File Refills Backup';
        }
        field(14; "Main Operator Work Type"; Code[10])
        {
            Caption = 'Main Operator Work Type';
            TableRelation = "Work Type";
        }
        field(15; "Ass. Operator Work Type"; Code[10])
        {
            Caption = 'Ass. Operator Work Type';
            TableRelation = "Work Type";
        }
        field(16; "Crane Service Cost Code"; Code[10])
        {
            Caption = 'Crane Service Cost Code';
            TableRelation = "Service Cost";
        }
        field(17; "Work Type Code PS Platform"; Code[10])
        {
            Caption = 'Work Type Code PS Platform';
            TableRelation = "Work Type";
        }
        field(18; "Serv. Order Type - Crane"; Code[10])
        {
            Caption = 'Service Order Type - Crane';
            TableRelation = "Service Order Type";
        }
        field(19; "Serv. Order Type - Platf. Del."; Code[10])
        {
            Caption = 'Service Order Type Platform Delivery';
            TableRelation = "Service Order Type";
        }
        field(20; "Serv. Order Type - Platf. Pick"; Code[10])
        {
            Caption = 'Service Order Type - Platfom Pickup';
            TableRelation = "Service Order Type";
        }
        field(21; "Service Item Tariff Nos."; Code[10])
        {
            Caption = 'Service Item Tariff Nos.';
            TableRelation = "No. Series";
        }
        field(22; "Finished Repair Status"; Code[10])
        {
            Caption = 'Finished Repair Status';
            TableRelation = "Repair Status";
        }
        field(23; "Daytime Workday UOM"; Code[10])
        {
            Caption = 'Daytime Workday Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(24; "Nighttime Workday UOM"; Code[10])
        {
            Caption = 'Nighttime Workday Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(25; "Daytime Saturday UOM"; Code[10])
        {
            Caption = 'Daytime Saturday Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(26; "Nighttime Saturday UOM"; Code[10])
        {
            Caption = 'Nighttime Workday Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(27; "Daytime Holiday UOM"; Code[10])
        {
            Caption = 'Daytime Holiday Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(28; "Nighttime Holiday UOM"; Code[10])
        {
            Caption = 'Nighttime Holiday Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(29; "Daytime Standby UOM"; Code[10])
        {
            Caption = 'Daytime Standby Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(30; "Nighttime Standby UOM"; Code[10])
        {
            Caption = 'Nighttime Standby Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(31; "Daytime Displacement UOM"; Code[10])
        {
            Caption = 'Daytime Displacement UOM';
            TableRelation = "Unit of Measure";
        }
        field(32; "Nighttime Displacement UOM"; Code[10])
        {
            Caption = 'Nighttime Displacement Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(33; "Internal Branch"; Code[10])
        {
            Caption = 'Internal Branch';
            TableRelation = Branch_LDR;
        }
        field(34; "Displacement Service Cost Code"; Code[10])
        {
            Caption = 'Displacement Service Cost Code';
            TableRelation = "Service Cost";
        }
        field(35; "Assistant Service Cost Code"; Code[10])
        {
            Caption = 'Assistant Service Cost Code';
            TableRelation = "Service Cost";
        }
        field(36; "Ready to Invoice Repair Status"; Code[10])
        {
            Caption = 'Ready to Invoice Repair Status';
            TableRelation = "Repair Status";
        }
        field(37; "Billiable Work Type Code"; Code[10])
        {
            Caption = 'Billiable Work Type Code';
            TableRelation = "Work Type";
        }
        field(38; "Auto Calc. Displacement"; BoolEAN)
        {
            Caption = 'Auto Calculate Displacement';
        }
        field(39; "Maint. Serv. Order Nos."; Code[10])
        {
            Caption = 'Maint. Serv. Order Nos.';
            TableRelation = "No. Series";
        }
        field(40; "Serv. Order Type - Maintenance"; Code[10])
        {
            Caption = 'Serv. Order Type - Maintenance';
            TableRelation = "Service Order Type";
        }
        field(41; "Serv. Order Type - Repair"; Code[10])
        {
            Caption = 'Serv. Order Type - Repair';
            TableRelation = "Service Order Type";
        }
        field(42; "Repair Operation Code"; Code[10])
        {
            Caption = 'Repair Operation Code';
            TableRelation = "Operations_LDR";
        }
        field(43; "Sent to Device Repair Status"; Code[10])
        {
            Caption = 'Sent to Device Repair Status';
            TableRelation = "Repair Status";
        }
        field(44; "Rec. in Device Repair Status"; Code[10])
        {
            Caption = 'Serv. Order in Device Repair Status';
            TableRelation = "Repair Status";
        }
        field(45; "Platf. Serv. Contract Group"; Code[10])
        {
            Caption = 'Platf. Serv. Contract Group';
            TableRelation = "Contract Group"."Code" WHERE(Internal_LDR = CONST(false));
        }
        field(46; "Platf. Serv. Cont. Acc. Group"; Code[10])
        {
            Caption = 'Platform Serv. Cont. Acc. Group';
            TableRelation = "Service Contract Account Group";
        }
        field(47; "Serv. Order Type - Reform"; Code[10])
        {
            Caption = 'Serv. Order Type - Reform';
            TableRelation = "Service Order Type";
        }
        field(48; "Auto Create General Quote"; BoolEAN)
        {
            Caption = 'Auto Create General Quote';
        }
        field(49; "Crane Invoice Account No"; Code[20])
        {
            Caption = 'Crane Invoice Account No';
            TableRelation = "G/L Account"."No.";
        }
        field(50; "Crane Serv. Order Nos."; Code[10])
        {
            Caption = 'Crane Serv. Order Nos.';
            TableRelation = "No. Series";
        }
        field(51; "Platf. Serv. Order Nos."; Code[10])
        {
            Caption = 'Platf. Serv. Order Nos.';
            TableRelation = "No. Series";
        }
        field(52; "Driver Resource Group"; Code[10])
        {
            Caption = 'Driver Resource Group';
            TableRelation = "Resource Group";
        }
        field(53; "Normal Resource Group"; Code[10])
        {
            Caption = 'Normal Resource Group';
            TableRelation = "Resource Group";
        }
        field(54; "Special Resource Group"; Code[10])
        {
            Caption = 'Special Resource Group';
            TableRelation = "Resource Group";
        }
        field(55; "Platform Delivery Concept"; Code[10])
        {
            Caption = 'Platform Delivery Concept';
            TableRelation = "Concept_LDR" WHERE("Type" = CONST("External"));
        }
        field(56; "Workshop Resource Group"; Code[10])
        {
            Caption = 'Special Resource Group';
            TableRelation = "Resource Group";
        }
        field(57; "Extratime UOM"; Code[10])
        {
            Caption = 'Extratime UOM';
            TableRelation = "Unit of Measure";
        }
        field(58; "Min. Crane Service Cost Code"; Code[10])
        {
            Caption = 'Minimums Crane Service Cost Code';
            TableRelation = "Service Cost";
        }
        field(59; "Worksheet PDF Path"; Text[250])
        {
            Caption = 'Worksheet PDF Path';
        }
        field(60; "Default Service Period"; DateFormula)
        {
            Caption = 'Default Service Period';
        }
        field(61; "Platform Pickup Concept"; Code[10])
        {
            Caption = 'Platform Pickup Concept';
            TableRelation = "Concept_LDR" WHERE("Type" = CONST("External"));
        }
        field(62; "Work Order Ticket Image"; BLOB)
        {
            Caption = 'Work order ticket';
            SubType = Bitmap;
        }
        field(63; "WorkLoad Jnl. Tmpl."; Code[20])
        {
            Caption = 'WorkLoad Jnl. Tmpl.';
            TableRelation = "Res. Journal Template";
        }
        field(64; "WorkLoad Jnl. Batch."; Code[20])
        {
            Caption = 'WorkLoad Jnl. Batch.';
            TableRelation = "Res. Journal Batch"."Name" WHERE("Journal Template Name" = FIELD("WorkLoad Jnl. Tmpl."));
        }
        field(67; "Traveltime Saturday UOM"; Code[10])
        {
            Caption = 'Travel Time Saturday Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(68; "Nighttraveltime Saturday UOM"; Code[10])
        {
            Caption = 'Night Travel Time Saturday Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(69; "Traveltime Holiday UOM"; Code[10])
        {
            Caption = 'Travel Time Holiday Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(70; "Nighttraveltime Holiday UOM"; Code[10])
        {
            Caption = 'Night Travel Time Holiday Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(71; "Ext Travel Work Type"; Code[10])
        {
            Caption = 'Ext Travel Work Type';
            TableRelation = "Work Type";
        }
        field(72; "Lunch Time UOM"; Code[10])
        {
            Caption = 'Lunch Time Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(73; "Standard Starting Time"; Time)
        {
            Caption = 'Standard Starting Time';
        }
        field(74; "Standard Ending Time"; Time)
        {
            Caption = 'Standard Ending Time';
        }
        field(75; "Extra traveltime UOM"; Code[10])
        {
            Caption = 'Extra traveltime UOM';
            TableRelation = "Unit of Measure";
        }
        field(76; "Platform Hour Limit"; Time)
        {
            Caption = 'Platform Hour Limit';
        }
        field(77; "Forfait Work Type"; Code[10])
        {
            Caption = 'Forfait Work Type';
            TableRelation = "Work Type";
        }
        field(78; "Refuel G/L Account"; Code[20])
        {
            Caption = 'Refuel G/L Account';
            TableRelation = "G/L Account"."No.";
        }
        field(79; "Fuel Unit Price"; Decimal)
        {
            Caption = 'Fuel Unit Price';
            MinValue = 0;
        }
        field(80; "Refuel Gen. Journal Template"; Code[20])
        {
            Caption = 'Refuel Gen. Journal Template';
            TableRelation = "Gen. Journal Template";
        }
        field(81; "Refuel Gen. Journal Batch"; Code[20])
        {
            Caption = 'Refuel Gen. Journal Batch';
            TableRelation = "Gen. Journal Batch"."Name" WHERE("Journal Template Name" = FIELD("Refuel Gen. Journal Template"));
        }
        field(82; "Forfait Gen. Journal Template"; Code[20])
        {
            Caption = 'Forfait Gen. Journal Template';
            TableRelation = "Gen. Journal Template";
        }
        field(83; "Forfait Gen. Journal Batch"; Code[20])
        {
            Caption = 'Forfait Gen. Journal Batch';
            TableRelation = "Gen. Journal Batch"."Name" WHERE("Journal Template Name" = FIELD("Refuel Gen. Journal Template"));
        }
        field(84; "Forfait Calc. Source Branch"; Code[20])
        {
            Caption = 'Forfait Calc. Source Branch';
            TableRelation = "Branch_LDR"."No.";
        }
        field(85; "Aux Veh. Travel Work Type"; Code[10])
        {
            Caption = 'Aux Vehicle Travel Work Type';
            DataClassification = ToBeClassified;
            TableRelation = "Work Type";
        }
        field(86; "Self Veh. Travel Work Type"; Code[10])
        {
            Caption = 'Self Vehicle Travel Work Type';
            DataClassification = ToBeClassified;
            TableRelation = "Work Type";
        }
        field(87; "Food Work Type Code"; Code[10])
        {
            Caption = 'Food Work Type Code';
            DataClassification = ToBeClassified;
            TableRelation = "Work Type";
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
}