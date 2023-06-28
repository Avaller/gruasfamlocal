pageextension 50037 "Posted Sales Credit Memo_LDR" extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("EU 3-Party Trade")
        {
            group("PDF Mail")
            {
                Caption = 'PDF Mail';
                field("E-Mail Destination_LDR"; Rec."E-Mail Destination_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Destino de correo electrónico';
                    ToolTip = 'Destino de correo electrónico';
                }
                field("Mail Status_LDR"; Rec."Mail Status_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Estado del correo';
                    DrillDown = false;
                    Lookup = false;
                    ToolTip = 'Estado del correo';
                }
                field("Send Document By Mail_LDR"; Rec."Send Document By Mail_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Enviar documento por correo';
                    ToolTip = 'Enviar documento por correo';
                }
            }
        }
    }

    actions
    {
        addafter(SendCustom)
        {
            group("&Print")
            {
                Caption = '&Imprimir';
            }
        }
        addafter(Print)
        {
            action("Print in Microsoft Word")
            {
                ApplicationArea = All;
                Caption = 'Imprimir en Microsoft Word';
                Image = PrintDocument;

                trigger OnAction()
                var
                    //InformeWord: Report 70071;//TODO: Reporte 70071 no encontrado
                    TempSalesCrMemoHeader: Record "Sales Cr.Memo Header";
                begin
                    TempSalesCrMemoHeader.Copy(Rec);
                    TempSalesCrMemoHeader.SetRecFilter();
                    //InformeWord.SetTableView(TempSalesCrMemoHeader);
                    //InformeWord.Run();
                end;
            }
        }
    }
}