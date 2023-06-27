pageextension 50019 "Purchase Order" extends "Purchase Order"
{
    layout
    {
        addafter("Vendor Shipment No.")
        {
            field("Receiving No. Series"; Rec."Receiving No. Series")
            {
                ApplicationArea = All;
                Caption = 'Número de recepción Serie';
                ToolTip = 'Número de recepción Serie';
            }
        }
        addafter("Responsibility Center")
        {
            field("Shortcut Dimension 1 Code_LDR"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Código de dimensión 1 de acceso directo';
                ToolTip = 'Código de dimensión 1 de acceso directo';
            }
            field("Shortcut Dimension 2 Code_LDR"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
                Caption = 'Código de dimensión 2 de acceso directo';
                ToolTip = 'Código de dimensión 2 de acceso directo';
            }
        }
        addafter("Currency Code")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Machine Purchase Document_LDR"; Rec."Machine Purchase Document_LDR")
            {
                ApplicationArea = All;
                Caption = 'Documento de compra de la máquina';
                ToolTip = 'Documento de compra de la máquina';
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                Caption = 'Número de contabilización Serie';
                ToolTip = 'Número de contabilización Serie';
            }
        }
        addafter("Ship-to Code")
        {
            field(Notas1_LDR; Rec.Notas1_LDR)
            {
                ApplicationArea = All;
                Caption = 'Notas';
                ToolTip = 'Notas';
            }
        }
        addafter("Vendor Cr. Memo No.")
        {
            group("AS5400 Integration")
            {
                Caption = 'Integraci¢n AS400';
                field("Sended to AS400_LDR"; Rec."Sended to AS400_LDR")
                {
                    ApplicationArea = All;
                    Caption = 'Enviado a AS400';
                    ToolTip = 'Enviado a AS400';
                }
                field(Resupply_LDR; Rec.Resupply_LDR)
                {
                    ApplicationArea = All;
                    Caption = 'Reabastecimiento';
                    ToolTip = 'Reabastecimiento';
                }
            }
        }
    }

    actions
    {
        addafter(SendCustom)
        {
            action("Enviar a AS400")
            {
                ApplicationArea = All;
                Caption = 'Enviar a AS400';

                trigger OnAction()
                var
                    recPurchHeader: Record "Purchase Header";
                //reportAs400: Report 70008;
                begin
                    recPurchHeader.COPY(Rec);
                    recPurchHeader.SETRECFILTER();
                end;
            }
            Separator(Separator1)
            {

            }
            group("Print Labels")
            {
                Caption = 'Imprimir Etiquetado';
                Image = BarCode;
                action("Imprimir Intermec")
                {
                    ApplicationArea = All;
                    Caption = 'Imprimir Intermec';
                    Image = BarCode;

                    trigger OnAction()
                    var
                        RecPedido: Record "Purchase Header";
                    begin
                        Clear(RecPedido);
                        RecPedido.SetRange("Document Type", Rec."Document Type"::Order);
                        RecPedido.SetRange("No.", Rec."No.");
                        if RecPedido.FindFirst() then begin
                            Report.RunModal(Report::Report7122018, true, false, RecPedido);
                        end;
                    end;
                }
                action("Imprimir Etiquetas")
                {
                    ApplicationArea = All;
                    Caption = 'Imprimir Etiquetas EAN13';
                    Image = BarCode;

                    trigger OnAction()
                    var
                        RecPedido: Record "Purchase Header";
                        reportSelection: Record "Report Selections Labels_LDR";
                    begin
                        CLEAR(RecPedido);
                        RecPedido.SETRANGE("Document Type", Rec."Document Type"::Order);
                        RecPedido.SETRANGE("No.", Rec."No.");
                        IF RecPedido.FINDSET THEN BEGIN
                            reportSelection.SETRANGE(Usage, reportSelection.Usage::"Purchase Order");
                            reportSelection.FINDSET;
                            REPEAT
                                REPORT.RUNMODAL(reportSelection."Report ID", TRUE, FALSE, RecPedido);
                            UNTIL reportSelection.NEXT = 0;
                        end;
                    end;
                }
            }
        }
    }

    var
        PurchSetup: Record "Purchases & Payables Setup";
        Text003: Label 'Hay lineas con Coste Unitario a 0. Desea continuar con el registro?';
        Text004: Label 'Proceso interrumpido para respetar el aviso.';
}