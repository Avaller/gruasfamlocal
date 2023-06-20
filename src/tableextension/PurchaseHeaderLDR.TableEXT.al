/// <summary>
/// tableextension 50010 "Purchase Header_LDR"
/// </summary>
tableextension 50010 "Purchase Header_LDR" extends "Purchase Header"
{
    fields
    {
        field(50000; Forecast_LDR; BoolEAN)
        {
            Caption = 'Previsión';
            DataClassification = ToBeClassified;
        }
        field(50001; "Machine Purchase Document_LDR"; BoolEAN)
        {
            Caption = 'Compra de Máquina';
            DataClassification = ToBeClassified;
            Description = 'Determina si se trata de una Compra de una Máquina';
        }
        field(50002; "Sended to AS400_LDR"; BoolEAN)
        {
            Caption = 'Enviado a AS400';
            DataClassification = ToBeClassified;
            Description = 'AS400';
        }
        field(50003; Resupply_LDR; BoolEAN)
        {
            Caption = 'Reaprovisionamiento';
            DataClassification = ToBeClassified;
            Description = 'AS400';
        }
        field(50004; "Total Amount_LDR"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            Caption = 'Importe';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Vendor Contract No._LDR"; Code[20])
        {
            Caption = 'Nº Contrato Proveedor';
            DataClassification = ToBeClassified;
            //TableRelation = Table70072.Field1 WHERE (Field2=CONST(1))"; //TODO: Revisar si conservamos la tabla
        }
        field(50006; Notas1_LDR; Text[100])
        {
            Caption = 'Notas';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key10; "Buy-from Vendor No.", "Vendor Authorization No.")
        {
        }
    }

    var
        Text000: TextConst ENU = 'Do you want to print receipt %1?', ESP = '¿Confirma que desea imprimir el albarán %1?';
        Text001: TextConst ENU = 'Do you want to print invoice %1?', ESP = '¿Confirma que desea imprimir la factura %1?';
        Text002: TextConst ENU = 'Do you want to print credit memo %1?', ESP = '¿Confirma que desea imprimir el abono %1?';
        Text024: TextConst ENU = 'Do you want to print return shipment %1?', ESP = '¿Confirma que desea imprimir el envío devolución %1?';
        Text043: TextConst ENU = 'Do you want to print prepayment invoice %1?', ESP = '¿Desea imprimir la factura prepago %1?';
        Text044: TextConst ENU = 'Do you want to print prepayment credit memo %1?', ESP = '¿Desea imprimir el abono prepago %1?';
        Text3: TextConst ENU = 'It is not possible to close %1 because it is included on bill group.', ESP = '%1 No se puede liquidar ya que esta incluido en una remesa.';
        Text4: TextConst ENU = 'Delete it from Bill group and try.', ESP = 'Borrelo de la remesa e intentelo de nuevo.';

    trigger OnAfterDelete()
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ReturnShptHeader: Record "Return Shipment Header";
        PurchInvHeaderPrepmt: Record "Purch. Inv. Header";
        PurchCrMemoHeaderPrepmt: Record "Purch. Cr. Memo Hdr.";
    begin
        Commit();

        if PurchRcptHeader."No." <> '' then
            if Confirm(
                 Text000, true,
                 PurchRcptHeader."No.")
            then begin
                PurchRcptHeader.SetRecFilter();
                PurchRcptHeader.PrintRecords(true);
            end;

        if PurchInvHeader."No." <> '' then
            if Confirm(
                 Text001, true,
                 PurchInvHeader."No.")
            then begin
                PurchInvHeader.SetRecFilter();
                PurchInvHeader.PrintRecords(true);
            end;

        if PurchCrMemoHeader."No." <> '' then
            if Confirm(
                 Text002, true,
                 PurchCrMemoHeader."No.")
            then begin
                PurchCrMemoHeader.SetRecFilter();
                PurchCrMemoHeader.PrintRecords(true);
            end;

        if ReturnShptHeader."No." <> '' then
            if Confirm(
                 Text024, true,
                 ReturnShptHeader."No.")
            then begin
                ReturnShptHeader.SetRecFilter();
                ReturnShptHeader.PrintRecords(true);
            end;

        if PurchInvHeaderPrepmt."No." <> '' then
            if Confirm(
                 Text043, true,
                 PurchInvHeader."No.")
            then begin
                PurchInvHeaderPrepmt.SetRecFilter();
                PurchInvHeaderPrepmt.PrintRecords(true);
            end;

        if PurchCrMemoHeaderPrepmt."No." <> '' then
            if Confirm(
                 Text044, true,
                 PurchCrMemoHeaderPrepmt."No.")
            then begin
                PurchCrMemoHeaderPrepmt.SetRecFilter();
                PurchCrMemoHeaderPrepmt.PrintRecords(true);
            end;
    end;

    procedure CheckBillSituation();
    var
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        Doc: Record "Cartera Doc.";
    begin
        VendorLedgerEntry2.SetCurrentKey("Document No.", "Document Type", "Vendor No.");
        VendorLedgerEntry2.SetRange("Document No.", "Applies-to Doc. No.");
        VendorLedgerEntry2.SetRange("Bill No.", "Applies-to Bill No.");
        VendorLedgerEntry2.SetFilter("Document Status", '<>%1', VendorLedgerEntry2."Document Status"::" ");
        if VendorLedgerEntry2.Find('-') then begin
            VendorLedgerEntry2.TestField("Document Status", VendorLedgerEntry2."Document Status"::Open);
            if Doc.Get(Doc.Type::Receivable, VendorLedgerEntry2."Entry No.") then
                if Doc."Bill Gr./Pmt. Order No." <> '' then
                    Error(
                      Text3 +
                      Text4,
                      VendorLedgerEntry2.Description);
        end;
    end;

    procedure CheckCostZero(tempPurchHeader: Record "Purchase Header") result: BoolEAN;
    var
        pHeader: Record "Purchase Header";
        pLines: Record "Purchase Line";
    begin
        if pHeader.Get(tempPurchHeader."Document Type", tempPurchHeader."No.") then begin
            Clear(pLines);
            pLines.SetRange("Document Type", pHeader."Document Type");
            pLines.SetRange("Document No.", pHeader."No.");
            pLines.SetFilter(pLines."Unit Cost", '%1', 0);
            if pLines.FindFirst() then
                exit(true)
            else
                exit(false);
        end;
    end;

    procedure updateCostZero(tempPurchHeader: Record "Purchase Header");
    var
        pHeader: Record "Purchase Header";
        pLines: Record "Purchase Line";
        itemLedgerEntries: Record "Item Ledger Entry";
        pLines2: Record "Purchase Line";
        item: Record "Item";
    begin
        if pHeader.Get(tempPurchHeader."Document Type", tempPurchHeader."No.") then begin
            Clear(pLines);
            pLines.SetRange("Document Type", pHeader."Document Type");
            pLines.SetRange("Document No.", pHeader."No.");
            pLines.SetRange(Type, pLines.Type::Item);
            pLines.SetFilter(pLines."Unit Cost", '<>%1', 0);
            if pLines.FindSet then begin
                repeat
                    Clear(item);
                    item.Get(pLines."No.");
                    if item."Unit Cost" = 0 then begin

                        Clear(itemLedgerEntries);
                        itemLedgerEntries.SetCurrentKey("Item No.");
                        itemLedgerEntries.SetRange("Item No.", pLines."No.");

                        Clear(pLines2);
                        pLines2.SetCurrentKey("Document Type", Type, "No.");
                        pLines2.SetFilter(
                          "Document Type", '%1|%2',
                          pLines2."Document Type"::Order,
                          pLines2."Document Type"::"Return Order");
                        pLines2.SetFilter(pLines2."Document No.", '<>%1', pHeader."No.");
                        pLines2.SetRange(Type, pLines2.Type::Item);
                        pLines2.SetRange("No.", pLines."No.");

                        if (not itemLedgerEntries.FindFirst) and (not pLines2.FindFirst) then begin
                            item."Unit Cost" := pLines."Unit Cost";
                            item.Modify(true);
                        end;
                    end;
                until pLines.Next = 0;
            end;
        end;
    end;

    local procedure UpdateTaxWithholdingLines();
    begin
        ;
        Modify();
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        if PurchLine.FindSet() then begin
            repeat
                PurchLine.Modify();
            until PurchLine.Next() = 0;
        end;
    end;

    procedure SetForecast(PaytoVendorNo: Code[20]);
    var
        TempForecast: Record "Forecast_LDR";
    begin
        TempForecast.SetRange("Vendor No.", PaytoVendorNo);
        TempForecast.SetRange(Status, TempForecast.Status::OPEN);
        TempForecast.SetRange("Summary declaration", TempForecast."Summary declaration"::FACTURA);
        if TempForecast.FindFirst then
            Forecast_LDR := true
        else
            Forecast_LDR := false;
    end;
}