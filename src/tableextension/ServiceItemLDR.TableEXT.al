/// <summary>
/// tableextension 50074 "Service Item_LDR"
/// </summary>
tableextension 50074 "Service Item_LDR" extends "Service Item"
{
    fields
    {
        field(50000; "Ingestrel Export_LDR"; Boolean)
        {
            Caption = 'Exportar a Ingestrel';
            DataClassification = ToBeClassified;
        }
        field(50001; "Explotation Customer No._LDR"; Code[20])
        {
            Caption = 'Nº Cliente Explotación';
            DataClassification = ToBeClassified;
            TableRelation = "Customer";
        }
        field(50002; "Model Code_LDR"; Code[10])
        {
            Caption = 'Código Modelo';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Model_LDR"."Model Code" WHERE("Code" = FIELD("Manufacturer Code_LDR"));
        }
        field(50003; "Service Item Type Code_LDR"; Code[10])
        {
            Caption = 'Código Tipo Producto Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Type_LDR";

            trigger OnValidate()
            var
                ServiceItemPresGroup: Record "Service Item Pres. Group_LDR";
            begin

            end;
        }
        field(50004; "Service Item Type Subtype_LDR"; Code[10])
        {
            Caption = 'Código SubTipo Producto Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Subtype_LDR"."Service Item Subtype Code" WHERE("Code" = FIELD("Service Item Type Code_LDR"));
        }
        field(50005; "Presentation Group Code_LDR"; Code[10])
        {
            Caption = 'Código Grupo Presentación';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Pres. Group_LDR";

            trigger OnValidate()
            var
                ServiceItemPresGroup: Record "Service Item Pres. Group_LDR";
                ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
            begin
                if ServiceItemPresGroup.Get("Presentation Group Code_LDR") and ServiceItemInvoiceGroup.Get("Invoicing Group Code_LDR") then begin
                    ServiceItemPresGroup.TestField(ServiceItemPresGroup."Group Type", ServiceItemInvoiceGroup."Group Type");
                    "Service Item Type_LDR" := ServiceItemPresGroup."Group Type";
                end;
            end;
        }
        field(50006; "Invoicing Group Code_LDR"; Code[10])
        {
            Caption = 'Código Grupo Facturación';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Invoice Group_LDR";

            trigger OnValidate()
            var
                ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
                ServiceItemPresGroup: Record "Service Item Pres. Group_LDR";
            begin
                if ServiceItemPresGroup.Get("Presentation Group Code_LDR") and ServiceItemInvoiceGroup.Get("Invoicing Group Code_LDR") then
                    ServiceItemInvoiceGroup.TestField(ServiceItemInvoiceGroup."Group Type", ServiceItemPresGroup."Group Type");

                Validate("Average Speed_LDR", ServiceItemInvoiceGroup."Average Speed");
            end;
        }
        field(50007; "Cancelation Cause Code_LDR"; Code[10])
        {
            Caption = 'Código Causa Baja';
            DataClassification = ToBeClassified;
            TableRelation = "Cancellat Type Servic Item_LDR";
        }
        field(50008; "No. Chassis_LDR"; Text[20])
        {
            Caption = 'Nº Chasis';
            DataClassification = ToBeClassified;
        }
        field(50009; "Plate No._LDR"; Text[20])
        {
            Caption = 'Matrícula';
            DataClassification = ToBeClassified;
        }
        field(50010; "Registration Date_LDR"; Date)
        {
            Caption = 'Fecha Matrícula';
            DataClassification = ToBeClassified;
        }
        field(50011; "Average Speed_LDR"; Integer)
        {
            Caption = 'Velocidad Media';
            DataClassification = ToBeClassified;
        }
        field(50012; "Cancellation Date_LDR"; Date)
        {
            Caption = 'Fecha Baja';
            DataClassification = ToBeClassified;
        }
        field(50013; "Engines Counter_LDR"; Integer)
        {
            Caption = 'Nº de Motores';
            DataClassification = ToBeClassified;
            MinValue = 1;
        }
        field(50014; "Maintenance Block_LDR"; Boolean)
        {
            CalcFormula = Exist("Serv. Item Avail Entry_LDR" WHERE("Service Item Code" = FIELD("No."), "Entry Type" = CONST("maintenance"), "Starting Date" = FIELD("Starting Date Filter_LDR"), "Ending Date" = FIELD("Ending Date Filter_LDR")));
            Caption = 'Bloqueado Mantenimiento';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50015; "Refueling Vehicle ID_LDR"; Code[10])
        {
            Caption = 'ID Vehículo Repostaje';
            DataClassification = ToBeClassified;
        }
        field(50016; "Export Ingestrel_LDR"; Boolean)
        {
            Caption = 'Exportar a Ingestrel';
            DataClassification = ToBeClassified;
        }
        field(50017; "Explotation Name_LDR"; Text[50])
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Explotation Customer No._LDR")));
            Caption = 'Nombre';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50018; "Explotation Name 2_LDR"; Text[50])
        {
            CalcFormula = Lookup("Customer"."Name 2" WHERE("No." = FIELD("Explotation Customer No._LDR")));
            Caption = 'Nombre 2';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50019; "Explotation Address_LDR"; Text[50])
        {
            CalcFormula = Lookup("Customer"."Address" WHERE("No." = FIELD("Explotation Customer No._LDR")));
            Caption = 'Dirección';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50020; "Explotation Address 2_LDR"; Text[50])
        {
            CalcFormula = Lookup("Customer"."Address 2" WHERE("No." = FIELD("Explotation Customer No._LDR")));
            Caption = 'Dirección 2';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50021; "Explotation Post Code_LDR"; Code[20])
        {
            CalcFormula = Lookup("Customer"."Post Code" WHERE("No." = FIELD("Explotation Customer No._LDR")));
            Caption = 'Código Postal';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50022; "Explotation City_LDR"; Text[30])
        {
            CalcFormula = Lookup("Customer"."City" WHERE("No." = FIELD("Explotation Customer No._LDR")));
            Caption = 'Población';
            FieldClass = FlowField;
            Editable = false;
            TableRelation = "Post Code"."City";
            ValidateTableRelation = false;
        }
        field(50023; "Explotation County_LDR"; Text[30])
        {
            CalcFormula = Lookup("Customer"."County" WHERE("No." = FIELD("Explotation Customer No._LDR")));
            Caption = 'Provincia';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50024; "Explot. Country/Region Code_LDR"; Code[10])
        {
            CalcFormula = Lookup("Customer"."Country/Region Code" WHERE("No." = FIELD("Explotation Customer No._LDR")));
            Caption = 'Código País/Región';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50025; "Explotation Phone No._LDR"; Text[30])
        {
            CalcFormula = Lookup("Customer"."Phone No." WHERE("No." = FIELD("Explotation Customer No._LDR")));
            Caption = 'Nº Teléfono';
            FieldClass = FlowField;
            Editable = false;
            ExtendedDatatype = PhoneNo;
        }
        field(50026; "Last Export Date_LDR"; Date)
        {
            Caption = 'Fecha Última Exportación';
            DataClassification = ToBeClassified;
        }
        field(50027; "Machine Resource Code_LDR"; Code[10])
        {
            Caption = 'Código Recurso Máquina';
            DataClassification = ToBeClassified;
            TableRelation = "Resource" WHERE("Type" = CONST("Machine"));
        }
        field(50028; "Starting Date Filter_LDR"; Date)
        {
            Caption = 'Filtro Fecha Inicio';
            FieldClass = FlowFilter;
        }
        field(50029; "Ending Date Filter_LDR"; Date)
        {
            Caption = 'Filtro Fecha Fin';
            FieldClass = FlowFilter;
        }
        field(50030; "Service Item Type_LDR"; Option)
        {
            Caption = 'Tipo Producto Servicio';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Grúa,Plataforma';
            OptionMembers = Crane,Platform;
        }
        field(50031; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50032; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
        field(50034; "Displacement Vehicle_LDR"; Boolean)
        {
            Caption = 'Vehículo para Desplazamiento';
            DataClassification = ToBeClassified;
        }
        field(50035; "Exported to Mobility_LDR"; Boolean)
        {
            CalcFormula = Lookup("Exp. to Mobility Relation_LDR"."Exported to Mobility" WHERE("Table Id" = CONST(5940), "Code" = FIELD("No.")));
            Caption = 'Exportado a Movilidad';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50036; "Branch Customer No._LDR"; Code[20])
        {
            Caption = 'Nº Cliente Sede Trabajo';
            DataClassification = ToBeClassified;
            TableRelation = "Customer";
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                ServMgtSetup: Record "Service Mgt. Setup";
                ServLogMgt: Codeunit "ServLogManagement";
            begin
                ServMgtSetup.Get();
                if ("Owner Customer No._LDR" <> '') and (Own_LDR = true) then begin
                    TestField("Owner Customer No._LDR", ServMgtSetup."No. Internal Customer_LDR");
                end;

                if xRec."Owner Customer No._LDR" <> Rec."Owner Customer No._LDR" then begin
                    //ServLogMgt.ServItemOwnerChange(Rec, xRec);
                end;
            end;
        }
        field(50037; "Branch Customer Name_LDR"; Text[50])
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Branch Customer No._LDR")));
            Caption = 'Nombre Cliente Sede Trabajo';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50038; RAEM4_LDR; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Has Active Operations_LDR"; Boolean)
        {
            CalcFormula = Exist("Serv. Item Operations_LDR" WHERE("Serv. Item Code" = FIELD("No."), "Status" = CONST("active")));
            Caption = 'Has Active Operations';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50050; Subcontracted_LDR; Boolean)
        {
            CalcFormula = Lookup("Service Item Pres. Group_LDR"."Subcontracted" WHERE("Code" = FIELD("Presentation Group Code_LDR")));
            Caption = 'Subcontratado';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50051; "Note 1_LDR"; Text[250])
        {
            Caption = 'Nota 1';
            DataClassification = ToBeClassified;
            Description = 'Nota 1';
        }
        field(50052; "Note 2_LDR"; Text[250])
        {
            Caption = 'Nota 2';
            DataClassification = ToBeClassified;
            Description = 'Nota 2';
        }
        field(50053; "Note 3_LDR"; Text[250])
        {
            Caption = 'Nota 3';
            DataClassification = ToBeClassified;
            Description = 'Nota 3';
        }
        field(50054; "Manufacturer Code_LDR"; Code[10])
        {
            Caption = 'Código Fabricante';
            DataClassification = ToBeClassified;
            Description = 'Código Fabricante';
            TableRelation = "Manufacturer";
        }
        field(50055; "Service Template_LDR"; Code[20])
        {
            Caption = 'Plantilla Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica la Plantilla de Mantenimiento';
            //TableRelation = Table70002; 
        }
        field(50056; "Machine Created_LDR"; Boolean)
        {
            Caption = 'Máquina en Parque Creada';
            DataClassification = ToBeClassified;
            Description = 'Máquina en Parque Creada';
        }
        field(50057; "Out Of Service_LDR"; Boolean)
        {
            Caption = 'Fuera de Servicio';
            DataClassification = ToBeClassified;
            Description = 'Indica si ya no se da Servicio sobre la Máquina';
        }
        field(50058; "Branch No._LDR"; Code[20])
        {
            Caption = 'Nº Sucursal';
            DataClassification = ToBeClassified;
            Description = 'Nº Sucursal';
            TableRelation = Branch_LDR;
        }
        field(50059; Location_LDR; Code[20])
        {
            CalcFormula = Lookup("Item Ledger Entry"."Location Code" WHERE("Item No." = FIELD("Item No."),
            "Serial No." = FIELD("Serial No."), "Open" = CONST(true)));
            Caption = 'Ubicación';
            Description = 'Ubicación';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50060; Own_LDR; Boolean)
        {
            Caption = 'Es Propia';
            DataClassification = ToBeClassified;
            Description = 'Es Propia';

            trigger OnValidate()
            var
                txtHayContrato: TextConst ENU = 'Service Item No. %1 is linked to Contract %2 type %2. Do you want to continue?', ESP = 'El Producto de servicio No. %1 está asociado al Contrato No. %2 de tipo %3.¿Está seguro de querer continuar?';
                recLineasContrato: Record "Service Contract Line";
                recContrato: Record "Service Contract Header";
                txtFinalidad: TextConst ENU = 'Service Item No. %1 purpose is %2. Do you want to continue?', ESP = 'El Producto de servicio No. %1 tiene una finalidad de tipo %2.¿Está seguro de querer continuar?';
                ServLogMgt: Codeunit "ServLogManagement";
            begin
                if (xRec.Own_LDR = true) and (Rec.Own_LDR = false) then begin

                    Clear(recLineasContrato);
                    recLineasContrato.SetRange(recLineasContrato."Service Item No.", "No.");
                    recLineasContrato.SetFilter(recLineasContrato."Starting Date", '<=%1', WorkDate);
                    recLineasContrato.SetFilter(recLineasContrato."Contract Expiration Date", '>=%1', WorkDate);
                    if recLineasContrato.Find('-') then begin
                        recContrato.Get(recLineasContrato."Contract Type", recLineasContrato."Contract No.");
                        if not Confirm(txtHayContrato, false, "No.", recContrato."Contract No.", recContrato."Contract Group Code") then
                            Error('');
                    end;
                end;

                //if Own_LDR <> xRec.Own_LDR then
                //ServLogMgt.ServItemOwnChange(Rec, xRec);
            end;
        }
        field(50061; "Global Dimension 1 Code_LDR"; Code[20])
        {
            Caption = 'Código Dimensión Global 1';
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            Description = 'Código Dimensión Global 1';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code_LDR");
            end;
        }
        field(50062; "Global Dimension 2 Code_LDR"; Code[20])
        {
            Caption = 'Código Dimensión Global 2';
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            Description = 'Código Dimensión Global 2';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code_LDR");
            end;
        }
        field(50063; "Customer Name_LDR"; Text[50])
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Nombre Cliente';
            Description = 'Nombre Cliente';
            FieldClass = FlowField;
        }
        field(50064; "Machine Type Dimension_LDR"; Code[20])
        {
            Caption = 'Dimensión Tipo Máquina';
            CaptionClass = 'CaptionMachineTypeDimension';
            DataClassification = ToBeClassified;
            Description = 'Dimensión Tipo Máquina';

            trigger OnValidate()
            begin
                ValidateMachineTypeDimension("Machine Type Dimension_LDR");
            end;

            trigger OnLookup()
            begin
                LookupMachineTypeDimension("Machine Type Dimension_LDR");
            end;
        }
        field(50065; "Owner Customer No._LDR"; Code[20])
        {
            Caption = 'Nº Cliente Propietario';
            DataClassification = ToBeClassified;
            TableRelation = "Customer";
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                ServMgtSetup: Record "Service Mgt. Setup";
                ServLogMgt: Codeunit "ServLogManagement";
            begin
                ServMgtSetup.Get();

                if ("Owner Customer No._LDR" <> '') and (Own_LDR = true) then begin
                    TestField("Owner Customer No._LDR", ServMgtSetup."No. Internal Customer_LDR");
                end;

                if xRec."Owner Customer No._LDR" <> Rec."Owner Customer No._LDR" then begin
                    //ServLogMgt.ServItemOwnerChange(Rec, xRec);
                end;
            end;
        }
        field(50066; "Without Counters_LDR"; Boolean)
        {
            Caption = 'Sin Contadores';
            DataClassification = ToBeClassified;
        }
        field(50067; "Owner Customer Name_LDR"; Text[50])
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Owner Customer No._LDR")));
            Caption = 'Dimensión Tipo Máquina';
            Description = 'Dimensión Tipo Máquina';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50068; "Planner No_LDR"; Code[20])
        {
            Caption = 'Nº Planificador';
            DataClassification = ToBeClassified;
        }
        field(50069; IsTruck_LDR; Boolean)
        {
            CalcFormula = Exist("Service Item Type_LDR" WHERE("Code" = FIELD("Service Item Type Code_LDR"), "Features Type" = FILTER("Crane" | "Truck")));
            FieldClass = FlowField;
        }
        field(50070; "Extranet Deletion_LDR"; Boolean)
        {
            Caption = 'Eliminar de Ingestrel';
            DataClassification = ToBeClassified;
        }
        field(50071; "LDR_No. of Active Contracts_LDR"; Integer)
        {
            CalcFormula = Count("Service Contract Line" Where("Service Item No." = field("No."), "Contract Type" = const(Contract), "Contract Status" = filter(<> Cancelled)));
            Caption = 'LDR Nº de activos de contrato';
            FieldClass = FlowField;
        }
        modify("Ship-to Code")
        {
            trigger OnBeforeValidate()
            var
                ServLogMgt: Codeunit "ServLogManagement";
            begin
                if "Ship-to Code" <> xRec."Ship-to Code" then begin
                    ServLogMgt.ServItemShipToCodeChange(Rec, xRec);
                    xRec."Ship-to Code" := Rec."Ship-to Code";
                    xRec.Modify(false);
                end;
            end;
        }
    }

    keys
    {
        key(Key7; "Description")
        {

        }
        key(Key8; "Invoicing Group Code_LDR")
        {

        }
        key(Key9; "Planner No_LDR")
        {

        }
    }

    fieldgroups
    {
        addlast(DropDown; "Search Description")
        { }
    }

    var
        TextElimina: TextConst ENU = 'Item No. %1 has no inventory for Serial No. %2', ESP = 'No hay existencias para el producto %1 con el No. de serie %2';
        SourceCodeSetup: Record "Source Code Setup";
        Text50003: TextConst ENU = 'Inlet', ESP = 'Entrada';
        Text50004: TextConst ENU = 'Output', ESP = 'Salida';
        Text50005: TextConst ENU = 'Pass to stock', ESP = 'Paso a exist.';
        //webMgtSetup: Record 70085;
        Companies: Record "Company";


    trigger OnAfterInsert()
    var
        ServiceItemFeatures: Record "Service Item Features_LDR";
    begin
        Clear(ServiceItemFeatures);
        if not ServiceItemFeatures.Get("No.") then begin
            ServiceItemFeatures.Init();
            ServiceItemFeatures."Service Item No." := "No.";
            ServiceItemFeatures.Insert();
        end;

        "Created Date_LDR" := CurrentDateTime;
        "Modified Date_LDR" := CurrentDateTime;
    end;

    trigger OnBeforeModify()
    begin
        if (Rec."Invoicing Group Code_LDR" <> xRec."Invoicing Group Code_LDR") or (Rec."Manufacturer Code_LDR" <> xRec."Manufacturer Code_LDR") or (Rec."Model Code_LDR" <> xRec."Model Code_LDR") or
                 (Rec."Installation Date" <> xRec."Installation Date") or (Rec."Serial No." <> xRec."Serial No.") then
            "Last Export Date_LDR" := 0D;

        "Modified Date_LDR" := CurrentDateTime;
    end;

    trigger OnAfterDelete()
    var
        ServiceItemCounter: Record "Service Item Counter_LDR";
        TowingAllocation: Record "Trailer Allocation_LDR";
        ServiceItemFeatures: Record "Service Item Features_LDR";
        ServItemOperations: Record "Serv. Item Operations_LDR";
        ServItemOperationsEntry: Record "Serv. Item Operat Entry_LDR";
        ServItemSinister: Record "Serv. Item Sinister_LDR";
        ServCommentLine: Record "Service Comment Line";
        DimMgt: Codeunit "DimensionManagement";
    begin
        if Companies.FindSet() then begin
            repeat
                ServCommentLine.ChangeCompany(Companies.Name);
            until Companies.Next() = 0;
        end;

        //DimMgt.DeleteDefaultDimMultiCompany(Database::"Service Item", "No.");

        Clear(ServiceItemCounter);
        ServiceItemCounter.SetRange(Code, "No.");
        ServiceItemCounter.DeleteAll(true);

        Clear(TowingAllocation);
        TowingAllocation.SetRange("Service Item No.", "No.");
        TowingAllocation.DeleteAll(true);

        Clear(ServiceItemFeatures);
        ServiceItemFeatures.SetRange("Service Item No.", "No.");
        ServiceItemFeatures.DeleteAll(true);

        Clear(ServItemOperations);
        ServItemOperations.SetRange("Serv. Item Code", "No.");
        ServItemOperations.DeleteAll(true);

        Clear(ServItemOperationsEntry);
        ServItemOperationsEntry.SetRange("Serv. Item Code", "No.");
        ServItemOperationsEntry.DeleteAll(true);

        Clear(ServItemSinister);
        ServItemSinister.SetRange("Cod. Service Item", "No.");
        ServItemSinister.DeleteAll(true);
    end;

    trigger OnAfterRename()
    var
        DefaultDim: Record "Default Dimension";
        DefaultDim2: Record "Default Dimension";
        ServContractLine: Record "Service Contract Line";
        ContractChangeLog: Record "Contract Change Log";
    begin
        if Companies.FindSet() then begin
            repeat
                ServContractLine.ChangeCompany(Companies.Name);
            //ContractChangeLog.LogContractChangeCompany(
            //xRec."No.", Rec."No.", "No.", 0, Companies.Name);
            until Companies.Next() = 0;
        end;

        if Companies.FindSet() then begin
            repeat
                DefaultDim.ChangeCompany(Companies.Name);
                DefaultDim.SetRange("Table ID", Database::"Service Item");
                DefaultDim.SetRange(DefaultDim."No.", xRec."No.");
                if DefaultDim.Find('-') then
                    repeat
                        DefaultDim2.ChangeCompany(Companies.Name);
                        DefaultDim2 := DefaultDim;
                        DefaultDim2."No." := "No.";
                        if DefaultDim2.Insert() then;
                    until DefaultDim.Next() = 0;
                DefaultDim.DeleteAll();
            until Companies.Next() = 0;
        end;
    end;

    procedure RecuperarCaracteristicas();
    var
        ServItemComp: Record "Service Item Component";
        ServItem: Record "Service Item";
        Item: Record "Item";
        AFCreated: Boolean;
    begin
        TestField("No.");

        if "Item No." <> '' then begin
            Item.Get("Item No.");
            if Item."Manufacturer Code" <> '' then
                Validate("Manufacturer Code_LDR", Item."Manufacturer Code");
        end;

        Modify(true);
    end;

    procedure CrearAF();
    var
        txtFinalidad: TextConst ENU = 'It is not posible to create an A/F for a Service Item with purpose %1.', ESP = 'No se puede crear un Activo Fijo para un producto cuya finalidad es %1.';
        AF: Record "Fixed Asset";
        txtHayAF: TextConst ENU = 'It exist an A/F for Service Item. A/F No. %1', ESP = 'Ya existe un Activo Fijo para el producto de servicio. No. Activo Fijo %1';
        txtFin: TextConst ENU = 'A/F No. %1 has been generated\Item has been moved from location %2 to %3', ESP = 'Se ha generado el Activo Fijo No. %1\Se ha movido el producto del almacén %2 al almacén %3';
        GLSETUP: Record "General Ledger Setup";
        ItemJnlLine: Record "Item Journal Line";
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        ServMgtSetup: Record "Service Mgt. Setup";
        ItemJnlPostLine: Codeunit "Item Jnl. Line-Reserve";
        ItemJnlPost: Codeunit "Item Jnl.-Post";
        //ServiceItemManag: Codeunit 70025;
        txtRevisar: TextConst ENU = 'Be sure to review value entry for this service item.Check the time interval between the last and final value Inventories Fixed assets and make the appropriate action in the fixed assets.', ESP = 'Recuerde revisar los movimientos de valor de este producto de servicio. Compruebe el intervalo de tiempo transcurrido entre el último valor Existencias y último valor Inmovilizado y realice las acciones oportunas en el activo fijo.';
        AFCREATED: Boolean;
        txtCreado: TextConst ENU = 'A/F created from %1', ESP = 'Creado A/F de %1';
    begin
        TestField("Serial No.");
        TestField("Machine Created_LDR", true);
        AFCREATED := false;

        ServMgtSetup.Get();
        ServMgtSetup.TestField(ServMgtSetup."In Location_LDR");
        ServMgtSetup.TestField(ServMgtSetup."A/F Location_LDR");

        SourceCodeSetup.Get();
        SourceCodeSetup.TestField(SourceCodeSetup."Item Journal");
        ServMgtSetup.TestField(ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ServMgtSetup.TestField(ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");

        Clear(AF);
        AF.SetRange(AF."Service Item No._LDR", Rec."No.");
        if not AF.Find('-') then begin

            GLSETUP.Get();
            GLSETUP.TestField(GLSETUP."Leasing Nos._LDR");

            AF.Init();
            if not AF.AssistEdit(AF)
              then
                Error('');
            AF.Insert(true);
            AF.Validate(AF."Service Item No._LDR", "No.");
            AF.Validate(Description, Description);
            AF.Validate("Serial No.", "Serial No.");
            AF.Modify(true);
            AFCREATED := true;
        end;

        ItemJnlLine.Init();
        ItemJnlLine.Validate("Source Code", SourceCodeSetup."Item Journal");
        ItemJnlLine.Validate("Journal Template Name", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ItemJnlLine.Validate("Journal Batch Name", ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");
        ItemJnlLine.Validate("Posting Date", WorkDate);
        ItemJnlLine."Line No." := 0;
        ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.");
        ItemJnlLine.Validate("Document No.", "No.");
        ItemJnlLine.Validate("Item No.", "Item No.");
        ItemJnlLine.Validate("Variant Code", "Variant Code");
        ItemJnlLine.Validate("Location Code", ServMgtSetup."In Location_LDR");
        ItemJnlLine.Validate(Quantity, 1);
        ItemJnlLine.Correction := false;
        ItemJnlLine.Validate(Description, StrSubstNo(txtCreado, "No."));
        ItemJnlLine.Insert(true);

        Clear(ReservEntry);
        Clear(ReservEntry2);

        if ReservEntry2.Find('+') then;

        ReservEntry.Validate("Entry No.", ReservEntry2."Entry No." + 1);
        ReservEntry.Validate("Lot No.", '');
        ReservEntry.Validate("Serial No.", "Serial No.");
        ReservEntry.Validate(Positive, false);
        ReservEntry.Validate("Item No.", "Item No.");
        ReservEntry.Validate("Variant Code", "Variant Code");
        ReservEntry.Validate("Location Code", ServMgtSetup."In Location_LDR");
        ReservEntry.Validate("Reservation Status", ReservEntry."Reservation Status"::Prospect);
        ReservEntry.Validate("Creation Date", WorkDate);
        ReservEntry.Validate("Source Type", 83);
        ReservEntry.Validate("Source Subtype", 3);
        ReservEntry.Validate("Source ID", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ReservEntry.Validate("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ReservEntry.Validate("Source Ref. No.", ItemJnlLine."Line No.");
        ReservEntry."Expected Receipt Date" := WorkDate;
        ReservEntry."Created By" := UserId;
        ReservEntry.Validate("Planning Flexibility", ReservEntry."Planning Flexibility"::Unlimited);
        ReservEntry.Validate("Quantity (Base)", -1);
        ReservEntry.Validate(ReservEntry."Qty. to Handle (Base)", -1);
        ReservEntry.Validate(ReservEntry."Qty. to Invoice (Base)", -1);
        ReservEntry.Insert(true);

        ItemJnlLine.Init();
        ItemJnlLine.Validate("Source Code", SourceCodeSetup."Item Journal");
        ItemJnlLine.Validate("Journal Template Name", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ItemJnlLine.Validate("Journal Batch Name", ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");
        ItemJnlLine.Validate("Posting Date", WorkDate);
        ItemJnlLine."Line No." := 10;
        ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
        ItemJnlLine.Validate("Document No.", "No.");
        ItemJnlLine.Validate("Item No.", "Item No.");
        ItemJnlLine.Validate("Variant Code", "Variant Code");
        ItemJnlLine.Validate("Location Code", ServMgtSetup."A/F Location_LDR");
        ItemJnlLine.Validate(Quantity, 1);
        ItemJnlLine.Correction := false;
        ItemJnlLine.Validate(Description, StrSubstNo(txtCreado, "No."));
        ItemJnlLine.Insert(true);

        Clear(ReservEntry);
        Clear(ReservEntry2);

        if ReservEntry2.Find('+') then;

        ReservEntry.Validate("Entry No.", ReservEntry2."Entry No." + 1);
        ReservEntry.Validate("Lot No.", '');
        ReservEntry.Validate("Serial No.", "Serial No.");
        ReservEntry.Validate(Positive, true);
        ReservEntry.Validate("Item No.", "Item No.");
        ReservEntry.Validate("Variant Code", "Variant Code");
        ReservEntry.Validate("Location Code", ServMgtSetup."A/F Location_LDR");
        ReservEntry.Validate("Reservation Status", ReservEntry."Reservation Status"::Prospect);
        ReservEntry.Validate("Creation Date", WorkDate);
        ReservEntry.Validate("Source Type", 83);
        ReservEntry.Validate("Source Subtype", 2);
        ReservEntry.Validate("Source ID", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ReservEntry.Validate("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ReservEntry.Validate("Source Ref. No.", ItemJnlLine."Line No.");
        ReservEntry."Expected Receipt Date" := WorkDate;
        ReservEntry."Created By" := UserId;
        ReservEntry.Validate("Planning Flexibility", ReservEntry."Planning Flexibility"::Unlimited);
        ReservEntry.Validate("Quantity (Base)", 1);
        ReservEntry.Validate(ReservEntry."Qty. to Handle (Base)", 1);
        ReservEntry.Validate(ReservEntry."Qty. to Invoice (Base)", 1);
        ReservEntry.Insert(true);

        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ItemJnlLine.SetFilter(ItemJnlLine."Journal Batch Name", ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");
        ItemJnlLine.SetFilter(ItemJnlLine."Line No.", '%1|%2', 0, 10);
        //ItemJnlPost.HideDialog(true);
        ItemJnlPost.Run(ItemJnlLine);

        Modify();

        //ServiceItemManag.PostAFEntry(Rec);

        if AFCREATED then
            Message(txtFin, AF."No.", ServMgtSetup."In Location_LDR", ServMgtSetup."A/F Location_LDR")
        else
            Message(txtRevisar);
    end;

    procedure CrearMaquinaParque(PurchRcptNo: Code[20]; PurchRcptLineNo: Integer);
    var
        ItemJnlLine: Record "Item Journal Line";
        ServMgtSetup: Record "Service Mgt. Setup";
        ServItemComp: Record "Service Item Component";
        CosteTotal: Decimal;
        SourceCodeSetup: Record "Source Code Setup";
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        txtFin: TextConst ENU = 'Machine has been entered on location %1.', ESP = 'Se ha dado entrada a la máquina en el almacén %1';
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        ItemJnlPost: Codeunit "Item Jnl.-Post";
        DefaultDim: Record "Default Dimension";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ServiceItem: Record "Service Item";
    begin
        ServMgtSetup.Get();
        ServMgtSetup.TestField(ServMgtSetup."In Location_LDR");

        SourceCodeSetup.Get();
        SourceCodeSetup.TestField(SourceCodeSetup."Item Journal");
        ServMgtSetup.TestField(ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ServMgtSetup.TestField(ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");

        TestField("Machine Created_LDR", false);
        TestField("Serial No.");

        ItemJnlLine.Init();
        ItemJnlLine.Validate("Source Code", SourceCodeSetup."Item Journal");
        ItemJnlLine.Validate("Journal Template Name", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ItemJnlLine.Validate("Journal Batch Name", ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");
        ItemJnlLine.Validate("Posting Date", WorkDate);
        ItemJnlLine."Line No." := 0;
        ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
        ItemJnlLine.Validate("Document No.", parseCode(Text50003, "No."));
        ItemJnlLine.Validate("Item No.", "Item No.");
        ItemJnlLine.Validate("Variant Code", "Variant Code");
        ItemJnlLine.Validate("Location Code", ServMgtSetup."In Location_LDR");
        ItemJnlLine.Validate(Quantity, 1);
        ItemJnlLine.Correction := false;
        ItemJnlLine.Insert(true);

        if (PurchRcptNo <> '') and PurchRcptLine.Get(PurchRcptNo, PurchRcptLineNo) then begin
            ItemJnlLine."Shortcut Dimension 1 Code" := PurchRcptLine."Shortcut Dimension 1 Code";
            ItemJnlLine."Shortcut Dimension 2 Code" := PurchRcptLine."Shortcut Dimension 2 Code";
            ItemJnlLine."Dimension Set ID" := PurchRcptLine."Dimension Set ID";
        end else begin
            if ServiceItem.Get("No.") then begin
                ItemJnlLine.Validate("Shortcut Dimension 1 Code", ServiceItem."Global Dimension 1 Code_LDR");
                ItemJnlLine.Validate("Shortcut Dimension 2 Code", ServiceItem."Global Dimension 2 Code_LDR");
            end;
        end;

        ItemJnlLine.Modify(true);

        Clear(ReservEntry);
        Clear(ReservEntry2);

        if ReservEntry2.Find('+') then;

        ReservEntry.Validate("Entry No.", ReservEntry2."Entry No." + 1);
        ReservEntry.Validate("Lot No.", '');
        ReservEntry.Validate("Serial No.", "Serial No.");
        ReservEntry.Validate(Positive, true);
        ReservEntry.Validate("Item No.", "Item No.");
        ReservEntry.Validate("Variant Code", "Variant Code");
        ReservEntry.Validate("Location Code", ServMgtSetup."In Location_LDR");
        ReservEntry.Validate("Reservation Status", ReservEntry."Reservation Status"::Prospect);
        ReservEntry.Validate("Creation Date", WorkDate);
        ReservEntry.Validate("Source Type", 83);
        ReservEntry.Validate("Source Subtype", 2);
        ReservEntry.Validate("Source ID", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ReservEntry.Validate("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ReservEntry.Validate("Source Ref. No.", ItemJnlLine."Line No.");
        ReservEntry."Expected Receipt Date" := WorkDate;
        ReservEntry."Created By" := UserId;
        ReservEntry.Validate("Planning Flexibility", ReservEntry."Planning Flexibility"::Unlimited);
        ReservEntry.Validate("Quantity (Base)", 1);
        ReservEntry.Validate(ReservEntry."Qty. to Handle (Base)", 1);
        ReservEntry.Validate(ReservEntry."Qty. to Invoice (Base)", 1);
        ReservEntry.Insert(true);
        ItemJnlLine.SetRecFilter();
        //ItemJnlPost.HideDialog(true);
        ItemJnlPost.Run(ItemJnlLine);

        "Machine Created_LDR" := true;

        Modify();
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        DimMgt: Codeunit "DimensionManagement";
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(Database:"Service Item", "No.", FieldNumber, ShortcutDimCode);
        Modify();
    end;

    procedure EliminarMaquinaParque();
    var
        ItemJnlLine: Record "Item Journal Line";
        ServMgtSetup: Record "Service Mgt. Setup";
        ServItemComp: Record "Service Item Component";
        CosteTotal: Decimal;
        SourceCodeSetup: Record "Source Code Setup";
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        txtFin: TextConst ENU = 'Machine has been entered on location %1.', ESP = 'Se ha dado entrada a la máquina en el almacén %1';
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        ItemJnlPost: Codeunit "Item Jnl.-Post";
        Movprod: Record "Item Ledger Entry";
        DefaultDim: Record "Default Dimension";
        ServiceItem: Record "Service Item";
    begin
        ServMgtSetup.Get();
        ServMgtSetup.TestField(ServMgtSetup."In Location_LDR");

        SourceCodeSetup.Get();
        SourceCodeSetup.TestField(SourceCodeSetup."Item Journal");
        ServMgtSetup.TestField(ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ServMgtSetup.TestField(ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");

        TestField("Machine Created_LDR", true);
        TestField("Serial No.");

        Clear(Movprod);
        Movprod.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date",
                              "Expiration Date", "Lot No.", "Serial No.");
        Movprod.SetRange(Movprod."Item No.", "Item No.");
        Movprod.SetRange(Movprod.Open, true);
        Movprod.SetRange(Movprod."Serial No.", "Serial No.");
        if not Movprod.FindFirst() then
            Error(
                 TextElimina,
                   "Item No.",
                   "Serial No.");

        ItemJnlLine.Init();
        ItemJnlLine.Validate("Source Code", SourceCodeSetup."Item Journal");
        ItemJnlLine.Validate("Journal Template Name", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ItemJnlLine.Validate("Journal Batch Name", ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");
        ItemJnlLine.Validate("Posting Date", WorkDate);
        ItemJnlLine."Line No." := 0;
        ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.");
        ItemJnlLine.Validate("Document No.", parseCode(Text50004, "No."));
        ItemJnlLine.Validate("Item No.", "Item No.");
        ItemJnlLine.Validate("Variant Code", "Variant Code");
        ItemJnlLine.Validate("Location Code", Movprod."Location Code");
        ItemJnlLine.Validate(Quantity, 1);
        ItemJnlLine.Correction := false;
        ItemJnlLine.Insert(true);

        if ServiceItem.Get("No.") then begin
            ItemJnlLine.Validate("Shortcut Dimension 1 Code", ServiceItem."Global Dimension 1 Code_LDR");
            ItemJnlLine.Validate("Shortcut Dimension 2 Code", ServiceItem."Global Dimension 2 Code_LDR");
        end;

        ItemJnlLine.Modify(true);

        Clear(ReservEntry);
        Clear(ReservEntry2);

        if ReservEntry2.Find('+') then;

        ReservEntry.Validate("Entry No.", ReservEntry2."Entry No." + 1);
        ReservEntry.Validate("Lot No.", '');
        ReservEntry.Validate("Serial No.", "Serial No.");
        ReservEntry.Validate(Positive, false);
        ReservEntry.Validate("Item No.", "Item No.");
        ReservEntry.Validate("Variant Code", "Variant Code");
        ReservEntry.Validate("Location Code", Movprod."Location Code");
        ReservEntry.Validate("Reservation Status", ReservEntry."Reservation Status"::Prospect);
        ReservEntry.Validate("Creation Date", WorkDate);
        ReservEntry.Validate("Source Type", 83);
        ReservEntry.Validate("Source Subtype", 3);
        ReservEntry.Validate("Source ID", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ReservEntry.Validate("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ReservEntry.Validate("Source Ref. No.", ItemJnlLine."Line No.");
        ReservEntry."Expected Receipt Date" := WorkDate;
        ReservEntry."Created By" := UserId;
        ReservEntry.Validate("Planning Flexibility", ReservEntry."Planning Flexibility"::Unlimited);
        ReservEntry.Validate("Quantity (Base)", -1);
        ReservEntry.Validate(ReservEntry."Qty. to Handle (Base)", -1);
        ReservEntry.Validate(ReservEntry."Qty. to Invoice (Base)", -1);
        ReservEntry.Insert(true);
        ItemJnlLine.SetRecFilter();
        //ItemJnlPost.HideDialog(true);
        ItemJnlPost.Run(ItemJnlLine);

        "Machine Created_LDR" := false;

        Modify();
    end;

    procedure GetActualContract(Fecha: Date) ContratoActivo: Code[20];
    var
        Planning: Record "Service Contract Planning_LDR";
        ServContract: Record "Service Contract Header";
        ServContractLine: Record "Service Contract Line";
    begin
        ContratoActivo := '';
        Clear(Planning);
        Planning.SetRange(Planning."Source Table", Database::"Service Contract Line");
        Planning.SetRange(Planning."Service Item No.", "No.");
        Planning.SetRange(Planning.Date, Fecha);
        Planning.SetRange(Planning."Contract Type", Planning."Contract Type"::Contract);
        if Planning.Find('-') then begin
            repeat
                ServContract.Get(Planning."Contract Type", Planning."Contract No.");
                if ServContract.Status <> ServContract.Status::Cancelled then
                    exit(Planning."Contract No.");
            until Planning.Next() = 0;
        end;

        Clear(ServContractLine);
        ServContractLine.SetCurrentKey("Service Item No.", "Contract Status");
        ServContractLine.SetRange(ServContractLine."Service Item No.", "No.");
        ServContractLine.SetFilter(ServContractLine."Starting Date", '<=%1', Fecha);
        ServContractLine.SetFilter(ServContractLine."Contract Expiration Date", '>=%1', Fecha);
        if ServContractLine.FindSet() then begin
            repeat
                ServContract.Get(ServContractLine."Contract Type", ServContractLine."Contract No.");
                if ServContract.Status = ServContract.Status::Signed then
                    exit(ServContractLine."Contract No.");

            until ServContractLine.Next() = 0;
        end;

        exit('');
    end;

    procedure GetActualInternalContract(Fecha: Date) ContratoActivo: Code[20];
    var
        Planning: Record "Service Contract Planning_LDR";
    //IntServContract: Record 70028;
    //IntServContractLine: Record 70029;
    begin
        ContratoActivo := '';
        Clear(Planning);
        //Planning.SetRange(Planning."Source Table", Database::Table70029);
        Planning.SetRange(Planning."Service Item No.", "No.");
        Planning.SetRange(Planning.Date, Fecha);
        Planning.SetRange(Planning."Contract Type", Planning."Contract Type"::Contract);
        if Planning.Find('-') then begin
            exit(Planning."Contract No.");
        end;

        // Clear(IntServContractLine);
        // IntServContractLine.SetRange(IntServContractLine."Service Item No.", "No.");
        // IntServContractLine.SetFilter(IntServContractLine."Starting Date", '<=%1', Fecha);
        // IntServContractLine.SetFilter(IntServContractLine."Expiration Date", '>=%1', Fecha);
        // if IntServContractLine.FindSet() then begin
        //     repeat
        //         IntServContract.Get(IntServContractLine."Contract Type", IntServContractLine."Contract No.");
        //         exit(IntServContractLine."Contract No.");

        //     until IntServContractLine.Next() = 0;
        // end;

        exit('');
    end;

    procedure PassToStock();
    var
        txtFinalidadPass: TextConst ENU = 'It can not pass a Fixed Asset to Stock if the finality is %1', ESP = 'No se puede pasar un Activo Fijo a Existencias para un producto cuya finalidad es %1.';
        AF: Record "Fixed Asset";
        txtHayAF: TextConst ENU = 'It exist an A/F for Service Item. A/F No. %1', ESP = 'Ya existe un Activo Fijo para el producto de servicio. No. Activo Fijo %1';
        txtFin: TextConst ENU = 'Item has been moved from Location %2 to Location %3', ESP = 'Se ha movido el producto del almacén %2 al almacén %3.';
        GLSETUP: Record "General Ledger Setup";
        ItemJnlLine: Record "Item Journal Line";
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        ServMgtSetup: Record "Service Mgt. Setup";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        ItemJnlPost: Codeunit "Item Jnl.-Post";
    //ServiceItemManag : Codeunit 70025;
    begin
        TestField("Serial No.");
        TestField("Machine Created_LDR", true);
        TestField(Own_LDR);

        ServMgtSetup.Get();
        ServMgtSetup.TestField(ServMgtSetup."In Location_LDR");
        ServMgtSetup.TestField(ServMgtSetup."A/F Location_LDR");

        SourceCodeSetup.Get();
        SourceCodeSetup.TestField(SourceCodeSetup."Item Journal");
        ServMgtSetup.TestField(ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ServMgtSetup.TestField(ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");

        ItemJnlLine.Init();
        ItemJnlLine.Validate("Source Code", SourceCodeSetup."Item Journal");
        ItemJnlLine.Validate("Journal Template Name", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ItemJnlLine.Validate("Journal Batch Name", ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");
        ItemJnlLine.Validate("Posting Date", WorkDate);
        ItemJnlLine."Line No." := 0;
        ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.");
        ItemJnlLine.Validate("Document No.", parseCode(Text50005, "No."));
        ItemJnlLine.Validate("Item No.", "Item No.");
        ItemJnlLine.Validate("Variant Code", "Variant Code");
        ItemJnlLine.Validate("Location Code", ServMgtSetup."A/F Location_LDR");
        ItemJnlLine.Validate(Quantity, 1);
        ItemJnlLine.Correction := false;
        ItemJnlLine.Insert(true);

        Clear(ReservEntry);
        Clear(ReservEntry2);

        if ReservEntry2.Find('+') then;

        ReservEntry.Validate("Entry No.", ReservEntry2."Entry No." + 1);
        ReservEntry.Validate("Lot No.", '');
        ReservEntry.Validate("Serial No.", "Serial No.");
        ReservEntry.Validate(Positive, false);
        ReservEntry.Validate("Item No.", "Item No.");
        ReservEntry.Validate("Variant Code", "Variant Code");
        ReservEntry.Validate("Location Code", ServMgtSetup."A/F Location_LDR");
        ReservEntry.Validate("Reservation Status", ReservEntry."Reservation Status"::Prospect);
        ReservEntry.Validate("Creation Date", WorkDate);
        ReservEntry.Validate("Source Type", 83);
        ReservEntry.Validate("Source Subtype", 3);
        ReservEntry.Validate("Source ID", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ReservEntry.Validate("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ReservEntry.Validate("Source Ref. No.", ItemJnlLine."Line No.");
        ReservEntry."Expected Receipt Date" := WorkDate;
        ReservEntry."Created By" := UserId;
        ReservEntry.Validate("Planning Flexibility", ReservEntry."Planning Flexibility"::Unlimited);
        ReservEntry.Validate("Quantity (Base)", -1);
        ReservEntry.Validate(ReservEntry."Qty. to Handle (Base)", -1);
        ReservEntry.Validate(ReservEntry."Qty. to Invoice (Base)", -1);
        ReservEntry.Insert(true);

        ItemJnlLine.Init();
        ItemJnlLine.Validate("Source Code", SourceCodeSetup."Item Journal");
        ItemJnlLine.Validate("Journal Template Name", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ItemJnlLine.Validate("Journal Batch Name", ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");
        ItemJnlLine.Validate("Posting Date", WorkDate);
        ItemJnlLine."Line No." := 10;
        ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
        ItemJnlLine.Validate("Document No.", parseCode(Text50005, "No."));
        ItemJnlLine.Validate("Item No.", "Item No.");
        ItemJnlLine.Validate("Variant Code", "Variant Code");
        ItemJnlLine.Validate("Location Code", ServMgtSetup."In Location_LDR");
        ItemJnlLine.Validate(Quantity, 1);
        ItemJnlLine.Correction := false;
        ItemJnlLine.Insert(true);

        Clear(ReservEntry);
        Clear(ReservEntry2);

        if ReservEntry2.Find('+') then;

        ReservEntry.Validate("Entry No.", ReservEntry2."Entry No." + 1);
        ReservEntry.Validate("Lot No.", '');
        ReservEntry.Validate("Serial No.", "Serial No.");
        ReservEntry.Validate(Positive, true);
        ReservEntry.Validate("Item No.", "Item No.");
        ReservEntry.Validate("Variant Code", "Variant Code");
        ReservEntry.Validate("Location Code", ServMgtSetup."In Location_LDR");
        ReservEntry.Validate("Reservation Status", ReservEntry."Reservation Status"::Prospect);
        ReservEntry.Validate("Creation Date", WorkDate);
        ReservEntry.Validate("Source Type", 83);
        ReservEntry.Validate("Source Subtype", 2);
        ReservEntry.Validate("Source ID", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ReservEntry.Validate("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ReservEntry.Validate("Source Ref. No.", ItemJnlLine."Line No.");
        ReservEntry."Expected Receipt Date" := WorkDate;
        ReservEntry."Created By" := UserId;
        ReservEntry.Validate("Planning Flexibility", ReservEntry."Planning Flexibility"::Unlimited);
        ReservEntry.Validate("Quantity (Base)", 1);
        ReservEntry.Validate(ReservEntry."Qty. to Handle (Base)", 1);
        ReservEntry.Validate(ReservEntry."Qty. to Invoice (Base)", 1);
        ReservEntry.Insert(true);

        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ItemJnlLine.SetFilter(ItemJnlLine."Journal Batch Name", ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");
        ItemJnlLine.SetFilter(ItemJnlLine."Line No.", '%1|%2', 0, 10);
        //ItemJnlPost.HideDialog(true);
        ItemJnlPost.Run(ItemJnlLine);

        Modify();

        //ServiceItemManag.PostPassToStock(Rec);

        Message(txtFin, ServMgtSetup."In Location_LDR", ServMgtSetup."A/F Location_LDR");
    end;

    procedure GetTotalAmount(): Decimal;
    var
    //ServItemValue : Record 70030;
    begin
        // ServItemValue.SetCurrentKey("Service Item no.", "Serial No.");
        // ServItemValue.SetRange(ServItemValue."Service Item no.", "No.");
        // ServItemValue.SetRange(ServItemValue."Serial No.", "Serial No.");
        // ServItemValue.CalcSums(ServItemValue.Amount);
        // exit(ServItemValue.Amount);
    end;

    procedure ActualizarMaquinaParque();
    var
        ItemJnlLine: Record "Item Journal Line";
        ServMgtSetup: Record "Service Mgt. Setup";
        ServItemComp: Record "Service Item Component";
        CosteTotal: Decimal;
        SourceCodeSetup: Record "Source Code Setup";
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        txtFin: TextConst ENU = 'Machine has been entered on location %1.', ESP = 'Se ha dado entrada a la máquina en el almacén %1';
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        ItemJnlPost: Codeunit "Item Jnl.-Post";
        DefaultDim: Record "Default Dimension";
        txtErrorStock: TextConst ENU = 'Service Item %1 is in Location', ESP = 'El producto de Servicio %1 ya está en Stock';
    begin
        ServMgtSetup.Get();
        ServMgtSetup.TestField(ServMgtSetup."In Location_LDR");
        ServMgtSetup.TestField(ServMgtSetup."No. Internal Customer_LDR");

        SourceCodeSetup.Get();
        SourceCodeSetup.TestField(SourceCodeSetup."Item Journal");
        ServMgtSetup.TestField(ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ServMgtSetup.TestField(ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");

        TestField("Machine Created_LDR", true);
        TestField(Own_LDR, true);
        TestField("Serial No.");
        TestField("Owner Customer No._LDR", ServMgtSetup."No. Internal Customer_LDR");

        if ChasisItemStock then
            Error(txtErrorStock, "No.");

        ItemJnlLine.Init();
        ItemJnlLine.Validate("Source Code", SourceCodeSetup."Item Journal");
        ItemJnlLine.Validate("Journal Template Name", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ItemJnlLine.Validate("Journal Batch Name", ServMgtSetup."Auto Adjust S. Item Jnl. Bach._LDR");
        ItemJnlLine.Validate("Posting Date", WorkDate);
        ItemJnlLine."Line No." := 0;
        ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
        ItemJnlLine.Validate("Document No.", parseCode(Text50003, "No."));
        ItemJnlLine.Validate("Item No.", "Item No.");
        ItemJnlLine.Validate("Variant Code", "Variant Code");
        ItemJnlLine.Validate("Location Code", ServMgtSetup."In Location_LDR");
        ItemJnlLine.Validate(Quantity, 1);
        ItemJnlLine.Correction := false;
        ItemJnlLine.Insert(true);

        ItemJnlLine.CreateDim(Database::"Service Item", "No.", 0, '', 0, '');

        ItemJnlLine.Modify(true);

        Clear(ReservEntry);
        Clear(ReservEntry2);

        if ReservEntry2.Find('+') then;

        ReservEntry.Validate("Entry No.", ReservEntry2."Entry No." + 1);
        ReservEntry.Validate("Lot No.", '');
        ReservEntry.Validate("Serial No.", "Serial No.");
        ReservEntry.Validate(Positive, true);
        ReservEntry.Validate("Item No.", "Item No.");
        ReservEntry.Validate("Variant Code", "Variant Code");
        ReservEntry.Validate("Location Code", ServMgtSetup."In Location_LDR");
        ReservEntry.Validate("Reservation Status", ReservEntry."Reservation Status"::Prospect);
        ReservEntry.Validate("Creation Date", WorkDate);
        ReservEntry.Validate("Source Type", 83);
        ReservEntry.Validate("Source Subtype", 2);
        ReservEntry.Validate("Source ID", ServMgtSetup."Auto Adjust S. Item Jnl. Tmpl._LDR");
        ReservEntry.Validate("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ReservEntry.Validate("Source Ref. No.", ItemJnlLine."Line No.");
        ReservEntry."Expected Receipt Date" := WorkDate;
        ReservEntry."Created By" := UserId;
        ReservEntry.Validate("Planning Flexibility", ReservEntry."Planning Flexibility"::Unlimited);
        ReservEntry.Validate("Quantity (Base)", 1);
        ReservEntry.Validate(ReservEntry."Qty. to Handle (Base)", 1);
        ReservEntry.Validate(ReservEntry."Qty. to Invoice (Base)", 1);
        ReservEntry.Insert(true);
        ItemJnlLine.SetRecFilter();
        //ItemJnlPost.HideDialog(true);
        ItemJnlPost.Run(ItemJnlLine);

        Modify();
    end;

    procedure ChasisItemStock() Stock: Boolean;
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        Clear(ItemLedgerEntry);
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Serial No.", "Serial No.");
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Item No.", "Item No.");
        ItemLedgerEntry.SetRange(ItemLedgerEntry.Open, true);
        if ItemLedgerEntry.FindFirst() then
            Stock := true
        else
            Stock := false;
    end;

    procedure ValidateMachineTypeDimension(var ShortcutDimCode: Code[20]);
    var
        DimMgt: Codeunit "DimensionManagement";
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        ServMgtSetup.Get();
        ServMgtSetup.TestField(ServMgtSetup."Machine Type Dimension_LDR");

        //DimMgt.ValidateDimAndValueCode(ServMgtSetup."Machine Type Dimension_LDR", ShortcutDimCode);
        //DimMgt.SaveDefaultDimCodeAndValue(Database::"Service Item", "No.", ServMgtSetup."Machine Type Dimension_LDR", ShortcutDimCode);

        Modify();
    end;

    procedure LookupMachineTypeDimension(var ShortcutDimCode: Code[20]);
    var
        DimMgt: Codeunit "DimensionManagement";
        ServMgtSetup: Record "Service Mgt. Setup";
        TempShortCutDimCode: Code[20];
    begin
        ServMgtSetup.Get();
        ServMgtSetup.TestField(ServMgtSetup."Machine Type Dimension_LDR");

        TempShortCutDimCode := ShortcutDimCode;
        //DimMgt.LookupDimValueAndCode(ServMgtSetup."Machine Type Dimension_LDR", ShortcutDimCode);
        if TempShortCutDimCode <> ShortcutDimCode then
            //DimMgt.SaveDefaultDimCodeAndValue(Database::"Service Item", "No.", ServMgtSetup."Machine Type Dimension_LDR", ShortcutDimCode);
        Modify();
    end;

    procedure CaptionMachineTypeDimension(): Text[80];
    var
        Dimension: Record "Dimension";
        ServMgtSetup: Record "Service Mgt. Setup";
    begin
        ServMgtSetup.Get();
        ServMgtSetup.TestField(ServMgtSetup."Machine Type Dimension_LDR");

        Dimension.Get(ServMgtSetup."Machine Type Dimension_LDR");
        exit(Dimension.Name);
    end;

    procedure UpdatePictures();
    begin
        //webMgtSetup.Get();
        //webMgtSetup.TestField(webMgtSetup."Default extension");
    end;

    procedure parseCode(text1: Text[30]; text2: Code[20]) string: Text[20];
    begin
        if StrLen(text1 + text2) > 20 then begin
            string := CopyStr(text1, 1, StrLen(text1) - (StrLen(text1 + text2) - 20) - 1) + ' ' + text2;
        end else begin
            string := text1 + text2;
        end;
    end;

    procedure GetActualVendorContract(Fecha: Date) ContratoActivo: Code[20];
    var
    //VendServContractLine : Record 70073;
    begin
        ContratoActivo := '';

        //   Clear(VendServContractLine);
        //   VendServContractLine.SetCurrentKey("Service Item No.");
        //   VendServContractLine.SetRange(VendServContractLine."Service Item No.","No.");
        //   VendServContractLine.SetFilter(VendServContractLine."Starting Date",'<=%1',Fecha);
        //   VendServContractLine.SetFilter(VendServContractLine."Expiration Date",'>=%1',Fecha);
        //   if VendServContractLine.FindFirst() then
        //     exit(VendServContractLine."Contract No.");

        //   exit('');
    end;

    procedure ServItemLinesExistCompany(Company: Text[80]): Boolean;
    var
        ServItemLine: Record "Service Item Line";
    begin
        ServItemLine.Reset();
        ServItemLine.ChangeCompany(Company);
        ServItemLine.SetCurrentKey("Service Item No.");
        ServItemLine.SetRange("Service Item No.", "No.");
        exit(ServItemLine.Find('-'));
    end;
}