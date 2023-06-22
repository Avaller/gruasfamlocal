/// <summary>
/// tableextension 50080 "Service Contract Template_LDR"
/// </summary>
tableextension 50080 "Service Contract Template_LDR" extends "Service Contract Template"
{
    fields
    {
        field(50000; "Day Invoicing_LDR"; Boolean)
        {
            Caption = 'Facturar por Precio Día';
            DataClassification = ToBeClassified;
            Description = 'Permite Especificar si se Factura por Precio Día';
        }
        field(50001; Lineal_LDR; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Permite Especificar si se Factura Linealmente en Fechas';
        }
        field(50002; "Responsibility Center_LDR"; Code[10])
        {
            Caption = 'Centro Responsabilidad';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(50003; "Invoice Series No._LDR"; Code[10])
        {
            Caption = 'Nº Serie Facturas';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

            trigger OnLookup()
            var
                ServiceContractHeader: Record "Service Contract Header";
                ServMgtSetup: Record "Service Mgt. Setup";
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit "NoSeriesManagement";
            begin
                ServMgtSetup.Get();
                ServMgtSetup.TestField(ServMgtSetup."Posted Service Invoice Nos.");
                if NoSeriesMgt.LookupSeries(ServMgtSetup."Posted Service Invoice Nos.", "Invoice Series No._LDR") then
                    Validate("Invoice Series No._LDR");

                //{
                SalesSetup.Get();
                SalesSetup.TestField(SalesSetup."Posted Invoice Nos.");
                if NoSeriesMgt.LookupSeries(SalesSetup."Posted Invoice Nos.", "Invoice Series No._LDR") then
                    Validate("Invoice Series No._LDR");
                //}                                           // END: ALQUINTA
            end;
        }
        field(50004; "LDR_Invoice Period_LDR"; Option)
        {
            Caption = 'Invoice Period';
            OptionCaption = 'Month,Two Months,Quarter,Half Year,Year,None,Third of a year';
            OptionMembers = Month,"Two Months",Quarter,"Half Year",Year,"None","Third of a year";
        }
    }
}