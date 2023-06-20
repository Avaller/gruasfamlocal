/// <summary>
/// Codeunit FAM Liquidaciones_LDR (ID 50099)
/// </summary>
codeunit 50099 "FAM Liquidaciones_LDR"
{
    trigger OnRun()
    var
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlLine: Record "Gen. Journal Line";
        ApplicationDate: Date;
        CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
    begin
        CustEntryApplID := USERID;
        CustLedgerEntries.SETRANGE("Entry No.", 269, 500);  // Introduce aqui el numero movimiento
        CustLedgerEntries.SETRANGE("Document Type", CustLedgerEntries."Document Type"::" ");
        CustLedgerEntries.SETRANGE(Open, TRUE);
        IF CustLedgerEntries.FINDSET THEN BEGIN
            REPEAT
                ApplyingCustLedgEntry.COPY(CustLedgerEntries);
                IF ApplyingCustLedgEntry."Remaining Amount" = 0 THEN
                    ApplyingCustLedgEntry.CALCFIELDS("Remaining Amount");

                ApplyingCustLedgEntry."Applying Entry" := TRUE;
                ApplyingCustLedgEntry."Applies-to ID" := CustEntryApplID;
                ApplyingCustLedgEntry."Amount to Apply" := ApplyingCustLedgEntry."Remaining Amount";
                CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", ApplyingCustLedgEntry);
                // COMMIT;

                CustLedgerEntries2.SETCURRENTKEY("Customer No.", Open, Positive);
                CustLedgerEntries2.SETRANGE("Customer No.", ApplyingCustLedgEntry."Customer No.");
                CustLedgerEntries2.SETRANGE(Open, TRUE);
                CustLedgerEntries2.SETRANGE("Document No.", ApplyingCustLedgEntry."Document No.");
                CustLedgerEntries2.SETRANGE("Entry No.", ApplyingCustLedgEntry."Entry No." - 1);
                CustLedgerEntries2.SETRANGE("Document Type", CustLedgerEntries2."Document Type"::Invoice);
                IF CustLedgerEntries2.FINDFIRST THEN BEGIN
                    IF ApplyingCustLedgEntry."Entry No." <> 0 THEN
                        GenJnlApply.CheckAgainstApplnCurrency(
                          ApplyingCustLedgEntry."Currency Code", CustLedgerEntries2."Currency Code", GenJnlLine."Account Type"::Customer, TRUE);

                    CustEntrySetApplID.SetApplId(CustLedgerEntries2, ApplyingCustLedgEntry, CustEntryApplID);

                    ApplicationDate := CustEntryApplyPostedEntries.GetApplicationDate(ApplyingCustLedgEntry);
                    CustEntryApplyPostedEntries.Apply(ApplyingCustLedgEntry, ApplyingCustLedgEntry."Document No.", ApplicationDate);

                    ApplyingCustLedgEntry."Applying Entry" := FALSE;
                    ApplyingCustLedgEntry."Applies-to ID" := '';
                    ApplyingCustLedgEntry."Amount to Apply" := 0;
                END;

            UNTIL CustLedgerEntries.NEXT = 0;
        END;

        MESSAGE('fin');
    end;

    var
        ApplyingCustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgerEntries: Record "Cust. Ledger Entry";
        CustLedgerEntries2: Record "Cust. Ledger Entry";
        CustEntryApplID: Text;
}