/// <summary>
/// tableextension 50106 "Default Dimension_LDR"
/// </summary>
tableextension 50106 "Default Dimension_LDR" extends "Default Dimension"
{
    trigger OnBeforeInsert()
    begin
        ServSetup.Get();
        if ServSetup."Machine Type Dimension_LDR" <> '' then begin
            if "Dimension Code" = ServSetup."Machine Type Dimension_LDR" then
                UpdateServItemCard("No.", "Dimension Value Code");
        end;
    end;

    trigger OnBeforeModify()
    begin
        ServSetup.Get();
        if ServSetup."Machine Type Dimension_LDR" <> '' then begin
            if "Dimension Code" = ServSetup."Machine Type Dimension_LDR" then
                UpdateServItemCard("No.", "Dimension Value Code");
        end;
    end;

    trigger OnBeforeDelete()
    begin
        ServSetup.Get();
        if ServSetup."Machine Type Dimension_LDR" <> '' then begin
            if "Dimension Code" = ServSetup."Machine Type Dimension_LDR" then
                UpdateServItemCard("No.", '');
        end;
    end;

    var
        ServSetup: Record "Service Mgt. Setup";

    local procedure UpdateServItemCard("No.": Code[20]; NewDimValue: Code[20]);
    var
        ServItem: Record "Service Item";
    begin
        if ServItem.Get("No.") then begin
            ServItem."Machine Type Dimension_LDR" := NewDimValue;
            ServItem.Modify(true);
        end;
    end;

    local procedure UpdateLeasingGLobalDimCode(GlobalDimCodeNo: Integer; LeasingNo: Code[20]; NewDimValue: Code[20]);
    var
    //LeasingHeader : Record 70010;
    begin
        //   if LeasingHeader.Get(LeasingNo) then begin
        //     caseend; GlobalDimCodeNo of
        //       1:
        //         LeasingHeader."Global Dimension 1 Code" := NewDimValue;
        //       2:
        //         LeasingHeader."Global Dimension 2 Code" := NewDimValue;
        //     end;
        //     LeasingHeader.Modify(true);
        //   end;
    end;
}