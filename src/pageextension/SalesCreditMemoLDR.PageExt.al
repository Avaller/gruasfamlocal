pageextension 50016 "Sales Credit Memo" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Corrected Invoice No.")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                Caption = 'Número de contabilización Serie';
                ToolTip = 'Número de contabilización Serie';
            }
        }
        addafter("Applies-to ID")
        {
            group("PDF Mail")
            {
                Caption = 'PDF Mail';
                field("Send Document By Mail"; Rec."Send Document By Mail_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Enviar documento por correo';
                    ToolTip = 'Enviar documento por correo';
                }
                field("E-Mail Destination"; Rec."E-Mail Destination_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Destino de correo electrónico';
                    ToolTip = 'Destino de correo electrónico';
                }
            }
        }
        addafter("Shipment Date")
        {
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
                Caption = 'Código de agente de envío';
                ToolTip = 'Código de agente de envío';
            }
        }
        addafter("Bill-to Contact")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                Caption = 'Nº de publicación';
                ToolTip = 'Nº de publicación';
            }
        }
        addafter("Area")
        {
            field("VAT Registration No._LDR"; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("Posting No. Series_LDR"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                Caption = 'Número de contabilización Serie';
                ToolTip = 'Número de contabilización Serie';
            }
            field("Payment Method Code_LDR"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Código de método de pago';
                ToolTip = 'Código de método de pago';
            }
            field("Payment Terms Code_LDR"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
                Caption = 'Código de condiciones de pago';
                ToolTip = 'Código de condiciones de pago';
            }
            field(Amount_LDR; Rec.Amount)
            {
                ApplicationArea = All;
                Caption = 'Cantidad';
                ToolTip = 'Cantidad';
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
                Caption = 'Importe IVA incluido';
                ToolTip = 'Importe IVA incluido';
            }
        }
    }

    actions
    {
        addafter("Preview Posting")
        {
            action(GetWaranty)
            {
                ApplicationArea = All;
                Caption = 'Traer Garantia';

                trigger OnAction()
                begin
                    //CurrPage.SalesLines.Page.GetWarrantyServiceOrder();
                end;
            }
            separator(Separator)
            { }
        }
    }
}