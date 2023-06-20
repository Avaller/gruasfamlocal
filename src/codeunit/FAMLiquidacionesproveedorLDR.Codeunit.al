/// <summary>
/// Codeunit FAM Liquidac proveedor_LDR (ID 50098)
/// </summary>
codeunit 50098 "FAM Liquidac proveedor_LDR"
{
    trigger OnRun()
    var
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlLine: Record "Gen. Journal Line";
        ApplicationDate: Date;
        VendEntryApplyPostedEntries: Codeunit "VendEntry-Apply Posted Entries";
    begin
        VendEntryApplID := USERID;
        VendLedgerEntries.SETRANGE("Entry No.", 1031, 1036);  // Introduce aqui el numero movimiento
        VendLedgerEntries.SETRANGE("Document Type", VendLedgerEntries."Document Type"::" ");
        VendLedgerEntries.SETRANGE(Open, TRUE);
        IF VendLedgerEntries.FINDSET THEN BEGIN
            REPEAT
                ApplyingVendLedgEntry.COPY(VendLedgerEntries);
                IF ApplyingVendLedgEntry."Remaining Amount" = 0 THEN
                    ApplyingVendLedgEntry.CALCFIELDS("Remaining Amount");

                ApplyingVendLedgEntry."Applying Entry" := TRUE;
                ApplyingVendLedgEntry."Applies-to ID" := VendEntryApplID;
                ApplyingVendLedgEntry."Amount to Apply" := ApplyingVendLedgEntry."Remaining Amount";
                CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", ApplyingVendLedgEntry);
                // COMMIT;

                VendLedgerEntries2.SETCURRENTKEY("Vendor No.", Open, Positive);
                VendLedgerEntries2.SETRANGE("Vendor No.", ApplyingVendLedgEntry."Vendor No.");
                VendLedgerEntries2.SETRANGE(Open, TRUE);
                VendLedgerEntries2.SETRANGE("Document No.", ApplyingVendLedgEntry."Document No.");
                VendLedgerEntries2.SETRANGE("Entry No.", ApplyingVendLedgEntry."Entry No." - 1);
                VendLedgerEntries2.SETRANGE("Document Type", VendLedgerEntries2."Document Type"::Invoice);
                IF VendLedgerEntries2.FINDFIRST THEN BEGIN
                    IF ApplyingVendLedgEntry."Entry No." <> 0 THEN
                        GenJnlApply.CheckAgainstApplnCurrency(
                          ApplyingVendLedgEntry."Currency Code", VendLedgerEntries2."Currency Code", GenJnlLine."Account Type"::Vendor, TRUE);

                    VendEntrySetApplID.SetApplId(VendLedgerEntries2, ApplyingVendLedgEntry, VendEntryApplID);

                    ApplicationDate := VendEntryApplyPostedEntries.GetApplicationDate(ApplyingVendLedgEntry);
                    VendEntryApplyPostedEntries.Apply(ApplyingVendLedgEntry, ApplyingVendLedgEntry."Document No.", ApplicationDate);

                    ApplyingVendLedgEntry."Applying Entry" := FALSE;
                    ApplyingVendLedgEntry."Applies-to ID" := '';
                    ApplyingVendLedgEntry."Amount to Apply" := 0;
                END;

            UNTIL VendLedgerEntries.NEXT = 0;
        END;

        MESSAGE('fin');
    end;

    var
        ApplyingVendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgerEntries: Record "Vendor Ledger Entry";
        VendLedgerEntries2: Record "Vendor Ledger Entry";
        VendEntryApplID: Text;
}