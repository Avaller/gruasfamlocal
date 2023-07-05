pageextension 50126 "Service Credit Memo" extends "Service Credit Memo"
{
    layout
    {
        addafter("Corrected Invoice No.")
        {
            field("External Document No._LDR"; Rec."External Document No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No de Documento externo';
                ToolTip = 'No de Documento externo';
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                Caption = 'Número de contabilización Serie';
                ToolTip = 'Número de contabilización Serie';
            }
            field("Crane Service Quote No._LDR"; Rec."Crane Service Quote No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No. de cotización de servicio de grúa';
                ToolTip = 'No. de cotización de servicio de grúa';
            }
        }
        addafter("Pmt. Discount Date")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                Caption = 'Nº de publicación';
                ToolTip = 'Nº de publicación';
            }
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;
                Caption = 'Descripción de la publicación';
                ToolTip = 'Descripción de la publicación';
            }
        }
        addafter("Cust. Bank Acc. Code")
        {
            field("Send Document By Mail_LDR"; Rec."Send Document By Mail_LDR")
            {
                ApplicationArea = All;
                Caption = 'Enviar documento por correo';
                ToolTip = 'Enviar documento por correo';
            }
            field("E-Mail Destination_LDR"; Rec."E-Mail Destination_LDR")
            {
                ApplicationArea = All;
                Caption = 'Destino de correo electrónico';
                ToolTip = 'Destino de correo electrónico';
            }
            group("PDF Mail")
            {
                Caption = 'PDF Mail';
            }
        }
    }

    actions
    {
        addafter(Dimensions)
        {
            action(Unlock)
            {
                ApplicationArea = All;
                Caption = 'Desbloquear';
                Image = Open;

                trigger OnAction()
                begin

                end;
            }
        }
        addafter("Get Prepaid Contract E&ntries")
        {
            separator("")
            {

            }
            action(CopyLines)
            {
                ApplicationArea = All;
                Caption = 'Copiar Lineas';
                Image = ChangeToLines;

                trigger OnAction()
                begin
                    CopyServInvoice;
                end;
            }
        }
    }

    procedure CopyServInvoice()
    var
        CopyServInv: Report "Copy Posted Serv. Inv. Lines"; //TODO: Crear Report
    begin
        Clear(CopyServInv);
        CopyServInv.SetServHeader(Rec);
        CopyServInv.RunModal;
    end;
}