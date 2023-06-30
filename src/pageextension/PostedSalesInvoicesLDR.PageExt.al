/// <summary>
/// PageExtension Posted Sales Invoices_LDR (ID 50046) extends Record Posted Sales Invoices.
/// </summary>
pageextension 50046 "Posted Sales Invoices_LDR" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("External Document No._LDR"; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'No. Documento externo';
                ToolTip = 'No. Documento externo';
            }
            field("Payment Terms Code_LDR"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
                Caption = 'Código de condiciones de pago';
                ToolTip = 'Código de condiciones de pago';
                Visible = false;
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Código de método de pago';
                ToolTip = 'Código de método de pago';
            }
        }
        addafter("Shipment Date")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                Caption = 'Tu Referencia';
                ToolTip = 'Tu Referencia';
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
        addafter(SendCustom)
        {
            action(PDFGenerate)
            {
                ApplicationArea = All;
                Caption = 'Generar PDF';
                Promoted = true;
                PromotedIsBig = true;
                Image = PrintReport;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                    //DoctoPDF: Codeunit 70045; //TODO: CoseUnit 70045 no encontrada
                    RecID: RecordId;
                    txtGeneratedPDF: Label 'Se han generado %1 Facturas';
                begin
                    Clear(SalesInvHeader);
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    if SalesInvHeader.FindSet() then
                        repeat
                            RecID := SalesInvHeader.RecordId;
                        //DoctoPDF.CreatePDF(RecID.TableNo, SalesInvHeader."No.");
                        until SalesInvHeader.Next() = 0;
                    Message(txtGeneratedPDF, SalesInvHeader.Count);
                end;
            }
        }
    }

    var
        myInt: Integer;
}