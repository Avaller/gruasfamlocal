/// <summary>
/// Page Posted Service Header (ID 50203).
/// </summary>
page 50203 "Posted Service Header"
{
    // version ALQUINTA9.00,FAM

    CaptionML = ENU = 'Posted Service Header',
                ESP = 'Pedido servicio registrado';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Posted Service Header_LDR";

    /*
    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            ESP = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                    Editable = false;
                    ToolTip = 'No';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    Editable = false;
                    ToolTip = 'Descripción';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cliente';
                    Editable = false;
                    ToolTip = 'No de Cliente';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Contacto';
                    Editable = false;
                    ToolTip = 'No de Contacto';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre';
                    Editable = false;
                    ToolTip = 'Nombre';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Caption = 'DDirección';
                    Editable = false;
                    ToolTip = 'DDirección';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección 2';
                    Editable = false;
                    ToolTip = 'Dirección 2';
                    Visible = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Envio';
                    Editable = false;
                    ToolTip = 'Codigo de Envio';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Caption = 'Ciudad';
                    Editable = false;
                    ToolTip = 'Ciudad';
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de contacto';
                    Editable = false;
                    ToolTip = 'Nombre de contacto';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Telefono';
                    Editable = false;
                    ToolTip = 'No de Telefono';
                }
                field("Phone No. 2"; Rec."Phone No. 2")
                {
                    ApplicationArea = All;
                    Caption = 'No de Telefono 2';
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'No de Telefono 2';
                    Visible = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail';
                    Editable = false;
                    ToolTip = 'E-Mail';
                }
                field("Notify Customer"; Rec."Notify Customer")
                {
                    ApplicationArea = All;
                    Caption = 'Notifica al Cliente';
                    Editable = false;
                    ToolTip = 'Notifica al Cliente';
                    Visible = false;
                }
                field("Service Order Type"; Rec."Service Order Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de orden de servicio';
                    Editable = false;
                    ToolTip = 'Tipo de orden de servicio';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de contrato';
                    Editable = false;
                    ToolTip = 'Nº de contrato';
                }
                field("Contract group Code"; Rec."Contract group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código del grupo de contratos';
                    ToolTip = 'Código del grupo de contratos';
                }
                field("Internal Contract No."; Rec."Internal Contract No.")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de contrato interno';
                    ToolTip = 'Nº de contrato interno';
                }
                field("Response Date"; Rec."Response Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de respuesta';
                    Editable = false;
                    ToolTip = 'Fecha de respuesta';
                }
                field("Response Time"; Rec."Response Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de respuesta';
                    Editable = false;
                    ToolTip = 'Tiempo de respuesta';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Caption = 'Centro de responsabilidad';
                    Editable = false;
                    ToolTip = 'Centro de responsabilidad';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    Caption = 'Prioridad';
                    Editable = false;
                    ToolTip = 'Prioridad';
                }
                field("Crane Service Quote No."; Rec."Crane Service Quote No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cotización de Servicio de Grúa';
                    ToolTip = 'No de Cotización de Servicio de Grúa';
                }
                field("Service Item Rate No."; Rec."Service Item Rate No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Tarifa de artículo de servicio';
                    ToolTip = 'No de Tarifa de artículo de servicio';
                }
            }
            part(ServShipmentItemLines; 50204)
            {
                SubPageLink = "No." = field("No.");
            }
            group(Invoicing)
            {
                CaptionML = ENU = 'Invoicing',
                            ESP = 'Facturación';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Factura al cliente';
                    Editable = false;
                    ToolTip = 'No de Factura al cliente';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de facturación';
                    Editable = false;
                    ToolTip = 'Nombre de facturación';
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de facturación';
                    Editable = false;
                    ToolTip = 'Dirección de facturación';
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de facturación 2';
                    Editable = false;
                    ToolTip = 'Dirección de facturación 2';
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código postal de facturación';
                    Editable = false;
                    ToolTip = 'Código postal de facturación';
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                    Caption = 'Ciudad de facturación';
                    Editable = false;
                    ToolTip = 'Ciudad de facturación';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                    Caption = 'Contacto de facturación';
                    Editable = false;
                    ToolTip = 'Contacto de facturación';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                    Caption = 'Tu referencia';
                    Editable = false;
                    ToolTip = 'Tu referencia';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de vendedor';
                    Editable = false;
                    ToolTip = 'Código de vendedor';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de publicación';
                    Editable = false;
                    ToolTip = 'Fecha de publicación';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha del documento';
                    Editable = false;
                    ToolTip = 'Fecha del documento';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de dimensión 1 de acceso directo';
                    Editable = false;
                    ToolTip = 'Código de dimensión 1 de acceso directo';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de dimensión 2 de acceso directo';
                    Editable = false;
                    ToolTip = 'Código de dimensión 2 de acceso directo';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de método de pago';
                    ToolTip = 'Código de método de pago';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de condiciones de pago';
                    ToolTip = 'Código de condiciones de pago';
                }
                field("No. of Posted Invoices"; Rec."No. of Posted Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'No. de Facturas Registradas';
                    ToolTip = 'No. de Facturas Registradas';
                }
                field("No. of Unposted Invoices"; Rec."No. of Unposted Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Nº de facturas no contabilizadas';
                    ToolTip = 'Nº de facturas no contabilizadas';
                }
                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                    ApplicationArea = All;
                    Caption = 'ID de mandato de domiciliación bancaria';
                    ToolTip = 'ID de mandato de domiciliación bancaria';
                }
            }
            group(Shipping)
            {
                CaptionML = ENU = 'Shipping',
                            ESP = 'Envío';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de envío';
                    Editable = false;
                    ToolTip = 'Código de envío';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    Caption = 'Enviar a nombre de';
                    Editable = false;
                    ToolTip = 'Enviar a nombre de';
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ApplicationArea = All;
                    Caption = 'Enviar a nombre 2';
                    ToolTip = 'Enviar a nombre 2';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de envío';
                    Editable = false;
                    ToolTip = 'Dirección de envío';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de envío 2';
                    Editable = false;
                    ToolTip = 'Dirección de envío 2';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código postal de envío';
                    Editable = false;
                    ToolTip = 'Código postal de envío';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                    Caption = 'Ciudad de destino';
                    Editable = false;
                    ToolTip = 'Ciudad de destino';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    Caption = 'Contacto de envío';
                    Editable = false;
                    ToolTip = 'Contacto de envío';
                }
                field("Ship-to Phone"; Rec."Ship-to Phone")
                {
                    ApplicationArea = All;
                    Caption = 'Teléfono de envío';
                    Editable = false;
                    ToolTip = 'Teléfono de envío';
                }
                field("Ship-to Phone 2"; Rec."Ship-to Phone 2")
                {
                    ApplicationArea = All;
                    Caption = 'Teléfono de envío 2';
                    Editable = false;
                    ToolTip = 'Teléfono de envío 2';
                }
                field("Ship-to E-Mail"; Rec."Ship-to E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'Enviar a correo electrónico';
                    Editable = false;
                    ToolTip = 'Enviar a correo electrónico';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de localización';
                    Editable = false;
                    ToolTip = 'Código de localización';
                }
            }
            group(Details)
            {
                CaptionML = ENU = 'Details',
                            ESP = 'Detalles';
                field("Warning Status"; Rec."Warning Status")
                {
                    ApplicationArea = All;
                    Caption = 'Estado de advertencia';
                    Editable = false;
                    ToolTip = 'Estado de advertencia';
                }
                field("Link Service to Service Item"; Rec."Link Service to Service Item")
                {
                    ApplicationArea = All;
                    Caption = 'Vincular servicio a artículo de servicio';
                    Editable = false;
                    ToolTip = 'Vincular servicio a artículo de servicio';
                }
                field("Allocated Hours"; Rec."Allocated Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas asignadas';
                    Editable = false;
                    ToolTip = 'Horas asignadas';
                }
                field("Service Zone Code"; Rec."Service Zone Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de zona de servicio';
                    Editable = false;
                    ToolTip = 'Código de zona de servicio';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de orden';
                    Editable = false;
                    ToolTip = 'Fecha de orden';
                }
                field("Order Time"; Rec."Order Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de la orden';
                    Editable = false;
                    ToolTip = 'Tiempo de la orden';
                }
                field("Expected Finishing Date"; Rec."Expected Finishing Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de finalización prevista';
                    Editable = false;
                    ToolTip = 'Fecha de finalización prevista';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de inicio';
                    Editable = false;
                    ToolTip = 'Fecha de inicio';
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de empezar';
                    Editable = false;
                    ToolTip = 'Tiempo de empezar';
                }
                field("Actual Response Time (Hours)"; Rec."Actual Response Time (Hours)")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de respuesta real (horas)';
                    Editable = false;
                    ToolTip = 'Tiempo de respuesta real (horas)';
                }
                field("Finishing Date"; Rec."Finishing Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de finalización';
                    Editable = false;
                    ToolTip = 'Fecha de finalización';
                }
                field("Finishing Time"; Rec."Finishing Time")
                {
                    ApplicationArea = All;
                    Caption = 'Hora de finalización';
                    Editable = false;
                    ToolTip = 'Hora de finalización';
                }
                field("Service Time (Hours)"; Rec."Service Time (Hours)")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de servicio (horas)';
                    Editable = false;
                    ToolTip = 'Tiempo de servicio (horas)';
                }
            }
            group("Foreign Trade")
            {
                CaptionML = ENU = 'Foreign Trade',
                            ESP = 'Internacional';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de moneda';
                    Editable = false;
                    ToolTip = 'Código de moneda';
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                    Caption = 'Comercio tripartito de la UE';
                    Editable = false;
                    ToolTip = 'Comercio tripartito de la UE';
                }
            }
            group(Payment)
            {
                CaptionML = ENU = 'Payment',
                            ESP = 'Pago';
                field("Pay-at Code"; Rec."Pay-at Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de pago';
                    Editable = false;
                    ToolTip = 'Código de pago';
                }
                field("Cust. Bank Acc. Code"; Rec."Cust. Bank Acc. Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de cuenta bancaria del cliente';
                    Editable = false;
                    ToolTip = 'Código de cuenta bancaria del cliente';
                }
            }
            group("PDF Mail")
            {
                CaptionML = ENU = 'PDF Mail',
                            ESP = 'PDF Mail';
                field("Send Document By Mail"; Rec."Send Document By Mail")
                {
                    ApplicationArea = All;
                    Caption = 'Enviar documento por correo';
                    Editable = false;
                    ToolTip = 'Enviar documento por correo';
                }
                field("E-Mail Destination"; Rec."E-Mail Destination")
                {
                    ApplicationArea = All;
                    Caption = 'Destino de correo electrónico';
                    Editable = false;
                    ToolTip = 'Destino de correo electrónico';
                }
            }
        }
        area(factboxes)
        {
            part(CustomerStatisticsFactBox; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = field("Bill-to Customer No.");
                Visible = false;
            }
            part(CustomerDetailsFactBox; "Customer Details FactBox")
            {
                SubPageLink = "No." = field("Customer No.");
                Visible = false;
            }
            part(ServiceHistSelltoFactBox; "Service Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = field("Customer No.");
                Visible = true;
            }
            part(ServiceHistBilltoFactBox; "Service Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = field("Bill-to Customer No.");
                Visible = false;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Order")
            {
                CaptionML = ENU = '&Order',
                            ESP = '&Pedido';
                action("Service Ledger E&ntries")
                {
                    CaptionML = ENU = 'Service Ledger E&ntries',
                                ESP = 'Movs. ser&vicio';
                    Image = ServiceLedger;
                    RunObject = Page "Service Ledger Entries";
                    RunPageLink = "Service Order No." = field("No.");
                    RunPageView = Sorting("Service Order No.", "Service Item No. (Serviced)", "Entry Type", "Moved from Prepaid Acc.", "Posting Date", Open, Type, "Service Contract No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("&Warranty Ledger Entries")
                {
                    CaptionML = ENU = '&Warranty Ledger Entries',
                                ESP = 'Movs. &garantía';
                    Image = WarrantyLedger;
                    RunObject = Page "Warranty Ledger Entries";
                    RunPageLink = "Service Order No." = field("No.");
                    RunPageView = Sorting("Service Order No.", "Posting Date", "Document No.");
                }
                action("&Job Ledger Entries")
                {
                    CaptionML = ENU = '&Job Ledger Entries',
                                ESP = 'Movs. pro&yectos';
                    Image = JobLedger;
                    RunObject = Page "Job Ledger Entries";
                    RunPageLink = "Service Order No." = field("No.");
                    RunPageView = Sorting("Service Order No.", "Posting Date")
                                  where("Entry Type" = Const(Usage));
                }
                separator(Separator)
                {
                }
                action("S&tatistics")
                {
                    CaptionML = ENU = 'S&tatistics',
                                ESP = '&Estadísticas';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 70086; //TODO: No encontrada
                    RunPageLink = "field" = field("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                ESP = 'C&omentarios';
                    Image = ViewComments;
                    RunObject = Page "Service Comment Sheet";
                    RunPageLink = "No." = field("No."),
                                  "Table Name" = Const("Service Header"), //TODO: "Posted Service Header" no esta , asi que lo sustitui por Service Header
                                  Type = Const(General);
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    CaptionML = ENU = 'Dimensions',
                                ESP = 'Dimensiones';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    Begin
                        Rec.ShowDimensions;
                    end;
                }
                separator(Separtor1)
                {
                }
                action("Service Document Lo&g")
                {
                    CaptionML = ENU = 'Service Document Lo&g',
                                ESP = '&Registro pedido servicio';
                    Image = Log;

                    trigger OnAction();
                    var
                        ServDocLog: Record "Service Document Log";
                        TempServDocLog: Record "Service Document Log" temporary;
                    Begin
                        TempServDocLog.Reset;
                        TempServDocLog.DeleteAll;

                        ServDocLog.Reset;
                        ServDocLog.SetRange("Document Type", ServDocLog."Document Type"::Shipment);
                        ServDocLog.SetRange("Document No.", Rec."No.");
                        if ServDocLog.FindSet then
                            Repeat
                                TempServDocLog := ServDocLog;
                                TempServDocLog.Insert;
                            Until ServDocLog.Next = 0;

                        ServDocLog.Reset;
                        ServDocLog.SetRange("Document Type", ServDocLog."Document Type"::Order);
                        ServDocLog.SetRange("Document No.", Rec."Order No.");
                        if ServDocLog.FindSet then
                            Repeat
                                TempServDocLog := ServDocLog;
                                TempServDocLog.Insert;
                            Until ServDocLog.Next = 0;

                        TempServDocLog.Reset;
                        TempServDocLog.SetCurrentKey("Change Date", "Change Time");
                        TempServDocLog.Ascending(false);

                        PAGE.Run(0, TempServDocLog);
                    end;
                }
                action("Service E-Mail &Queue")
                {
                    CaptionML = ENU = 'Service E-Mail &Queue',
                                ESP = '&Cola correo electrónico servicio';
                    Image = Email;
                    RunObject = Page "Service Email Queue";
                    RunPageLink = "Document Type" = Const("Service Order"),
                                  "Document No." = field("No.");
                    RunPageView = Sorting("Document Type", "Document No.");
                }
                separator(Separator2)
                {
                }
                action("Print Warranty / Submission Agreement")
                {
                    CaptionML = ENU = 'Print Warranty / Submission Agreement',
                                ESP = 'Imprimir Garantía / Petición Acuerdo';
                    Image = WarrantyLedger;
                    Promoted = true;
                    PromotedCategory = "report";
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        PostedServItemLine: Record "Posted Service Item Line_LDR";
                        reportGarantia: report 70007; //TODO: No encontrado
                    Begin
                        Clear(PostedServItemLine);
                        PostedServItemLine.SetRange(PostedServItemLine."No.", Rec."No.");
                        reportGarantia.SetTableView(PostedServItemLine);
                        reportGarantia.Run;
                    end;
                }
            }
            group("Comm&ents")
            {
                CaptionML = ENU = 'Comm&ents',
                            ESP = 'Come&ntarios';
                Image = ViewComments;
                action(Faults)
                {
                    CaptionML = ENU = 'Faults',
                                ESP = 'Defectos';
                    Image = Error;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction();
                    Begin
                        CurrPage.ServShipmentItemLines.PAGE.ShowComments(1);
                    end;
                }
                action(Resolutions)
                {
                    CaptionML = ENU = 'Resolutions',
                                ESP = 'Resoluciones';
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction();
                    Begin
                        CurrPage.ServShipmentItemLines.PAGE.ShowComments(2);
                    end;
                }
                action(Internal)
                {
                    CaptionML = ENU = 'Internal',
                                ESP = 'Interno';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction();
                    Begin
                        CurrPage.ServShipmentItemLines.PAGE.ShowComments(4);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            ESP = 'Acci&ones';
                group("Print Labels")
                {
                    CaptionML = ENU = 'Print Labels',
                                ESP = 'Imprimir Etiquetado';
                    Image = BarCode;
                    action(PrintIntermec)
                    {
                        CaptionML = ENU = 'Print Intermec',
                                    ESP = 'Imprimir Intermec';
                        Image = BarCode;
                        Promoted = true;

                        trigger OnAction();
                        var
                            PostedServHeader: Record "Posted Service Header_LDR";
                            reportSelection: Record "report Selections Labels_LDR";
                        Begin
                            Clear(PostedServHeader);
                            PostedServHeader.SetRange(PostedServHeader."No.", Rec."No.");
                            if PostedServHeader.FindSet then
                                report.RunModal(report::report7122024, true, false, PostedServHeader);
                        end;
                    }
                    action(PrintLabel)
                    {
                        CaptionML = ENU = 'Print Label EAN13',
                                    ESP = 'Imprimir Etiqueta EAN13';
                        Image = BarCode;
                        Promoted = true;
                        PromotedCategory = Process;

                        trigger OnAction();
                        var
                            PostedServItemLine: Record "Posted Service Item Line_LDR";
                            ServiceItem: Record "Service Item";
                            reportSelection: Record "report Selections Labels_LDR";
                            i: Integer;
                            EANServItem: report 70120; //TODO: No se encuentra
                        Begin
                            Clear(PostedServItemLine);
                            PostedServItemLine.SetRange("No.", Rec."No.");

                            if PostedServItemLine.FindSet then Begin
                                Clear(ServiceItem);
                                Repeat
                                    ServiceItem.Reset;
                                    ServiceItem.SetRange("No.", PostedServItemLine."Service Item No.");
                                    if ServiceItem.FindFirst then Begin
                                        reportSelection.SetRange(Usage, reportSelection.Usage::"Serv. Item");
                                        reportSelection.FindFirst;
                                        Repeat
                                            if reportSelection."report ID" = 7122151 then Begin
                                                EANServItem.SetTableView(ServiceItem);
                                                EANServItem.SetServHeaderNo(Rec."No.");
                                                EANServItem.RunModal();
                                            end else
                                                report.RunModal(reportSelection."report ID", false, false, ServiceItem);
                                        Until reportSelection.Next = 0;
                                    end;
                                Until PostedServItemLine.Next = 0;
                            end;
                        end;
                    }
                }
                action("&Print")
                {
                    CaptionML = ENU = '&Print',
                                ESP = '&Imprimir';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    Begin
                        Clear(PostedServHeader);
                        PostedServHeader.SetRange("No.", Rec."No.");
                        report.Run(report::report7122091, true, true, PostedServHeader);
                    end;
                }
            }
        }
    }

    trigger OnFindRecord(Which: Text): BoolEAN;
    Begin
        if Rec.Find(Which) then
            Exit(true);
        Rec.SetRange(Rec."No.");
        Exit(Rec.Find(Which));
    end;

    trigger OnModifyRecord(): BoolEAN;
    Begin
        CodeUnit.Run(CodeUnit::"Shipment Header - Edit", Rec);
        Exit(false);
    end;

    var
        PostedServHeader: Record "Posted Service Header_LDR";
        PurchSetup: Record "Purchases & Payables Setup";
        PostedServiceItemLine: Record "Posted Service Item Line_LDR";
    */
}

