/// <summary>
/// Codeunit FAM Actualizar proveedor_LDR (ID 50097)
/// </summary>
codeunit 50097 "FAM Actualizar proveedor_LDR"
{
    trigger OnRun()
    var
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlLine: Record "Gen. Journal Line";
        ApplicationDate: Date;
        VendEntryApplyPostedEntries: Codeunit "VendEntry-Apply Posted Entries";
        Vendor: Record "Vendor";
        VendorAddr: Record "Order Address";
        Vendor2: Record "Vendor";
        PostCode: Record "Post Code";
    begin
        Vendor.SETRANGE(Address, '');
        IF Vendor.FINDSET THEN BEGIN
            REPEAT
                CLEAR(VendorAddr);
                VendorAddr.SETRANGE("Vendor No.", Vendor."No.");
                IF VendorAddr.FINDSET THEN BEGIN
                    IF VendorAddr.COUNT = 1 THEN BEGIN
                        Vendor2.GET(Vendor."No.");
                        Vendor2.Address := VendorAddr.Address;
                        Vendor2."Address 2" := VendorAddr."Address 2";
                        Vendor2."Post Code" := VendorAddr."Post Code";
                        Vendor2.County := VendorAddr.County;
                        Vendor2.City := VendorAddr.City;
                        Vendor2.MODIFY(TRUE);
                    END;
                END;
            UNTIL Vendor.NEXT = 0;
        END;

        CLEAR(Vendor);
        Vendor.SETFILTER("Post Code", '<>%1', '');
        IF Vendor.FINDSET THEN BEGIN
            REPEAT
                IF PostCode.GET(Vendor."Post Code", Vendor.City) THEN BEGIN
                    Vendor.County := PostCode.County;
                    Vendor.MODIFY;
                END;
            UNTIL Vendor.NEXT = 0;
        END;

        MESSAGE('Fin');
    end;

    var
        ApplyingVendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgerEntries: Record "Vendor Ledger Entry";
        VendLedgerEntries2: Record "Vendor Ledger Entry";
        VendEntryApplID: Text;
}