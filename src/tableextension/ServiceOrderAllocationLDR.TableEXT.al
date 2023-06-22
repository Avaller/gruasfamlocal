/// <summary>
/// tableextension 50075 "Service Order Allocation_LDR"
/// </summary>
tableextension 50075 "Service Order Allocation_LDR" extends "Service Order Allocation"
{
    fields
    {
        field(50001; "Exported to Device_LDR"; Boolean)
        {
            Caption = 'Exportado a Dispositivo';
            DataClassification = ToBeClassified;
        }
        field(50002; "Resource Name_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text 
        {
            CalcFormula = Lookup("Resource"."Name" WHERE("No." = FIELD("Resource No.")));
            Caption = 'Nombre Recurso';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50003; Responsible_LDR; Boolean)
        {
            Caption = 'Responsable';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                txtResponsable: TextConst ENU = 'Almost one allocation must be responsible.', ESP = 'Al menos una asignación debe ser Responsable.';
            begin
                if (xRec.Responsible_LDR = false) and (Rec.Responsible_LDR = true) then begin
                    TestField(Status, Status::Active);
                    UpdateOtherResponsible(false);
                end else
                    if (xRec.Responsible_LDR = true) and (Rec.Responsible_LDR = false) then begin
                        Error(txtResponsable);
                    end;
            end;
        }
        field(50004; "Assignation Priority_LDR"; Integer)
        {
            Caption = 'Prioridad Asignación';
            DataClassification = ToBeClassified;
        }
        field(50005; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50006; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
        field(50007; "Order Date_LDR"; Date)
        {
            CalcFormula = Lookup("Service Header"."Order Date" WHERE("Document Type" = FIELD("Document Type"),
            "No." = FIELD("Document No.")));
            Caption = 'Fecha Pedido';
            FieldClass = FlowField;
        }
    }

    trigger OnAfterInsert()
    begin
        "Created Date_LDR" := CurrentDateTime;
    end;

    trigger OnAfterModify()
    var
        ServOrderAllocLog: Record "ServOrderAllocLog_LDR";
    begin
        "Modified Date_LDR" := CurrentDateTime;

        if (xRec.Status = xRec.Status::Active) and (xRec."Resource No." <> '') then begin
            if (xRec.Status <> Rec.Status) or (xRec."Resource No." <> Rec."Resource No.") then
                ServOrderAllocLog.CreateEntry(xRec."Document Type", xRec."Document No.", xRec."Service Item Line No.", xRec."Resource No.", xRec.Responsible_LDR);
        end;

        if xRec."Resource No." = '' then
            "Created Date_LDR" := CurrentDateTime;
    end;

    trigger OnAfterDelete()
    var
        ServOrderAllocLog: Record "ServOrderAllocLog_LDR";
        ServItemLine: Record "Service Item Line";
    begin
        if (Responsible_LDR) and (Status in [Status::Active, Status::"Reallocation Needed"]) then begin
            UpdateOtherResponsible(true);
        end;

        ServItemLine.Get("Document Type", "Document No.", "Service Item Line No.");
        if (Rec.Status = xRec.Status::Active) and (Rec."Resource No." <> '') and (ServItemLine."Sent to Device_LDR") then begin
            ServOrderAllocLog.CreateEntry(Rec."Document Type", Rec."Document No.", Rec."Service Item Line No.", Rec."Resource No.", Rec.Responsible_LDR);
        end;
    end;

    var
        HideDialog: Boolean;
        gAsignResource: Boolean;
        gAsignLocation: Boolean;

    procedure InitResponsible();
    var
        servOrderAlloc: Record "Service Order Allocation";
    begin
        Clear(servOrderAlloc);
        servOrderAlloc.SetCurrentKey("Document Type", "Document No.", "Service Item Line No.");
        servOrderAlloc.SetRange("Document Type", "Document Type");
        servOrderAlloc.SetRange(servOrderAlloc."Document No.", "Document No.");
        servOrderAlloc.SetRange(servOrderAlloc."Service Item Line No.", "Service Item Line No.");
        servOrderAlloc.SetFilter(servOrderAlloc."Entry No.", '<>%1', "Entry No.");
        servOrderAlloc.SetFilter(Status, '%1|%2', servOrderAlloc.Status::Active, servOrderAlloc.Status::"Reallocation Needed");
        servOrderAlloc.SetRange(Responsible_LDR, true);
        if not servOrderAlloc.Find('-') then begin
            Responsible_LDR := true;
        end;
    end;

    procedure UpdateOtherResponsible(Deleting: Boolean);
    var
        servOrderAlloc: Record "Service Order Allocation";
        ServOrderAllocLog: Record "ServOrderAllocLog_LDR";
    begin
        if not Deleting then begin
            Clear(servOrderAlloc);
            servOrderAlloc.SetCurrentKey("Document Type", "Document No.", "Service Item Line No.");
            servOrderAlloc.SetRange("Document Type", "Document Type");
            servOrderAlloc.SetRange(servOrderAlloc."Document No.", "Document No.");
            servOrderAlloc.SetRange(servOrderAlloc."Service Item Line No.", "Service Item Line No.");
            servOrderAlloc.SetFilter(servOrderAlloc."Entry No.", '<>%1', "Entry No.");
            if servOrderAlloc.Find('-') then begin
                repeat
                    servOrderAlloc.Responsible_LDR := false;
                    servOrderAlloc."Modified Date_LDR" := CurrentDateTime;
                    servOrderAlloc.Modify();

                    if (xRec.Status = xRec.Status::Active) and (xRec."Resource No." <> '') then begin
                        if (xRec.Status <> Rec.Status) or (xRec."Resource No." <> Rec."Resource No.") then
                            ServOrderAllocLog.CreateEntry(xRec."Document Type", xRec."Document No.", xRec."Service Item Line No.", xRec."Resource No.", xRec.Responsible_LDR);
                    end;

                    ServOrderAllocLog.CreateEntry(servOrderAlloc."Document Type", servOrderAlloc."Document No.", servOrderAlloc."Service Item Line No.", servOrderAlloc."Resource No.", servOrderAlloc.Responsible_LDR);
                until servOrderAlloc.Next() = 0;
            end;
        end else begin
            Clear(servOrderAlloc);
            servOrderAlloc.SetCurrentKey("Document Type", "Document No.", "Service Item Line No.");
            servOrderAlloc.SetRange("Document Type", "Document Type");
            servOrderAlloc.SetRange(servOrderAlloc."Document No.", "Document No.");
            servOrderAlloc.SetRange(servOrderAlloc."Service Item Line No.", "Service Item Line No.");
            servOrderAlloc.SetFilter(servOrderAlloc."Entry No.", '<>%1', "Entry No.");
            servOrderAlloc.SetFilter(Status, '%1|%2', servOrderAlloc.Status::Active, servOrderAlloc.Status::"Reallocation Needed");
            if servOrderAlloc.Find('-') then begin
                servOrderAlloc.Responsible_LDR := true;
                servOrderAlloc.Modify();
                ServOrderAllocLog.CreateEntry(servOrderAlloc."Document Type", servOrderAlloc."Document No.", servOrderAlloc."Service Item Line No.", servOrderAlloc."Resource No.", servOrderAlloc.Responsible_LDR);
            end;
        end;
    end;

    procedure getGeneralResHours(servHeaderNo: Code[20]) nHours: Decimal;
    var
        servLine: Record "Service Line";
        ServmgtSetup: Record "Service Mgt. Setup";
    begin
        Clear(servLine);

        ServmgtSetup.Get();
        ServmgtSetup.TestField("General Resource Mantenaince_LDR");

        servLine.SetCurrentKey("Document Type", "Document No.", "Service Item Line No.", Type, "No.");
        servLine.SetRange("Document Type", servLine."Document Type"::Order);
        servLine.SetRange("Document No.", servHeaderNo);
        servLine.SetRange(Type, servLine.Type::Resource);
        servLine.SetRange("No.", ServmgtSetup."General Resource Mantenaince_LDR");
        if servLine.FindSet() then begin
            repeat
                if servLine."Unit of Measure Code" = ServmgtSetup."Work Time Unit Of Measure_LDR" then
                    nHours += servLine.Quantity;
            until servLine.Next() = 0;
        end;

        exit(nHours);
    end;

    procedure setAllocatedResource(servHeaderNo: Code[20]; allocatedResNo: Code[20]);
    var
        txtResourceCode: TextConst ENU = 'Do you wish to assign the allocated Resource No. to planned lines?', ESP = '¿Desea asignar el No. de Recurso asignado a las líneas planificadas?';
        servLine: Record "Service Line";
        servLine2: Record "Service Line";
        ServmgtSetup: Record "Service Mgt. Setup";
        txtResourceLocation: TextConst ENU = 'The assigned resource has a default Location Code, Do you wish to assign this Location Code to planned lines?', ESP = 'El recurso asignado tiene un Cód Almacén por defecto, ¿Desea asignar este Cód Almacén a las líneas planificadas?';
        resource: Record "Resource";
        resLocation: Record "Resource Location";
    begin
        ServmgtSetup.Get();
        if ServmgtSetup."Hide proposal Res. Allocation_LDR" then
            exit;

        Clear(servLine);

        ServmgtSetup.Get();
        ServmgtSetup.TestField("General Resource Mantenaince_LDR");

        if HideDialog then begin
            if gAsignResource then begin
                servLine.SetCurrentKey("Document Type", "Document No.", "Service Item Line No.", Type, "No.");
                servLine.SetRange("Document Type", servLine."Document Type"::Order);
                servLine.SetRange("Document No.", servHeaderNo);
                servLine.SetRange(Type, servLine.Type::Resource);
                servLine.SetRange("No.", ServmgtSetup."General Resource Mantenaince_LDR");
                if servLine.FindSet() then begin
                    repeat
                        if servLine."Unit of Measure Code" = ServmgtSetup."Work Time Unit Of Measure_LDR" then begin
                            servLine2.Get(servLine."Document Type", servLine."Document No.", servLine."Line No.");
                            servLine2.Validate("No.", allocatedResNo);
                            servLine2.Modify(true);
                        end;
                    until servLine.Next() = 0;
                end;
            end;

        end else begin
            if Confirm(txtResourceCode) then begin
                servLine.SetCurrentKey("Document Type", "Document No.", "Service Item Line No.", Type, "No.");
                servLine.SetRange("Document Type", servLine."Document Type"::Order);
                servLine.SetRange("Document No.", servHeaderNo);
                servLine.SetRange(Type, servLine.Type::Resource);
                servLine.SetRange("No.", ServmgtSetup."General Resource Mantenaince_LDR");
                if servLine.FindSet() then begin
                    repeat
                        if servLine."Unit of Measure Code" = ServmgtSetup."Work Time Unit Of Measure_LDR" then begin
                            servLine2.Get(servLine."Document Type", servLine."Document No.", servLine."Line No.");
                            servLine2.Validate("No.", allocatedResNo);
                            servLine2.Modify(true);
                        end;
                    until servLine.Next() = 0;
                end;
            end;
        end;

        Clear(resLocation);
        resLocation.SetRange("Resource No.", allocatedResNo);
        resLocation.SetRange(resLocation.Main_LDR, true);
        if (resLocation.FindFirst()) then begin
            if HideDialog then begin
                if gAsignLocation then begin
                    Clear(servLine);
                    servLine.SetCurrentKey("Document Type", "Document No.", "Service Item Line No.", Type, "No.");
                    servLine.SetRange("Document Type", servLine."Document Type"::Order);
                    servLine.SetRange("Document No.", servHeaderNo);
                    servLine.SetRange(Type, servLine.Type::Item);
                    if servLine.FindSet() then begin
                        repeat
                            servLine.SetHideDialog(false);
                            servLine.Validate(servLine."Location Code", resLocation."Location Code");
                            servLine.Modify(true);
                        until servLine.Next() = 0;
                    end;
                end;
            end else begin
                if Confirm(txtResourceLocation) then begin
                    Clear(servLine);
                    servLine.SetCurrentKey("Document Type", "Document No.", "Service Item Line No.", Type, "No.");
                    servLine.SetRange("Document Type", servLine."Document Type"::Order);
                    servLine.SetRange("Document No.", servHeaderNo);
                    servLine.SetRange(Type, servLine.Type::Item);
                    if servLine.FindSet() then begin
                        repeat
                            servLine.SetHideDialog(false);
                            servLine.Validate(servLine."Location Code", resLocation."Location Code");
                            servLine.Modify(true);
                        until servLine.Next() = 0;
                    end;
                end;
            end;
        end;
    end;

    procedure SetMultipleParams(AsignResource: Boolean; AsignLocation: Boolean);
    begin
        gAsignResource := AsignResource;
        gAsignLocation := AsignLocation;
    end;
}