/// <summary>
/// tableextension 50076 "Resource Location_LDR"
/// </summary>
tableextension 50076 "Resource Location_LDR" extends "Resource Location"
{
    fields
    {
        modify("Resource No.")
        {
            trigger OnAfterValidate()
            begin
                CheckMain();
            end;
        }
        field(50000; Main_LDR; Boolean)
        {
            Caption = 'Principal';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckMain();
            end;
        }
        field(50001; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50002; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key2; "Resource No.", "Starting Date")
        {

        }
    }

    trigger OnBeforeInsert()
    begin
        "Created Date_LDR" := CurrentDateTime;
    end;

    trigger OnBeforeModify()
    begin
        "Modified Date_LDR" := CurrentDateTime;
    end;

    procedure CheckMain();
    var
        TempResLocation: Record "Resource Location";
        txtMain: TextConst ENU = 'Resource No. %1 has already as main the location No. %2', ESP = 'El Recurso %1 ya tiene definido como principal el almacén %2';
    begin
        if Main_LDR then begin
            Clear(TempResLocation);
            TempResLocation.SetFilter(TempResLocation."Location Code", '<>%1', "Location Code");
            TempResLocation.SetRange(TempResLocation."Resource No.", "Resource No.");
            TempResLocation.SetRange(Main_LDR, true);
            if TempResLocation.FindFirst() then
                Error(txtMain, "Resource No.", TempResLocation."Location Code");
        end;
    end;
}