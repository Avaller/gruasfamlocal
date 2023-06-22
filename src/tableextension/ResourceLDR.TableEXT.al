/// <summary>
/// tableextension 50031 "Resource_LDR"
/// </summary>
tableextension 50031 "Resource_LDR" extends "Resource"
{
    fields
    {
        modify("Resource Group No.")
        {
            trigger OnAfterValidate()
            var
                ResGroup: Record 152;
            begin
                if rec."Resource Group No." <> '' then begin
                    ResGroup.Get("Resource Group No.");
                    "Base Calendar Code_LDR" := ResGroup."Base Calendar Code_LDR";
                end;
            end;
        }
        field(50001; "Journey Starting Time_LDR"; Time)
        {
            Caption = 'Hora Inicio Jornada';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Journey Ending Time_LDR"; Time)
        {
            Caption = 'Hora Fin Jornada';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Explotation Customer No._LDR"; Code[20])
        {
            Caption = 'Nº Cliente Explotación';
            DataClassification = ToBeClassified;
            TableRelation = "Customer";
        }
        field(50004; "Explotation Name_LDR"; Text[50]) //TODO: Revisar warning del field de la longitud Text
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Explotation Customer No._LDR")));
            Caption = 'Nombre';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Exported to Mobility_LDR"; Boolean)
        {
            CalcFormula = Lookup("Exp. to Mobility Relation_LDR"."Exported to Mobility" WHERE("Table Id" = CONST(156), "Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Company Dependence_LDR"; Code[20])
        {
            Caption = 'Empresa Pertenencia';
            DataClassification = ToBeClassified;
            TableRelation = "Company";
        }
        field(50007; "Mobility User_LDR"; Code[20])
        {
            Caption = 'Usuario Movilidad';
            DataClassification = ToBeClassified;
        }
        field(50008; "Mobility Password_LDR"; Text[40])
        {
            Caption = 'PassWord Movilidad';
            DataClassification = ToBeClassified;
        }
        field(50009; "Resource Disc. Group_LDR"; Code[10])
        {
            Caption = 'Grupo Departamento Recurso';
            DataClassification = ToBeClassified;
            TableRelation = "Resource";
        }
        field(50010; "Qty. on Serv. Order_LDR"; Decimal)
        {
            CalcFormula = Sum("Service Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST("Order"), "Type" = CONST("Resource"), "No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"),
            "Unit of Measure Code" = FIELD("Unit of Measure Filter")));
            Caption = 'Cantidad en Pedido servicio';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Created Date_LDR"; DateTime)
        {
            Caption = 'Fecha Creación';
            DataClassification = ToBeClassified;
        }
        field(50012; "Modified Date_LDR"; DateTime)
        {
            Caption = 'Fecha Modificación';
            DataClassification = ToBeClassified;
        }
        field(50013; "Base Calendar Code_LDR"; Code[10])
        {
            Caption = 'Código Calendario Base';
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar";
        }
    }
    trigger OnAfterInsert()
    begin
        "Created Date_LDR" := CurrentDateTime;
    end;

    trigger OnAfterModify()
    begin
        "Modified Date_LDR" := CurrentDateTime;
    end;
}