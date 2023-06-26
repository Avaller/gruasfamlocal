pageextension 50014 "Sales Order" extends "Sales Order"
{
    layout
    {
        addafter("Ship-to Contact")
        {
            field("Shipping No. Series"; Rec."Shipping No. Series")
            {
                ApplicationArea = All;
                Caption = 'Número de envío Serie';
                ToolTip = 'Número de envío Serie';
            }
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                Caption = 'Nº de publicación';
                ToolTip = 'Nº de publicación';
            }
        }
        addafter("Bill-to Contact")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                Caption = 'Número de contabilización Serie';
                ToolTip = 'Número de contabilización Serie';
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
        addafter("Prepmt. Pmt. Discount Date")
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
    }
}