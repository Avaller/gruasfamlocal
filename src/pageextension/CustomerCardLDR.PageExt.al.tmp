pageextension 50004 "Customer Card_LDR" extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field("Name 2_LDR"; Rec."Name 2")
            {
                ApplicationArea = All;
                Caption = 'Nombre 2';
                ToolTip = 'Nombre 2';
            }
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
                Caption = 'Comentario';
                ToolTip = 'Comentario';
            }
        }
        addafter(Blocked)
        {
            field(; Cus)
            {
                DataClassification = ToBeClassified;
            }
        }
    }

    actions
    {
        addafter(CustomerReportSelections)
        {
            action(ActiveContracts)
            {
                ApplicationArea = All;
                Caption = 'Active Contracts';
                Visible = false;
                Image = Documents;

                trigger OnAction()
                var
                    recLineasContrato: Record "Service Contract Line";
                    frmLineasContrato: Page "Serv. Contr. List (Serv. Item)";
                begin
                    Clear(recLineasContrato);
                    recLineasContrato.SetRange("Customer No.", Rec."No.");
                    recLineasContrato.SetFilter("Starting Date", '<=%1', WORKDATE);
                    recLineasContrato.SetFilter("Contract Expiration Date", '>=%1', WORKDATE);
                    frmLineasContrato.SetTableView(recLineasContrato);
                    frmLineasContrato.Run();
                end;
            }
        }

        addafter("Ser&vice Contracts")
        {
            action("<Page Customer Posted Service Contracts")
            {
                ApplicationArea = All;
                Caption = 'Página Contratos de servicio publicados por el cliente';
                Image = PostedServiceOrder;

                RunObject = Page "Customer Service Contracts";
                RunPageView = SORTING("Customer No.", "Ship-to Code")
                                  WHERE(Historical = CONST(Yes));
                RunPageLink = "Customer No." = FIELD("No.");
            }
        }

        addafter("Service &Items")
        {
            group("Crane Service Quotes")
            {
                Caption = 'Ofertas Servicio Grua';
                Image = CoupledQuote;

                action(CraneServiceQuotes)
                {
                    ApplicationArea = All;
                    Caption = 'Ofertas Servicio Grua';
                    Promoted = true;
                    Image = Quote;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        CraneServiceQuotes: Page "Crane Service Quotes";
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
                action("View Links")
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
                        pLinks.SetParams(RecordId);
                    end;
                }
                action("Set Delete From Extranet")
                {
                    ApplicationArea = All;
                    Caption = 'Marcar para eliminaci¢n en Ingestrel';
                    Image = RemoveContacts;

                    trigger OnAction()
                    begin
                        Rec.TestField("Ingestrel Export_LDR");
                        Rec.TestField("Last Export Date_LDR");

                        if Confirm(Text50002, false) then begin
                            Rec."Extranet Deletion_LDR" := true;
                            Rec.Modify(true)
                        end;
                    end;
                }
            }
        }
        addafter(ApplyTemplate)
        {
            action("Create Alarm")
            {
                ApplicationArea = All;
                Ellipsis = true;
                Caption = 'Crear alarma';
                Promoted = true;
                Image = CreateReminders;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ConfigTemplateMgt: Codeunit "Config. Template Management";
                    RecRef: RecordRef;
                begin
                    CreaAlarmFor(1);
                end;
            }
        }
        addafter("Sales Journal")
        {
            group("Multi-company Management")
            {
                action("Replicate among Companies")
                {
                    ApplicationArea = All;
                    Caption = 'Replicar entre Empresas';
                    Image = Intercompany;

                    trigger OnAction()
                    var
                        MultiCompanyMgt: Report 50212;
                    begin
                        MultiCompanyMgt.CreateCustomer(Rec, true);
                    end;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ServiceQuoteMgt: Codeunit "Service Quote Mgt._LDR";
        SalesSetup: Record "Sales & Receivables Setup";
        txtErrorCIF: Label 'Debe especificar un CIF/NIF valido';
        CraneMgtSetup: Record "Crane Mgt. Setup_LDR";
        temp: Text;
    begin
        CraneMgtSetup.Get();
        temp := Format(CloseAction);
        if (CraneMgtSetup."Auto Create General Quote") and ((CloseAction = ACTION::OK) OR (CloseAction = ACTION::LookupOK)) then
            ServiceQuoteMgt.CreateGeneralQuote(Rec);
        SalesSetup.Get();
        if (SalesSetup."CIF/NIF Obligatory") and (Rec."VAT Registration No." = '') AND (Rec."No." <> '') then
            Message(txtErrorCIF);
    end;
}