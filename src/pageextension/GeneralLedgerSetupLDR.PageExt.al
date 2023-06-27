pageextension 50031 "General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addafter("Max. Payment Tolerance Amount")
        {
            group(Leasing)
            {
                Caption = 'Leasing';
                field("Leasing Nos._LDR"; Rec."Leasing Nos._LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Núm. de arrendamiento';
                    ToolTip = 'Núm. de arrendamiento';
                }
                field("Leasing Journal Template Name_LDR"; Rec."Leasing Journal Template Name_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de la plantilla del diario de arrendamiento';
                    ToolTip = 'Nombre de la plantilla del diario de arrendamiento';
                }
                field("Leasing Journal Name_LDR"; Rec."Leasing Journal Name_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre del diario de arrendamiento';
                    ToolTip = 'Nombre del diario de arrendamiento';
                }
                field("Leasing Document No. Nos._LDR"; Rec."Leasing Document No. Nos._LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Documento de Arrendamiento No. Nos.';
                    ToolTip = 'Documento de Arrendamiento No. Nos.';
                }
                field("Leasing PreDocument No. Nos._LDR"; Rec."Leasing PreDocument No. Nos._LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Arrendamiento PreDocumento No. Nos.';
                    ToolTip = 'Arrendamiento PreDocumento No. Nos.';
                }
                field("Leasing Service Open Cost_LDR"; Rec."Leasing Service Open Cost_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Servicio de Arrendamiento Costo Abierto';
                    ToolTip = 'Servicio de Arrendamiento Costo Abierto';
                }
                field("Leasing Service Cost_LDR"; Rec."Leasing Service Cost_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Costo del servicio de arrendamiento';
                    ToolTip = 'Costo del servicio de arrendamiento';
                }
                field("Leasing Service Cancel Cost_LDR"; Rec."Leasing Service Cancel Cost_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Costo de cancelación del servicio de arrendamiento';
                    ToolTip = 'Costo de cancelación del servicio de arrendamiento';
                }
                field("Leasing Service Residual Cost_LDR"; Rec."Leasing Service Residual Cost_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Costo Residual del Servicio de Leasing';
                    ToolTip = 'Costo Residual del Servicio de Leasing';
                }
                field("Leasing Interest Cost_LDR"; Rec."Leasing Interest Cost_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Costo de interés de arrendamiento';
                    ToolTip = 'Costo de interés de arrendamiento';
                }
                group(Analytical)
                {
                    Caption = 'Analitica';
                    field("Analytical Schedule Name_LDR"; Rec."Analytical Schedule Name_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Nombre del programa analítico';
                        ToolTip = 'Nombre del programa analítico';
                    }
                    field("Analytical Excel Template_LDR"; Rec."Analytical Excel Template_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Plantilla Excel Analítica';
                        ToolTip = 'Plantilla Excel Analítica';
                        trigger OnAssistEdit()
                        var
                            TemplateExist: Boolean;
                            FileMgt: Codeunit "File Management";
                            TempBlob: Record 99008535; //TODO: TempBlop
                        begin
                            TemplateExist := Rec."Analytical Excel Template_LDR".HasValue;
                            IF FileMgt.BLOBImport(TempBlob, '*.xlsm') = '' THEN
                                EXIT;
                            Rec."Analytical Excel Template_LDR" := TempBlob.Blob;
                            IF TemplateExist THEN
                                IF NOT CONFIRM(TextExcel, FALSE) THEN
                                    EXIT;
                            CurrPage.SaveRecord();
                        end;
                    }
                    field("External Net Sales Acc. Filter_LDR"; Rec."External Net Sales Acc. Filter_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Cuenta de ventas netas externas Filtrar';
                        ToolTip = 'Cuenta de ventas netas externas Filtrar';
                    }
                    field("Usage (Expenses) Acc. Filter_LDR"; Rec."Usage (Expenses) Acc. Filter_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Uso (Gastos) Cta. Filtrar';
                        ToolTip = 'Uso (Gastos) Cta. Filtrar';
                    }
                    field("Other Income Acc. Filter_LDR"; Rec."Other Income Acc. Filter_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Otros Ingresos Cuenta Filtrar';
                        ToolTip = 'Otros Ingresos Cuenta Filtrar';
                    }
                    field("Other Expenses Acc. Filter_LDR"; Rec."Other Expenses Acc. Filter_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Cuenta Otros Gastos Filtrar';
                        ToolTip = 'Cuenta Otros Gastos Filtrar';
                    }
                }
            }
        }
    }

    actions
    {
        addafter("Change Payment &Tolerance")
        {
            action("<Export>")
            {
                ApplicationArea = All;
                Caption = 'Exportar';
                Promoted = true;
                PromotedIsBig = true;
                Image = Export;
                PromotedCategory = Process;

                trigger OnAction()
                    TempBlob: Record 99008535;
                    FileMgt: Codeunit 419;
                    begin
                        Rec.CALCFIELDS("Analytical Excel Template_LDR");
                        IF Rec."Analytical Excel Template_LDR".HASVALUE THEN BEGIN
                            TempBlob.Blob := Rec."Analytical Excel Template_LDR";
                            FileMgt.BLOBExport(TempBlob, '*.xlsm', FALSE);
                        END;
                    end;
            }
        }
    }

    var
        TextExcel: Label 'Confirma que desea reemplazar la Excel anterior?';
}