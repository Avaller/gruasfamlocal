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
            //TableRelation = "Service Item Model"."Model Code" WHERE("Code" = FIELD("Manufacturer Code")); //TODO: Revisar si conservamos la tabla
        }
        field(50003; "Service Item Type Code_LDR"; Code[10])
        {
            Caption = 'Código Tipo Producto Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Type"; //TODO: Revisar si conservamos la tabla
        }
        field(50004; "Service Item Type Subtype_LDR"; Code[10])
        {
            Caption = 'Código SubTipo Producto Servicio';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Subtype"."Service Item Subtype Code" WHERE("Code" = FIELD("Service Item Type Code")); //TODO: Revisar si conservamos la tabla
        }
        field(50005; "Presentation Group Code_LDR"; Code[10])
        {
            Caption = 'Código Grupo Presentación';
            DataClassification = ToBeClassified;
            //TableRelation = "Service Item Pres. Group"; //TODO: Revisar si conservamos la tabla

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
            //TableRelation = "Service Item Invoice Group"; //TODO: Revisar si conservamos la tabla

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
            //TableRelation = "Cancellation Type Service Item"; //TODO: Revisar si conservamos la tabla
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
        field(50014; "Maintenance Block_LDR"; Boolean) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Exist("Serv. Item Availability Entry" WHERE("Service Item Code" = FIELD("No."), "Entry Type" = CONST("maintenance"), "Starting Date" = FIELD("Starting Date Filter"), "Ending Date" = FIELD("Ending Date Filter"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Bloqueado Mantenimiento';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50015; "Refueling Vehicle ID_LDR"; Code[10])
        {
            Caption = 'ID Vehículo Repostaje';
            DataClassification = ToBeClassified;
        }
        field(50016; "Export Ingestrel_LDR"; BoolEAN)
        {
            Caption = 'Exportar a Ingestrel';
            DataClassification = ToBeClassified;
        }
        field(50017; "Explotation Name_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text 
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
        field(50019; "Explotation Address_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text 
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
            //ExtendedDatatype = "Phone No."; //TODO: Revisar si conservamos el ExtendedDatatype
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
        field(50034; "Displacement Vehicle_LDR"; BoolEAN)
        {
            Caption = 'Vehículo para Desplazamiento';
            DataClassification = ToBeClassified;
        }
        field(50035; "Exported to Mobility_LDR"; BoolEAN) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Lookup("Exp. to Mobility Relation"."Exported to Mobility" WHERE("Table Id" = CONST(5940), "Code" = FIELD("No."))); //TODO: Revisar si conservamos el atributo CalcFormula
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
        field(50037; "Branch Customer Name_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Branch Customer No._LDR")));
            Caption = 'Nombre Cliente Sede Trabajo';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50038; RAEM4_LDR; Code[20]) //TODO: Revisar warning del field de la longitud Text
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Has Active Operations_LDR"; BoolEAN) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Exist("Serv. Item Operations" WHERE("Serv. Item Code" = FIELD("No."), "Status" = CONST("active"))); //TODO: Revisar si conservamos el atributo CalcFormula
            Caption = 'Has Active Operations';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50050; Subcontracted_LDR; BoolEAN) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Lookup("Service Item Pres. Group"."Subcontracted" WHERE("Code" = FIELD("Presentation Group Code"))); //TODO: Revisar si conservamos el atributo CalcFormula
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
            //TableRelation = Table70002; //TODO: Revisar si conservamos la tabla
        }
        field(50056; "Machine Created_LDR"; BoolEAN)
        {
            Caption = 'Máquina en Parque Creada';
            DataClassification = ToBeClassified;
            Description = 'Máquina en Parque Creada';
        }
        field(50057; "Out Of Service_LDR"; BoolEAN)
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
            //TableRelation = "Branch"; //TODO: Revisar si conservamos la tabla
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
        field(50060; Own_LDR; BoolEAN)
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
            begin
                // if (xRec.Own = TRUE)  (Rec.Own = FALSE) THEN BEGIN

                //     // CIC IALFONSO
                //     CLEAR(recLineasContrato);
                //     recLineasContrato.SETRANGE(recLineasContrato."Service Item No.", "No.");
                //     recLineasContrato.SETFILTER(recLineasContrato."Starting Date", '<=%1', WORKDATE);
                //     recLineasContrato.SETFILTER(recLineasContrato."Contract Expiration Date", '>=%1', WORKDATE);
                //     IF recLineasContrato.FIND('-') THEN BEGIN
                //         recContrato.GET(recLineasContrato."Contract Type", recLineasContrato."Contract No.");
                //         IF NOT CONFIRM(txtHayContrato, FALSE, "No.", recContrato."Contract No.", recContrato."Contract Group Code") THEN
                //             ERROR('');
                //     END;

                // END;

                //Generar una linea en el log de producto al modificar el campo
                // IF Own <> xRec.Own THEN
                //     ServLogMgt.ServItemOwnChange(Rec, xRec);
                // END: ALQUINTA
            end;
        }
        field(50061; "Global Dimension 1 Code_LDR"; Code[20])
        {
            Caption = 'Código Dimensión Global 1';
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            Description = 'Código Dimensión Global 1';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(50062; "Global Dimension 2 Code_LDR"; Code[20])
        {
            Caption = 'Código Dimensión Global 2';
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            Description = 'Código Dimensión Global 2';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));
        }
        field(50063; "Customer Name_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text 
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
        }
        field(50065; "Owner Customer No._LDR"; Code[20])
        {
            Caption = 'Nº Cliente Propietario';
            DataClassification = ToBeClassified;
            TableRelation = "Customer";
            ValidateTableRelation = true;
        }
        field(50066; "Without Counters_LDR"; BoolEAN)
        {
            Caption = 'Sin Contadores';
            DataClassification = ToBeClassified;
        }
        field(50067; "Owner Customer Name_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text
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
        field(50069; IsTruck_LDR; BoolEAN) //TODO: Revisar warning del atributo CalcFormula del field
        {
            //CalcFormula = Exist("Service Item Type" WHERE ("Code"=FIELD("Service Item Type Code"),"Features Type"=FILTER("Crane"|"Truck"))); //TODO: Revisar si conservamos el atributo CalcFormula
            FieldClass = FlowField;
        }
        field(50070; "Extranet Deletion_LDR"; BoolEAN)
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
                ServLogMgt: Codeunit ServLogManagement;
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
        // if Companies.FindSet() then begin
        //     repeat
        //         ServCommentLine.ChangeCompany(Companies.Name);
        //     until Companies.Next() = 0;
        // end;

        // DimMgt.DeleteDefaultDimMultiCompany(Database::"Service Item", "No.");

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
        // if Companies.FindSet() then begin
        //     repeat
        //         ServContractLine.ChangeCompany(Companies.Name);
        //         ContractChangeLog.LogContractChangeCompany(
        //             xRec."No.", Rec."No.", "No.", 0, Companies.Name);
        //     until Companies.Next() = 0;
        // end;

        // if Companies.FindSet() then begin
        //     repeat
        //         DefaultDim.ChangeCompany(Companies.Name);
        //         DefaultDim.SetRange("Table ID", Database::"Service Item");
        //         DefaultDim.SetRange(DefaultDim."No.", xRec."No.");
        //         if DefaultDim.Find('-') then
        //             repeat
        //                 DefaultDim2.ChangeCompany(Companies.Name);
        //                 DefaultDim2 := DefaultDim;
        //                 DefaultDim2."No." := "No.";
        //                 if DefaultDim2.Insert() then;
        //             until DefaultDim.Next() = 0;
        //         DefaultDim.DeleteAll();
        //     until Companies.Next() = 0;
        // end;
    end;

    /// <summary>
    ///  Multiempresa , comprueba si existe la maquina en algun pedido para la empresa parametro
    /// </summary>
    /// <param name="Company"></param>
    /// <returns></returns>
    procedure ServItemLinesExistCompany(Company: Text[80]): BoolEAN
    var
        ServItemLine: Record "Service Item Line";
    begin
        ServItemLine.Reset;
        ServItemLine.ChangeCompany(Company);
        ServItemLine.SetCurrentKey("Service Item No.");
        ServItemLine.SetRange("Service Item No.", "No.");
        exit(ServItemLine.FIND('-'));
    end;


}