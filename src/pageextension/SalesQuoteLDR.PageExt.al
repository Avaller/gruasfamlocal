pageextension 50013 "Sales Quote_LDR" extends "Sales Quote"
{
    layout
    {
        addafter("Area")
        {
            group("PDF Mail")
            {
                Caption = 'PDF Mail';
                field("Send Document By Mail"; Rec."Send Document By Mail_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Enviar Documento por E-Mail';
                    ToolTip = 'Enviar Documento por E-Mail';
                }
                field("E-Mail Destination"; Rec."E-Mail Destination_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Destino del E-Mail';
                    ToolTip = 'Destino del E-Mail';
                }
            }
        }
    }
}