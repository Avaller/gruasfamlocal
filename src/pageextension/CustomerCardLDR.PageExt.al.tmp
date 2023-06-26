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
            field("Customer Vendor No._LDR"; Rec."Customer Vendor No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Nº Proveedor Cliente';
                ToolTip = 'Nº Proveedor Cliente';
            }
        }
        addafter("Service Zone Code")
        {
            field("Rating Code_LDR"; Rec."Rating Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Código de Calificación';
                ToolTip = 'Código de Calificación';
            }
        }
        addafter("Document Sending Profile")
        {
            field("Send Sales Documents By Mail_LDR"; Rec."Send Sales Documents By Mail_LDR")
            {
                ApplicationArea = All;
                Caption = 'Enviar Documentos de Venta por Mail';
                ToolTip = 'Enviar Documentos de Venta por Mail';
            }
            field("Sales E-Mail Destination"; Rec."Sales E-Mail Destination_LDR")
            {
                ApplicationArea = All;
                Caption = 'Destino de correo electrónico de ventas';
                ToolTip = 'Destino de correo electrónico de ventas';
            }
            field("Send Service Documents By Mail"; Rec."Send Service Documents By Mail_LDR")
            {
                ApplicationArea = All;
                Caption = 'Enviar documentos de servicio por correo';
                ToolTip = 'Enviar documentos de servicio por correo';
            }
            field("Service E-Mail Destination"; Rec."Service E-Mail Destination_LDR")
            {
                ApplicationArea = All;
                Caption = 'Destino del correo electrónico del servicio';
                ToolTip = 'Destino del correo electrónico del servicio';
            }
        }
        addafter("Last Date Modified")
        {
            field("Last User Modified"; Rec."Last User Modified_LDR")
            {
                ApplicationArea = All;
                Caption = 'Último usuario modificado';
                ToolTip = 'Último usuario modificado';
            }
            field("Old Customer No."; Rec."Old Customer No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Viejo cliente No.';
                ToolTip = 'Viejo cliente No.';
            }
            field("Internal Customer"; Rec."Internal Customer_LDR")
            {
                ApplicationArea = All;
                Caption = 'Cliente interno';
                ToolTip = 'Cliente interno';
            }
            group("Ingestrel Params")
            {
                Caption = 'Parametros Ingestrel';
                Visible = false;

                field("Ingestrel Export"; Rec."Ingestrel Export_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Exportación de Ingestrel';
                    ToolTip = 'Exportación de Ingestrel';
                    trigger OnValidate()
                    begin
                        if not Rec."Ingestrel Export_LDR" then
                            Error(Text50003);
                    end;
                }
                field("Creation Date"; Rec."Creation Date_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de creación';
                    ToolTip = 'Fecha de creación';
                }
                field("VAT Registration No._LDR"; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de registro de IVA';
                    ShowMandatory = true;
                    ToolTip = 'Número de registro de IVA';
                }
                field("Name2"; Rec."Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre';
                    ToolTip = 'Nombre';
                }
                field(Address1; Rec.Address)
                {
                    ApplicationArea = All;
                    Caption = 'Dirección';
                    ToolTip = 'Dirección';
                }
                field(Address2; Rec."Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección';
                    ToolTip = 'Dirección';
                }
                field("Post Code_LDR"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo Postal';
                    ToolTip = 'Codigo Postal';
                }
                field(City2; Rec.City)
                {
                    ApplicationArea = All;
                    Caption = 'Ciudad';
                    ToolTip = 'Ciudad';
                }
                field(County2; Rec.County)
                {
                    ApplicationArea = All;
                    Caption = 'Condado';
                    ToolTip = 'Condado';
                }
                field("Country/Region Code2"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de país/región';
                    ToolTip = 'Código de país/región';
                }
                field("Phone No.3"; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de Telefono';
                    ToolTip = 'Nº de Telefono';
                }
                field("Fax No.2"; Rec."Fax No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de Fax';
                    ToolTip = 'Nº de Fax';
                }
                field("E-Mail2"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail';
                    Importance = Promoted;
                    ToolTip = 'E-Mail';
                }
                field("Home Page2"; Rec."Home Page")
                {
                    ApplicationArea = All;
                    Caption = 'Página de inicio';
                    ToolTip = 'Página de inicio';
                }
                field("Ingestrel Export Date"; Rec."Ingestrel Export Date_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de exportación de Ingestrel';
                    Editable = false;
                    ToolTip = 'Fecha de exportación de Ingestrel';
                }
                field("Last Export Date_LDR"; Rec."Last Export Date_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Última fecha de exportación';
                    Editable = false;
                    ToolTip = 'Última fecha de exportación';
                }
                field("Extranet Deletion_LDR"; Rec."Extranet Deletion_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Eliminación de extranet';
                    Editable = false;
                    ToolTip = 'Eliminación de extranet';
                }
            }
        }
        addafter("Primary Contact No.")
        {
            field("Financial Institution_LDR"; Rec."Financial Institution_LDR")
            {
                ApplicationArea = All;
                Caption = 'Institución financiera';
                ToolTip = 'Institución financiera';
            }
        }
        addafter("Fax No.")
        {
            field("Telex No."; Rec."Telex No.")
            {
                ApplicationArea = All;
                Caption = 'Télex No.';
                ToolTip = 'Télex No.';
            }
        }
        addafter("Language Code")
        {
            group(PaymentDistinction)
            {
                field("Serv Cont Payment Terms Code_LDR"; Rec."Serv Cont Payment Terms Code_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Código de condiciones de pago de Serv Cont';
                    ToolTip = 'Código de condiciones de pago de Serv Cont';
                }
                field("Serv Cont Payment Method Code_LDR"; Rec."Serv Cont Payment Method Code_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Serv Cont Código de método de pago';
                    ToolTip = 'Serv Cont Código de método de pago';
                }
                field("Serv Order Payment Terms Code_LDR"; Rec."Serv Order Payment Terms Code_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Código de condiciones de pago de la orden de servicio';
                    ToolTip = 'Código de condiciones de pago de la orden de servicio';
                }
                field("Serv Order Payment Method Code_LDR"; Rec."Serv Order Payment Method Code_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Código de método de pago de la orden de servicio';
                    ToolTip = 'Código de método de pago de la orden de servicio';
                }
                field("Sales Doc Payment Terms Code_LDR"; Rec."Sales Doc Payment Terms Code_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Código de condiciones de pago del documento de ventas';
                    ToolTip = 'Código de condiciones de pago del documento de ventas';
                }
                field("Sales Doc Payment Method Code_LDR"; Rec."Sales Doc Payment Method Code_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Código de método de pago del documento de ventas';
                    ToolTip = 'Código de método de pago del documento de ventas';
                }
            }
            group(Services)
            {
                Caption = 'Service';
                field("Service Customer Sales Code_LDR"; Rec."Service Customer Sales Code_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Servicio Cliente Código Ventas';
                    ToolTip = 'Servicio Cliente Código Ventas';
                }
            }
        }
        addafter("Copy Sell-to Addr. to Qte From")
        {
            field("Group Serv. Contract Invoices_LDR"; Rec."Group Serv. Contract Invoices_LDR")
            {
                ApplicationArea = All;
                Caption = 'Servicio de grupo Facturas de contrato';
                ToolTip = 'Servicio de grupo Facturas de contrato';
            }
        }
        addafter("Prepayment %")
        {
            field("Invoice Period_LDR"; Rec."Invoice Period_LDR")
            {
                ApplicationArea = All;
                Caption = 'Período de facturación';
                ToolTip = 'Período de facturación';
            }
            field("Days Until Report_LDR"; Rec."Days Until Report_LDR")
            {
                ApplicationArea = All;
                Caption = 'Días hasta el informe';
                ToolTip = 'Días hasta el informe';
            }
            field("Invoicing Type_LDR"; Rec."Invoicing Type_LDR")
            {
                ApplicationArea = All;
                Caption = 'Tipo de facturación';
                ToolTip = 'Tipo de facturación';
            }
        }
        addafter("Preferred Bank Account Code")
        {
            field("Submit for Acceptance_LDR"; Rec."Submit for Acceptance_LDR")
            {
                ApplicationArea = All;
                Caption = 'Enviar para aceptación';
                ToolTip = 'Enviar para aceptación';
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
                        pLinks.SetParams(Rec.RecordId);
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

    var
        ServInfoPaneMgt: Codeunit "Service Info-Pane Management";
        Text50002: Label 'Esta seguro de querer establecer este registro para su eliminaci¢n de Ingestrel?';
        Text50003: Label 'Debe utilizar el proceso de Eliminacion de Ingestrel.';
}