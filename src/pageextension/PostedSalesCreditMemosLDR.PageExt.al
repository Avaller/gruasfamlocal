pageextension 50047 "Posted Sales Credit Memos_LDR" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Document Date")
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Metodo de Pago';
                ToolTip = 'Codigo de Metodo de Pago';
            }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'No de Documento Externo';
                ToolTip = 'No de Documento Externo';
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                Caption = 'Tu Referencia';
                ToolTip = 'Tu Referencia';
            }
            field("Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Terminos de Pago';
                ToolTip = 'Codigo de Terminos de Pago';
            }
        }
        addafter("Document Exchange Status")
        {
            field("Send Document By Mail_LDR"; Rec."Send Document By Mail_LDR")
            {
                ApplicationArea = All;
                Caption = 'Enviar documento por correo';
                Editable = false;
                ToolTip = 'Enviar documento por correo';
            }
            field("Mail Status_LDR"; Rec."Mail Status_LDR")
            {
                ApplicationArea = All;
                Caption = 'Estado del correo';
                Editable = false;
                ToolTip = 'Estado del correo';
            }
            field("E-Mail Destination_LDR"; Rec."E-Mail Destination_LDR")
            {
                ApplicationArea = All;
                Caption = 'Destino de correo electrónico';
                Editable = false;
                ToolTip = 'Destino de correo electrónico';
            }
        }
    }

    actions
    {
        addafter(SendCustom)
        {
            action(PDFGenerate)
            {
                ApplicationArea = All;
                Ellipsis = true;
                Caption = 'Generar PDF';
                Promoted = true;
                PromotedIsBig = true;
                Image = PrintReport;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                    //DoctoPdf: Codeunit 70045; //TODO: Codeunit no encontrada
                    RecID: RecordId;
                    txtGeneratedPDF: Label '=Se han generado %1 Abonos.';
                begin
                    CLEAR(SalesCrMemoHeader);
                    SalesCrMemoHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
                    IF SalesCrMemoHeader.FINDSET THEN
                        REPEAT
                            RecID := SalesCrMemoHeader.RECORDID;
                        //DoctoPDF.CreatePDF(RecID.TABLENO, SalesCrMemoHeader."No.");
                        UNTIL SalesCrMemoHeader.NEXT = 0;

                    MESSAGE(txtGeneratedPDF, SalesCrMemoHeader.COUNT);
                end;
            }
        }
    }

}