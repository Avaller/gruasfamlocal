/// <summary>
/// PageExtension Posted Sales Invoice_LDR (ID 50036) extends Record Posted Sales Invoice.
/// </summary>
pageextension 50036 "Posted Sales Invoice_LDR" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Bill-to Contact")
        {
            field("Your Reference_LDR"; Rec."Your Reference")
            {
                ApplicationArea = All;
                Caption = 'Tu referencia';
                ToolTip = 'Tu referencia';
            }
        }
        addafter("EU 3-Party Trade")
        {
            field("Language Code"; Rec."Language Code")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Lenguaje';
                ToolTip = 'Codigo de Lenguaje';
            }
            group("PDF Mail")
            {
                Caption = 'PDF Mail';
            }
            field("Send Document By Mail_LDR"; Rec."Send Document By Mail_LDR")
            {
                ApplicationArea = All;
                Caption = 'Enviar documento por correo';
                ToolTip = 'Enviar documento por correo';
            }
            field("Mail Status_LDR"; Rec."Mail Status_LDR")
            {
                ApplicationArea = All;
                Caption = 'Estado del correo';
                ToolTip = 'Estado del correo';
            }
            field("E-Mail Destination_LDR"; Rec."E-Mail Destination_LDR")
            {
                ApplicationArea = All;
                Caption = 'Destino de correo electrónico';
                ToolTip = 'Destino de correo electrónico';
            }
        }
    }

    actions
    {
        addafter(ActivityLog)
        {
            group(Print1)
            {
                Caption = 'Imprimir';
                action("&Print")
                {
                    ApplicationArea = All;
                    Caption = 'Imprimir';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        SalesInvHeader := Rec;
                        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                        SalesInvHeader.PrintRecords(true);
                    end;
                }
                action("Print in Microsoft Word")
                {
                    ApplicationArea = All;
                    Caption = 'Imprimir en Microsoft Word';
                    Image = Print;

                    trigger OnAction()
                    var
                        //InformeWord: Report 70070; //TODO: No encontrado
                        TempSalesInvHeader: Record "Sales Invoice Header";
                    begin
                        TempSalesInvHeader.COPY(Rec);
                        TempSalesInvHeader.SETRECFILTER;
                        //InformeWord.SETTABLEVIEW(TempSalesInvHeader);
                        //InformeWord.RUN;
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}