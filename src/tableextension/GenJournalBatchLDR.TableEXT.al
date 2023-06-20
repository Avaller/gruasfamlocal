/// <summary>
/// tableextension 50104 "Gen. Journal Batch_LDR"
/// </summary>
tableextension 50104 "Gen. Journal Batch_LDR" extends "Gen. Journal Batch"
{
    procedure ClearDataExchEntries();
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", Name);
        if GenJnlLine.FindSet then
            repeat
                GenJnlLine.ClearDataExchangeEntries(true);
            until GenJnlLine.Next() = 0;
    end;
}