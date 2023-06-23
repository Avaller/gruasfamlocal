pageextension 50005 "Customer List_LDR" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
                Caption = 'Balance';
                ToolTip = 'Balance';
            }
            field("Sales (LCY)2"; Rec."Sales (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Ventas (LCY)';
                ToolTip = 'Ventas (LCY)';
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
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
            field("Cr. Memo Amounts (LCY)"; Rec."Cr. Memo Amounts (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Importes de las notas de crédito (LCY)';
                ToolTip = 'Importes de las notas de crédito (LCY)';
            }
            field("Cr. Memo Amounts"; Rec."Cr. Memo Amounts")
            {
                ApplicationArea = All;
                Caption = 'Importes de las notas de crédito';
                ToolTip = 'Importes de las notas de crédito';
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
                Caption = 'E-Mail';
                ToolTip = 'E-Mail';
            }
            field("Submit for Acceptance"; Rec."Submit for Acceptance_LDR")
            {
                ApplicationArea = All;
                Caption = 'Enviar para aceptación';
                ToolTip = 'Enviar para aceptación';
            }
            field(Name2; Rec."Name 2")
            {
                ApplicationArea = All;
                Caption = 'Nombre';
                ToolTip = 'Nombre';
            }
            field("Service Zone Code"; Rec."Service Zone Code")
            {
                ApplicationArea = All;
                Caption = 'Código de zona de servicio';
                ToolTip = 'Código de zona de servicio';
            }
            field(PaymentTermsCode; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
                Caption = 'Código de condiciones de pago';
                ToolTip = 'Código de condiciones de pago';
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Metodo de Pago';
                ToolTip = 'Codigo de Metodo de Pago';
            }
        }
        addafter("Location Code")
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
                Caption = 'Dirección';
                ToolTip = 'Dirección';
                Visible = false;
            }
            field(County; Rec.County)
            {
                ApplicationArea = All;
                Caption = 'Condado';
                ToolTip = 'Condado';
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Dirección';
                Caption = 'Dirección';
                Visible = false;
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
                Caption = 'Ciudad';
                ToolTip = 'Ciudad';
                Visible = false;
            }
        }
        addafter("Language Code")
        {
            field("Service E-Mail Destination_LDR"; Rec."Service E-Mail Destination_LDR")
            {
                ApplicationArea = All;
                Caption = 'Destino del correo electrónico del servicio';
                ToolTip = 'Destino del correo electrónico del servicio';
            }
            field("Sales E-Mail Destination_LDR"; Rec."Sales E-Mail Destination_LDR")
            {
                ApplicationArea = All;
                Caption = 'Destino de correo electrónico de ventas';
                ToolTip = 'Destino de correo electrónico de ventas';
            }
        }
        addafter("Base Calendar Code")
        {
            field("Rating Code_LDR"; Rec."Rating Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Valoración';
                ToolTip = 'Codigo de Valoración';
            }
            field("Invoice Period_LDR"; Rec."Invoice Period_LDR")
            {
                ApplicationArea = All;
                Caption = 'Período de facturación';
                ToolTip = 'Período de facturación';
            }
            field("Days Until Report_LDR"; Rec."Days Until Report_LDR")
            {
                ApplicationArea = All;
                Caption = 'Dias Hasta el Informe';
                ToolTip = 'Dias Hasta el Informe';
            }
            field("Invoicing Type_LDR"; Rec."Invoicing Type_LDR")
            {
                ApplicationArea = All;
                Caption = 'Tipo de facturación';
                ToolTip = 'Tipo de facturación';
            }
            field("Old Customer No._LDR"; Rec."Old Customer No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Viejo No. de Cliente';
                ToolTip = 'Viejo No. de Cliente';
            }
        }
    }

    actions
    {
        addafter("Ser&vice Contracts")
        {
            action("Page Posted Service Contracts")
            {
                ApplicationArea = All;
                Caption = 'Hist¢rico Contratos servicios';

                RunObject = Page "Customer Service Contracts";
                RunPageView = sorting("Customer No.", "Ship-to Code")
                            where(Historical = const(Yes));
                RunPageLink = "Customer No." = field("No.");
                Image = PostedServiceOrder;
            }
        }
        addafter("Service &Items")
        {
            group("Crane Service Quotes")
            {
                action(CraneServiceQuotes)
                {
                    ApplicationArea = All;
                    Caption = 'Ofertas Servicio Grua';
                    Promoted = true;
                    Image = Quote;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        CraneServiceQuote: Page "Crane Service Quotes";
                        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
                    begin
                        CraneServiceQuoteHeader.SetRange("Customer No.", Rec."No.");
                        Page.Run(50023, CraneServiceQuoteHeader);
                    end;
                }
                action(CraneServiceQuotesHis)
                {
                    ApplicationArea = All;
                    Caption = 'Ofertas Servicio Grua Hist.';
                    Image = AgreementQuote;

                    trigger OnAction()
                    var
                        CraneServiceQuotesHis: Page "Crane Serv. Q. Op. Inv. G Line";
                        CraneServiceQuoteHeader: Record "Crane Service Quote Header_LDR";
                    begin
                        CraneServiceQuoteHeader.SetRange("Customer No.", Rec."No.");
                        Page.Run(50035, CraneServiceQuoteHeader);
                    end;
                }
            }
            group(Ingestrel)
            {
                Caption = 'Ingestrel';
                action(ViewLinks)
                {
                    ApplicationArea = All;
                    Caption = 'Ver Adjuntos';
                    Image = Links;

                    trigger OnAction()
                    var
                        RecordLink: Record "Record Link";
                        pLinks: Page "Service Item Bin Entry";
                    begin
                        RecordLink.SetRange("Record ID", Rec.RecordId);
                        RecordLink.SetRange(Type, RecordLink.Type::Link);
                        Clear(pLinks);
                        pLinks.SetTableView(RecordLink);
                        pLinks.SetParams(Rec.RecordId);
                        pLinks.RunModal();
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}