pageextension 50015 "Sales Invoice_LDR" extends "Sales Invoice"
{
    layout
    {
        addafter("Posting No.")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                Caption = 'Número de contabilización Serie';
                ToolTip = 'Número de contabilización Serie';
            }
            field("VAT Registration No._LDR"; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
        }
        addafter("Area")
        {
            group("PDF Mail")
            {
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