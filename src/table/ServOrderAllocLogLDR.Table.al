/// <summary>
/// Table ServOrderAllocLog_LDR (ID 50220)
/// </summary>
table 50220 ServOrderAllocLog_LDR
{
    // UPG2016 23/12/2015 1CF_FVB Field 'User Id' Code20 -> Code50

    Caption = 'ServOrderAllocLog';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; Datetime; DateTime)
        {
            Caption = 'Datetime';
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo";
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; "Resource No."; Code[20])
        {
            Caption = 'ResourceNo';
            TableRelation = Resource;
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'UPG2016';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                LoginMgt.DisplayUserInformation(Rec."User ID");
            end;
        }
        field(7; "Document Line No."; Integer)
        {
        }
        field(50001; Responsible; BoolEAN)
        {
            Caption = 'Responsible';
        }
        field(50002; "Exported to Mobility"; BoolEAN)
        {
            Caption = 'Exported to Mobility';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    /// <summary>
    /// GetNextNo()
    /// </summary>
    procedure GetNextNo() EntryNo: Integer
    var
        Log: Record "ServOrderAllocLog_LDR";
    begin
        CLEAR(Log);
        IF Log.FINDLAST THEN;
        EntryNo := Log."Entry No." + 1;
    end;

    /// <summary>
    /// CreateEntry()
    /// </summary>
    procedure CreateEntry(pDocType: Option Quote,"Order",Invoice,"Credit Memo"; pDocNo: Code[20]; pDocLineNo: Integer; pResourceNo: Code[20]; pResponsible: BoolEAN)
    var
        NewEntry: Record "ServOrderAllocLog_LDR";
    begin
        NewEntry.Datetime := CREATEDATETIME(TODAY, TIME);
        NewEntry."User ID" := USERID;
        NewEntry."Document Type" := pDocType;
        NewEntry."Document No." := pDocNo;
        NewEntry."Document Line No." := pDocLineNo;
        NewEntry."Resource No." := pResourceNo;
        NewEntry."Entry No." := NewEntry.GetNextNo;
        NewEntry.Responsible := pResponsible;
        NewEntry.INSERT;
    end;
}