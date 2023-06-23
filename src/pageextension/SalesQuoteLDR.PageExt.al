pageextension 50013 "Sales Quote" extends "Sales Quote"
{
    layout
    {
        addafter("Area")
        {
            group("PDF Mail")
            {
                Caption = 'PDF Mail';
                field("Send Document By Mail"; Rec."Send Document By Mail")
                {
                    ApplicationArea = All;
                    Caption = 'Enviar Documento por E-Mail';
                    ToolTip = 'Enviar Documento por E-Mail';
                }
                field("E-Mail Destination"; Rec."E-Mail Destination")
                {
                    ApplicationArea = All;
                    Caption = 'Destino del E-Mail';
                    ToolTip = 'Destino del E-Mail';
                }
            }
        }
    }
}