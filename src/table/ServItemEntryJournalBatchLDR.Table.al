/// <summary>
/// Table Serv.Item Entr Journ Batch_LDR (ID 50211)
/// </summary>
table 50211 "Serv.Item Entr Journ Batch_LDR"
{
    Caption = 'Serv.Item. Entry Journal Batch';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Serv Item Entr Journ Templ_LDR";
        }
        field(2; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ServiceItemBinJnlTemplate: Record "Serv Item Entr Journ Templ_LDR";
        ServiceItemBinJnlLine: Record "Posted Serv Item Bin Entr_LDR";
        Text000: Label 'Only the %1 field can be filled in on recurring journals.';
        Text001: Label 'must not be %1';

    /// <summary>
    /// SetupNewBatch()
    /// </summary>
    procedure SetupNewBatch()
    begin
        ServiceItemBinJnlTemplate.GET("Journal Template Name");
        "No. Series" := ServiceItemBinJnlTemplate."No. Series";
    end;
}