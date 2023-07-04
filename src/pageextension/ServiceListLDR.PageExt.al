/// <summary>
/// PageExtension Service List_LDR (ID 50112) extends Record Service List.
/// </summary>
pageextension 50112 "Service List_LDR" extends "Service List"
{
    layout
    {
        addafter("Order Date")
        {
            field("No. Printed"; Rec."No. Printed")
            {
                ApplicationArea = All;
                Caption = 'No. Impreso';
                ToolTip = 'No. Impreso';
            }
            field("Review Template No._LDR"; Rec."Review Template No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No. de Plantilla de revisión';
                ToolTip = 'No. de Plantilla de revisión';
            }
            field("Review No._LDR"; Rec."Review No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No. de Review';
                ToolTip = 'No. de Review';
            }
            field("Source Type_LDR"; Rec."Source Type_LDR")
            {
                ApplicationArea = All;
                Caption = 'Tipo de Fuente';
                ToolTip = 'Tipo de Fuente';
            }
            field("Internal Contract No._LDR"; Rec."Internal Contract No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No. de Contrato Interno';
                ToolTip = 'No. de Contrato Interno';
            }
            field("Default Work Type Code_LDR"; Rec."Default Work Type Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Código de tipo de trabajo predeterminado';
                ToolTip = 'Código de tipo de trabajo predeterminado';
            }
            field("Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
                Caption = 'Código de condiciones de pago';
                ToolTip = 'Código de condiciones de pago';
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Código de método de pago';
                ToolTip = 'Código de método de pago';
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                Caption = 'Número de contabilización Serie';
                ToolTip = 'Número de contabilización Serie';
            }
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                Caption = 'Nº de publicación';
                ToolTip = 'Nº de publicación';
            }
            field("Quote No."; Rec."Quote No.")
            {
                ApplicationArea = All;
                Caption = 'No. de Cotización';
                ToolTip = 'No. de Cotización';
            }
            field("No. of Allocations"; Rec."No. of Allocations")
            {
                ApplicationArea = All;
                Caption = 'Nº de asignaciones';
                ToolTip = 'Nº de asignaciones';
            }
            field("Expected Finishing Date"; Rec."Expected Finishing Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de finalización prevista';
                ToolTip = 'Fecha de finalización prevista';
            }
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
                Caption = 'Centro de responsabilidad';
                ToolTip = 'Centro de responsabilidad';
            }
            field("VAT Country/Region Code"; Rec."VAT Country/Region Code")
            {
                ApplicationArea = All;
                Caption = 'Código de país/región de IVA';
                ToolTip = 'Código de país/región de IVA';
            }
            field("VAT Country/Region Code2"; Rec."VAT Country/Region Code")
            {
                ApplicationArea = All;
                Caption = 'Código de país/región de IVA 2';
                ToolTip = 'Código de país/región de IVA 2';
            }
            field("Ship-to Post Code"; Rec."Ship-to Post Code")
            {
                ApplicationArea = All;
                Caption = 'Código postal de envío';
                ToolTip = 'Código postal de envío';
            }
            field("Ship-to Name"; Rec."Ship-to Name")
            {
                ApplicationArea = All;
                Caption = 'Enviar a nombre de';
                ToolTip = 'Enviar a nombre de';
            }
            field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
            {
                ApplicationArea = All;
                Caption = 'Código de país/región de envío';
                ToolTip = 'Código de país/región de envío';
            }
            field("Ship-to Country/Region Code2"; Rec."Ship-to Country/Region Code")
            {
                ApplicationArea = All;
                Caption = 'Código de país/región de envío';
                ToolTip = 'Código de país/región de envío';
            }
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
                Caption = 'Código de vendedor';
                ToolTip = 'Código de vendedor';
            }
            field("Warning Status"; Rec."Warning Status")
            {
                ApplicationArea = All;
                Caption = 'Estado de advertencia';
                ToolTip = 'Estado de advertencia';
            }
            field("Finishing Time"; Rec."Finishing Time")
            {
                ApplicationArea = All;
                Caption = 'Hora de finalización';
                ToolTip = 'Hora de finalización';
            }
            field("Finishing Date"; Rec."Finishing Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de finalización';
                ToolTip = 'Fecha de finalización';
            }
            field("Starting Time"; Rec."Starting Time")
            {
                ApplicationArea = All;
                Caption = 'Tiempo de empezar';
                ToolTip = 'Tiempo de empezar';
            }
            field("Starting Date"; Rec."Starting Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de inicio';
                ToolTip = 'Fecha de inicio';
            }
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha del documento';
                ToolTip = 'Fecha del documento';
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de publicación';
                ToolTip = 'Fecha de publicación';
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                Caption = 'Tu referencia';
                ToolTip = 'Tu referencia';
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
                Caption = 'Correo electrónico';
                ToolTip = 'Correo electrónico';
            }
            field("Phone No."; Rec."Phone No.")
            {
                ApplicationArea = All;
                Caption = 'Telefono no.';
                ToolTip = 'Telefono no.';
            }
            field("Post Code"; Rec."Post Code")
            {
                ApplicationArea = All;
                Caption = 'Código postal';
                ToolTip = 'Código postal';
            }
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
                Caption = 'Dirección';
                ToolTip = 'Dirección';
            }
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo de precios del cliente';
                ToolTip = 'Grupo de precios del cliente';
            }
            field("Service Order Type"; Rec."Service Order Type")
            {
                ApplicationArea = All;
                Caption = 'Tipo de orden de servicio';
                ToolTip = 'Tipo de orden de servicio';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Converted to Order_LDR"; Rec."Converted to Order_LDR")
            {
                ApplicationArea = aLL;
                Caption = 'Convertido a la orden';
                ToolTip = 'Convertido a la orden';
            }
            field("Rejected Quote_LDR"; Rec."Rejected Quote_LDR")
            {
                ApplicationArea = All;
                Caption = 'Cotización rechazada';
                ToolTip = 'Cotización rechazada';
            }
        }
    }

    var
        DimMgt: Codeunit DimensionManagement;
}