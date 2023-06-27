/// <summary>
/// tableextension 50011 "Purchase Line_LDR"
/// </summary>
tableextension 50011 "Purchase Line_LDR" extends "Purchase Line"
{
    fields
    {
        field(50000; "Forecast Code_LDR"; Code[20])
        {
            Caption = 'Código de Previsión';
            DataClassification = ToBeClassified;
        }
        field(50001; "Forecast Line_LDR"; Integer)
        {
            Caption = 'Línea de Previsión';
            DataClassification = ToBeClassified;
        }
        field(50002; "No. 2_LDR"; Code[20])
        {
            CalcFormula = Lookup(Item."No. 2" WHERE("No." = FIELD("No.")));
            Caption = 'Nº 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; Warranty_LDR; Boolean)
        {
            Caption = 'Garantía';
            DataClassification = ToBeClassified;
            Description = 'Determina si es una Garantía';
        }
        field(50004; "Service Item No._LDR"; Code[20])
        {
            Caption = 'Nº Producto Servicio';
            DataClassification = ToBeClassified;
            Description = 'Nº Producto Servicio';
            TableRelation = "Service Item";

            trigger OnValidate()
            var
                servContractLine: Record "Service Contract Line";
            begin
                if ("Service Contract No._LDR" <> '') and ("Service Contract Line No._LDR" <> 0) then begin
                    servContractLine.Get(servContractLine."Contract Type"::Contract,
                                         "Service Contract No._LDR",
                                         "Service Contract Line No._LDR");
                    if servContractLine."Service Item No." <> "Service Item No._LDR" then begin
                        Validate("Service Contract No._LDR", '');
                        Validate("Service Contract Line No._LDR", 0);
                    end;
                end;
            end;
        }
        field(50005; "No. EAN Labels_LDR"; Integer)
        {
            Caption = 'Nº Etiquetas EAN';
            DataClassification = ToBeClassified;
            Description = 'Incluye el Número de Copias de Etiquetas EAN por Línea de Pedido';
            MinValue = 0;
        }
        field(50006; "Service Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Servicio';
            DataClassification = ToBeClassified;
            Description = 'Indica el Número de Pedido de Servicio al que se imputara el Material al ser Recibido';

            trigger OnValidate()
            var
                ServHeader: Record "Service Header";
            begin
                TestStatusOpen();

                if "Service Order No._LDR" <> '' then begin
                    if not ServHeader.Get(ServHeader."Document Type"::Order, "Service Order No._LDR") then
                        Error(Text50006);
                end else begin
                    "Service Item Line No._LDR" := 0;
                end;
            end;

            trigger OnLookup()
            var
                ServItemLine: Record "Service Item Line";
                ServItemLine2: Record "Service Item Line";
                ServItemLineRetorno: Record "Service Item Line";
                ServItemList: Page "Service Item Lines";
                ServMgtSetup: Record "Service Mgt. Setup";
            begin
                if Type <> Type::Item then
                    Error(Text035);
                ServMgtSetup.Get();

                Clear(ServItemLine2);
                ServItemLine2.SetRange(ServItemLine2."Document Type", ServItemLine."Document Type"::Order);
                ServItemLine2.SetFilter(ServItemLine2."Serive Order Type_LDR", '<>%1', ServMgtSetup."Assembly Service Order Type_LDR");
                ServItemLine2.SetRange(ServItemLine2."Document No.", "Service Order No._LDR");
                ServItemLine2.SetRange(ServItemLine2."Line No.", "Service Item Line No._LDR");
                if ServItemLine2.FindFirst() then;

                Clear(ServItemLine);
                ServItemLine.SetRange(ServItemLine."Document Type", ServItemLine."Document Type"::Order);
                ServItemLine.SetFilter(ServItemLine."Serive Order Type_LDR", '<>%1', ServMgtSetup."Assembly Service Order Type_LDR");
                if ServItemLine.Find('-') then begin
                    ServItemList.SetTableView(ServItemLine);
                    ServItemList.SetRecord(ServItemLine2);
                    ServItemList.LookupMode(True);
                    if ServItemList.RunModal = Action::LookupOK then begin
                        ServItemList.GetRecord(ServItemLineRetorno);
                        Validate("Service Order No._LDR", ServItemLineRetorno."Document No.");
                        Validate("Service Item Line No._LDR", ServItemLineRetorno."Line No.");
                    end;
                end;
            end;
        }
        field(50007; "Service Item Line No._LDR"; Integer)
        {
            BlankZero = true;
            Caption = 'Nº Línea Pedido Servicio';
            DataClassification = ToBeClassified;
            Description = 'Indica el Número de Línea del Pedido de Servicio, para los casos de Multilínea de Pedido de Servicio';

            trigger OnValidate()
            var
                ServItemLine: Record "Service Item Line";
            begin
                TestStatusOpen();

                if "Service Order No._LDR" = '' then
                    Error(Text50008);

                Clear(ServItemLine);
                ServItemLine.SetRange(ServItemLine."Document No.", "Service Order No._LDR");
                ServItemLine.SetRange(ServItemLine."Line No.", "Service Item Line No._LDR");
                if not ServItemLine.FindSet() then
                    Error(Text50009);
            end;

            trigger OnLookup()
            var
                ServItemLine: Record "Service Item Line";
                ServItemList: Page "Service Item Lines";
                ServItemLineRetorno: Record "Service Item Line";
            begin
                ServItemLine.SetRange(ServItemLine."Document No.", "Service Order No._LDR");
                if ServItemLine.Find('-') then begin
                    ServItemList.SettableView(ServItemLine);
                    ServItemList.LookupMode(true);
                    if ServItemList.RunModal = Action::LookupOK then begin
                        ServItemList.GetRecord(ServItemLineRetorno);
                        "Service Item Line No._LDR" := ServItemLineRetorno."Line No.";
                        Modify(true);
                    end;
                end;
            end;
        }
        field(50008; "Warranty Service Code_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Garantía';
            DataClassification = ToBeClassified;
            TableRelation = "Service Cost";

            trigger OnValidate()
            var
                ServCost: Record "Service Cost";
                TempWarrantyServiceCost: Code[20];
            begin
                TempWarrantyServiceCost := "Warranty Service Code_LDR";

                if "Warranty Service Code_LDR" <> '' then begin
                    ServCost.Get("Warranty Service Code_LDR");
                    ServCost.TestField(ServCost."Account No.");
                    Validate(Type, Type::"G/L Account");
                    Validate("No.", ServCost."Account No.");
                    "Warranty Service Code_LDR" := TempWarrantyServiceCost;
                end;
            end;
        }
        field(50009; "Warranty No._LDR"; Code[20])
        {
            Caption = 'Nº Garantía';
            DataClassification = ToBeClassified;
        }
        field(50010; "Service Contract No._LDR"; Code[20])
        {
            Caption = 'Nº Contrato Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract));

            trigger OnLookup()
            var
                ServContractHeader: Record "Service Contract Header";
            begin
                ServContractHeader.FilterGroup(2);
                ServContractHeader.SetRange(ServContractHeader."Contract Type", ServContractHeader."Contract Type"::Contract);
                ServContractHeader.FilterGroup(0);
                if Page.RunModal(0, ServContractHeader) = Action::LookupOK then
                    Validate("Service Contract No._LDR", ServContractHeader."Contract No.");
            end;
        }
        field(50011; "Demand Location Code_LDR"; Code[20])
        {
            Caption = 'Código Almacén Demanda';
            DataClassification = ToBeClassified;
            TableRelation = "Location";

            trigger OnValidate()
            var
                WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
                InvtSetup: Record "Inventory Setup";
                Location: Record "Location";
            begin
                TestStatusOpen();

                if xRec."Location Code" <> "Location Code" then begin
                    TestField("Qty. Rcd. Not Invoiced", 0);
                    TestField("Receipt No.", '');
                    TestField("Return Qty. Shipped Not Invd.", 0);
                    TestField("Return Shipment No.", '');
                end;

                if "Drop Shipment" then
                    Error(
                      Text001,
                      FieldCaption("Location Code"), "Sales Order No.");

                if "Location Code" <> xRec."Location Code" then
                    //InitItemAppl();

                if (xRec."Location Code" <> "Location Code") and (Quantity <> 0) then begin
                        //ReservePurchLine.VerifyChange(Rec, xRec);
                        WhseValidateSourceLine.PurchaseLineVerifyChange(Rec, xRec);
                        UpdateWithWarehouseReceive();
                    end;
                "Demand Bin Code_LDR" := '';

                if Type = Type::Item then
                    UpdateDirectUnitCost(FieldNo("Location Code"));

                if "Demand Location Code_LDR" = '' then begin
                    if InvtSetup.Get() then
                        "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
                end else
                    if Location.Get("Location Code") then
                        "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";

                UpdateLeadTimeFields();
                UpdateDates();

                GetDefaultBinDemand();
            end;
        }
        field(50012; "Demand Bin Code_LDR"; Code[20])
        {
            Caption = 'Código Ubicación Demanda';
            DataClassification = ToBeClassified;
            TableRelation = "Location";

            trigger OnValidate()
            var
                WMSManagement: Codeunit "WMS Management";
                Location: Record "Location";
            begin
                if "Demand Bin Code_LDR" <> '' then
                    if (("Document Type" in ["Document Type"::Order, "Document Type"::Invoice]) and (Quantity < 0)) or
                       (("Document Type" in ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) and (Quantity >= 0))
                    then
                        WMSManagement.FindBinContent("Demand Location Code_LDR", "Demand Bin Code_LDR", "No.", "Variant Code", '')
                    else
                        WMSManagement.FindBin("Demand Location Code_LDR", "Demand Bin Code_LDR", '');

                if xRec."Demand Bin Code_LDR" <> "Demand Bin Code_LDR" then begin
                    TestField("Qty. Rcd. Not Invoiced", 0);
                    TestField("Receipt No.", '');
                    TestField("Return Qty. Shipped Not Invd.", 0);
                    TestField("Return Shipment No.", '');
                end;

                if "Drop Shipment" then
                    Error(
                      Text001,
                      FieldCaption("Demand Bin Code_LDR"), "Sales Order No.");

                TestField(Type, Type::Item);
                TestField("Demand Location Code_LDR");

                if "Demand Location Code_LDR" <> '' then begin
                    //GetLocation("Demand Location Code");
                    Location.TestField("Bin Mandatory");
                    //CheckWarehouse();
                end;
            end;

            trigger OnLookup()
            var
                BinCode: Code[20];
                WMSManagement: Codeunit "WMS Management";
            begin
                if (("Document Type" in ["Document Type"::Order, "Document Type"::Invoice]) and (Quantity < 0)) or
                                                                 (("Document Type" in ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) and (Quantity >= 0))
                                                              then
                    BinCode := WMSManagement.BinContentLookUp("Demand Location Code_LDR", "No.", "Variant Code", '', "Demand Bin Code_LDR")
                else
                    BinCode := WMSManagement.BinLookUp("Demand Location Code_LDR", "No.", "Variant Code", '');

                if BinCode <> '' then
                    Validate("Demand Bin Code_LDR", BinCode);
            end;
        }
        field(50013; "Vendor Contract No._LDR"; Code[20])
        {
            Caption = 'Nº Contrato Proveedor';
            DataClassification = ToBeClassified;
            //TableRelation = Table70072.Field1 WHERE (Field2=CONST(1)); 
        }
        field(50014; "Service Contract Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Contrato Servicio';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                ServContractLine: Record "Service Contract Line";
            begin
                if "Service Contract No._LDR" <> '' then begin
                    ServContractLine.FilterGroup(2);
                    ServContractLine.SetRange(ServContractLine."Contract Type", ServContractLine."Contract Type"::Contract);
                    ServContractLine.SetRange(ServContractLine."Contract No.", "Service Contract No._LDR");
                    ServContractLine.FilterGroup(0);
                    if Page.RunModal(0, ServContractLine) = Action::LookupOK then begin
                        Validate("Service Contract Line No._LDR", ServContractLine."Line No.");
                        Validate("Service Item No._LDR", ServContractLine."Service Item No.");
                    end;
                end;
            end;
        }
        field(50015; Notas1_LDR; Text[100])
        {
            Caption = 'Notas';
            DataClassification = ToBeClassified;
        }
        field(50016; "Inv. Disc. Amount to Receive_LDR"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Importe Documentación Factura';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Quantity);
                UpdateAmounts();
                UpdateUnitCost();
                CalcInvDiscToInvoice();
            end;
        }
    }

    var
        Text001: TextConst ENU = 'You cannot change %1 because the order line is associated with sales order %2.', ESP = 'No se puede cambiar %1 porque la línea de pedido estando asociada con el pedido de venta %2.';
        Text035: TextConst ENU = '%1 units for %2 %3 have already been returned or transferred. Therefore, only %4 units can be returned.', ESP = '%1 unidades para el %2 %3 ya se han devuelto o transferido. Por lo tanto, sólo se pueden devolver %4 unidades.';
        Text50006: TextConst ENU = 'The Service Order dont exist', ESP = 'El Pedido de Servicio introducido no existe';
        Text50007: TextConst ENU = 'The Service Order has been registered', ESP = 'El Pedido de Servicio ha sido registrado';
        Text50008: TextConst ENU = 'You must introduce the Service Order number', ESP = 'Se debe rellenar primero el No. de Pedido de Servicio';
        Text50009: TextConst ENU = 'The Line No. inserted isnt created in the Service Order No. chosen, you have to check the Service Order No.', ESP = 'El No. de Línea introducida no está creada en el Pedido de Servicio introducido, revise el No. Pedido de Servicio';

    local procedure GetDefaultBinDemand();
    var
        WMSManagement: Codeunit "WMS Management";
        Location: Record "Location";
    begin
        if Type <> Type::Item then
            exit;

        if (Quantity * xRec.Quantity > 0) and
           ("No." = xRec."No.") and
           ("Demand Location Code_LDR" = xRec."Demand Location Code_LDR") and
           ("Variant Code" = xRec."Variant Code")
        then
            exit;

        "Demand Bin Code_LDR" := '';
        if "Drop Shipment" then
            exit;

        if ("Demand Location Code_LDR" <> '') and ("No." <> '') then begin
            //GetLocation("Demand Location Code");
            if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
                WMSManagement.GetDefaultBin("No.", "Variant Code", "Demand Location Code_LDR", "Demand Bin Code_LDR");
        end;
    end;

    procedure GetServiceContractLines();
    var
        ServContractLine: Record "Service Contract Line";
        frmServContractLine: Page "Service Contract Line List";
    begin
        TestField("Service Item No._LDR");
        Clear(ServContractLine);
        ServContractLine.SetRange(ServContractLine."Contract Type", ServContractLine."Contract Type"::Contract);
        ServContractLine.SetRange(ServContractLine."Contract Status", ServContractLine."Contract Status"::Signed);
        ServContractLine.SetRange(ServContractLine."Service Item No.", "Service Item No._LDR");
        if ServContractLine.FindSet() then;

        Clear(frmServContractLine);
        frmServContractLine.LookupMode := true;
        frmServContractLine.SetTableView(ServContractLine);
        if frmServContractLine.RunModal = Action::LookupOK then begin
            frmServContractLine.GetRecord(ServContractLine);
            "Service Contract No._LDR" := ServContractLine."Contract No.";
            "Service Contract Line No._LDR" := ServContractLine."Line No.";
        end;
    end;
}