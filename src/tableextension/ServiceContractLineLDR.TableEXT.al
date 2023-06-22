/// <summary>
/// tableextension 50077 "Service Contract Line_LDR"
/// </summary>
tableextension 50077 "Service Contract Line_LDR" extends "Service Contract Line"
{
    fields
    {
        field(50000; "Dimension Set ID_LDR"; Integer)
        {
            Caption = 'ID Grupo Dimensiones';
            DataClassification = ToBeClassified;
            Description = 'UPG2016';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(50001; "Service Item Tariff No._LDR"; Code[20])
        {
            Caption = 'Código Tarifa Producto Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Rate Line - Platf"."Code" WHERE("Invoice Group No." = FIELD("Serv. Item Invoice Group Code")); //TODO: Revisar si conservamos la tabla

            trigger OnValidate()
            begin
                TestStatusOpen();

                if ("Serv. Item Invoice Group Code_LDR" <> '') and ("Service Item Tariff No._LDR" <> '') then
                    GetPlatformPrices();
            end;
        }
        field(50002; "Serv. Item Invoice Group Code_LDR"; Code[10])
        {
            Caption = 'Código Grupo Facturación Producto Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Invoice Group_LDR"."Code" WHERE("Group Type" = CONST("Platform"));

            trigger OnValidate()
            begin
                TestStatusOpen();
                if ("Serv. Item Invoice Group Code_LDR" <> '') and ("Service Item Tariff No._LDR" <> '') then
                    GetPlatformPrices();
            end;
        }
        field(50003; "Serv. Item Invoice Group Desc_LDR"; Text[50])
        {
            CalcFormula = Lookup("Service Item Invoice Group_LDR"."Description" WHERE("Code" = FIELD("Serv. Item Invoice Group Code_LDR")));
            Caption = 'Descripción Grupo Facturación Producto Servicio';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50004; "Deliver/Pickup Price_LDR"; Decimal)
        {
            Caption = 'Precio Entrega/Recogida';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50005; "Use Saturdays_LDR"; Boolean)
        {
            Caption = 'Utilizar Sábados';
            DataClassification = ToBeClassified;
        }
        field(50006; "Use Sundays_LDR"; Boolean)
        {
            Caption = 'Utilizar Domingos';
            DataClassification = ToBeClassified;
        }
        field(50007; "Service Quote no._LDR"; Code[20])
        {
            Caption = 'Código Oferta';
            DataClassification = ToBeClassified;
            TableRelation = "Crane Service Quote Header_LDR"."Quote no." WHERE("Platform Quote" = CONST(true));
        }
        field(50008; "Serv. Item Planner No_LDR"; Code[20])
        {
            CalcFormula = Lookup("Service Item"."Planner No_LDR" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Nº Planificador';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50009; "No of Days_LDR"; Integer)
        {
            CalcFormula = Count("Service Contract Planning_LDR" WHERE("Source Table" = CONST(5964), "Contract Type" = FIELD("Contract Type"), "Contract No." = FIELD("Contract No."), "Line No." = FIELD("Line No."), "Service Item No." = FIELD("Service Item No.")));
            Caption = 'Nº de días';
            Description = 'Campo Calculado con el Nº Días Planificados';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50010; "Month Amount_LDR"; Decimal)
        {
            Caption = 'Importe Mensual';
            DataClassification = ToBeClassified;
            Description = 'Permite Introducir un Importe Mensual a Facturar';

            trigger OnValidate()
            var
                ValorLinea: Decimal;
            begin
                Validate("Line Value", "Month Amount_LDR" * 12);
            end;
        }
        field(50011; "Day Amount_LDR"; Decimal)
        {
            Caption = 'Precio Venta Día';
            DataClassification = ToBeClassified;
            Description = 'Permite Introducir un Importe Diario a Facturar';

            trigger OnValidate()
            var
            begin

            end;
        }
        field(50012; "Day Unit Cost_LDR"; Decimal)
        {
            Caption = 'Coste Unitario Día';
            DataClassification = ToBeClassified;
            Description = 'Permite Introducir un Importe Coste Diario';
        }
        field(50013; "Exit No. of Hours_LDR"; Integer)
        {
            Caption = 'Nº Horas Salida';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas Salida';

            trigger OnValidate()
            var
                TempServContractLineHours: Record "Serv. Contract Line Hours_LDR";
            begin
                Clear(TempServContractLineHours);
                TempServContractLineHours.SetRange(TempServContractLineHours.Type, TempServContractLineHours.Type::External);
                TempServContractLineHours.SetRange(TempServContractLineHours."Contract Type", "Contract Type");
                TempServContractLineHours.SetRange(TempServContractLineHours."Contract No.", "Contract No.");
                TempServContractLineHours.SetRange(TempServContractLineHours."Contract Line No.", "Line No.");
                if TempServContractLineHours.FindFirst() then
                    Error(Text50004);

                Validate("Hired No. Of Hours_LDR");
            end;
        }
        field(50014; "Total No. of Hours_LDR"; Integer)
        {
            Caption = 'Nº Horas Totales';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas Totales';
        }
        field(50015; "Tires Change Hours_LDR"; Integer)
        {
            Caption = 'Horas Cambio Rueda';
            DataClassification = ToBeClassified;
            Description = 'Horas Cambio Rueda';
        }
        field(50016; "Shortcut Dimension 1 Code_LDR"; Code[20])
        {
            Caption = 'Código Dimensión Acceso Directo 1';
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            Description = 'Código Dimensión Acceso Directo 1';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code_LDR");
            end;
        }
        field(50017; "Shortcut Dimension 2 Code_LDR"; Code[20])
        {
            Caption = 'Código Dimensión Acceso Directo 2';
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            Description = 'Código Dimensión Acceso Directo 2';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code_LDR");
            end;
        }
        field(50018; "Revisions number contracted_LDR"; Integer)
        {
            Caption = 'Nº Revisiones Contratadas';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(50019; "Service Template No._LDR"; Code[20])
        {
            Caption = 'Nº Plantilla Servicios';
            DataClassification = ToBeClassified;
            //TableRelation = Table70002; //TODO: Revisar si conservamos la tabla

            trigger OnValidate()
            var
                HideDialog: Boolean;
            begin
                if not HideDialog then
                    MaintenanceMgt.TestOrdersExist(Database::"Service Contract Line", "Contract No.", "Line No.", xRec."Service Template No._LDR");

            end;
        }
        field(50020; "Hired No. Of Hours_LDR"; Integer)
        {
            Caption = 'Nº Horas Contratadas';
            DataClassification = ToBeClassified;
            Description = 'Nº Horas Contratadas';
            Editable = false;

            trigger OnValidate()
            begin
                "Hired No. Of Hours_LDR" := "Total No. of Hours_LDR" - "Exit No. of Hours_LDR"
            end;
        }
        field(50021; "Delivery Planified_LDR"; Boolean)
        {
            Caption = 'Entrega Planificada';
            DataClassification = ToBeClassified;
        }
        field(50022; "Collection Planified_LDR"; Boolean)
        {
            Caption = 'Recogida Planificada';
            DataClassification = ToBeClassified;
        }
        field(50023; "Delivery Realiced_LDR"; Boolean)
        {
            Caption = 'Entrega Realizada';
            DataClassification = ToBeClassified;
        }
        field(50024; "Collection Realiced_LDR"; Boolean)
        {
            Caption = 'Recogida Realizada';
            DataClassification = ToBeClassified;
        }
        field(50025; "Total No. of Hours Calc._LDR"; Decimal)
        {
            Caption = 'Nº Horas Totales';
            DataClassification = ToBeClassified;
            Description = 'Utilizado para Poder Meter Fórmulas al Calcular Nº de Horas Totales. Se Copia su Contenido en Nº Horas Totales.';
        }
        field(50026; "Service Price Group Code_LDR"; Code[10])
        {
            Caption = 'Código Grupo Precio Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Price Group";
        }
        field(50027; "Service Price Version No._LDR"; Code[20])
        {
            Caption = 'Nº Versión Grupo Precio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item Price_LDR"."Version No." WHERE("Service Price Group" = FIELD("Service Price Group Code_LDR"));
        }
        field(50028; Grouper_LDR; Text[20])
        {
            Caption = 'Agrupador';
            DataClassification = ToBeClassified;
        }
        field(50029; "Service item Model_LDR"; Text[50])
        {
            Caption = 'Modelo';
            DataClassification = ToBeClassified;
            Description = 'Modelo';
        }
        field(50030; "Charge Capacity_LDR"; Decimal)
        {
            Caption = 'Capacidad Carga (Kg)';
            DataClassification = ToBeClassified;
            Description = 'Indica la Capacidad de Carga de la Máquina en Kg';
        }
        field(50031; "Hours Period Review_LDR"; Option)
        {
            Caption = 'Revisión Horas Período';
            DataClassification = ToBeClassified;
            InitValue = "Year";
            OptionCaption = 'Mes,Dos Meses,Trimestre,Medio Año,Año,Ninguno';
            OptionMembers = "Month","Two Months","Quarter","Half Year","Year","None";
        }
        field(50032; "Contracted Hours_LDR"; Decimal)
        {
            CalcFormula = Sum("Serv. Contract Line Hours_LDR"."Contracted hours" WHERE("Type" = CONST(External), "Contract Type" = FIELD("Contract Type"), "Contract No." = FIELD("Contract No."), "Contract Line No." = FIELD("Line No.")));
            Caption = 'Nº Horas Contratadas';
            DecimalPlaces = 0 : 0;
            Description = 'Nº Horas Contratadas';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50033; "Calculate Maint. Type_LDR"; Option)
        {
            Caption = 'Tipo Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Tipo de Cálculo que se utilizará para Sacar las Horas/Día de una Máquina';
            NotBlank = true;
            OptionCaption = 'Según Configuración,Según Contrato,Por Período,Por Nº Pedidos';
            OptionMembers = "Según configuración","Según Contrato","Por Período","Por Nº Pedidos";
        }
        field(50034; "Calculate Maint. Type Period_LDR"; DateFormula)
        {
            Caption = 'Período Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Período que se utilizará para el Cálculo de Horas/Día de una Máquina por Período';
        }
        field(50035; "Calculate Maint. Type Order_LDR"; Integer)
        {
            Caption = 'Nº Pedidos Cálculo Mantenimiento';
            DataClassification = ToBeClassified;
            Description = 'Indica el Número de Pedidos que se utilizarán para el Cálculo de Horas/Día de una Máquina por Pedidos Servicio';
            MinValue = 0;
            NotBlank = true;
        }
        field(50036; Historical_LDR; Boolean)
        {
            Caption = 'Histórico';
            DataClassification = ToBeClassified;
        }
        field(50037; Replicate_LDR; Boolean)
        {
            Caption = 'Replicar';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50038; "Explotation Customer No._LDR"; Code[20])
        {
            Caption = 'Nº Cliente Explotación';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Customer"."No.";

            trigger OnValidate()
            var
                ServiceMgtSetup: Record "Service Mgt. Setup";
            begin
                ServiceMgtSetup.Get();
                if "Explotation Customer No._LDR" <> ServiceMgtSetup."No. Internal Customer_LDR" then begin
                    Validate(Replicate_LDR, true);
                end else begin
                    "Explotation Customer No._LDR" := '';
                    Validate(Replicate_LDR, false);
                end;
            end;
        }
    }

    trigger OnAfterInsert()
    var
        ServContractHeader: Record "Service Contract Header";
    begin
        if "Dimension Set ID_LDR" = 0 then
            "Dimension Set ID_LDR" := ServContractHeader."Dimension Set ID";
        "Shortcut Dimension 1 Code_LDR" := ServContractHeader."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code_LDR" := ServContractHeader."Shortcut Dimension 2 Code";
    end;

    trigger OnAfterModify()
    begin
        if xRec."Service Item No." = '' then
            SuspendStatusCheck(true)
        else
            SuspendStatusCheck(false);
    end;

    trigger OnAfterDelete()
    var
        ContractConcepts: Record "Contract Concepts_LDR";
        ContractLineHours: Record "Serv. Contract Line Hours_LDR";
    begin
        Clear(ContractConcepts);
        ContractConcepts.SetRange(ContractConcepts."Source Table", Database::"Service Contract Line");
        ContractConcepts.SetRange(ContractConcepts."Contract No.", "Contract No.");
        ContractConcepts.SetRange(ContractConcepts."Contract Type", "Contract Type");
        ContractConcepts.SetRange(ContractConcepts."Contract Line No.", "Line No.");
        ContractConcepts.SetRange(ContractConcepts.Invoiced, true);
        if ContractConcepts.FindFirst() then
            Error(txtConceptos)
        else begin
            Clear(ContractConcepts);
            ContractConcepts.SetRange(ContractConcepts."Source Table", Database::"Service Contract Line");
            ContractConcepts.SetRange(ContractConcepts."Contract No.", "Contract No.");
            ContractConcepts.SetRange(ContractConcepts."Contract Type", "Contract Type");
            ContractConcepts.SetRange(ContractConcepts."Contract Line No.", "Line No.");
            ContractConcepts.DeleteAll(true);
        end;

        Clear(ContractLineHours);
        ContractLineHours.SetRange(ContractLineHours.Type, ContractLineHours.Type::External);
        ContractLineHours.SetRange(ContractLineHours."Contract Type", "Contract Type");
        ContractLineHours.SetRange(ContractLineHours."Contract No.", "Contract No.");
        ContractLineHours.SetRange(ContractLineHours."Contract Line No.", "Line No.");
        ContractLineHours.DeleteAll(true);

        CalendarMgt.DeleteAllReservation("Contract Type", "Contract No.", "Line No.",
                           "Service Item No.", Database::"Service Contract Line", '');

        MaintenanceMgt.CheckDeleteContractLine("Contract Type", "Contract No.", "Line No.", "Service Item No.",
                             Database::"Service Contract Line");
    end;

    var
        CalendarMgt: Report "Service Contract Planning";
        MaintenanceMgt: Report "Maintenance Mgt";
        ServContractMgt: Codeunit "ServContractManagement";
        DimMGT: Codeunit "DimensionManagement";
        txtConceptos: TextConst ENU = 'You cannot delete the line because there are concepts invoiced', ESP = 'No puede eliminar la línea porque existen conceptos facturados';
        Text50004: TextConst ENU = 'It is not posible to modify "Exit No. of hours" because there are service contract line hours detail. Delete it to proceed.', ESP = 'No se puede modificar las horas de salida por que existe un detalle de horas. Elimine el detalle antes de realizar el cambio.';

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMGT.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID_LDR");
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]);
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        ServiceContractHeader: Record "Service Contract Header";
        ServContractLine: Record "Service Contract Line";
        InheritFromDimSetID: Integer;
        InheritFromTableNo: Integer;
    begin
        SourceCodeSetup.Get();
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        "Shortcut Dimension 1 Code_LDR" := '';
        "Shortcut Dimension 2 Code_LDR" := '';

        Clear(ServContractLine);
        ServContractLine.SetRange(ServContractLine."Contract Type", "Contract Type");
        ServContractLine.SetRange(ServContractLine."Contract No.", "Contract No.");
        ServContractLine.SetRange(ServContractLine."Service Item No.", "Service Item No.");
        ServContractLine.SetRange(ServContractLine."Item No.", "Item No.");
        if ServContractLine.Find('-') then begin
            InheritFromDimSetID := ServContractLine."Dimension Set ID_LDR";
            InheritFromTableNo := Database::"Service Contract Line";
        end else begin
            if ServiceContractHeader.Get("Contract Type", "Contract No.") then begin
                InheritFromDimSetID := ServiceContractHeader."Dimension Set ID";
                InheritFromTableNo := Database::"Service Contract Header";
            end;
        end;

        "Dimension Set ID_LDR" :=
          DimMGT.GetDefaultDimID(
            TableID, No, SourceCodeSetup."Service Contract Line_LDR",
            "Shortcut Dimension 1 Code_LDR", "Shortcut Dimension 2 Code_LDR", InheritFromDimSetID, InheritFromTableNo);
    end;

    procedure ShowDimensions();
    begin
        TestField("Contract No.");
        TestField("Line No.");
        "Dimension Set ID_LDR" :=
          DimMGT.EditDimensionSet(
            "Dimension Set ID_LDR", StrSubstNo('%1 %2 %3', "Contract Type", "Contract No.", "Line No."),
            "Shortcut Dimension 1 Code_LDR", "Shortcut Dimension 2 Code_LDR");
    end;

    procedure GetConceptPeriodAmount() valor: Decimal;
    var
        Conceptos: Record "Contract Concepts_LDR";
        FechaInicio: Date;
        FechaFin: Date;
        Contrato: Record "Service Contract Header";
        LineaContrato: Record "Service Contract Line";
    begin
        if "Contract No." <> '' then begin
            Contrato.Get("Contract Type", "Contract No.");

            if Contrato.Lineal_LDR then begin
                //ServContractMgt.GetNextLineLinealInvoicePeriod(Contrato, Rec, FechaInicio, FechaFin);
            end else begin
                //ServContractMgt.GetNextLineInvoicePeriod(Contrato, Rec, FechaInicio, FechaFin);
            end;
        end;

        if (FechaInicio <> 0D) and (FechaFin <> 0D) then begin
            Clear(Conceptos);
            Conceptos.SetCurrentKey("Source Table", "Contract No.", "Contract Type", "Contract Line No.", Periodicity, Date, Invoiced);
            Conceptos.SetRange(Conceptos."Source Table", Database::"Service Contract Line");
            Conceptos.SetRange(Conceptos."Contract No.", "Contract No.");
            Conceptos.SetRange(Conceptos."Contract Type", "Contract Type");
            Conceptos.SetRange(Conceptos."Contract Line No.", "Line No.");
            Conceptos.SetRange(Conceptos.Periodicity, Conceptos.Periodicity::"Date expecific");
            Conceptos.SetRange(Conceptos.Date, FechaInicio, FechaFin);
            Conceptos.SetRange(Conceptos.Invoiced, false);
            Conceptos.CalcSums(Conceptos.Amount);
            valor := Conceptos.Amount;

            Clear(Conceptos);
            Conceptos.SetCurrentKey("Source Table", "Contract No.", "Contract Type", "Contract Line No.", Periodicity, Date, Invoiced);
            Conceptos.SetRange(Conceptos."Source Table", Database::"Service Contract Line");
            Conceptos.SetRange(Conceptos."Contract No.", "Contract No.");
            Conceptos.SetRange(Conceptos."Contract Type", "Contract Type");
            Conceptos.SetRange(Conceptos."Contract Line No.", "Line No.");
            Conceptos.SetRange(Conceptos.Periodicity, Conceptos.Periodicity::"Service Contract");
            Conceptos.CalcSums(Conceptos.Amount);
            valor := valor + Conceptos.Amount;
        end;
    end;

    procedure GetServItemHoursUsage() HoursDay: Decimal;
    var
        Days: Integer;
        Hours: Integer;
        ServItemLine: Record "Service Item Line";
        PostedServItemLine: Record "Posted Service Item Line_LDR";
        ServHeader: Record "Service Header";
        ServMgtSetup: Record "Service Mgt. Setup";
        PostedServHeader: Record "Posted Service Header_LDR";
        //TempServItemMaintenance: Record 70057 temporary;
        StartDate: Date;
        txtPeriodError: TextConst ENU = 'You must specify a negative date formula in field %1.', ESP = 'Establezca una fórmula fecha negativa en el campo %1.', ITA = 'Impostare una formula negativa data nel campo %1.';
        FirstDate: Date;
        LastDate: Date;
        FirstHours: Integer;
        LastHours: Integer;
        Counter: Integer;
        CalculateMgtType: Option "Seg£n configuraci¢n","Seg£n Contrato","Por Per¡odo","Por N§ Pedidos";
        CalculateMgtPeriod: DateFormula;
        CalculateMgtNOrders: Integer;
    begin
        ServMgtSetup.Get();
        CalcFields("Contracted Hours_LDR");
        TestField("Contracted Hours_LDR");
        TestField("Starting Date");
        TestField("Contract Expiration Date");

        if "Calculate Maint. Type_LDR" = "Calculate Maint. Type_LDR"::"Según configuración" then begin
            ServMgtSetup.TestField("Calculate Maint. Type Period_LDR");
            ServMgtSetup.TestField("Calculate Maint. Type Order_LDR");
            CalculateMgtType := ServMgtSetup."Calculate Maint. Type Order_LDR";
            CalculateMgtPeriod := ServMgtSetup."Calculate Maint. Type Period_LDR";
            CalculateMgtNOrders := ServMgtSetup."Calculate Maint. Type Order_LDR";
        end else begin
            case "Calculate Maint. Type_LDR" of
                "Calculate Maint. Type_LDR"::"Por Período":
                    TestField("Calculate Maint. Type Period_LDR");
                "Calculate Maint. Type_LDR"::"Por Nº Pedidos":
                    TestField("Calculate Maint. Type Order_LDR");
            end;
            CalculateMgtType := "Calculate Maint. Type_LDR";
            CalculateMgtPeriod := "Calculate Maint. Type Period_LDR";
            CalculateMgtNOrders := "Calculate Maint. Type Order_LDR";
        end;

        case CalculateMgtType of
            CalculateMgtType::"Seg£n Contrato":
                begin
                    Days := "Contract Expiration Date" - "Starting Date" + 1;
                    Hours := "Contracted Hours_LDR";
                    if Days <> 0 then
                        HoursDay := Hours / Days;
                end;
            CalculateMgtType::"Por Per¡odo":
                begin
                    StartDate := CalcDate(CalculateMgtPeriod, WorkDate);

                    if StartDate >= WorkDate then
                        Error(txtPeriodError, CalculateMgtPeriod);

                    if not ServMgtSetup."Not Service Orders Active_LDR" then begin
                        Clear(ServItemLine);
                        ServItemLine.SetCurrentKey("Service Item No.");
                        ServItemLine.SetRange(ServItemLine."Service Item No.", "Service Item No.");
                        if ServItemLine.FindSet() then begin
                            repeat
                                ServHeader.Get(ServItemLine."Document Type", ServItemLine."Document No.");
                                if (ServHeader.Status = ServHeader.Status::Finished) and (ServHeader."Finishing Date" >= StartDate)
                                  and (ServHeader."Finishing Date" <= WORKDATE) then begin
                                    //InsertTempLinesMaintenance(TempServItemMaintenance, ServHeader."No.", ServHeader."Finishing Date",
                                    //ServItemLine."No of hours_LDR");
                                end;
                            until (ServItemLine.Next() = 0);
                        end;
                    end;

                    Clear(PostedServItemLine);
                    PostedServItemLine.SetCurrentKey("Service Item No.");
                    PostedServItemLine.SetRange(PostedServItemLine."Service Item No.", "Service Item No.");
                    // if PostedServItemLine.FindSet() then begin
                    //     repeat
                    //         PostedServHeader.Get(PostedServItemLine."No.");
                    //         if (PostedServHeader."Finishing Date" >= StartDate) and (PostedServHeader."Finishing Date" <= WorkDate) then
                    //InsertTempLinesMaintenance(TempServItemMaintenance, PostedServHeader."No.", PostedServHeader."Finishing Date",
                    //PostedServItemLine."No of hours");
                    //until PostedServItemLine.Next() = 0;
                    //end;

                    //if TempServItemMaintenance.FindFirst() then begin
                    //FirstDate := TempServItemMaintenance."Finish Date";
                    //FirstHours := TempServItemMaintenance."No. of Hours";
                    //end;

                    //if TempServItemMaintenance.FindLast() then begin
                    //LastDate := TempServItemMaintenance."Finish Date";
                    //LastHours := TempServItemMaintenance."No. of Hours";
                    //end;

                    // if (LastDate <> FirstDate) then
                    //     HoursDay := (LastHours - FirstHours) / (LastDate - FirstDate);
                end;

            CalculateMgtType::"Por N§ Pedidos":
                begin
                    if not ServMgtSetup."Not Service Orders Active_LDR" then begin
                        Clear(ServItemLine);
                        ServItemLine.SetCurrentKey("Service Item No.");
                        ServItemLine.SetRange(ServItemLine."Service Item No.", "Service Item No.");
                        if ServItemLine.FindSet() then begin
                            repeat
                                ServHeader.Get(ServItemLine."Document Type", ServItemLine."Document No.");
                                if ServHeader.Status = ServHeader.Status::Finished then begin
                                    //InsertTempLinesMaintenance(TempServItemMaintenance, ServHeader."No.", ServHeader."Finishing Date",
                                    //ServItemLine."No of hours_LDR");
                                end;
                            until ServItemLine.Next() = 0;
                        end;
                    end;

                    Clear(PostedServItemLine);
                    PostedServItemLine.SetCurrentKey("Service Item No.");
                    PostedServItemLine.SetRange(PostedServItemLine."Service Item No.", "Service Item No.");
                    if PostedServItemLine.FindSet() then begin
                        repeat
                            PostedServHeader.Get(PostedServItemLine."No.");
                        //InsertTempLinesMaintenance(TempServItemMaintenance, PostedServHeader."No.", PostedServHeader."Finishing Date",
                        //PostedServItemLine."No of hours");
                        until PostedServItemLine.Next() = 0;
                    end;

                    Counter := 1;

                    // TempServItemMaintenance.Ascending(false);
                    // if TempServItemMaintenance.Find('-') then begin
                    //     LastDate := TempServItemMaintenance."Finish Date";
                    //     LastHours := TempServItemMaintenance."No. of Hours";
                    //     repeat
                    //         Counter := Counter + 1;
                    //     until (TempServItemMaintenance.Next() = 0) or (Counter > CalculateMgtNOrders);
                    //     FirstDate := TempServItemMaintenance."Finish Date";
                    //     FirstHours := TempServItemMaintenance."No. of Hours";
                    // end;

                    if (LastDate <> FirstDate) then
                        HoursDay := (LastHours - FirstHours) / (LastDate - FirstDate);
                end;
        end;
    end;

    local procedure InsertTempLinesMaintenance(/*var TempContMaintHoursDay: Record 70057 temporary;*/ OrderNo: Code[20]; FinishDate: Date; Hours: Integer);
    begin
        // TempContMaintHoursDay.Init();
        // TempContMaintHoursDay."Source Table" := Database::"Service Contract Line";
        // TempContMaintHoursDay."Contract Type" := "Contract Type";
        // TempContMaintHoursDay."Contract No." := "Contract No.";
        // TempContMaintHoursDay."Contract Line No." := "Line No.";
        // TempContMaintHoursDay."Finish Date" := FinishDate;
        // TempContMaintHoursDay."Service Order No." := OrderNo;
        // TempContMaintHoursDay."Service Item No." := "Service Item No.";
        // TempContMaintHoursDay."No. of Hours" := Hours;
        // TempContMaintHoursDay.Insert();
    end;

    local procedure GetPlatformPrices();
    var
        ServiceItemRateLinePlatf: Record "Servic Item Rat Lin - Plat_LDR";
        PlatfServQInvGLine: Record "Platf. Serv. Q. Inv G Line_LDR";
    begin
        Clear(ServiceItemRateLinePlatf);
        if ServiceItemRateLinePlatf.Get("Service Item Tariff No._LDR", "Serv. Item Invoice Group Code_LDR") then begin
            Validate("Line Value", "Month Amount_LDR" * 12);
            "Day Amount_LDR" := ServiceItemRateLinePlatf."Day Cost";
            "Month Amount_LDR" := ServiceItemRateLinePlatf."Mouth Cost";

            Clear(PlatfServQInvGLine);
            PlatfServQInvGLine.SetRange("Quote No.", "Service Quote no._LDR");
            PlatfServQInvGLine.SetRange("Invoice Group No.", "Serv. Item Invoice Group Code_LDR");
            PlatfServQInvGLine.SetRange("Rate No.", "Service Item Tariff No._LDR");
            if PlatfServQInvGLine.FindFirst() then
                "Deliver/Pickup Price_LDR" := PlatfServQInvGLine."Deliver/Pickup Price";
        end;
    end;
}