/// <summary>
/// tableextension 50005 "Vendor_LDR"
/// </summary>
tableextension 50005 "Vendor_LDR" extends Vendor
{
    fields
    {
        field(50000; "Bank Forecast_LDR"; Code[20])
        {
            Caption = 'Banco Previsión';
            DataClassification = ToBeClassified;
            Enabled = false;
            TableRelation = "Bank Account";
        }
        field(50001; "Refueling Vendor_LDR"; BoolEAN)
        {
            Caption = 'Proveedor Combustible';
            DataClassification = ToBeClassified;
        }
        field(50003; "Old Vendor No._LDR"; Code[20])
        {
            Caption = 'Nº Proveedor Antiguo';
            DataClassification = ToBeClassified;
        }
        field(50004; "Exported to Mobility_LDR"; BoolEAN)
        {
            Caption = 'Exportado a Movilidad';
            DataClassification = ToBeClassified;
        }
        field(50005; "Last User Modified_LDR"; Code[50])
        {
            Caption = 'Usuario Última Modificación';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Vendor Customer No._LDR"; Text[20])
        {
            Caption = 'Nº Cliente Proveedor';
            DataClassification = ToBeClassified;
            Description = 'Almacena el Nº Proveedor para el Cliente';
        }
        field(50007; "Rating Code_LDR"; Code[20])
        {
            Caption = 'Código de Calificación';
            DataClassification = ToBeClassified;
            TableRelation = "Rating Code_LDR";
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Search Name")
        { }
    }

    trigger OnAfterInsert()
    var
        PurchaseSetupAux: Record "Purchases & Payables Setup";
    begin
        if PurchaseSetupAux."Create Payment Days" then begin

        end;
    end;

    trigger OnAfterDelete()
    var
        ItemVendor: Record "Item Vendor";
        PurchPrice: Record "Purchase Price";
        PurchLineDiscount: Record "Purchase Line Discount";
        PurchPrepmtPct: Record "Purchase Prepayment %";
        //SocialListeningSearchTopic: Record "Social Listening Search Topic";
        CustomReportSelection: Record "Custom Report Selection";
        PurchOrderLine: Record "Purchase Line";
        VendBankAcc: Record "Vendor Bank Account";
        CommentLine: Record "Comment Line";
        OrderAddr: Record "Order Address";
        VendPmtAddr: Record "Vendor Pmt. Address";
        //ItemCrossReference: Record "Item Cross Reference";
        ServiceItem: Record "Service Item Line";
    begin
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::Vendor);
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll();

        VendBankAcc.SetRange("Vendor No.", "No.");
        VendBankAcc.DeleteAll();

        OrderAddr.SetRange("Vendor No.", "No.");
        OrderAddr.DeleteAll();

        VendPmtAddr.SetRange("Vendor No.", "No.");
        if VendPmtAddr.Find('-') then
            VendPmtAddr.DeleteAll();

        //ItemCrossReference.SetCurrentKey("Cross-Reference Type", "Cross-Reference Type No.");
        //ItemCrossReference.SetRange("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::Vendor);
        //ItemCrossReference.SetRange("Cross-Reference Type No.", "No.");
        //ItemCrossReference.DeleteAll();

        PurchOrderLine.SetCurrentKey("Document Type", "Pay-to Vendor No.");
        PurchOrderLine.SetFilter(
          "Document Type", '%1|%2',
          PurchOrderLine."Document Type"::Order,
          PurchOrderLine."Document Type"::"Return Order");
        PurchOrderLine.SetRange("Pay-to Vendor No.", "No.");
        if PurchOrderLine.Find('-') then
            Error(
              Text50000,
              TableCaption, "No.",
        PurchOrderLine."Document Type", Companies.Name);

        PurchOrderLine.SetRange("Pay-to Vendor No.");
        PurchOrderLine.SetRange("Buy-from Vendor No.", "No.");
        if PurchOrderLine.Find('-') then
            Error(
              Text50000,
              TableCaption, "No.", Companies.Name);

        ServiceItem.SetRange("Vendor No.", "No.");
        ServiceItem.ModifyAll("Vendor No.", '');

        ItemVendor.SetRange("Vendor No.", "No.");
        ItemVendor.DeleteAll(true);

        PurchPrice.SetCurrentKey("Vendor No.");
        PurchPrice.SetRange("Vendor No.", "No.");
        PurchPrice.DeleteAll(true);

        PurchLineDiscount.SetCurrentKey("Vendor No.");
        PurchLineDiscount.SetRange("Vendor No.", "No.");
        PurchLineDiscount.DeleteAll(true);

        PurchPrepmtPct.SetCurrentKey("Vendor No.");
        PurchPrepmtPct.SetRange("Vendor No.", "No.");
        PurchPrepmtPct.DeleteAll(true);

        CustomReportSelection.SetRange("Source Type", DATABASE::Vendor);
        CustomReportSelection.SetRange("Source No.", "No.");
        CustomReportSelection.DeleteAll();
    end;

    var
        Companies: Record "Company";
        Text50000: TextConst ENU = 'You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor in company %4.', ESP = 'No puede borrar %1 %2 porque hay al menos una compra pendiente %3 para este proveedor en la empresa %4.';

    procedure CreateAlarmFor(Type: Integer)
    var
        ServItemLine: Record "Service Item Line";
        NewAlarm: Record "Alarms_LDR";
    //AlarmCard: Page 70104;
    begin
        case Type of
            1:
                begin
                    TestField("No.");
                    Clear(NewAlarm);
                    NewAlarm."Alarm No." := NewAlarm.GetNextAlarmNo;
                    NewAlarm."Start Date" := WorkDate();
                    NewAlarm."Source Type" := NewAlarm."Source Type"::Vendor;
                    NewAlarm."Source No." := "No.";
                    NewAlarm."User ID" := UserId;
                    NewAlarm.insert(true);
                end;
        end;

        //Clear(AlarmCard);
        //AlarmCard.setTableView(NewAlarm);
        //AlarmCard.SetRecord(NewAlarm);
        //AlarmCard.Run();
    end;
}