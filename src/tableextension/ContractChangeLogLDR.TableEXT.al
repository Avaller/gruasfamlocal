/// <summary>
/// tableextension 50111 "Contract Change Log_LDR"
/// </summary>
tableextension 50111 "Contract Change Log_LDR" extends "Contract Change Log"
{
    procedure LogContractChangeCompany(ContractNo: Code[20]; ContractPart: Option Header,Line,Discount; FieldName: Text[80]; ChangeType: Integer; OldValue: Text[100]; NewValue: Text[100]; ServItemNo: Code[20]; ServContractLineNo: Integer; CompanyName: Text[80]);
    var
        ContractChangeLog: Record "Contract Change Log";
        NextChangeNo: Integer;
    begin
        ContractChangeLog.Reset();
        ContractChangeLog.LockTable();
        ContractChangeLog.ChangeCompany(CompanyName);
        ContractChangeLog.SetRange("Contract No.", ContractNo);
        if ContractChangeLog.Find('+') then
            NextChangeNo := ContractChangeLog."Change No." + 1
        else
            NextChangeNo := 1;

        ContractChangeLog.Init();
        ContractChangeLog."Contract Type" := ContractChangeLog."Contract Type"::Contract;
        ContractChangeLog."Contract No." := ContractNo;
        ContractChangeLog."User ID" := UserId;
        ContractChangeLog."Date of Change" := Today;
        ContractChangeLog."Time of Change" := Time;
        ContractChangeLog."Change No." := NextChangeNo;
        ContractChangeLog."Contract Part" := ContractPart;
        ContractChangeLog."Service Item No." := ServItemNo;
        ContractChangeLog."Serv. Contract Line No." := ServContractLineNo;

        case ChangeType of
            0:
                ContractChangeLog."Type of Change" := ContractChangeLog."Type of Change"::Modify;
            1:
                ContractChangeLog."Type of Change" := ContractChangeLog."Type of Change"::Insert;
            2:
                ContractChangeLog."Type of Change" := ContractChangeLog."Type of Change"::Delete;
            3:
                ContractChangeLog."Type of Change" := ContractChangeLog."Type of Change"::Rename;
        end;
        ContractChangeLog."Field Description" := FieldName;
        ContractChangeLog."Old Value" := OldValue;
        ContractChangeLog."New Value" := NewValue;
        ContractChangeLog.Insert();
    end;
}