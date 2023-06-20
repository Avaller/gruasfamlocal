/// <summary>
/// tableextension 50018 "General Ledger Setup_LDR"
/// </summary>
tableextension 50018 "General Ledger Setup_LDR" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Leasing Nos._LDR"; Code[10])
        {
            Caption = 'Nº Serie Leasing';
            DataClassification = ToBeClassified;
            Description = 'Almacena el Nº de Serie de los Leasing';
            TableRelation = "No. Series";
        }
        field(50001; "Leasing Journal Template Name_LDR"; Code[20])
        {
            Caption = 'Nombre Libro Diario Leasing';
            DataClassification = ToBeClassified;
            Description = 'Nº Libro Diario Leasing';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50002; "Leasing Journal Name_LDR"; Code[20])
        {
            Caption = 'Nombre Sección Diario Leasing';
            DataClassification = ToBeClassified;
            Description = 'Nº Sección Diario Leasing';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Leasing Journal Template Name_LDR"));
        }
        field(50003; "Leasing Service Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Cuota Leasing';
            DataClassification = ToBeClassified;
            Description = 'Coste Servicio Leasing';
            TableRelation = "Service Cost";
        }
        field(50004; "Leasing Interest Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Intereses Leasing';
            DataClassification = ToBeClassified;
            Description = 'Coste Servicio Interes Leasing';
            TableRelation = "Service Cost";
        }
        field(50005; "Leasing Service Open Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Apertura Leasing';
            DataClassification = ToBeClassified;
            Description = 'Coste Servicio Apertura Leasing';
            TableRelation = "Service Cost";
        }
        field(50006; "Leasing Service Cancel Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Cancelación Leasing';
            DataClassification = ToBeClassified;
            Description = 'Coste Servicio Cancelación Leasing';
            TableRelation = "Service Cost";
        }
        field(50007; "Leasing Document No. Nos._LDR"; Code[10])
        {
            Caption = 'Nº Serie Documento Reg. Diario Leasing';
            DataClassification = ToBeClassified;
            Description = 'Almacena el Nº de Serie Registro de los Leasing';
            TableRelation = "No. Series";
        }
        field(50008; "Leasing Service Residual Cost_LDR"; Code[20])
        {
            Caption = 'Coste Servicio Cuota Residual Leasing';
            DataClassification = ToBeClassified;
            Description = 'Coste Servicio Cuota Residual Leasing';
            TableRelation = "Service Cost";
        }
        field(50009; "Leasing PreDocument No. Nos._LDR"; Code[10])
        {
            Caption = 'Nº Serie Documento Diario Leasing';
            DataClassification = ToBeClassified;
            Description = 'Almacena el Nº de serie de los Leasing';
            TableRelation = "No. Series";
        }
        field(50010; "Analytical Schedule Name_LDR"; Code[20])
        {
            Caption = 'Nombre Esquema Cuentas Analítica';
            DataClassification = ToBeClassified;
            TableRelation = "Acc. Schedule Name";
        }
        field(50011; "Analytical Excel Template_LDR"; Blob)
        {
            Caption = 'Plantilla Excel Analítica';
            DataClassification = ToBeClassified;
        }
        field(50012; "External Net Sales Acc. Filter_LDR"; Code[250])
        {
            Caption = 'Filtro Cuenta Facturación Neta Externa';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                GLAccList: Page "G/L Account List";
            begin
                GLAccList.LookupMode(true);
                if GLAccList.RunModal() = Action::LookupOK then
                    "External Net Sales Acc. Filter_LDR" := GLAccList.GetSelectionFilter;
            end;
        }
        field(50013; "Usage (Expenses) Acc. Filter_LDR"; Code[250])
        {
            Caption = 'Filtro Cuentas Consumos (Compras)';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                GLAccList: Page "G/L Account List";
            begin
                GLAccList.LookupMode(true);
                if GLAccList.RunModal() = Action::LookupOK then
                    "Usage (Expenses) Acc. Filter_LDR" := GLAccList.GetSelectionFilter;
            end;
        }
        field(50014; "Other Income Acc. Filter_LDR"; Code[250])
        {
            Caption = 'Filtro Cuenta Resto de Ingresos';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                GLAccList: Page "G/L Account List";
            begin
                GLAccList.LookupMode(true);
                if GLAccList.RunModal() = Action::LookupOK then
                    "Other Income Acc. Filter_LDR" := GLAccList.GetSelectionFilter;
            end;
        }
        field(50015; "Other Expenses Acc. Filter_LDR"; Code[250])
        {
            Caption = 'Filtro Cuenta Resto de Gastos';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                GLAccList: Page "G/L Account List";
            begin
                GLAccList.LookupMode(true);
                if GLAccList.RunModal() = Action::LookupOK then
                    "Other Expenses Acc. Filter_LDR" := GLAccList.GetSelectionFilter;
            end;
        }
    }
}