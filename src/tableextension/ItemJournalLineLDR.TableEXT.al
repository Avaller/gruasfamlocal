/// <summary>
/// tableextension 50015 "Item Journal Line_LDR"
/// </summary>
tableextension 50015 "Item Journal Line_LDR" extends "Item Journal Line"
{
    fields
    {
        field(50000; "No. EAN labels_LDR"; Integer)
        {
            Caption = 'Nº Etiquetas EAN';
            DataClassification = ToBeClassified;
            Description = 'Especifica el Número de Etiquetas a Imprimir';
            InitValue = 0;
            MinValue = 0;
        }
        field(50001; "Default Bin Destination_LDR"; Option)
        {
            Caption = 'Ubicación Genérica Destino';
            DataClassification = ToBeClassified;
            InitValue = No;
            OptionCaption = 'No,Sí';
            OptionMembers = No,Sí;
        }
        field(50002; "EAN code_LDR"; Code[20])
        {
            Caption = 'Código EAN';
            DataClassification = ToBeClassified;
            Description = 'Código EAN';

            trigger OnValidate()
            var
                RecItem: Record "Item";
            begin
                if "EAN code_LDR" <> '' then begin
                    Clear(RecItem);
                    RecItem.SetCurrentKey(EAN_LDR);
                    RecItem.SetRange(RecItem.EAN_LDR, "EAN code_LDR");
                    if RecItem.FindFirst() then begin
                        Validate("Item No.", RecItem."No.");
                    end else
                        Error(TxtErrorEAN,
                             "EAN code_LDR");
                end;
            end;

            trigger OnLookup()
            var
                FrmProductos: Page "Item List";
                RecItem: Record "Item";
            begin
                RecItem.SetCurrentKey(EAN_LDR);
                if "EAN code_LDR" <> '' then
                    RecItem.SetRange(RecItem.EAN_LDR, "EAN code_LDR");
                if RecItem.FindSet() then;
                FrmProductos.SetRecord(RecItem);
                FrmProductos.LookupMode := true;
                if FrmProductos.RunModal = Action::LookupOK then begin
                    FrmProductos.GetRecord(RecItem);
                    if RecItem.EAN_LDR <> '' then
                        Validate("EAN code_LDR", RecItem.EAN_LDR)
                    else
                        Validate("Item No.", RecItem."No.");
                end;
            end;
        }
        field(50003; "Purch. Rcpt. No._LDR"; Code[20])
        {
            Caption = 'Nº Albarán Compra';
            DataClassification = ToBeClassified;
        }
        field(50004; "Purch. Rcpt. Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Albarán Compra';
            DataClassification = ToBeClassified;
        }
        field(50005; "Service Item Line No._LDR"; Integer)
        {
            BlankZero = true;
            Caption = 'Nº Línea Pedido Servicio';
            DataClassification = ToBeClassified;
            Description = 'Indica el Número de Línea del Pedido de Servicio, para los casos de Multilínea de Pedido de Servicio';

            trigger OnValidate()
            var
                ServItemLine: Record "Service Item Line";
            begin
                TestField("Order Type", "Order Type"::Service);
                if "Service Item Line No._LDR" <> 0 then begin
                    if "Order No." = '' then
                        Error(Text038);

                    Clear(ServItemLine);
                    ServItemLine.SetRange(ServItemLine."Document No.", "Order No.");
                    ServItemLine.SetRange(ServItemLine."Line No.", "Service Item Line No._LDR");
                    if not ServItemLine.FindSet() then
                        Error(Text039);
                end;
            end;

            trigger OnLookup()
            var
                ServItemLine: Record "Service Item Line";
                ServItemList: Page "Service Item Lines";
                ServItemLineRetorno: Record "Service Item Line";
            begin
                ServItemLine.SetRange(ServItemLine."Document No.", "Order No.");
                if ServItemLine.Find('-') then begin
                    ServItemList.SetTableView(ServItemLine);
                    ServItemList.LookupMode(true);
                    if ServItemList.RunModal = Action::LookupOK then begin
                        ServItemList.GetRecord(ServItemLineRetorno);
                        "Service Item Line No._LDR" := ServItemLineRetorno."Line No.";
                        Modify(true);
                    end;
                end;
            end;
        }
        field(50006; "Service Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Servicio';
            DataClassification = ToBeClassified;
        }
        field(50007; Mobility_LDR; BoolEAN)
        {
            Caption = 'Movilidad';
            DataClassification = ToBeClassified;
        }
        field(50008; Marked_LDR; BoolEAN)
        {
            Caption = 'Marcado';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; "Service Order No._LDR"; Code[20])
        {
            Caption = 'Nr. Ordine Assistenza';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ServHeader: Record "Service Header";
                ServItemLine: Record "Service Item Line";
                Text50006: TextConst ENU = 'The Service Order dont exist', ESP = 'El Pedido de Servicio introducido no existe', ITA = 'L Ordine di Servizio introdotto non esiste';
            begin
                if "Service Order No._LDR" <> '' then begin
                    if not ServHeader.Get(ServHeader."Document Type"::Order, "Service Order No._LDR") then
                        Error(Text50006);

                    Clear(ServItemLine);
                    ServItemLine.SetRange(ServItemLine."Document Type", ServItemLine."Document Type"::Order);
                    ServItemLine.SetFilter(ServItemLine."Document No.", "Service Order No._LDR");
                    if ServItemLine.FindSet() then begin
                        if ServItemLine.Count() = 1 then
                            Validate("Service Item Line No._LDR", ServItemLine."Line No.");
                    end;
                end else begin
                    Validate("Service Item Line No._LDR", 0);
                end;
            end;

            trigger OnLookup()
            var
                ServMgtSetup: Record "Service Mgt. Setup";
                ServItemLine: Record "Service Item Line";
                ServitemList: Page "Service Item Lines";
                ServItemLineRetorno: Record "Service Item Line";
            begin
                ServMgtSetup.Get();
                Clear(ServItemLine);
                ServItemLine.SetRange(ServItemLine."Document Type", ServItemLine."Document Type"::Order);
                ServItemLine.SetFilter(ServItemLine."Serive Order Type_LDR", '<>%1', ServMgtSetup."Assembly Service Order Type_LDR");
                if ServItemLine.Find('-') then begin
                    ServitemList.SetTableView(ServItemLine);
                    ServitemList.LookupMode(true);
                    if ServitemList.RunModal = Action::LookupOK then begin
                        ServitemList.GetRecord(ServItemLineRetorno);
                        Validate("Service Order No._LDR", ServItemLineRetorno."Document No.");
                        Validate("Service Item Line No._LDR", ServItemLineRetorno."Line No.");
                    end;
                end;
            end;
        }
        field(50010; "Rectified by Device_LDR"; BoolEAN)
        {
            Caption = 'Rectificado por Dispositivo';
            DataClassification = ToBeClassified;
        }
        modify("Journal Batch Name")
        {
            trigger OnBeforeValidate()
            var
                ItemJnlTemplate: Record "Item Journal Template";
                ItemJnlBatch: Record "Item Journal Batch";
            begin
                ItemJnlTemplate.Get("Journal Template Name");
                ItemJnlBatch.Get("Journal Template Name", "Journal Batch Name");

                if ItemJnlBatch.Mobility_LDR then begin
                    Mobility_LDR := true;
                end;
            end;
        }
    }

    keys
    {
        key(Key7; "Journal Template Name", "Journal Batch Name", "Location Code", "Bin Code",
        "Posting Date", "Entry Type", "Item No.", "Variant Code")
        {
            MaintainSQLIndex = false;
        }
    }

    var
        TxtErrorEAN: TextConst ENU = 'EAN does not match with any item.', ESP = 'El EAN especificado no corresponde con ningún producto, verifique dicho código';
        Text038: TextConst ENU = 'You must introduce the Service Order number', ESP = 'Se debe rellenar primero el No. de Pedido de Servicio';
        Text039: TextConst ENU = 'The Line No. inserted isnt created in the Service Order No. chosen, you have to check the Service Order No.', ESP = 'El No. de Línea introducida no está creada en el Pedido de Servicio introducido, revise el No. Pedido de Servicio';

    trigger OnAfterInsert()
    var
        ItemJnlBatch: Record "Item Journal Batch";
    begin
        Mobility_LDR := ItemJnlBatch.Mobility_LDR;
    end;

    local procedure CreateCodeArray(var CodeArray: array[10] of Code[20]; No1: Code[20]; No2: Code[20]; No3: Code[20]);
    begin
        Clear(CodeArray);
        CodeArray[1] := No1;
        CodeArray[2] := No2;
        CodeArray[3] := No3;
    end;

    local procedure CreateTableArray(var TableID: array[10] of Integer; Type1: Integer; Type2: Integer; Type3: Integer);
    begin
        Clear(TableID);
        TableID[1] := Type1;
        TableID[2] := Type2;
        TableID[3] := Type3;
    end;

    local procedure CreateDimWithProdOrderLine();
    var
        ProdOrderLine: Record "Prod. Order Line";
        InheritFromDimSetID: Integer;
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        if "Order Type" = "Order Type"::Production then
            if ProdOrderLine.Get(ProdOrderLine.Status::Released, "Order No.", "Order Line No.") then
                InheritFromDimSetID := ProdOrderLine."Dimension Set ID";

        CreateTableArray(TableID, Database::"Work Center", Database::"Salesperson/Purchaser", 0);
        CreateCodeArray(No, "Work Center No.", "Salespers./Purch. Code", '');
        //OnAfterCreateDimTableIDs(Rec, CurrFieldNo, TableID, No);
        //PickDimension(TableID, No, InheritFromDimSetID, Database::Item);
    end;

    //[External]
    procedure CopyDocumentFields(DocType: Option; DocNo: Code[20]; ExtDocNo: Text[35]; SourceCode: Code[10]; NoSeriesCode: Code[20]);
    begin
        "Document Type" := DocType;
        "Document No." := DocNo;
        "External Document No." := ExtDocNo;
        "Source Code" := SourceCode;
        if NoSeriesCode <> '' then
            "Posting No. Series" := NoSeriesCode;
    end;

    //[External]
    procedure CopyFromSalesHeader(SalesHeader: Record "Sales Header");
    begin
        "Posting Date" := SalesHeader."Posting Date";
        "Document Date" := SalesHeader."Document Date";
        "Order Date" := SalesHeader."Order Date";
        "Source Posting Group" := SalesHeader."Customer Posting Group";
        "Salespers./Purch. Code" := SalesHeader."Salesperson Code";
        "Reason Code" := SalesHeader."Reason Code";
        "Source Currency Code" := SalesHeader."Currency Code";
        "Shpt. Method Code" := SalesHeader."Shipment Method Code";

        //OnAfterCopyItemJnlLineFromSalesHeader(Rec, SalesHeader);
    end;

    //[External]
    procedure CopyFromSalesLine(SalesLine: Record "Sales Line");
    begin
        "Item No." := SalesLine."No.";
        Description := SalesLine.Description;
        "Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := SalesLine."Dimension Set ID";
        "Location Code" := SalesLine."Location Code";
        "Bin Code" := SalesLine."Bin Code";
        "Variant Code" := SalesLine."Variant Code";
        "Inventory Posting Group" := SalesLine."Posting Group";
        "Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
        "Transaction Type" := SalesLine."Transaction Type";
        "Transport Method" := SalesLine."Transport Method";
        "Entry/Exit Point" := SalesLine."Exit Point";
        Area := SalesLine.Area;
        "Transaction Specification" := SalesLine."Transaction Specification";
        "Drop Shipment" := SalesLine."Drop Shipment";
        "Entry Type" := "Entry Type"::Sale;
        "Unit of Measure Code" := SalesLine."Unit of Measure Code";
        "Qty. per Unit of Measure" := SalesLine."Qty. per Unit of Measure";
        "Derived from Blanket Order" := SalesLine."Blanket Order No." <> '';
        //"Cross-Reference No." := SalesLine."Cross-Reference No.";
        "Originally Ordered No." := SalesLine."Originally Ordered No.";
        "Originally Ordered Var. Code" := SalesLine."Originally Ordered Var. Code";
        "Out-of-Stock Substitution" := SalesLine."Out-of-Stock Substitution";
        "Item Category Code" := SalesLine."Item Category Code";
        Nonstock := SalesLine.Nonstock;
        "Purchasing Code" := SalesLine."Purchasing Code";
        "Return Reason Code" := SalesLine."Return Reason Code";
        "Planned Delivery Date" := SalesLine."Planned Delivery Date";
        "Document Line No." := SalesLine."Line No.";
        "Unit Cost" := SalesLine."Unit Cost (LCY)";
        "Unit Cost (ACY)" := SalesLine."Unit Cost";
        "Value Entry Type" := "Value Entry Type"::"Direct Cost";
        "Source Type" := "Source Type"::Customer;
        "Source No." := SalesLine."Sell-to Customer No.";
        "Invoice-to Source No." := SalesLine."Bill-to Customer No.";

        //OnAfterCopyItemJnlLineFromSalesLine(Rec, SalesLine);
    end;

    //[External]
    procedure CopyFromPurchHeader(PurchHeader: Record "Purchase Header");
    begin
        "Posting Date" := PurchHeader."Posting Date";
        "Document Date" := PurchHeader."Document Date";
        "Source Posting Group" := PurchHeader."Vendor Posting Group";
        "Salespers./Purch. Code" := PurchHeader."Purchaser Code";
        "Country/Region Code" := PurchHeader."Buy-from Country/Region Code";
        "Reason Code" := PurchHeader."Reason Code";
        "Source Currency Code" := PurchHeader."Currency Code";
        "Shpt. Method Code" := PurchHeader."Shipment Method Code";

        //OnAfterCopyItemJnlLineFromPurchHeader(Rec, PurchHeader);
    end;

    //[External]
    procedure CopyFromPurchLine(PurchLine: Record "Purchase Line");
    begin
        "Item No." := PurchLine."No.";
        Description := PurchLine.Description;
        "Shortcut Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := PurchLine."Dimension Set ID";
        "Location Code" := PurchLine."Location Code";
        "Bin Code" := PurchLine."Bin Code";
        "Variant Code" := PurchLine."Variant Code";
        "Item Category Code" := PurchLine."Item Category Code";
        "Inventory Posting Group" := PurchLine."Posting Group";
        "Gen. Bus. Posting Group" := PurchLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := PurchLine."Gen. Prod. Posting Group";
        "Job No." := PurchLine."Job No.";
        "Job Task No." := PurchLine."Job Task No.";
        if "Job No." <> '' then
            "Job Purchase" := true;
        "Applies-to Entry" := PurchLine."Appl.-to Item Entry";
        "Transaction Type" := PurchLine."Transaction Type";
        "Transport Method" := PurchLine."Transport Method";
        "Entry/Exit Point" := PurchLine."Entry Point";
        Area := PurchLine.Area;
        "Transaction Specification" := PurchLine."Transaction Specification";
        "Drop Shipment" := PurchLine."Drop Shipment";
        "Entry Type" := "Entry Type"::Purchase;
        if PurchLine."Prod. Order No." <> '' then begin
            "Order Type" := "Order Type"::Production;
            "Order No." := PurchLine."Prod. Order No.";
            "Order Line No." := PurchLine."Prod. Order Line No.";
        end;
        "Unit of Measure Code" := PurchLine."Unit of Measure Code";
        "Qty. per Unit of Measure" := PurchLine."Qty. per Unit of Measure";
        //"Cross-Reference No." := PurchLine."Cross-Reference No.";
        "Document Line No." := PurchLine."Line No.";
        "Unit Cost" := PurchLine."Unit Cost (LCY)";
        "Unit Cost (ACY)" := PurchLine."Unit Cost";
        "Value Entry Type" := "Value Entry Type"::"Direct Cost";
        "Source Type" := "Source Type"::Vendor;
        "Source No." := PurchLine."Buy-from Vendor No.";
        "Invoice-to Source No." := PurchLine."Pay-to Vendor No.";
        "Purchasing Code" := PurchLine."Purchasing Code";
        "Indirect Cost %" := PurchLine."Indirect Cost %";
        "Overhead Rate" := PurchLine."Overhead Rate";
        "Return Reason Code" := PurchLine."Return Reason Code";

        //OnAfterCopyItemJnlLineFromPurchLine(Rec, PurchLine);
    end;

    //[External]
    procedure CopyFromServHeader(ServiceHeader: Record "Service Header");
    begin
        "Document Date" := ServiceHeader."Document Date";
        "Order Date" := ServiceHeader."Order Date";
        "Source Posting Group" := ServiceHeader."Customer Posting Group";
        "Salespers./Purch. Code" := ServiceHeader."Salesperson Code";
        "Country/Region Code" := ServiceHeader."VAT Country/Region Code";
        "Reason Code" := ServiceHeader."Reason Code";
        "Source Type" := "Source Type"::Customer;
        "Source No." := ServiceHeader."Customer No.";
        "Shpt. Method Code" := ServiceHeader."Shipment Method Code";

        //OnAfterCopyItemJnlLineFromServHeader(Rec, ServiceHeader);
    end;

    //[External]
    procedure CopyFromServLine(ServiceLine: Record "Service Line");
    begin
        "Item No." := ServiceLine."No.";
        "Posting Date" := ServiceLine."Posting Date";
        Description := ServiceLine.Description;
        "Shortcut Dimension 1 Code" := ServiceLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := ServiceLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := ServiceLine."Dimension Set ID";
        "Location Code" := ServiceLine."Location Code";
        "Bin Code" := ServiceLine."Bin Code";
        "Variant Code" := ServiceLine."Variant Code";
        "Inventory Posting Group" := ServiceLine."Posting Group";
        "Gen. Bus. Posting Group" := ServiceLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := ServiceLine."Gen. Prod. Posting Group";
        "Applies-to Entry" := ServiceLine."Appl.-to Item Entry";
        "Transaction Type" := ServiceLine."Transaction Type";
        "Transport Method" := ServiceLine."Transport Method";
        "Entry/Exit Point" := ServiceLine."Exit Point";
        Area := ServiceLine.Area;
        "Transaction Specification" := ServiceLine."Transaction Specification";
        "Entry Type" := "Entry Type"::Sale;
        "Unit of Measure Code" := ServiceLine."Unit of Measure Code";
        "Qty. per Unit of Measure" := ServiceLine."Qty. per Unit of Measure";
        "Derived from Blanket Order" := false;
        "Item Category Code" := ServiceLine."Item Category Code";
        Nonstock := ServiceLine.Nonstock;
        "Return Reason Code" := ServiceLine."Return Reason Code";
        "Order Type" := "Order Type"::Service;
        "Order No." := ServiceLine."Document No.";
        "Order Line No." := ServiceLine."Line No.";
        "Job No." := ServiceLine."Job No.";
        "Job Task No." := ServiceLine."Job Task No.";

        //OnAfterCopyItemJnlLineFromServLine(Rec, ServiceLine);
    end;

    //[External]
    procedure CopyFromServShptHeader(ServShptHeader: Record "Service Shipment Header");
    begin
        "Document Date" := ServShptHeader."Document Date";
        "Order Date" := ServShptHeader."Order Date";
        "Country/Region Code" := ServShptHeader."VAT Country/Region Code";
        "Source Posting Group" := ServShptHeader."Customer Posting Group";
        "Salespers./Purch. Code" := ServShptHeader."Salesperson Code";
        "Reason Code" := ServShptHeader."Reason Code";

        //OnAfterCopyItemJnlLineFromServShptHeader(Rec, ServShptHeader);
    end;

    //[External]
    procedure CopyFromServShptLine(ServShptLine: Record "Service Shipment Line");
    begin
        "Item No." := ServShptLine."No.";
        Description := ServShptLine.Description;
        "Gen. Bus. Posting Group" := ServShptLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := ServShptLine."Gen. Prod. Posting Group";
        "Inventory Posting Group" := ServShptLine."Posting Group";
        "Location Code" := ServShptLine."Location Code";
        "Unit of Measure Code" := ServShptLine."Unit of Measure Code";
        "Qty. per Unit of Measure" := ServShptLine."Qty. per Unit of Measure";
        "Variant Code" := ServShptLine."Variant Code";
        "Bin Code" := ServShptLine."Bin Code";
        "Shortcut Dimension 1 Code" := ServShptLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := ServShptLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := ServShptLine."Dimension Set ID";
        "Entry/Exit Point" := ServShptLine."Exit Point";
        "Value Entry Type" := ItemJnlLine."Value Entry Type"::"Direct Cost";
        "Transaction Type" := ServShptLine."Transaction Type";
        "Transport Method" := ServShptLine."Transport Method";
        Area := ServShptLine.Area;
        "Transaction Specification" := ServShptLine."Transaction Specification";
        "Qty. per Unit of Measure" := ServShptLine."Qty. per Unit of Measure";
        "Item Category Code" := ServShptLine."Item Category Code";
        Nonstock := ServShptLine.Nonstock;
        "Return Reason Code" := ServShptLine."Return Reason Code";

        //OnAfterCopyItemJnlLineFromServShptLine(Rec, ServShptLine);
    end;

    //[External]
    procedure CopyFromServShptLineUndo(ServShptLine: Record "Service Shipment Line");
    begin
        "Item No." := ServShptLine."No.";
        "Posting Date" := ServShptLine."Posting Date";
        "Order Date" := ServShptLine."Order Date";
        "Inventory Posting Group" := ServShptLine."Posting Group";
        "Gen. Bus. Posting Group" := ServShptLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := ServShptLine."Gen. Prod. Posting Group";
        "Location Code" := ServShptLine."Location Code";
        "Variant Code" := ServShptLine."Variant Code";
        "Bin Code" := ServShptLine."Bin Code";
        "Entry/Exit Point" := ServShptLine."Exit Point";
        "Shortcut Dimension 1 Code" := ServShptLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := ServShptLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := ServShptLine."Dimension Set ID";
        "Value Entry Type" := "Value Entry Type"::"Direct Cost";
        "Item No." := ServShptLine."No.";
        Description := ServShptLine.Description;
        "Location Code" := ServShptLine."Location Code";
        "Variant Code" := ServShptLine."Variant Code";
        "Transaction Type" := ServShptLine."Transaction Type";
        "Transport Method" := ServShptLine."Transport Method";
        Area := ServShptLine.Area;
        "Transaction Specification" := ServShptLine."Transaction Specification";
        "Unit of Measure Code" := ServShptLine."Unit of Measure Code";
        "Qty. per Unit of Measure" := ServShptLine."Qty. per Unit of Measure";
        "Derived from Blanket Order" := false;
        "Item Category Code" := ServShptLine."Item Category Code";
        Nonstock := ServShptLine.Nonstock;
        "Return Reason Code" := ServShptLine."Return Reason Code";

        //OnAfterCopyItemJnlLineFromServShptLineUndo(Rec, ServShptLine);
    end;

    //[External]
    procedure CopyFromJobJnlLine(JobJnlLine: Record "Job Journal Line");
    begin
        "Line No." := JobJnlLine."Line No.";
        "Item No." := JobJnlLine."No.";
        "Posting Date" := JobJnlLine."Posting Date";
        "Document Date" := JobJnlLine."Document Date";
        "Document No." := JobJnlLine."Document No.";
        "External Document No." := JobJnlLine."External Document No.";
        Description := JobJnlLine.Description;
        "Location Code" := JobJnlLine."Location Code";
        "Applies-to Entry" := JobJnlLine."Applies-to Entry";
        "Applies-from Entry" := JobJnlLine."Applies-from Entry";
        "Shortcut Dimension 1 Code" := JobJnlLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := JobJnlLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := JobJnlLine."Dimension Set ID";
        "Country/Region Code" := JobJnlLine."Country/Region Code";
        "Entry Type" := "Entry Type"::"Negative Adjmt.";
        "Source Code" := JobJnlLine."Source Code";
        "Gen. Bus. Posting Group" := JobJnlLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := JobJnlLine."Gen. Prod. Posting Group";
        "Posting No. Series" := JobJnlLine."Posting No. Series";
        "Variant Code" := JobJnlLine."Variant Code";
        "Bin Code" := JobJnlLine."Bin Code";
        "Unit of Measure Code" := JobJnlLine."Unit of Measure Code";
        "Reason Code" := JobJnlLine."Reason Code";
        "Transaction Type" := JobJnlLine."Transaction Type";
        "Transport Method" := JobJnlLine."Transport Method";
        "Entry/Exit Point" := JobJnlLine."Entry/Exit Point";
        Area := JobJnlLine.Area;
        "Transaction Specification" := JobJnlLine."Transaction Specification";
        "Invoiced Quantity" := JobJnlLine.Quantity;
        "Invoiced Qty. (Base)" := JobJnlLine."Quantity (Base)";
        "Source Currency Code" := JobJnlLine."Source Currency Code";
        Quantity := JobJnlLine.Quantity;
        "Quantity (Base)" := JobJnlLine."Quantity (Base)";
        "Qty. per Unit of Measure" := JobJnlLine."Qty. per Unit of Measure";
        "Unit Cost" := JobJnlLine."Unit Cost (LCY)";
        "Unit Cost (ACY)" := JobJnlLine."Unit Cost";
        Amount := JobJnlLine."Total Cost (LCY)";
        "Amount (ACY)" := JobJnlLine."Total Cost";
        "Value Entry Type" := "Value Entry Type"::"Direct Cost";
        "Job No." := JobJnlLine."Job No.";
        "Job Task No." := JobJnlLine."Job Task No.";
        "Shpt. Method Code" := JobJnlLine."Shpt. Method Code";

        //OnAfterCopyItemJnlLineFromJobJnlLine(Rec, JobJnlLine);
    end;

    local procedure CopyFromProdOrderComp(ProdOrderComp: Record "Prod. Order Component");
    begin
        Validate("Order Line No.", ProdOrderComp."Prod. Order Line No.");
        Validate("Prod. Order Comp. Line No.", ProdOrderComp."Line No.");
        "Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
        "Location Code" := ProdOrderComp."Location Code";
        Validate("Variant Code", ProdOrderComp."Variant Code");
        Validate("Bin Code", ProdOrderComp."Bin Code");

        //OnAfterCopyFromProdOrderComp(Rec, ProdOrderComp);
    end;

    local procedure CopyFromProdOrderLine(ProdOrderLine: Record "Prod. Order Line");
    begin
        Validate("Order Line No.", ProdOrderLine."Line No.");
        "Unit of Measure Code" := ProdOrderLine."Unit of Measure Code";
        "Location Code" := ProdOrderLine."Location Code";
        Validate("Variant Code", ProdOrderLine."Variant Code");
        Validate("Bin Code", ProdOrderLine."Bin Code");

        //OnAfterCopyFromProdOrderLine(Rec, ProdOrderLine);
    end;

    local procedure CopyFromWorkCenter(WorkCenter: Record "Work Center");
    begin
        "Work Center No." := WorkCenter."No.";
        Description := WorkCenter.Name;
        "Gen. Prod. Posting Group" := WorkCenter."Gen. Prod. Posting Group";
        "Unit Cost Calculation" := WorkCenter."Unit Cost Calculation";

        //OnAfterCopyFromWorkCenter(Rec, WorkCenter);
    end;

    local procedure CopyFromMachineCenter(MachineCenter: Record "Machine Center");
    begin
        "Work Center No." := MachineCenter."Work Center No.";
        Description := MachineCenter.Name;
        "Gen. Prod. Posting Group" := MachineCenter."Gen. Prod. Posting Group";
        "Unit Cost Calculation" := "Unit Cost Calculation"::Time;

        //OnAfterCopyFromMachineCenter(Rec, MachineCenter);
    end;
}