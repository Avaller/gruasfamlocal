/// <summary>
/// tableextension 50056 "Employee_LDR"
/// </summary>
tableextension 50056 "Employee_LDR" extends "Employee"
{
    fields
    {
        field(50000; "Tag Card No._LDR"; Code[10])
        {
            Caption = 'Nº Tarjeta Marcaje';
            DataClassification = ToBeClassified;
        }
        field(50001; "Ingestrel Export_LDR"; Boolean)
        {
            Caption = 'Exportar a Ingestrel';
            DataClassification = ToBeClassified;
        }
        field(50002; "VAT Registration No._LDR"; Code[20])
        {
            Caption = 'CIF/NIF';
            DataClassification = ToBeClassified;
        }
        field(50003; "Last Export Date_LDR"; Date)
        {
            Caption = 'Fecha Útima Exportación';
            DataClassification = ToBeClassified;
        }
        field(50004; "Journey Starting Time_LDR"; Time)
        {
            Caption = 'Hora Inicio Jornada';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Journey Ending Time_LDR"; Time)
        {
            Caption = 'Hora Fin Jornada';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Visa Card_LDR"; Code[20])
        {
            Caption = 'Tarjeta Visa';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(50007; "Creditor_LDR"; Code[20])
        {
            Caption = 'Acreedor';
            DataClassification = ToBeClassified;
            TableRelation = "Vendor"."No.";
        }
        field(50008; "Visa Expiration Year_LDR"; Integer)
        {
            Caption = 'Año Caducidad Tarjeta';
            DataClassification = ToBeClassified;
        }
        field(50009; "Visa Expiration Month_LDR"; Integer)
        {
            Caption = 'Mes Caducidad Tarjeta';
            DataClassification = ToBeClassified;
            MaxValue = 12;
            MinValue = 1;
        }
        field(50010; "Expenses Account_LDR"; Code[10])
        {
            Caption = 'Cuenta Liquidación de Gastos';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50011; "Avoid Expenses_LDR"; Boolean)
        {
            Caption = 'Nº Generar Gastos';
            DataClassification = ToBeClassified;
        }
        field(50012; "Company Dependence_LDR"; Code[20])
        {
            CalcFormula = Lookup("Resource"."Company Dependence_LDR" WHERE("No." = FIELD("Resource No.")));
            Caption = 'Empresa Pertenencia';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Company";
        }
        field(50013; "Extranet Deletion_LDR"; Boolean)
        {
            Caption = 'Eliminar de Ingestrel';
            DataClassification = ToBeClassified;
        }
        field(50014; "Total Accumulated Hours_LDR"; Decimal)
        {
            CalcFormula = Sum("Accumulated Employee Hours_LDR"."Remaining Hours" WHERE("Employee No." = FIELD("No.")));
            Caption = 'Horas Totales Acumuladas';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "Resource Group No._LDR"; Code[20])
        {
            CalcFormula = Lookup("Resource"."Resource Group No." WHERE("No." = FIELD("Resource No.")));
            Caption = 'Nº Familia Recurso';
            FieldClass = FlowField;
        }
    }

    trigger OnAfterModify()
    begin
        if (Rec."VAT Registration No._LDR" <> xRec."VAT Registration No._LDR") or (Rec."Employment Date" <> xRec."Employment Date") or (Rec.Name <> xRec.Name) or
            (Rec."First Family Name" <> xRec."First Family Name") or (Rec."Second Family Name" <> xRec."Second Family Name") or (Rec."Phone No." <> xRec."Phone No.") or
            (Rec."Mobile Phone No." <> xRec."Mobile Phone No.") or (Rec."Fax No." <> xRec."Fax No.") or (Rec."E-Mail" <> xRec."E-Mail") or
            (Rec."Job Title" <> xRec."Job Title") then
            "Last Export Date_LDR" := 0D;
    end;
}