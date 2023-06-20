/// <summary>
/// Table Performanc Session Archiv_LDR (ID 50057)
/// </summary>
table 50057 "Performanc Session Archiv_LDR"
{
    DataCaptionFields = "Code", Description;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; Fecha; Date)
        {
        }
        field(4; Inicio; Time)
        {
        }
        field(5; Fin; Time)
        {
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

    trigger OnDelete()
    var
        PerformanceProfilerArchive: Record "Performanc Profiler Archiv_LDR";
    begin
        PerformanceProfilerArchive.SETRANGE("Session Code", Code);
        PerformanceProfilerArchive.DELETEALL;
    end;
}