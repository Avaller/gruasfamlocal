/// <summary>
/// tableextension 50067 "Service Line_LDR"
/// </summary>
tableextension 50067 "Service Line_LDR" extends "Service Line"
{
    fields
    {
        field(50050; "Invoicing UOM Code_LDR"; Code[10])
        {
            Caption = 'Código Unidad Medida Facturación';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Type" = CONST("Item")) "Item Unit of Measure"."Code" WHERE("Item No." = FIELD("No.")) ELSE
            IF ("Type" = CONST("Resource")) "Resource Unit of Measure"."Code" WHERE("Resource No." = FIELD("No.")) ELSE
            "Unit of Measure";

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
                ResUnitofMeasure: Record "Resource Unit of Measure";
                WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
            begin

            end;
        }
        field(50051; "Crane Quote No._LDR"; Code[20])
        {
            Caption = 'Código Oferta Grúa';
            DataClassification = ToBeClassified;
            TableRelation = "Crane Service Quote Header_LDR"."Quote no.";
        }
        field(50052; "Crane Quote Op. Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Operación Oferta Grúa';
            DataClassification = ToBeClassified;
        }
        field(50053; "Crane Quote Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Oferta Grúa';
            DataClassification = ToBeClassified;
        }
        field(50054; "Contract Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Contrato';
            DataClassification = ToBeClassified;
        }
        field(50055; "Contract Concept Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Concepto Contrato';
            DataClassification = ToBeClassified;
        }
        field(50056; Replicated_LDR; Boolean)
        {
            Caption = 'Replicado';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50059; "Source Serv. Inv. No._LDR"; Code[20])
        {
            Caption = 'Nº Factura Servicio Origen';
            DataClassification = ToBeClassified;
        }
        field(50060; "Source Serv. Inv. Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Factura Servicio Origen';
            DataClassification = ToBeClassified;
        }
        field(50061; "Purchase Receipt No._LDR"; Code[20])
        {
            Caption = 'Nº Albarán Compra';
            DataClassification = ToBeClassified;
            Description = 'Nº Albarán Compra';
        }
        field(50062; "Purchase Receipt Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Albarán Compra';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Albarán Compra';
        }
        field(50063; "Opened (Quote)_LDR"; Boolean)
        {
            Caption = 'Abierto';
            DataClassification = ToBeClassified;
        }
        field(50064; "Quote No._LDR"; Code[20])
        {
            Caption = 'Nº Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Oferta';
        }
        field(50065; "Quote Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Oferta';
        }
        field(50066; "Quote Invoice Line No._LDR"; Integer)
        {
            Caption = 'Nº Línea Factura Oferta';
            DataClassification = ToBeClassified;
            Description = 'Nº Línea Factura Oferta';
        }
        field(50067; "Item Entry No._LDR"; Integer)
        {
            Caption = 'Nº Movimiento Producto';
            DataClassification = ToBeClassified;
            Description = 'Nº Movimiento Producto';
        }
        field(50068; "Initial Time_LDR"; Time)
        {
            Caption = 'Hora Inicio';
            DataClassification = ToBeClassified;
            Description = 'Hora Inicio';

            trigger OnValidate()
            var
                Cantidad: Decimal;
            begin
                if "End Time_LDR" <> 0T then begin
                    if "End Time_LDR" < "Initial Time_LDR" then
                        Error(TxtHoraInicio);

                    Cantidad := Round(("End Time_LDR" - "Initial Time_LDR") / 3600000, 0.00001);
                    Validate(Quantity, Cantidad);
                    Validate("Internal Quantity_LDR", Cantidad);
                end;

                //{
                if "Service Item Line No." <> 0 then begin
                    ServOrderLine.Get("Document Type", "Document No.", "Service Item Line No.");
                    ServOrderLine.ActualizaFechas(Rec);
                end;
                //}
            end;
        }
        field(50069; "End Time_LDR"; Time)
        {
            Caption = 'Hora Fin';
            DataClassification = ToBeClassified;
            Description = 'Hora Fin';

            trigger OnValidate()
            var
                Cantidad: Decimal;
            begin
                if "Initial Time_LDR" <> 0T then begin
                    if "End Time_LDR" < "Initial Time_LDR" then
                        Error(txtHoraFin);

                    Cantidad := Round(("End Time_LDR" - "Initial Time_LDR") / 3600000, 0.00001);
                    Validate(Quantity, Cantidad);
                    Validate("Internal Quantity_LDR", Cantidad);
                    if Chargeable_LDR then
                        Validate("Qty. to Invoice", Quantity);
                end;

                //{
                if "Service Item Line No." <> 0 then begin
                    ServOrderLine.Get("Document Type", "Document No.", "Service Item Line No.");
                    ServOrderLine.ActualizaFechas(Rec);
                end;
                //}
            end;
        }
        field(50070; "Internal Quantity_LDR"; Decimal)
        {
            Caption = 'Cantidad Teórica';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'Cantidad Teórica';
            Editable = false;
        }
        field(50071; "Service Order Description_LDR"; Text[50])
        {
            CalcFormula = Lookup("Service Header"."Description" WHERE("Document Type" = FIELD("Document Type"),
             "No." = FIELD("Document No.")));
            Caption = 'Descripción Pedido';
            Description = 'Descripción Pedido';
            FieldClass = FlowField;
        }
        field(50072; "Number of Hours_LDR"; Integer)
        {
            CalcFormula = Lookup("Service Item Line"."No of hours_LDR" WHERE("Document Type" = FIELD("Document Type"),
            "Document No." = FIELD("Document No."), "Line No." = FIELD("Service Item Line No.")));
            Caption = 'Nº Horas';
            Description = 'Nº Horas Máquina';
            FieldClass = FlowField;
        }
        field(50073; "EAN code_LDR"; Code[13])
        {
            Caption = 'Código EAN';
            DataClassification = ToBeClassified;
            Description = 'Código EAN';

            trigger OnValidate()
            var
                RecItem: Record "Item";
            begin
                if (Type <> Type::Item) and (Type <> Type::" ") then
                    Error(txtTipoEAN);

                if (xRec."No." <> '') or (xRec."No." = '') then begin
                    Clear(RecItem);
                    RecItem.SetCurrentKey(EAN_LDR);
                    RecItem.SetRange(RecItem.EAN_LDR, "EAN code_LDR");
                    if RecItem.FindFirst() then begin
                        Validate(Type, Type::Item);
                        Validate("No.", RecItem."No.");
                    end else
                        Error(txtErrorEAN,
                              "EAN code_LDR");
                end;
            end;

            trigger OnLookup()
            var
                FrmProductos: Page "Item List";
                RecItem: Record "Item";
            begin
                RecItem.Reset();
                RecItem.Get("No.");
                FrmProductos.SetRecord(RecItem);
                FrmProductos.LookupMode := true;
                if FrmProductos.RunModal = Action::LookupOK then begin
                    FrmProductos.GetRecord(RecItem);
                    if RecItem.EAN_LDR <> '' then
                        Validate("EAN code_LDR", RecItem.EAN_LDR)
                    else
                        Validate("No.", RecItem."No.");
                end;
            end;
        }
        field(50074; Revaluation_LDR; Boolean)
        {
            Caption = 'Revalorizar Máquina';
            DataClassification = ToBeClassified;
            Description = 'Para Generar Movimientos de Valor de Máquina';

            trigger OnValidate()
            var
                ServiceMgtSetup: Record "Service Mgt. Setup";
                Serviceheader: Record "Service Header";
                ServItem: Record "Service Item";
            begin
                Serviceheader.Get("Document Type", "Document No.");

                if Revaluation_LDR <> xRec.Revaluation_LDR then begin
                    if "Quantity Invoiced" <> 0 then
                        Error(txtRevaluar);
                end;

                Serviceheader.TestField(Serviceheader."Service Order Type");

                if "Service Item No." <> '' then begin
                    ServItem.Get("Service Item No.");
                    if not ServItem.Own_LDR then
                        Error(TextNoespropia);
                end;

                ServiceMgtSetup.Get();
                if ServiceMgtSetup."Assembly Service Order Type_LDR" = Serviceheader."Service Order Type" then
                    Error(TextErrorMontaje);
            end;
        }
        field(50075; "Created from Transfer_LDR"; Boolean)
        {
            Caption = 'Creado desde Transferencia';
            DataClassification = ToBeClassified;
            Description = 'Indica que la Liínea se ha Creado desde una Reclasificación';
        }
        field(50076; "Transfer Source Location Code_LDR"; Code[20])
        {
            Caption = 'Código Almacén Origen Transferencia';
            DataClassification = ToBeClassified;
            TableRelation = "Location";
        }
        field(50077; "Transfer Source Bin Code_LDR"; Code[20])
        {
            Caption = 'Código Ubicación Origen Transferencia';
            DataClassification = ToBeClassified;
            TableRelation = "Bin"."Code" WHERE("Location Code" = FIELD("Transfer Source Location Code_LDR"));
        }
        field(50078; "Convert to Order_LDR"; Boolean)
        {
            Caption = 'Convertir en Pedido';
            DataClassification = ToBeClassified;
        }
        field(50079; Chargeable_LDR; Boolean)
        {
            Caption = 'Generar Factura';
            DataClassification = ToBeClassified;
            InitValue = true;

            trigger OnValidate()
            begin
                TestField("Quantity Shipped", 0);
                TestField("Quantity Invoiced", 0);
                TestField("Quantity Consumed", 0);

                if not Chargeable_LDR then begin
                    Validate("Line Discount %", 100);
                    Validate("Qty. to Invoice", 0);
                end;
            end;
        }
        field(50080; Grouper_LDR; Text[20])
        {
            Caption = 'Agrupador';
            DataClassification = ToBeClassified;
        }
        field(50081; "Service item Model_LDR"; Text[50])
        {
            Caption = 'Modelo';
            DataClassification = ToBeClassified;
            Description = 'Modelo';
        }
        field(50082; "Contract Hours Entry No._LDR"; Integer)
        {
            Caption = 'Nº Movimiento Contrato por Horas';
            DataClassification = ToBeClassified;
            //TableRelation = Table70061; 
        }
        field(50083; "Service Price Version No._LDR"; Code[20])
        {
            Caption = 'Nº Versión Grupo Precio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Price_LDR"."Version No." WHERE("Service Price Group" = FIELD("Service Price Group Code"));
        }
        field(50084; "Service Contract Period_LDR"; Text[50])
        {
            Caption = 'Período Contrato Servicio';
            DataClassification = ToBeClassified;
        }
        field(50085; "Concept No._LDR"; Code[20])
        {
            Caption = 'Nº concepto';
            DataClassification = ToBeClassified;
            TableRelation = Concept_LDR."No." WHERE("Type" = CONST("External"));

            trigger OnValidate()
            var
                Concepto: Record "Concept_LDR";
            begin

            end;
        }
        field(50086; "Charge Capacity_LDR"; Decimal)
        {
            Caption = 'Capacidad Carga (Kg)';
            DataClassification = ToBeClassified;
            Description = 'Indica la Capacidad de Carga de la Máquina en Kg';
        }
        field(50087; "Warranty Service Code_LDR"; Code[20])
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
        field(50088; "Warranty No._LDR"; Code[20])
        {
            Caption = 'Nº Garantía';
            DataClassification = ToBeClassified;
        }
        field(50089; Warranty_LDR; Boolean)
        {
            Caption = 'Garantía';
            DataClassification = ToBeClassified;
            Description = 'Determina si es una Garantía';
        }
        field(50090; "Invoice Line Discount Amount_LDR"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Importe Descuento Línea a Facturar';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50091; "Invoice Line Amount_LDR"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Importe Línea a Facturar';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50092; Migrated_LDR; Boolean)
        {
            Caption = 'Migrada';
            DataClassification = ToBeClassified;
        }
        field(50093; Reclasified_LDR; Boolean)
        {
            Caption = 'Reclasificado';
            DataClassification = ToBeClassified;
        }
        field(50094; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50095; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
        field(50096; "Warranty Service Order No._LDR"; Code[20])
        {
            Caption = 'Nº Pedido Servicio';
            DataClassification = ToBeClassified;

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
                    Validate(Description, ServCost.Description);
                end;
            end;
        }
        field(50097; "Historical Quote_LDR"; Boolean)
        {
            CalcFormula = Lookup("Service Header"."Historical Quote_LDR" WHERE("Document Type" = FIELD("Document Type"),
            "No." = FIELD("Document No.")));
            Caption = 'Oferta Histórica';
            FieldClass = FlowField;
        }
        field(50098; "Day Invoicing_LDR"; Boolean)
        {
            Caption = 'Facturar por Precio Día';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50099; "No of Days_LDR"; Integer)
        {
            Caption = 'Nº de Días';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50100; "Day Amount_LDR"; Decimal)
        {
            Caption = 'Precio Venta Día';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50101; Replicate_LDR; Boolean)
        {
            Caption = 'Replicar';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50102; "Replicate Company_LDR"; Text[30])
        {
            Caption = 'Empresa Réplica';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Company"."Name";
        }
        field(50103; "Replicate Service Item_LDR"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "No. 2_LDR"; Code[20])
        {
            CalcFormula = Lookup("Item"."No. 2" WHERE("No." = FIELD("No.")));
            Caption = 'Nº 2';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key17; "Purchase Receipt No._LDR", "Purchase Receipt Line No._LDR")
        {

        }
    }

    trigger OnAfterInsert()
    begin
        "Created Date_LDR" := CurrentDateTime;
    end;

    trigger OnAfterModify()
    var
        txtOferta: TextConst ENU = 'You cant modify the line because it comes from a quote. You have to unblock from the menu Line - Unblock', ESP = 'No se puede modificar la línea porque proviene de una Oferta. Desbloquee la línea desde el menú Línea - Desbloquear';
        txtPedidoCompra: TextConst ENU = 'You cant modify the line because it comes from a purchase order. You have to unblock from the menu Line - Unblock', ESP = 'No se puede modificar la línea porque proviene de un Pedido de Compra. Desbloquee la línea desde el menú Línea - Desbloquear';
    begin
        if ("Quote No._LDR" <> '') and ("Opened (Quote)_LDR" = false) then begin
            if (Quantity <> xRec.Quantity) or ("Unit Price" <> xRec."Unit Price") or ("Line Discount %" <> xRec."Line Discount %") then
                Error(txtOferta);
        end;

        if ("Purchase Receipt No._LDR" <> '') and ("Purchase Receipt Line No._LDR" <> 0) and ("Opened (Quote)_LDR" = false) then begin
            if (Quantity <> xRec.Quantity) or ("Unit Price" <> xRec."Unit Price")
                                          or ("Unit Cost" <> xRec."Unit Cost") or ("Unit Cost (LCY)" <> xRec."Unit Cost (LCY)")
                                          or ("Qty. to Invoice (Base)" <> xRec."Qty. to Invoice (Base)") then
                Error(txtPedidoCompra);
        end;

        "Modified Date_LDR" := CurrentDateTime;
    end;

    trigger OnAfterDelete()
    var
        txtOferta: TextConst ENU = 'It is not posible to delete Line because it is linked with a Quote. Unlock line by menu Line - Unlock.', ESP = 'No se puede eliminar la línea por que proviene de una Oferta. Desloquee la línea desde el menú Línea - Desloquear';
        Almacenes: Record "Location";
        Ubicaciones: Record "Bin";
        bOk: Boolean;
        //ContractHoursEntry: Record 70061;
        CraneServQForfaitCalendar: Record "Crane Serv Q. Forf Calend_LDR";
    begin
        TestField("Quantity Shipped", 0);

        if ("Quote No._LDR" <> '') and ("Opened (Quote)_LDR" = false) then begin
            Error(txtOferta);
        end;

        begin
            if ("Contract No." <> '') then begin
                Error(Text50011, ServLedgEntry.TableCaption);
            end else begin
            end;
        end;

        if (Rec."Created from Transfer_LDR") and (not bRecreating) then begin
            if HideDialogBox then
                bOk := true
            else
                bOk := Dialog.Confirm(Text50002, true);

            if bOk then begin
                CreateReturnJournal(Quantity);
                Message(txtLineaDiarioGenerada);
            end;
        end;

        if "Contract Hours Entry No._LDR" <> 0 then begin
            //"Contract Hours Entry No._LDR".Get("Contract Hours Entry No._LDR");
            //"Contract Hours Entry No._LDR".Procesed := false;
            //"Contract Hours Entry No._LDR".Modify();
        end;

        Clear(CraneServQForfaitCalendar);
        if CraneServQForfaitCalendar.Get("Crane Quote No._LDR", "Crane Quote Op. Line No._LDR", "Crane Quote Line No._LDR") then begin
            CraneServQForfaitCalendar.Processed := false;
            CraneServQForfaitCalendar.Modify();
        end;
    end;

    var
        Text000: TextConst ENU = 'You cannot invoice more than %1 units.', ESP = 'No se pueden facturar más de %1 unidades.';
        Text006: TextConst ENU = 'Replace Component,New Component,Ignore,Change Component', ESP = 'Reponer componente,Nuevo componente,Ignorar,Sustituir Componente';
        Text007: TextConst ENU = 'You must select a %1.', ESP = 'Debe seleccionar un %1.';
        TxtHoraInicio: TextConst ENU = 'Starting Time is bigger than End Time', ESP = 'La hora de Inicio es mayor que la hora de Fin.';
        txtHoraFin: TextConst ENU = 'End Time is lower than Starting Time', ESP = 'La hora de Fin es menor que la hora de Inicio.';
        ServOrderLine: Record "Service Item Line";
        txtErrorEAN: TextConst ENU = 'EAN %1 does not exist', ESP = 'No existe ningún producto con el EAN %1';
        txtTipoEAN: TextConst ENU = 'Type must be Item', ESP = 'El tipo debe ser Producto';
        txtRevaluar: TextConst ENU = 'You can not modify the value because the line has been posted', ESP = 'No se puede modificar el campo porque la línea ya ha sido registrada';
        TextErrorMontaje: TextConst ENU = 'It is not posible to revaluate a machine on an assembly service order', ESP = 'No se puede revalorizar la máquina en un pedido de montaje';
        TextNoespropia: TextConst ENU = 'It is not posible to revaluate a not own machine', ESP = 'No se puede revalorizar una máquina que no es propia';
        txtUbicacionPs: TextConst ENU = 'Service Item No. %1 is not placed on Customer.Are you sure to calculate by customer address?', ESP = 'El Prod. Servicio %1 no está ubicado en el Cliente.¿Está seguro de querer realizar el cálculo en base a la dirección del cliente?';
        txtErrorDiario: TextConst ENU = 'It isnt defined the journal book called TRANSFEREN', ESP = 'No se encuentra definido el Libro Diario Reclasificación denominado TRANSFEREN.';
        txtErrorSeccion: TextConst ENU = 'It isnt defined the batch AJUSTES in the TRANSFEREN journal', ESP = 'No se encuentra definida la sección AJUSTES en el libro diario TRANSFEREN del Diario de Reclasificación.';
        txtLineaDiarioGenerada: TextConst ENU = 'There are lines to register in the Reclasif. Journal, Journal Book TRANSFEREN, batch AJUSTES', ESP = 'Se han generado líneas en el Diario de Reclasificación, libro diario TRANSFEREN, sección AJUSTES pendientes de registrar.';
        Text50002: TextConst ENU = 'Dou you want creata a line in Serv.Item. Entry Journal?', ESP = '¿Desea crear la línea de devolución en el Diario de Reclasificación?';
        Text50011: TextConst ENU = 'You cannot delete this invoice line because a %1 exists for this line. Delete all invoice for reverse contract periodo.', ESP = 'No puede eliminar esta factura porque existe un %1 para esta línea. Elimine completamente la factura para deshacer el periodo y vuelva a generar la factura.';
        HideDialogBox: Boolean;
        ServLedgEntry: Record "Service Ledger Entry";
        bRecreating: Boolean;
        ServItemComponent: Record "Service Item Component";
        ServItem2: Record "Service Item";

    procedure CheckServOrderLineDiscount();
    var
        ServItemLine: Record "Service Item Line";
    begin
        if "Document Type" = "Document Type"::Order then begin
            if "Service Item Line No." <> 0 then begin
                ServItemLine.Get("Document Type", "Document No.", "Service Item Line No.");
                if ServItemLine.nonfacturable_LDR then
                    Validate("Line Discount %", 100);
            end;
        end;
    end;

    procedure CheckWorkTypeLineDiscount();
    var
        WorkType: Record "Work Type";
    begin
        if "Document Type" = "Document Type"::Order then begin
            if "Work Type Code" <> '' then begin
                WorkType.Get("Work Type Code");
                if WorkType.Nonfacturable_LDR then begin
                    Validate(Chargeable_LDR, false)
                end else begin
                    Validate(Chargeable_LDR, true);
                    if Quantity < 0 then
                        Validate(Quantity, 0);
                end;
            end;
        end;
    end;

    procedure CalcDistanceDuration();
    var
        ServSetup: Record "Service Mgt. Setup";
        ServiceHeader: Record "Service Header";
        CPOrigen: Code[20];
        CPDestino: Code[20];
        CityOrigen: Text[30];
        CityDestino: Text[30];
        Distancias: Record "Kilometric distance_LDR";
        txtNoHayDistancias: TextConst ENU = 'Distance from Postal Code %1 City %2 to Postal Code %3 City %4 does not exist.', ESP = 'No se encuentra la distancia entre CP %1 Población %2 y CP %3 Población %4';
        ServiceItem: Record "Service Item";
        Sucursal: Record "Branch_LDR";
        txtUnidadMedida: TextConst ENU = 'Unit of measure must be %1 or %2.', ESP = 'La unidad de medida debe ser %1 o %2';
        TipoCalculo: Option Distancia,Duracion;
        Mensaje: Dialog;
    begin
        ServSetup.Get();
        ServSetup.TestField(ServSetup."Displacement Unit Of Measure_LDR");
        ServSetup.TestField(ServSetup."Disp. Time Unit Of Measure_LDR");
        case "Unit of Measure Code" of
            ServSetup."Displacement Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Distancia;
                end;
            ServSetup."Disp. Time Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Duracion;
                end;
            else
                Error(txtUnidadMedida, ServSetup."Displacement Unit Of Measure_LDR", ServSetup."Disp. Time Unit Of Measure_LDR");
        end;

        ServiceHeader.Get("Document Type", "Document No.");
        if ServiceHeader."Ship-to Code" <> '' then begin
            ServiceHeader.TestField(ServiceHeader."Ship-to Post Code");
            ServiceHeader.TestField(ServiceHeader."Ship-to City");

            CPDestino := ServiceHeader."Ship-to Post Code";
            CityDestino := ServiceHeader."Ship-to City";

        end else begin
            ServiceHeader.TestField(ServiceHeader."Post Code");
            ServiceHeader.TestField(ServiceHeader.City);

            CPDestino := ServiceHeader."Post Code";
            CityDestino := ServiceHeader.City;
        end;

        ServiceItem.Get("Service Item No.");

        if (ServiceItem."Customer No." <> ServiceHeader."Customer No.") or
           (ServiceItem."Ship-to Code" <> ServiceHeader."Ship-to Code") then begin

            if not Confirm(txtUbicacionPs, false, ServiceItem."No.") then
                exit;
        end;

        CPOrigen := Sucursal."Post Code";
        CityOrigen := Sucursal.City;

        Clear(Distancias);
        Distancias.SetRange(Distancias."From City", CityOrigen);
        Distancias.SetRange(Distancias."From Post Code", CPOrigen);
        Distancias.SetRange(Distancias."To City", CityDestino);
        Distancias.SetRange(Distancias."To Post Code", CPDestino);
        if not Distancias.Find('-') then begin
            Clear(Distancias);
            Distancias.SetRange(Distancias."From City", CityDestino);
            Distancias.SetRange(Distancias."From Post Code", CPDestino);
            Distancias.SetRange(Distancias."To City", CityOrigen);
            Distancias.SetRange(Distancias."To Post Code", CPOrigen);
            if not Distancias.Find('-') then begin
                Error(txtNoHayDistancias, CPOrigen, CityOrigen, CPDestino, CityDestino);
            end;
        end;

        case TipoCalculo of
            TipoCalculo::Distancia:
                begin
                    if not Chargeable_LDR then
                        Validate(Quantity, Distancias."Distance (Km)" * 2)
                    else begin
                        if Quantity = 0 then begin
                            Validate(Quantity, Distancias."Distance (Km)" * 2);
                        end;

                        Validate("Qty. to Invoice", Distancias."Distance (Km)" * 2);
                    end;

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Distancias."Distance (Km)" * 2);
                    Modify(true);
                end;
            TipoCalculo::Duracion:
                begin
                    if not Chargeable_LDR then
                        Validate(Quantity, Distancias.Duration * 2)
                    else begin
                        if Quantity = 0 then begin
                            Validate(Quantity, Distancias.Duration * 2);
                        end;

                        Validate("Qty. to Invoice", Distancias.Duration * 2);
                    end;

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Distancias.Duration * 2);
                    Modify(true);
                end;
        end;
    end;

    procedure CalcPriceDistanceDuration();
    var
        ServSetup: Record "Service Mgt. Setup";
        ServiceHeader: Record "Service Header";
        CPOrigen: Code[20];
        CPDestino: Code[20];
        CityOrigen: Text[30];
        CityDestino: Text[30];
        Distancias: Record "Kilometric distance_LDR";
        ServiceItem: Record "Service Item";
        Sucursal: Record "Branch_LDR";
        TipoCalculo: Option Distancia,Duracion;
        Importe: Decimal;
        Cantidad: Decimal;
        txtNoExistePrecio: TextConst ENU = 'Resource price not exist for Resource No. %1 Unit of measure %2 work type %3', ESP = 'No existe una tarifa definida para el Recurso %1 Unidad Medida %2 Tipo Trabajo %3';
        ResPrice: Record "Resource Price";
        txtValora0: TextConst ENU = 'Value %1 for field %2 on branch %3 may cause an incorrect calculation.Do you want to continue ?', ESP = 'El valor %1 para el campo %2 en la Sucursal %3 puede provocar un cálculo incorrecto.¿Está seguro de querer continuar?';
        PVP: Decimal;
        txtNoHayDistancias: TextConst ENU = 'Distance from Postal Code %1 City %2 to Postal Code %3 City %4 does not exist.', ESP = 'No se encuentra la distancia entre CP %1 Población %2 y CP %3 Población %4';
        txtUnidadMedida: TextConst ENU = 'Unit of measure must be %1 or %2.', ESP = 'La unidad de medida debe ser %1 o %2';
    begin
        ServSetup.Get();
        ServSetup.TestField(ServSetup."Displacement Unit Of Measure_LDR");
        ServSetup.TestField(ServSetup."Disp. Time Unit Of Measure_LDR");
        case "Unit of Measure Code" of
            ServSetup."Displacement Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Distancia;
                end;
            ServSetup."Disp. Time Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Duracion;
                end;
            else
                Error(txtUnidadMedida, ServSetup."Displacement Unit Of Measure_LDR", ServSetup."Disp. Time Unit Of Measure_LDR");
        end;

        ServiceHeader.Get("Document Type", "Document No.");
        if ServiceHeader."Ship-to Code" <> '' then begin
            ServiceHeader.TestField(ServiceHeader."Ship-to Post Code");
            ServiceHeader.TestField(ServiceHeader."Ship-to City");

            CPDestino := ServiceHeader."Ship-to Post Code";
            CityDestino := ServiceHeader."Ship-to City";

        end else begin

            ServiceHeader.TestField(ServiceHeader."Post Code");
            ServiceHeader.TestField(ServiceHeader.City);

            CPDestino := ServiceHeader."Post Code";
            CityDestino := ServiceHeader.City;
        end;

        ServiceItem.Get("Service Item No.");

        if (ServiceItem."Customer No." <> ServiceHeader."Customer No.") or
           (ServiceItem."Ship-to Code" <> ServiceHeader."Ship-to Code") then begin

            if not Confirm(txtUbicacionPs, false, ServiceItem."No.") then
                exit;
        end;

        Sucursal.TestField(Sucursal."Post Code");
        Sucursal.TestField(Sucursal.City);

        if Sucursal."Fixed value" = 0 then begin
            if not Confirm(txtValora0, true, Sucursal."Fixed value", Sucursal.FieldCaption("Fixed value"), Sucursal."No.") then
                Error('');
        end;

        if Sucursal.Fuel = 0 then begin
            if not Confirm(txtValora0, true, Sucursal.Fuel, Sucursal.FieldCaption(Fuel), Sucursal."No.") then
                Error('');
        end;

        if Sucursal.Maintenance = 0 then begin
            if not Confirm(txtValora0, true, Sucursal.Maintenance, Sucursal.FieldCaption(Maintenance), Sucursal."No.") then
                Error('');
        end;

        CPOrigen := Sucursal."Post Code";
        CityOrigen := Sucursal.City;

        Clear(Distancias);
        Distancias.SetRange(Distancias."From City", CityOrigen);
        Distancias.SetRange(Distancias."From Post Code", CPOrigen);
        Distancias.SetRange(Distancias."To City", CityDestino);
        Distancias.SetRange(Distancias."To Post Code", CPDestino);
        if not Distancias.Find('-') then begin
            Clear(Distancias);
            Distancias.SetRange(Distancias."From City", CityDestino);
            Distancias.SetRange(Distancias."From Post Code", CPDestino);
            Distancias.SetRange(Distancias."To City", CityOrigen);
            Distancias.SetRange(Distancias."To Post Code", CPOrigen);
            if not Distancias.Find('-') then begin
                Error(txtNoHayDistancias, CPOrigen, CityOrigen, CPDestino, CityDestino);
            end;
        end;

        case TipoCalculo of
            TipoCalculo::Distancia:
                begin
                    Clear(ResPrice);
                    ResPrice.SetRange(ResPrice.Type, ResPrice.Type::Resource);
                    ResPrice.SetRange(ResPrice.Code, "No.");
                    ResPrice.SetRange(ResPrice."Unit of Measure Code_LDR", "Unit of Measure Code");
                    ResPrice.SetRange(ResPrice."Work Type Code", "Work Type Code");
                    ResPrice.SetFilter(ResPrice."Unit Price", '<>%1', 0);
                    if not ResPrice.Find('-') then
                        Error(txtNoExistePrecio, "No.", "Unit of Measure Code", "Work Type Code");


                    UpdateUnitPrice(FieldNo("Work Type Code"));
                    Cantidad := Distancias."Distance (Km)" * 2;
                    Importe := (Sucursal."Fixed value" + (Cantidad * Sucursal.Fuel) + (Cantidad * Sucursal.Maintenance));
                    if Cantidad <> 0 then
                        PVP := Importe / Cantidad;

                    if not Chargeable_LDR then
                        Validate(Quantity, Cantidad)
                    else begin
                        if Quantity = 0 then begin
                            Validate(Quantity, Cantidad);
                        end;

                        Validate("Qty. to Invoice", Cantidad);
                    end;
                    Validate("Unit Price", PVP);

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Cantidad);

                    Modify(true);
                end;

            TipoCalculo::Duracion:
                begin
                    if not Chargeable_LDR then
                        Validate(Quantity, Distancias.Duration * 2)
                    else begin
                        if Quantity = 0 then begin
                            Validate(Quantity, Distancias.Duration * 2);
                        end;

                        Validate("Qty. to Invoice", Distancias.Duration * 2);
                    end;

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Distancias.Duration * 2);

                    Modify(true);
                end;
        end;
    end;

    procedure CalcDistanceDuration2();
    var
        ServSetup: Record "Service Mgt. Setup";
        ServiceHeader: Record "Service Header";
        CPOrigen: Code[20];
        CPDestino: Code[20];
        CityOrigen: Text[30];
        CityDestino: Text[30];
        Distancias: Record "Kilometric distance_LDR";
        txtNoHayDistancias: TextConst ENU = 'Distance from Postal Code %1 City %2 to Postal Code %3 City %4 does not exist.', ESP = 'No se encuentra la distancia entre CP %1 Población %2 y CP %3 Población %4';
        ServiceItem: Record "Service Item";
        Sucursal: Record "Branch_LDR";
        txtUnidadMedida: TextConst ENU = 'Unit of measure must be %1 or %2.', ESP = 'La unidad de medida debe ser %1 o %2';
        TipoCalculo: Option Distancia,Duracion;
        Mensaje: Dialog;
        Factor: Integer;
    begin
        ServSetup.Get();
        if ServSetup."Displacement Unit Of Measure_LDR" = '' then
            exit;

        if ServSetup."Disp. Time Unit Of Measure_LDR" = '' then
            exit;

        case "Unit of Measure Code" of
            ServSetup."Displacement Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Distancia;
                end;
            ServSetup."Disp. Time Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Duracion;
                end;
            else
                exit;
        end;

        case ServSetup."Transfer Displacement / KM_LDR" of
            ServSetup."Transfer Displacement / KM_LDR"::Way:
                Factor := 1;
            ServSetup."Transfer Displacement / KM_LDR"::"Way Back":
                Factor := 2;
        end;

        ServiceHeader.Get("Document Type", "Document No.");
        if ServiceHeader."Ship-to Code" <> '' then begin
            if ServiceHeader."Ship-to Post Code" = '' then
                exit;
            if ServiceHeader."Ship-to City" = '' then
                exit;

            CPDestino := ServiceHeader."Ship-to Post Code";
            CityDestino := ServiceHeader."Ship-to City";

        end else begin

            if ServiceHeader."Post Code" = '' then
                exit;
            if ServiceHeader.City = '' then
                exit;

            CPDestino := ServiceHeader."Post Code";
            CityDestino := ServiceHeader.City;
        end;

        ServiceItem.Get("Service Item No.");

        Clear(Distancias);
        Distancias.SetRange(Distancias."From City", CityOrigen);
        Distancias.SetRange(Distancias."From Post Code", CPOrigen);
        Distancias.SetRange(Distancias."To City", CityDestino);
        Distancias.SetRange(Distancias."To Post Code", CPDestino);
        if not Distancias.Find('-') then begin
            Clear(Distancias);
            Distancias.SetRange(Distancias."From City", CityDestino);
            Distancias.SetRange(Distancias."From Post Code", CPDestino);
            Distancias.SetRange(Distancias."To City", CityOrigen);
            Distancias.SetRange(Distancias."To Post Code", CPOrigen);
            if not Distancias.Find('-') then begin
                exit;
            end;
        end;

        case TipoCalculo of
            TipoCalculo::Distancia:
                begin
                    if not Chargeable_LDR then
                        Validate(Quantity, Distancias."Distance (Km)" * Factor)
                    else
                        Validate("Qty. to Invoice (Base)", Distancias."Distance (Km)" * Factor);

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Distancias."Distance (Km)" * Factor);

                    Modify(true);
                end;

            TipoCalculo::Duracion:
                begin
                    if not Chargeable_LDR then
                        Validate(Quantity, Distancias.Duration * Factor)
                    else
                        Validate("Qty. to Invoice (Base)", Distancias.Duration * Factor);

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Distancias.Duration * Factor);

                    Modify(true);
                end;
        end;
    end;

    procedure CalcPriceDistanceDuration2();
    var
        ServSetup: Record "Service Mgt. Setup";
        ServiceHeader: Record "Service Header";
        CPOrigen: Code[20];
        CPDestino: Code[20];
        CityOrigen: Text[30];
        CityDestino: Text[30];
        Distancias: Record "Kilometric distance_LDR";
        ServiceItem: Record "Service Item";
        Sucursal: Record "Branch_LDR";
        TipoCalculo: Option Distancia,Duracion;
        Importe: Decimal;
        Cantidad: Decimal;
        txtNoExistePrecio: TextConst ENU = 'Resource price not exist for Resource No. %1 Unit of measure %2 work type %3', ESP = 'No existe una tarifa definida para el Recurso %1 Unidad Medida %2 Tipo Trabajo %3';
        ResPrice: Record "Resource Price";
        txtValora0: TextConst ENU = 'Value %1 for field %2 on branch %3 may cause an incorrect calculation.Do you want to continue?', ESP = 'El valor %1 para el campo %2 en la Sucursal %3 puede provocar un cálculo incorrecto.¿Está seguro de querer continuar?';
        PVP: Decimal;
        txtNoHayDistancias: TextConst ENU = 'Distance from Postal Code %1 City %2 to Postal Code %3 City %4 does not exist.', ESP = 'No se encuentra la distancia entre CP %1 Población %2 y CP %3 Población %4';
        txtUnidadMedida: TextConst ENU = 'Unit of measure must be %1 or %2.', ESP = 'La unidad de medida debe ser %1 o %2';
        Factor: Integer;
    begin
        ServSetup.Get();
        if ServSetup."Displacement Unit Of Measure_LDR" = '' then
            exit;
        if ServSetup."Disp. Time Unit Of Measure_LDR" = '' then
            exit;
        case "Unit of Measure Code" of
            ServSetup."Displacement Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Distancia;
                end;
            ServSetup."Disp. Time Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Duracion;
                end;
            else
                exit;
        end;

        case ServSetup."Transfer Displacement / KM_LDR" of
            ServSetup."Transfer Displacement / KM_LDR"::Way:
                Factor := 1;
            ServSetup."Transfer Displacement / KM_LDR"::"Way Back":
                Factor := 2;
        end;

        ServiceHeader.Get("Document Type", "Document No.");
        if ServiceHeader."Ship-to Code" <> '' then begin
            if ServiceHeader."Ship-to Post Code" = '' then
                exit;
            if ServiceHeader."Ship-to City" = '' then
                exit;

            CPDestino := ServiceHeader."Ship-to Post Code";
            CityDestino := ServiceHeader."Ship-to City";

        end else begin

            if ServiceHeader."Post Code" = '' then
                exit;
            if ServiceHeader.City = '' then
                exit;

            CPDestino := ServiceHeader."Post Code";
            CityDestino := ServiceHeader.City;
        end;

        ServiceItem.Get("Service Item No.");

        Clear(Distancias);
        Distancias.SetRange(Distancias."From City", CityOrigen);
        Distancias.SetRange(Distancias."From Post Code", CPOrigen);
        Distancias.SetRange(Distancias."To City", CityDestino);
        Distancias.SetRange(Distancias."To Post Code", CPDestino);
        if not Distancias.Find('-') then begin
            Clear(Distancias);
            Distancias.SetRange(Distancias."From City", CityDestino);
            Distancias.SetRange(Distancias."From Post Code", CPDestino);
            Distancias.SetRange(Distancias."To City", CityOrigen);
            Distancias.SetRange(Distancias."To Post Code", CPOrigen);
            if not Distancias.Find('-') then begin
                exit;
            end;
        end;

        case TipoCalculo of
            TipoCalculo::Distancia:
                begin
                    UpdateUnitPrice(FieldNo("Work Type Code"));
                    Cantidad := Distancias."Distance (Km)" * Factor;
                    Importe := (Sucursal."Fixed value" + (Cantidad * Sucursal.Fuel) + (Cantidad * Sucursal.Maintenance));
                    if Cantidad <> 0 then
                        PVP := Importe / Cantidad;

                    if not Chargeable_LDR then
                        Validate(Quantity, Cantidad)
                    else
                        Validate("Qty. to Invoice (Base)", Cantidad);

                    Validate("Unit Price", PVP);

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Cantidad);

                    Modify(true);
                end;

            TipoCalculo::Duracion:
                begin
                    if not Chargeable_LDR then
                        Validate(Quantity, Distancias.Duration * Factor)
                    else
                        Validate("Qty. to Invoice (Base)", Distancias.Duration * Factor);

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Distancias.Duration * Factor);

                    Modify(true);
                end;
        end;
    end;

    procedure CheckDistanceDuration2();
    var
        ServSetup: Record "Service Mgt. Setup";
        ServiceHeader: Record "Service Header";
        CPOrigen: Code[20];
        CPDestino: Code[20];
        CityOrigen: Text[30];
        CityDestino: Text[30];
        Distancias: Record "Kilometric distance_LDR";
        txtNoHayDistancias: TextConst ENU = 'Distance from Postal Code %1 City %2 to Postal Code %3 City %4 does not exist.', ESP = 'No se encuentra la distancia entre CP %1 Población %2 y CP %3 Población %4';
        ServiceItem: Record "Service Item";
        Sucursal: Record "Branch_LDR";
        txtUnidadMedida: TextConst ENU = 'Unit of measure must be %1 or %2.', ESP = 'La unidad de medida debe ser %1 o %2';
        TipoCalculo: Option Distancia,Duracion;
        Mensaje: Dialog;
        Factor: Integer;
    begin
        ServSetup.Get();
        if ServSetup."Displacement Unit Of Measure_LDR" = '' then
            exit;

        if ServSetup."Disp. Time Unit Of Measure_LDR" = '' then
            exit;

        case "Unit of Measure Code" of
            ServSetup."Displacement Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Distancia;
                end;
            ServSetup."Disp. Time Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Duracion;
                end;
            else
                exit;
        end;

        case ServSetup."Transfer Displacement / KM_LDR" of
            ServSetup."Transfer Displacement / KM_LDR"::Way:
                Factor := 1;
            ServSetup."Transfer Displacement / KM_LDR"::"Way Back":
                Factor := 2;
        end;

        ServiceHeader.Get("Document Type", "Document No.");
        if ServiceHeader."Ship-to Code" <> '' then begin
            if ServiceHeader."Ship-to Post Code" = '' then
                exit;
            if ServiceHeader."Ship-to City" = '' then
                exit;

            CPDestino := ServiceHeader."Ship-to Post Code";
            CityDestino := ServiceHeader."Ship-to City";

        end else begin

            if ServiceHeader."Post Code" = '' then
                exit;
            if ServiceHeader.City = '' then
                exit;

            CPDestino := ServiceHeader."Post Code";
            CityDestino := ServiceHeader.City;
        end;

        ServiceItem.Get("Service Item No.");

        Clear(Distancias);
        Distancias.SetRange(Distancias."From City", CityOrigen);
        Distancias.SetRange(Distancias."From Post Code", CPOrigen);
        Distancias.SetRange(Distancias."To City", CityDestino);
        Distancias.SetRange(Distancias."To Post Code", CPDestino);
        if not Distancias.Find('-') then begin
            Clear(Distancias);
            Distancias.SetRange(Distancias."From City", CityDestino);
            Distancias.SetRange(Distancias."From Post Code", CPDestino);
            Distancias.SetRange(Distancias."To City", CityOrigen);
            Distancias.SetRange(Distancias."To Post Code", CPOrigen);
            if not Distancias.Find('-') then begin
                exit;
            end;
        end;

        case TipoCalculo of
            TipoCalculo::Distancia:
                begin
                    if not Chargeable_LDR then
                        Validate(Quantity, Distancias."Distance (Km)" * Factor)
                    else
                        Validate("Qty. to Invoice (Base)", Distancias."Distance (Km)" * Factor);

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Distancias."Distance (Km)" * Factor);
                end;

            TipoCalculo::Duracion:
                begin
                    if not Chargeable_LDR then
                        Validate(Quantity, Distancias.Duration * Factor)
                    else
                        Validate("Qty. to Invoice (Base)", Distancias.Duration * Factor);

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Distancias.Duration * Factor);
                end;
        end;
    end;

    procedure CheckPriceDistanceDuration2();
    var
        ServSetup: Record "Service Mgt. Setup";
        ServiceHeader: Record "Service Header";
        CPOrigen: Code[20];
        CPDestino: Code[20];
        CityOrigen: Text[30];
        CityDestino: Text[30];
        Distancias: Record "Kilometric distance_LDR";
        ServiceItem: Record "Service Item";
        Sucursal: Record "Branch_LDR";
        TipoCalculo: Option Distancia,Duracion;
        Importe: Decimal;
        Cantidad: Decimal;
        txtNoExistePrecio: TextConst ENU = 'Resource price not exist for Resource No. %1 Unit of measure %2 work type %3', ESP = 'No existe una tarifa definida para el Recurso %1 Unidad Medida %2 Tipo Trabajo %3';
        ResPrice: Record "Resource Price";
        txtValora0: TextConst ENU = 'Value %1 for field %2 on branch %3 may cause an incorrect calculation.Do you want to continue?', ESP = 'El valor %1 para el campo %2 en la Sucursal %3 puede provocar un cálculo incorrecto.¿Está seguro de querer continuar?';
        PVP: Decimal;
        txtNoHayDistancias: TextConst ENU = 'Distance from Postal Code %1 City %2 to Postal Code %3 City %4 does not exist.', ESP = 'No se encuentra la distancia entre CP %1 Población %2 y CP %3 Población %4';
        txtUnidadMedida: TextConst ENU = 'Unit of measure must be %1 or %2.', ESP = 'La unidad de medida debe ser %1 o %2';
        Factor: Integer;
    begin
        ServSetup.Get();
        if ServSetup."Displacement Unit Of Measure_LDR" = '' then
            exit;
        if ServSetup."Disp. Time Unit Of Measure_LDR" = '' then
            exit;
        case "Unit of Measure Code" of
            ServSetup."Displacement Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Distancia;
                end;
            ServSetup."Disp. Time Unit Of Measure_LDR":
                begin
                    TipoCalculo := TipoCalculo::Duracion;
                end;
            else
                exit;
        end;

        case ServSetup."Transfer Displacement / KM_LDR" of
            ServSetup."Transfer Displacement / KM_LDR"::Way:
                Factor := 1;
            ServSetup."Transfer Displacement / KM_LDR"::"Way Back":
                Factor := 2;
        end;

        ServiceHeader.Get("Document Type", "Document No.");
        if ServiceHeader."Ship-to Code" <> '' then begin
            if ServiceHeader."Ship-to Post Code" = '' then
                exit;
            if ServiceHeader."Ship-to City" = '' then
                exit;

            CPDestino := ServiceHeader."Ship-to Post Code";
            CityDestino := ServiceHeader."Ship-to City";

        end else begin

            if ServiceHeader."Post Code" = '' then
                exit;
            if ServiceHeader.City = '' then
                exit;

            CPDestino := ServiceHeader."Post Code";
            CityDestino := ServiceHeader.City;
        end;

        ServiceItem.Get("Service Item No.");

        Clear(Distancias);
        Distancias.SetRange(Distancias."From City", CityOrigen);
        Distancias.SetRange(Distancias."From Post Code", CPOrigen);
        Distancias.SetRange(Distancias."To City", CityDestino);
        Distancias.SetRange(Distancias."To Post Code", CPDestino);
        if not Distancias.Find('-') then begin
            Clear(Distancias);
            Distancias.SetRange(Distancias."From City", CityDestino);
            Distancias.SetRange(Distancias."From Post Code", CPDestino);
            Distancias.SetRange(Distancias."To City", CityOrigen);
            Distancias.SetRange(Distancias."To Post Code", CPOrigen);
            if not Distancias.Find('-') then begin
                exit;
            end;
        end;

        case TipoCalculo of
            TipoCalculo::Distancia:
                begin
                    Clear(ResPrice);
                    ResPrice.SetRange(ResPrice.Type, ResPrice.Type::Resource);
                    ResPrice.SetRange(ResPrice.Code, "No.");
                    ResPrice.SetRange(ResPrice."Unit of Measure Code_LDR", "Unit of Measure Code");
                    ResPrice.SetRange(ResPrice."Work Type Code", "Work Type Code");
                    ResPrice.SetFilter(ResPrice."Unit Price", '<>%1', 0);
                    if not ResPrice.Find('-') then
                        exit;

                    UpdateUnitPrice(FieldNo("Work Type Code"));
                    Cantidad := Distancias."Distance (Km)" * Factor;
                    Importe := (Sucursal."Fixed value" + (Cantidad * Sucursal.Fuel) + (Cantidad * Sucursal.Maintenance));
                    if Cantidad <> 0 then
                        PVP := Importe / Cantidad;

                    if not Chargeable_LDR then
                        Validate(Quantity, Cantidad)
                    else
                        Validate("Qty. to Invoice (Base)", Cantidad);

                    Validate("Unit Price", PVP);

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Cantidad);
                end;

            TipoCalculo::Duracion:
                begin
                    if not Chargeable_LDR then
                        Validate(Quantity, Distancias.Duration * Factor)
                    else
                        Validate("Qty. to Invoice (Base)", Distancias.Duration * Factor);

                    if (Format("Initial Time_LDR") = '') and (Format("End Time_LDR") = '') then
                        Validate("Internal Quantity_LDR", Distancias.Duration * Factor);
                end;
        end;
    end;

    procedure ChangeComponentAction();
    var
        ServItem: Record "Service Item";
        Select: Integer;
    begin
        if Type <> Type::Item then
            exit;

        if "Service Item No." = '' then
            exit;

        ServItem.Get("Service Item No.");

        if ServItem."Item No." = "No." then
            exit;

        ServItem.CalcFields("Service Item Components");
        if not ServItem."Service Item Components" then
            exit;

        Select := StrMenu(Text006, 3);
        case Select of
            1:
                begin
                    Commit();
                    ServItemComponent.Reset();
                    ServItemComponent.SetRange(Active, true);
                    ServItemComponent.SetRange("Parent Service Item No.", ServItem."No.");
                    if Page.RunModal(0, ServItemComponent) = Action::LookupOK then begin
                        "Replaced Item No." := ServItemComponent."No.";
                        "Component Line No." := ServItemComponent."Line No.";
                        CheckIfServItemReplacement("Component Line No.");
                        if ServItemComponent.Type = ServItemComponent.Type::"Service Item" then begin
                            ServItem2.Get(ServItemComponent."No.");
                            "Warranty Disc. %" := ServItem2."Warranty % (Parts)";
                        end;
                        "Spare Part Action" := "Spare Part Action"::"Component Replaced";
                        Quantity := 0;
                    end else
                        Error(Text007, ServItemComponent.TableCaption);
                end;

            2:
                begin
                    "Replaced Item No." := '';
                    "Component Line No." := 0;
                    "Spare Part Action" := "Spare Part Action"::"Component Installed";
                    Quantity := 0;
                end;

            3:
                begin
                    "Replaced Item No." := '';
                    "Component Line No." := 0;
                    "Spare Part Action" := "Spare Part Action"::" ";
                end;

            4:
                begin
                    Commit();
                    ServItemComponent.Reset();
                    ServItemComponent.SetRange(Active, true);
                    ServItemComponent.SetRange("Parent Service Item No.", ServItem."No.");
                    if Page.RunModal(0, ServItemComponent) = Action::LookupOK then begin
                        "Replaced Item No." := ServItemComponent."No.";
                        "Component Line No." := ServItemComponent."Line No.";
                        CheckIfServItemReplacement("Component Line No.");
                        if ServItemComponent.Type = ServItemComponent.Type::"Service Item" then begin
                            ServItem2.Get(ServItemComponent."No.");
                            "Warranty Disc. %" := ServItem2."Warranty % (Parts)";
                        end;
                        //"Spare Part Action" := "Spare Part Action"::"Component Changed";
                        Quantity := 0;
                    end else
                        Error(Text007, ServItemComponent.TABLECAPTION);
                end;
        end;
    end;

    procedure SetHideDialog(bHide: Boolean);
    begin
        HideDialogBox := bHide;
    end;

    procedure GetNextLineNoLast(ServInvLine: Record "Service Line"; BelowxRec: Boolean): Integer;
    var
        ServInvLine2: Record "Service Line";
        LoLineNo: Integer;
        HiLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        LoLineNo := 0;
        HiLineNo := 0;
        NextLineNo := 0;
        LineStep := 10000;
        ServInvLine2.SetRange("Document Type", "Document Type");
        ServInvLine2.SetRange("Document No.", "Document No.");
        if ServInvLine2.FindLast() then;
        NextLineNo := ServInvLine2."Line No." + LineStep;
        exit(NextLineNo);
    end;

    procedure LookupServiceItem();
    var
        ServItem: Record "Service Item";
        ServContractLine: Record "Service Contract Line";
        ServItemList: Page "Service Item List";
        ServContractLineList: Page "Serv. Item List (Contract)";
    begin
        if ServItem.Get("Service Item No.") then
            ServItemList.SetRecord(ServItem);

        ServItem.Reset();
        ServItem.FilterGroup(2);
        ServItem.SetCurrentKey("Customer No.", "Ship-to Code");

        case "Document Type" of
            "Document Type"::Invoice:
                ServItem.SetRange(ServItem.Own_LDR, true);
            "Document Type"::"Credit Memo":
                ServItem.SetRange(ServItem.Own_LDR, false);
        end;
        ServItem.FilterGroup(0);
        ServItemList.SetTableView(ServItem);
        ServItemList.LookupMode(true);
        if ServItemList.RunModal() = Action::LookupOK then begin
            ServItemList.GetRecord(ServItem);
            Validate("Service Item No.", ServItem."No.");
        end;
    end;

    procedure CheckNonFacturable();
    var
        ServHeader: Record "Service Header";
        ServSetup: Record "Service Mgt. Setup";
        ServItemLine: Record "Service Item Line";
    begin
        ServSetup.Get();
        ServSetup.TestField(ServSetup."Assembly Service Order Type_LDR");

        ServHeader.Get("Document Type", "Document No.");
        if ServHeader."Service Order Type" = ServSetup."Assembly Service Order Type_LDR" then
            Validate(Chargeable_LDR, false);

        if ServHeader."Internal Contract No._LDR" <> '' then
            Validate(Chargeable_LDR, false);

        if ("Document Type" <> "Document Type"::Invoice) and
          ("Document Type" <> "Document Type"::"Credit Memo") then begin

            ServItemLine.Get("Document Type", "Document No.", "Service Item Line No.");
            if ServItemLine.nonfacturable_LDR then
                Validate("Line Discount %", 100);
        end;
    end;

    procedure InitFacturableQty(CurrentFieldNo: Integer);
    begin
        if (Quantity <> 0) and (Chargeable_LDR) and
           (("Qty. to Invoice" = 0) or (CurrFieldNo = FieldNo(Quantity)) or (CurrFieldNo = FieldNo("Unit of Measure Code"))) then begin
            "Qty. to Invoice" := Quantity;
            "Qty. to Invoice (Base)" := "Quantity (Base)";
        end;
    end;

    procedure SetRecreatingTable(bRecreate: Boolean);
    begin
        bRecreating := bRecreate;
    end;

    procedure InsertServItemExtText();
    var
        ToSalesLine: Record "Service Line";
        LineSpacing: Integer;
        NextLineNo: Integer;
        TmpExtTextLine: Record "Service Item Component";
    begin
        TestField("Service Item No.");

        TmpExtTextLine.Reset();
        TmpExtTextLine.SetRange(TmpExtTextLine.Active, true);
        TmpExtTextLine.SetRange(TmpExtTextLine."Parent Service Item No.", "Service Item No.");
        if TmpExtTextLine.FindSet() then;

        ToSalesLine.Reset();
        ToSalesLine.SetRange("Document Type", "Document Type");
        ToSalesLine.SetRange("Document No.", "Document No.");
        ToSalesLine := Rec;
        if ToSalesLine.Find('>') then begin
            LineSpacing :=
              (ToSalesLine."Line No." - "Line No.") div
              (1 + TmpExtTextLine.Count);
            if LineSpacing = 0 then
                Error(Text000);
        end else
            LineSpacing := 10000;

        NextLineNo := "Line No." + LineSpacing;

        if TmpExtTextLine.FindSet() then begin
            repeat
                ToSalesLine.Init();
                ToSalesLine."Document Type" := "Document Type";
                ToSalesLine."Document No." := "Document No.";
                ToSalesLine."Line No." := NextLineNo;
                NextLineNo := NextLineNo + LineSpacing;
                ToSalesLine.Description := TmpExtTextLine.Description;
                ToSalesLine."Attached to Line No." := "Line No.";
                ToSalesLine.Insert();
            until TmpExtTextLine.Next() = 0;
        end;
    end;

    procedure ChangeLocationReclasified(newLocation: Code[10]; NotReclassify: Boolean);
    var
        ItemJnlLine: Record "Item Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        JnlLineNo: Integer;
        ServiceLine2: Record "Service Line";
        //LocationModifyLog: Record 70087;
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        ServiceLine2.Copy(Rec);
        if ("Created from Transfer_LDR") then begin
            SourceCodeSetup.Get();
            SourceCodeSetup.TestField(SourceCodeSetup."Item Reclass. Journal");
            ServMgtSetup.Get();
            ServMgtSetup.TestField("Auto Adjust Journal Template_LDR");
            ServMgtSetup.TestField("Auto Adjust Journal Batch_LDR");

            if ItemJnlTemplate.Get(ServMgtSetup."Auto Adjust Journal Template_LDR") then begin
                if ItemJnlBatch.Get(ItemJnlTemplate.Name, ServMgtSetup."Auto Adjust Journal Batch_LDR") then begin
                    Clear(ItemJnlLine);
                    ItemJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    ItemJnlLine.SetRange("Source Code", SourceCodeSetup."Item Reclass. Journal");
                    ItemJnlLine.SetRange("Journal Template Name", ServMgtSetup."Auto Adjust Journal Template_LDR");
                    ItemJnlLine.SetRange("Journal Batch Name", ServMgtSetup."Auto Adjust Journal Batch_LDR");
                    if ItemJnlLine.FindLast() then
                        JnlLineNo := ItemJnlLine."Line No." + 10000
                end else
                    Error(txtErrorSeccion);
            end else begin
                Error(txtErrorDiario);
            end;

            Delete(true);
            if NotReclassify = false then begin
                ItemJnlLine.Init();
                ItemJnlLine.Validate(ItemJnlLine."Entry Type", ItemJnlLine."Entry Type"::Transfer);
                ItemJnlLine.Validate("Source Code", SourceCodeSetup."Item Reclass. Journal");
                ItemJnlLine.Validate("Journal Template Name", ServMgtSetup."Auto Adjust Journal Template_LDR");
                ItemJnlLine.Validate("Journal Batch Name", ServMgtSetup."Auto Adjust Journal Batch_LDR");
                ItemJnlLine.Validate("Posting Date", WorkDate);
                ItemJnlLine.Validate(ItemJnlLine."Line No.", (JnlLineNo + 10000));
                ItemJnlLine.Validate(ItemJnlLine."Document No.", ServiceLine2."Document No.");
                ItemJnlLine.Validate(ItemJnlLine."Item No.", ServiceLine2."No.");
                ItemJnlLine.Validate(ItemJnlLine.Quantity, ServiceLine2.Quantity);
                ItemJnlLine.Validate(ItemJnlLine."Location Code", ServiceLine2."Transfer Source Location Code_LDR");
                ItemJnlLine.Validate(ItemJnlLine."Bin Code", ServiceLine2."Transfer Source Bin Code_LDR");
                ItemJnlLine.Validate(ItemJnlLine."New Location Code", newLocation);
                ItemJnlLine."Order Type" := ItemJnlLine."Order Type"::Service;
                ItemJnlLine.Validate(ItemJnlLine."Order No.", ServiceLine2."Document No.");
                ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::Transfer);
                ItemJnlLine.Insert(true);
            end;

            // LocationModifyLog.CreateEntry(
            // ServiceLine2.Type,
            // ServiceLine2."Document No.",
            // "Location Code",
            // "Bin Code",
            // newLocation,
            // ServiceLine2."No.",
            // ServiceLine2."Line No.");
        end;
    end;

    procedure CreateReturnJournal(QtyToReturn: Decimal);
    var
        SourceCodeSetup: Record "Source Code Setup";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        JnlLineNo: Integer;
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        SourceCodeSetup.Get();
        SourceCodeSetup.TestField(SourceCodeSetup."Item Reclass. Journal");
        ServMgtSetup.Get();
        ServMgtSetup.TestField("Auto Adjust Journal Template_LDR");
        ServMgtSetup.TestField("Auto Adjust Journal Batch_LDR");

        if ItemJnlTemplate.Get(ServMgtSetup."Auto Adjust Journal Template_LDR") then begin
            if ItemJnlBatch.Get(ItemJnlTemplate.Name, ServMgtSetup."Auto Adjust Journal Batch_LDR") then begin
                Clear(ItemJnlLine);
                ItemJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                ItemJnlLine.SetRange("Source Code", SourceCodeSetup."Item Reclass. Journal");
                ItemJnlLine.SetRange("Journal Template Name", ServMgtSetup."Auto Adjust Journal Template_LDR");
                ItemJnlLine.SetRange("Journal Batch Name", ServMgtSetup."Auto Adjust Journal Batch_LDR");
                if ItemJnlLine.FindLast() then
                    JnlLineNo := ItemJnlLine."Line No." + 10000;
            end else begin
                Error(txtErrorSeccion);
            end;
        end else begin
            Error(txtErrorDiario);
        end;

        ItemJnlLine.Init();
        ItemJnlLine.Validate("Source Code", SourceCodeSetup."Item Reclass. Journal");
        ItemJnlLine.Validate("Journal Template Name", ServMgtSetup."Auto Adjust Journal Template_LDR");
        ItemJnlLine.Validate("Journal Batch Name", ServMgtSetup."Auto Adjust Journal Batch_LDR");
        ItemJnlLine.Validate("Posting Date", WorkDate);
        ItemJnlLine.Validate(ItemJnlLine."Line No.", JnlLineNo);
        ItemJnlLine.Validate(ItemJnlLine."Document No.", "Document No.");
        ItemJnlLine.Validate(ItemJnlLine."Item No.", "No.");
        ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code", "Unit of Measure Code");
        ItemJnlLine.Validate(ItemJnlLine.Quantity, QtyToReturn);
        ItemJnlLine.Validate(ItemJnlLine."Location Code", "Location Code");
        ItemJnlLine.Validate(ItemJnlLine."Bin Code", "Bin Code");
        ItemJnlLine."New Location Code" := "Transfer Source Location Code_LDR";
        ItemJnlLine."New Bin Code" := "Transfer Source Bin Code_LDR";
        ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::Transfer);
        ItemJnlLine.Insert(true);
    end;
}