/// <summary>
/// Codeunit EventosTablas_LDR (ID 50003)
/// </summary>
codeunit 50100 "EventosTablas_LDR"
{
    //**********************************************************************************************************  17
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line");
    var
        CarteraSetup: Record "Cartera Setup";
    begin
        if CarteraSetup.Get() then;
        if GenJournalLine."Journal Batch Name" = CarteraSetup."VISA Journal Name_LDR" then
            GLEntry.Description := CarteraSetup."VISA Description_LDR";

        GLEntry."Leasing No._LDR" := GenJournalLine."Leasing No._LDR";
        GLEntry."Leasing Line No._LDR" := GenJournalLine."Leasing Line No._LDR";
    end;

    //**********************************************************************************************************  203
    [EventSubscriber(ObjectType::Table, Database::"Res. Ledger Entry", OnAfterCopyFromResJnlLine, '', false, false)]
    local procedure OnAfterCopyFromResJnlLine(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line");
    var
        Res: Record "Resource";
        UnitOfMeasure: Record "Unit of Measure";
    begin
        Res.Get(ResLedgerEntry."Resource No.");
        UnitOfMeasure.Get(ResJournalLine."Unit of Measure Code");
        if UnitOfMeasure."Time Measure Unit_LDR" = true then begin
            ResJournalLine.TestField("Initial Time_LDR");
            ResJournalLine.TestField("End Time_LDR");
        end;

        ResLedgerEntry.Replicated_LDR := ResJournalLine.Replicated_LDR;
        ResLedgerEntry."Resource Name_LDR" := Res.Name;
        ResLedgerEntry."Initial Time_LDR" := ResJournalLine."Initial Time_LDR";
        ResLedgerEntry."End Time_LDR" := ResJournalLine."End Time_LDR";
        ResLedgerEntry."Internal Quantity_LDR" := ResJournalLine."Internal Quantity_LDR";
    end;

    //**********************************************************************************************************  5940
    [EventSubscriber(ObjectType::Table, Database::"Service Item", OnBeforeValidateCustomerNo, '', false, false)]
    local procedure OnBeforeValidateCustomerNo(var ServiceItem: Record "Service Item"; CurrFieldNo: Integer; var IsHandled: BoolEAN)
    var
        Cust: Record Customer;
        xRecServiceItem: Record "Service Item";
        ServMgtSetup: Record "Service Mgt. Setup";
        ServLogMgt: Codeunit ServLogManagement;
    begin
        ServMgtSetup.Get;
        ServMgtSetup.TestField("No. Internal Customer_LDR");

        Clear(Cust);
        Cust.SetRange("No.", ServiceItem."Customer No.");
        if Cust.FindFirst() then begin
            ServiceItem.Validate("Branch Customer No._LDR", ServiceItem."Customer No.");
        end;

        if ServiceItem."Customer No." = ServMgtSetup."No. Internal Customer_LDR" then begin
            ServiceItem.Validate("Branch Customer No._LDR", ServiceItem."Customer No.");
        end;

        if xRecServiceItem.Get(ServiceItem."No.") then;
        ServiceItem."Ship-to Code" := '';
        if (ServiceItem."Customer No." <> '') and (xRecServiceItem."Customer No." = '') then
            ServiceItem.Status := ServiceItem.Status::Installed;
        ServLogMgt.ServItemCustChange(ServiceItem, xRecServiceItem);
        ServLogMgt.ServItemShipToCodeChange(ServiceItem, xRecServiceItem);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Item", OnAfterAssignItemValues, '', false, false)]
    local procedure OnAfterAssignItemValues(var ServiceItem: Record "Service Item"; var xServiceItem: Record "Service Item"; Item: Record Item; CurrFieldNo: Integer)
    begin
        ServiceItem.Validate("Manufacturer Code_LDR", Item."Manufacturer Code");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Item", OnBeforeCheckIfCanBeDeleted, '', false, false)]
    local procedure OnBeforeCheckIfCanBeDeleted(var ServiceItem: Record "Service Item"; var Result: Text; var IsHandled: BoolEAN)
    var
        Companies: Record "Company";
        ServContract: Record "Service Contract Header";
        ServContractLine: Record "Service Contract Line";
        ServItemComponent: Record "Service Item Component";
        Text50000: Label 'No puedes borrar %1 %2,porque hay adjunto en la empresa %3';
        Text50006: Label 'No puedes borrar %1 %2, porque esta en uso %3 para %1 %4 en empresa %5';
        Text50007: Label 'No puedes borrar %1 %2, porque pertenece a uno o más contratos en la empresa %3';
    begin
        IF Companies.FindSet() then begin
            repeat
                if ServiceItem.ServItemLinesExistCompany(Companies.Name) THEN
                    Result := StrSubstNo(Text50000, ServiceItem.TableCaption, ServiceItem."No.", Companies.Name);

                ServItemComponent.Reset();
                ServItemComponent.ChangeCompany(Companies.Name);
                ServItemComponent.SetCurrentKey(Type, "No.", Active);
                ServItemComponent.SetRange(Type, ServItemComponent.Type::"Service Item");
                ServItemComponent.SetRange("No.", ServiceItem."No.");
                if ServItemComponent.FindFirst() then
                    Result := StrSubstNo(Text50006, ServiceItem.TableCaption, ServiceItem."No.",
                                ServItemComponent.TableCaption, ServItemComponent."Parent Service Item No.", Companies.Name);

                ServContractLine.Reset();
                ServContractLine.ChangeCompany(Companies.Name);
                ServContractLine.SetCurrentKey("Service Item No.", "Contract Status");
                ServContractLine.SetRange("Service Item No.", ServiceItem."No.");
                ServContractLine.SetFilter("Contract Status", '<>%1', ServContractLine."Contract Status"::Cancelled);
                if ServContractLine.FindFirst() then begin
                    ServContract.ChangeCompany(Companies.Name);
                    if ServContract.Get(ServContractLine."Contract Type", ServContractLine."Contract No.") then
                        Result := StrSubstNo(Text50007, ServiceItem.TableCaption, ServiceItem."No.", Companies.Name);
                end;
            until Companies.next = 0;
            IsHandled := true;
        end;
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeInitInsert, '', false, false)]
    // local procedure OnBeforeInitInsert(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var IsHandled: BoolEAN);
    // var
    //     NoSeriesMgt: Codeunit NoSeriesManagement;
    // begin
    //     if SalesHeader."No." = '' then begin
    //         if SalesHeader."Sales Order Series No." = '' then begin
    //             SalesHeader."No. Series" := SalesHeader.GetNoSeriesCode();
    //         end else begin
    //             SalesHeader.TestNoSeries();
    //             NoSeriesMgt.InitSeries(SalesHeader."Sales Order Series No.", SalesHeader."No. Series", SalesHeader."Posting Date", SalesHeader."No.", SalesHeader."Sales Order Series No.");
    //             SalesHeader."No. Series" := SalesHeader."Sales Order Series No.";
    //         end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeCreateDimSetForPrepmtAccDefaultDim, '', false, false)]
    // local procedure OnBeforeCreateDimSetForPrepmtAccDefaultDim(SalesHeader: Record "Sales Header"; var IsHandled: BoolEAN);
    // var
    //     TempSalesLine: Record 37;
    // begin
    //     if SalesHeader."Document Type" = SalesHeader."Document Type" then
    //         if not SalesHeader.IsApprovedForPosting() then
    //             Database::"Unit of Measure", TempSalesLine."Unit of Measure",
    //             DataBase::"Work Type", TempSalesLine."Work Type Code";
    //     exit;
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnFindResUnitCostOnAfterInitResCost, '', false, false)]
    // local procedure OnFindResUnitCostOnAfterInitResCost(var SalesLine: Record "Sales Line"; var ResourceCost: Record "Resource Cost");
    // begin
    //     ResourceCost."Unit Cost"."Unit of Measure Code" := SalesLine."Unit of Measure Code";
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeCreateDim, '', false, false)]  //TODO: Esta obsoleta segun "Seles Line"
    // local procedure OnBeforeCreateDim(var Sender: Record "Sales Line"; var IsHandled: BoolEAN; var SalesLine: Record "Sales Line"; FieldNo: Integer; DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]);
    // var
    //     TableID: array[10] of Integer;
    //     No: array[10] of Code[20];
    // begin
    //     TableID[4] := Type4;
    //     No[4] := No4;
    //     TableID[5] := Type5;
    //     No[5] := No5;
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", OnAfterInsertInvLineFromShptLine, '', false, false)]
    // local procedure OnAfterInsertInvLineFromShptLine(var SalesLine: Record "Sales Line"; SalesOrderLine: Record "Sales Line"; var NextLineNo: Integer; SalesShipmentLine: Record "Sales Shipment Line");
    // var
    //     SalesInvHeader: Record 36;
    //     SalesOrderHeader: Record 36;
    //     TransferOldExtLines: Codeunit 379;
    //     ItemTrackingMgt: Codeunit 6500;
    //     LanguageManagement: Codeunit 43;
    //     ExtTextLine: BoolEAN;
    //     IsHandled: BoolEAN;
    //     SalesShipmentHeader: Record "Sales Shipment Header";
    // begin
    //     if SalesLine."Shipment No." <> "Document No." then begin
    //         SalesShipmentHeader.GET("Document No.");
    //     end;
    //     if SalesShipmentHeader."Your Reference" <> '' then begin
    //         SalesLine.init;
    //         SalesLine."Line No." := NextLineNo;
    //         SalesLine."Document Type" := TempSalesLine."Document Type";
    //         SalesLine."Document No." := TempSalesLine."Document No.";
    //         SalesLine.Description := StrSubsTNo.(Text50000, SalesShipmentHeader."Your Reference");
    //         SalesLine.Insert();
    //         NextLineNo := NextLineNo + 10000;
    //     end;
    // end;


    // [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", OnAfterInitFromSalesLine, '', false, false)]
    // local procedure OnAfterInitFromSalesLine(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line");
    // begin
    //     IF (SalesInvLine."No." = '') AND (SalesInvLine.Type IN [SalesInvLine.Type::"G/L Account" .. SalesInvHeader.Type::"Charge (Item)"]) THEN
    //         SalesInvLine.Type := SalesInvLine.Type::" ";
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", OnAfterInsertInvLineFromRcptLine, '', false, false)]
    local procedure OnAfterInsertInvLineFromRcptLine(var PurchLine: Record "Purchase Line"; PurchOrderLine: Record "Purchase Line"; var NextLineNo: Integer; PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchCalcDiscount: Codeunit "Purch.-Calc.Discount";
    begin
        PurchSetup.Get();
        if PurchSetup."Calc. Inv. Discount" then
            PurchCalcDiscount.CalculateInvoiceDiscountOnLine(PurchLine);
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Res. Ledger Entry", OnAfterCopyFromResJnlLine, '', false, false)]
    // local procedure OnAfterCopyFromResJnlLine(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line");
    // var
    //     Res: Record 156;
    //     UnitOfMeasure: Record 204;
    //     ResJnlLine: Record 207;
    // begin
    //     ResLedgerEntry.Replicated := ResJnlLine.Replicated;
    //     Res.GET(ResLedgerEntry."Resource No.");
    //     ResLedgerEntry."Resource Name" := Res.Name;
    //     UnitOfMeasure.GET(ResJnlLine."Unit of Measure Code");
    //     IF UnitOfMeasure."Time Measure Unit" = TRUE THEN BEGIN
    //         ResJnlLine.TESTFIELD("Initial Time");
    //         ResJnlLine.TESTFIELD("End Time");
    //     END;

    //     ResLedgerEntry."Initial Time" := "Initial Time";
    //     ResLedgerEntry."End Time" := "End Time";
    //     ResLedgerEntry."Internal Quantity" := "Internal Quantity";
    // end;

    /// <summary>
    /// ProcessSingleEntry.
    /// </summary>
    /// <param name="Rec">Record "Service Item Refills Reg_LDR".</param>
    procedure ProcessSingleEntry(Rec: Record "Service Item Refills Reg_LDR")
    begin

    end;
}