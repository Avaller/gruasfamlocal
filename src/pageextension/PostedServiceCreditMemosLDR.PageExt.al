/// <summary>
/// PageExtension PostedServiceCreditMemos_LDR (ID 50135) extends Record Posted Service Credit Memos.
/// </summary>
pageextension 50135 "PostedServiceCreditMemos_LDR" extends "Posted Service Credit Memos"
{
    layout
    {
        addafter(Name)
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Metodo de Pago';
                ToolTip = 'Codigo de Metodo de Pago';
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
                Caption = 'Importe';
                ToolTip = 'Importe';
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
                Caption = 'Importe IVA incluido';
                ToolTip = 'Importe IVA incluido';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
                Caption = 'Código de condiciones de pago';
                ToolTip = 'Código de condiciones de pago';
            }
            field("External Document No._LDR"; Rec."External Document No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No de Documento externo';
                ToolTip = 'No de Documento externo';
            }
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de vencimiento';
                ToolTip = 'Fecha de vencimiento';
            }
            field("No. Printed"; Rec."No. Printed")
            {
                ApplicationArea = All;
                Caption = 'No. de Impreso';
                ToolTip = 'No. de Impreso';
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                Caption = 'Tu referencia';
                ToolTip = 'Tu referencia';
            }
        }
        addafter("Document Exchange Status")
        {
            field("Send Document By Mail_LDR"; Rec."Send Document By Mail_LDR")
            {
                DataClassification = ToBeClassified;
            }
            field("Mail Status_LDR"; Rec."Mail Status_LDR")
            {
                DataClassification = ToBeClassified;
            }
            field(id; Rec.Ema)
            {
                DataClassification = ToBeClassified;
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
                Caption = 'Generar PDF';
                Image = PrintReport;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    SeviceCrMemoHeader: Record "Service Cr.Memo Header";
                    //DoctoPDF: Codeunit 7122044;
                    RecID: RecordID;
                    txtGeneratedPDF: Label 'Se han generado %1 Abonos';
                begin
                    CLEAR(SeviceCrMemoHeader);
                    SeviceCrMemoHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SeviceCrMemoHeader);
                    IF SeviceCrMemoHeader.FINDSET THEN
                        REPEAT
                            RecID := SeviceCrMemoHeader.RECORDID;
                        //DoctoPDF.CreatePDF(RecID.TABLENO, SeviceCrMemoHeader."No.");
                        UNTIL SeviceCrMemoHeader.NEXT = 0;

                    MESSAGE(txtGeneratedPDF, SeviceCrMemoHeader.COUNT);
                end;
            }
        }
    }

    var
        myInt: Integer;
}