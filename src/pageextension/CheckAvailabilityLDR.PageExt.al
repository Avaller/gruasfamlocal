/// <summary>
/// PageExtension Check Availability_LDR (ID 50066) extends Record Check Availability.
/// </summary>
pageextension 50066 "Check Availability_LDR" extends "Check Availability"
{

    /// <summary>
    /// ItemVendorJnlLineShowWarning.
    /// </summary>
    /// <param name="ItemJnlLine">Record 70066.</param>
    /// <returns>Return value of type Boolean.</returns>
    //procedure ItemVendorJnlLineShowWarning(ItemJnlLine: Record 70066): Boolean;
    //begin
    //    SalesSetup.Get();
    //    if not SalesSetup."Stockout Warning" then
    //        exit(false);
    //    case ItemJnlLine."Entry Type" OF
    //        ItemJnlLine."Entry Type"::"0":
    //            ItemNetChange := -ItemJnlLine.Quantity;
    //        ItemJnlLine."Entry Type"::"1":
    //            ItemNetChange := ItemJnlLine.Quantity;
    //    END;
    //    EXIT(
    //      ShowWarning(
    //        ItemJnlLine."Item No.",
    //        '',
    //        ItemJnlLine."Location Code",
    //        ItemJnlLine."Unit of Measure Code",
    //        ItemJnlLine."Qty. per Unit of Measure",
    //        ItemNetChange,
    //        0,
    //        0D,
    //        0D));
    //end;

    local procedure ShowWarning(ItemNo2: Code[20]; ItemVariantCode: Code[10]; ItemLocationCode: Code[10]; UnitOfMeasureCode2: Code[10]; QtyPerUnitOfMeasure2: Decimal; NewItemNetChange2: Decimal; OldItemNetChange2: Decimal; ShipmentDate: Date; OldShipmentDate: Date): Boolean;
    begin
        ItemNo := ItemNo2;
        UnitOfMeasureCode := UnitOfMeasureCode2;
        QtyPerUnitOfMeasure := QtyPerUnitOfMeasure2;
        NewItemNetChange := NewItemNetChange2;
        OldItemNetChange := ConvertQty(OldItemNetChange2);
        OldItemShipmentDate := OldShipmentDate;

        if NewItemNetChange >= 0 then
            exit(false);

        Rec.Get(ItemNo);
        Rec.SETRANGE("No.", Rec."No.");
        Rec.SETRANGE("Variant Filter", ItemVariantCode);
        Rec.SETRANGE("Location Filter", ItemLocationCode);
        Rec.SETRANGE("Drop Shipment Filter", FALSE);

        IF UseOrderPromise THEN
            Rec.SETRANGE("Date Filter", 0D, ShipmentDate)
        ELSE
            Rec.SETRANGE("Date Filter", 0D, WORKDATE);

        Item2.COPY(Rec);

        Calculate;
        EXIT(InitialQtyAvailable + ItemNetChange < 0);
    end;

    local procedure ConvertQty(Qty: Decimal): Decimal;
    begin
        if QtyPerUnitOfMeasure = 0 then
            QtyPerUnitOfMeasure := 1;
        exit(Round(Qty / QtyPerUnitOfMeasure, 0.00001));
    end;

    LOCAL PROCEDURE Calculate();
    BEGIN
        IF NOT SetupDataIsPresent THEN
            GetSetupData;

        AvailToPromise.QtyAvailabletoPromise(
          Rec, GrossReq, SchedRcpt, Rec.GETRANGEMAX("Date Filter"),
          CompanyInfo."Check-Avail. Time Bucket", CompanyInfo."Check-Avail. Period Calc.");

        EarliestAvailDate :=
          AvailToPromise.EarliestAvailabilityDate(
            Rec, -NewItemNetChange, Rec.GETRANGEMAX("Date Filter"), -OldItemNetChange, OldItemShipmentDate, AvailableQty,
            CompanyInfo."Check-Avail. Time Bucket", CompanyInfo."Check-Avail. Period Calc.");

        IF NOT UseOrderPromise THEN
            SchedRcpt := 0;

        Rec.CALCFIELDS(Inventory, "Reserved Qty. on Inventory");
        InventoryQty := ConvertQty(Rec.Inventory - Rec."Reserved Qty. on Inventory");
        GrossReq := ConvertQty(GrossReq);
        SchedRcpt := ConvertQty(SchedRcpt);

        ItemNetChange := 0;
        IF Rec."No." = ItemNo THEN BEGIN
            ItemNetChange := NewItemNetChange;
            GrossReq := GrossReq + OldItemNetChange;
        END;

        InitialQtyAvailable := InventoryQty + SchedRcpt - GrossReq;
    END;

    PROCEDURE GetSetupData();
    BEGIN
        CompanyInfo.get();
        SetupDataIsPresent := true;
    END;

    var
        InventoryQty: Decimal;
        SalesSetup: Record "Sales & Receivables Setup";
        ItemNetChange: Decimal;
        ItemNo: Code[20];
        QtyPerUnitOfMeasure: Decimal;
        NewItemNetChange: Decimal;
        OldItemNetChange: Decimal;
        OldItemShipmentDate: Date;
        UseOrderPromise: Boolean;
        Item2: Record Item;
        InitialQtyAvailable: Decimal;
        SetupDataIsPresent: Boolean;
        AvailToPromise: Codeunit "Available to Promise";
        CompanyInfo: Record "Company Information";
        AvailableQty: Decimal;
        UnitOfMeasureCode: Code[10];
        GrossReq: Decimal;
        SchedRcpt: Decimal;
        EarliestAvailDate: Date;
}