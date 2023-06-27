pageextension 50007 "Vendor Card" extends "Vendor Card"
{
    layout
    {
        addafter(Name)
        {
            field(Name2; Rec."Name 2")
            {
                ApplicationArea = All;
                Caption = 'Nombre';
                ToolTip = 'Nombre';
            }
        }
        addafter("Last Date Modified")
        {
            field("Last User Modified_LDR"; Rec."Last User Modified_LDR")
            {
                ApplicationArea = All;
                Caption = 'Ultimo Usuario Modificado';
                ToolTip = 'Ultimo Usuario Modificado';
            }
            field("Rating Code_LDR"; Rec."Rating Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Valoración';
                ToolTip = 'Codigo de Valoración';
            }
            field("Refueling Vendor_LDR"; REC."Refueling Vendor_LDR")
            {
                ApplicationArea = All;
                Caption = 'Proveedor de reabastecimiento de combustible';
                ToolTip = 'Proveedor de reabastecimiento de combustible';
            }
            field("Old Vendor No._LDR"; Rec."Old Vendor No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de proveedor antiguo';
                ToolTip = 'Número de proveedor antiguo';
            }
        }
        addafter("Preferred Bank Account Code")
        {
            field("Bank Forecast_LDR"; Rec."Bank Forecast_LDR")
            {
                ApplicationArea = All;
                Caption = 'Pronóstico del Banco';
                ToolTip = 'Pronóstico del Banco';
            }
        }
        addafter(Name)
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
                Caption = 'Balance';
                ToolTip = 'Balance';
            }
            field("Purchases (LCY)"; Rec."Purchases (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Compras (LCY)';
                ToolTip = 'Compras (LCY)';
            }
            field("Balance Due"; Rec."Balance Due")
            {
                ApplicationArea = All;
                Caption = 'Saldo adeudado';
                ToolTip = 'Saldo adeudado';
            }
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
                Caption = 'Cambio neto';
                ToolTip = 'Cambio neto';
            }
            field("VAT Registration No._LDR"; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
            field("Cr. Memo Amounts (LCY)"; Rec."Cr. Memo Amounts (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Montos de notas de crédito (LCY)';
                ToolTip = 'Montos de notas de crédito (LCY)';
            }
            field("Cr. Memo Amounts"; Rec."Cr. Memo Amounts")
            {
                ApplicationArea = All;
                Caption = 'Montos de notas de crédito';
                ToolTip = 'Montos de notas de crédito';
            }
            field("Payment Method Code_LDR"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Metodo de Pago';
                ToolTip = 'Codigo de Metodo de Pago';
            }
            field("E-Mail_LDR"; Rec."E-Mail")
            {
                ApplicationArea = All;
                Caption = 'Email';
                ToolTip = 'Email';
            }
        }
        addafter("Location Code")
        {
            field(Address_LDR; Rec.Address)
            {
                ApplicationArea = All;
                Caption = 'Dirección';
                ToolTip = 'Dirección';
                Visible = false;
            }
            field("Address 2_LDR"; Rec."Address 2")
            {
                ApplicationArea = All;
                Caption = 'Dirección 2';
                ToolTip = 'Dirección 2';
                Visible = false;
            }
            field(City_LDR; Rec.City)
            {
                ApplicationArea = All;
                Caption = 'Ciudad';
                ToolTip = 'Ciudad';
                Visible = false;
            }
        }
        addafter("Country/Region Code")
        {
            field(County_LDR; Rec.County)
            {
                ApplicationArea = All;
                Caption = 'Condado';
                ToolTip = 'Condado';
            }
        }
        addafter("Base Calendar Code")
        {
            field(RatingCode_LDR; Rec."Rating Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Valoración';
                ToolTip = 'Codigo de Valoración';
            }
            field(OldVendorNo_LDR; Rec."Old Vendor No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No de Proveedor Antiguo';
                ToolTip = 'No de Proveedor Antiguo';
            }
        }
    }

    actions
    {
        addafter(ApplyTemplate)
        {
            action(CreateAlarm)
            {
                ApplicationArea = All;
                Caption = 'Crear Alarma';
                trigger OnAction()
                begin
                    Rec.CreateAlarmFor(1);
                end;
            }
        }
        addafter("Purchase Journal")
        {
            group("Multi-CompanyManagement")
            {
                action(ReplicateAmongCompanies)
                {
                    ApplicationArea = All;
                    Caption = 'Replicar entre Empresas';
                    Image = Intercompany;

                    trigger OnAction()
                    var
                        MultiCompanyMgt: Report "MultiCompany Mgt.";
                    begin
                        MultiCompanyMgt.CreateVendor(Rec, true);
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}