/// <summary>
/// tableextension 50039 "Order Address_LDR"
/// </summary>
tableextension 50039 "Order Address_LDR" extends "Order Address"
{
    fields
    {
        field(50001; "Last User Modified"; Code[50])
        {
            Caption = 'Usuario Última Modificación';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    trigger OnAfterModify()
    begin
        "Last User Modified" := UserId;
    end;

    trigger OnAfterRename()
    begin
        "Last User Modified" := UserId;
    end;
}