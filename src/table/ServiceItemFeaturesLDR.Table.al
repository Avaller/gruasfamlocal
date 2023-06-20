/// <summary>
/// Table Service Item Features_LDR (ID 50008)
/// </summary>
table 50008 "Service Item Features_LDR"
{
    Caption = 'Service Item Features';
    DataPerCompany = false;
    LookupPageID = "Service Item Features";

    fields
    {
        field(1; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item";
        }
        field(2; JIB; BoolEAN)
        {
            Caption = 'JIB';
        }
        field(3; Bed; Text[30])
        {
            Caption = 'Base Dimensions';
        }
        field(4; "Height Gauge"; Decimal)
        {
            Caption = 'Height Gauge';
        }
        field(5; "Maximun Load"; Decimal)
        {
            Caption = 'Maximun Load';
        }
        field(6; "Type Crane Model"; Text[30])
        {
            Caption = 'Type Crane Model';
        }
        field(7; "Jib Lenght"; Decimal)
        {
            Caption = 'Jib Lenght';
        }
        field(8; "Jib Extension"; Text[30])
        {
            Caption = 'Jib Extension';
        }
        field(9; "Winches Maximun Load"; Decimal)
        {
            Caption = 'Winches Maximun Load';
        }
        field(10; "Rear Supports"; BoolEAN)
        {
            Caption = 'Rear Supports';
        }
        field(11; "Width Front Supports"; Decimal)
        {
            Caption = 'Width Front Supports';
        }
        field(12; "Axles Traction Direction"; Text[30])
        {
            Caption = 'Axles Traction Direction';
        }
        field(13; Tires; Text[30])
        {
            Caption = 'Tires';
        }
        field(14; "Remote Control"; BoolEAN)
        {
            Caption = 'Remote Control';
        }
        field(15; "Electric Brake"; BoolEAN)
        {
            Caption = 'Electric Bracke';
        }
        field(16; "Spare Wheel"; BoolEAN)
        {
            Caption = 'Spare Wheel';
        }
        field(17; "Wheel Measures"; Text[30])
        {
            Caption = 'Wheel Measures';
        }
        field(18; "No. Winches"; Integer)
        {
            Caption = 'No. Winches';
        }
        field(19; Nib; Text[30])
        {
            Caption = 'Nib';
        }
        field(20; "Retractable Nib Lenght"; Decimal)
        {
            Caption = 'Retractable Nib Lenght';
        }
        field(21; Hooks; Text[30])
        {
            Caption = 'Hooks';
        }
        field(22; Runner; Text[30])
        {
            Caption = 'Runner';
        }
        field(23; "Work Area Limiter"; BoolEAN)
        {
            Caption = 'Work Area Limiter';
        }
        field(24; "Pressure Control Supports"; BoolEAN)
        {
            Caption = 'Pressure Control Supports';
        }
        field(25; "Base Counterweight"; Decimal)
        {
            Caption = 'Base Counterweight';
        }
        field(26; "Maximum Counterweight"; Decimal)
        {
            Caption = 'Maximum Counterweight';
        }
        field(27; Anemometer; BoolEAN)
        {
            Caption = 'Anemometer';
        }
        field(28; Superlift; BoolEAN)
        {
            Caption = 'Superlift';
        }
        field(29; Control; BoolEAN)
        {
            Caption = 'Control';
        }
        field(30; "Working Lights"; BoolEAN)
        {
            Caption = 'Working Lights';
        }
        field(31; Others; Text[250])
        {
            Caption = 'Others';
        }
        field(32; "Light Airplane"; BoolEAN)
        {
            Caption = 'Light Airplane';
        }
        field(33; Variousbase; BoolEAN)
        {
            Caption = 'Variousbase';
        }
        field(34; "Additional Feather"; BoolEAN)
        {
            Caption = 'Additional Feather';
        }
        field(35; "Additional Feather Desc."; Text[30])
        {
            Caption = 'Additional Feather Desc.';
        }
        field(36; "Maximum Load Drag - trailer"; Decimal)
        {
            Caption = 'Maximum Load Drag (trailer)';
        }
        field(37; "Total Distance"; Decimal)
        {
            Caption = 'Total Distance';
        }
        field(38; "Wheelbase 1-2"; Decimal)
        {
            Caption = 'Wheelbase (1-2)';
        }
        field(39; "Wheelbase 2-3"; Decimal)
        {
            Caption = 'Wheelbase (2-3)';
        }
        field(40; "Wheelbase 3-4"; Decimal)
        {
            Caption = 'Wheelbase (3-4)';
        }
        field(41; "Rear Cantilever"; Decimal)
        {
            Caption = 'Rear Cantilever';
        }
        field(42; "5th Wheel to Last Distance"; Decimal)
        {
            Caption = '5th Wheel to Last Distance';
        }
        field(43; "Admit Trailers"; BoolEAN)
        {
            Caption = 'Admit Trailers';
        }
        field(44; "Power System"; Option)
        {
            Caption = 'Power System';
            OptionCaption = 'Diesel,Electric';
            OptionMembers = Diesel,Electric;
        }
        field(45; "Working Height"; Decimal)
        {
            Caption = 'Working Height';
        }
        field(46; "Platform Height"; Decimal)
        {
            Caption = 'Platform Height';
        }
        field(47; "Maximum capacity"; Decimal)
        {
            Caption = 'Maximum capacity';
        }
        field(48; "Speed Translation"; Text[30])
        {
            Caption = 'Speed Translation';
        }
        field(49; Width; Decimal)
        {
            Caption = 'Width';
        }
        field(50; "Turning Radius"; Decimal)
        {
            Caption = 'Turning Radius';
        }
        field(51; "Maximum Slope"; Decimal)
        {
            Caption = 'Maximum Slope';

            trigger OnValidate()
            begin
                IF "Maximum Slope" > 100 THEN
                    "Maximum Slope" := 100
                ELSE
                    IF "Maximum Slope" < 0 THEN
                        "Maximum Slope" := 0;
            end;
        }
        field(52; Power; Text[30])
        {
            Caption = 'Power';
        }
        field(53; "Total Weight"; Decimal)
        {
            Caption = 'Total Weight';
        }
        field(54; "Extended Dimensions"; Text[30])
        {
            Caption = 'Extended Dimensions';
        }
        field(55; "Height Retracted Railings"; Decimal)
        {
            Caption = 'Height Retracted Railings';
        }
        field(56; "Retracted Height"; Decimal)
        {
            Caption = 'Retracted Height';
        }
        field(58; "Upload-Download Time"; Text[30])
        {
            Caption = 'Upload-Download Time';
        }
        field(59; "Point Articulation"; Decimal)
        {
            Caption = 'Point Articulation';
        }
        field(60; "Platform Dimensions"; Text[20])
        {
            Caption = 'Platform Dimensions';
        }
        field(61; "Retracted Long"; Decimal)
        {
            Caption = 'Retracted Long';
        }
        field(62; "Maximum Range"; Decimal)
        {
            Caption = 'Maximum Range';
        }
        field(63; Length; Decimal)
        {
            Caption = 'Length';
        }
        field(64; Height; Decimal)
        {
            Caption = 'Height';
        }
        field(65; "Rear Range"; Text[20])
        {
            Caption = 'Rear Range';
        }
        field(66; "Wheelbase 4-5"; Decimal)
        {
            Caption = 'Wheelbase 4-5';
        }
        field(67; "Wheelbase 5-6"; Decimal)
        {
            Caption = 'Wheelbase 5-6';
        }
        field(68; "Wheelbase 6-7"; Decimal)
        {
            Caption = 'Distancia entre Ejes (6-7)';
        }
        field(69; "Wheelbase 7-8"; Decimal)
        {
            Caption = 'Wheelbase 7-8';
        }
    }

    keys
    {
        key(Key1; "Service Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}