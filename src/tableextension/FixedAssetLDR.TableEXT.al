/// <summary>
/// tableextension 50060 "Fixed Asset_LDR"
/// </summary>
tableextension 50060 "Fixed Asset_LDR" extends "Fixed Asset"
{
    fields
    {
        field(50000; "Service Item No._LDR"; Code[20])
        {
            Caption = 'Nº Producto Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item";

            trigger OnValidate()
            begin
                CreateDim(
                Database::"Service Item", "Service Item No._LDR",
                0, '',
                0, '',
                0, '');
            end;
        }
    }

    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20]);
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        G1: Code[20];
        G2: Code[20];
        DimMgt: Codeunit DimensionManagement;
    begin
        SourceCodeSetup.Get();
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;

        DimMgt.GetDefaultDimID(
          TableID, No, SourceCodeSetup."Fixed Asset_LDR",
          G1, G2, 0, 0);
        // if "No." <> '' then
        //     DimMgt.UpdateAFDim(Database::"Fixed Asset", "No.", G1, G2);
    end;
}