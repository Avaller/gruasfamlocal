/// <summary>
/// Page Posted Service Order List (ID 50219).
/// </summary>
page 50219 "Posted Service Order List"
{
    Caption = 'Posted Service Orders';
    CardPageID = "Posted Service Header";
    Editable = false;
    PageType = List;
    SourceTable = "Posted Service Header_LDR";

    /*
    layout
    {
        area(content)
        {
            repeater(fields)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                    ToolTip = 'No';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cliente';
                    ToolTip = 'No de Cliente';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre';
                    ToolTip = 'Nombre';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Envio';
                    ToolTip = 'Codigo de Envio';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    Caption = 'Enviar a nombre de';
                    ToolTip = 'Enviar a nombre de';
                }
                field("Review No."; Rec."Review No.")
                {
                    ApplicationArea = All;
                    Caption = 'N.° de revisión';
                    ToolTip = 'N.° de revisión';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    Caption = 'tipo de fuente';
                    ToolTip = 'tipo de fuente';
                }
                field("Internal Contract No."; Rec."Internal Contract No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Contrato Interno';
                    ToolTip = 'No de Contrato Interno';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Terminos de Pago';
                    ToolTip = 'Codigo de Terminos de Pago';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Metodo de Pago';
                    ToolTip = 'Codigo de Metodo de Pago';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Caption = 'Centro de Responsabilidad';
                    ToolTip = 'Centro de Responsabilidad';
                }
                field(SalespersonCode2; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de vendedor';
                    ToolTip = 'Código de vendedor';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de dimensión 1 de acceso directo';
                    ToolTip = 'Código de dimensión 1 de acceso directo';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de dimensión 2 de acceso directo';
                    ToolTip = 'Código de dimensión 2 de acceso directo';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Publicación';
                    ToolTip = 'Fecha de Publicación';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                    Caption = 'Tu Referencia';
                    ToolTip = 'Tu Referencia';
                }
                field("Bill-toCustomerNo.2"; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Factura al cliente';
                    ToolTip = 'No de Factura al cliente';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de facturación';
                    ToolTip = 'Nombre de facturación';
                }
                field(OrderDate2; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de orden';
                    ToolTip = 'Fecha de orden';
                }
                field(ResponseDate2; Rec."Response Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de respuesta';
                    ToolTip = 'Fecha de respuesta';
                    Visible = false;
                }
                field("Response Time"; Rec."Response Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de respuesta';
                    ToolTip = 'Tiempo de respuesta';
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de inicio';
                    ToolTip = 'Fecha de inicio';
                    Visible = false;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de empezar';
                    ToolTip = 'Tiempo de empezar';
                    Visible = false;
                }
                field("Finishing Date"; Rec."Finishing Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de finalización';
                    ToolTip = 'Fecha de finalización';
                    Visible = false;
                }
                field("Finishing Time"; Rec."Finishing Time")
                {
                    ApplicationArea = All;
                    Caption = 'Hora de finalización';
                    ToolTip = 'Hora de finalización';
                    Visible = false;
                }
                field("Default Work Type Code"; Rec."Default Work Type Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de tipo de trabajo predeterminado';
                    ToolTip = 'Código de tipo de trabajo predeterminado';
                    Visible = false;
                }
                field("Actual Response Time (Hours)"; Rec."Actual Response Time (Hours)")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de respuesta real (horas)';
                    ToolTip = 'Tiempo de respuesta real (horas)';
                    Visible = false;
                }
                field("Service Time (Hours)"; Rec."Service Time (Hours)")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de servicio (horas)';
                    ToolTip = 'Tiempo de servicio (horas)';
                    Visible = false;
                }
                field("Crane Service Quote No."; Rec."Crane Service Quote No.")
                {
                    ApplicationArea = All;
                    Caption = 'No. de Servicio de grúa Cotización';
                    ToolTip = 'No. de Servicio de grúa Cotización';
                }
                field("Service Item Rate No."; Rec."Service Item Rate No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de tasa de artículo de servicio';
                    ToolTip = 'Número de tasa de artículo de servicio';
                }
                field("Customer Order No."; Rec."Customer Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de pedido del cliente';
                    ToolTip = 'Número de pedido del cliente';
                }
            }
        }
        area(factboxes)
        {
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
            group("O&rder")
            {
                Caption = 'O&rder';
                action("&Customer Card")
                {
                    Caption = '&Customer Card';
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = field("Customer No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action("Service Ledger E&ntries")
                {
                    Caption = 'Service Ledger E&ntries';
                    Image = ServiceLedger;
                    RunObject = Page "Service Ledger Entries";
                    RunPageLink = "Service Order No." = field("No.");
                    RunPageView = sorting("Service Order No.", "Service Item No. (Serviced)", "Entry Type", "Moved from Prepaid Acc.", "Posting Date", "Open", "Type");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Service Comment Sheet";
                    RunPageLink = "No." = field("No."),
                                  "Table Name" = CONST("Service Header"),
                                  Type = CONST("General");
                }
            }
            group(Statistics)
            {
                Caption = 'Statistics';
                Image = Statistics;
                action("S&tatistics")
                {
                    Caption = 'S&tatistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 70086; //TODO: No encontrado
                    RunPageLink = "No." = field("No.");
                    ShortCutKey = 'F7';
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Service Shipments";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Service Invoices";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                }
                action("&Warranty Ledger Entries")
                {
                    Caption = '&Warranty Ledger Entries';
                    Image = WarrantyLedger;
                    RunObject = Page "Warranty Ledger Entries";
                    RunPageLink = "Service Order No." = field("No.");
                    RunPageView = sorting("Service Order No.", "Posting Date", "Document No.");
                }
            }
        }
    }
    */
}