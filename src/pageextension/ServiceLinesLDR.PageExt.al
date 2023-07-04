/// <summary>
/// PageExtension Service Lines_LDR (ID 50116) extends Record Service Lines.
/// </summary>
pageextension 50116 "Service Lines_LDR" extends "Service Lines"
{
    layout
    {
        addafter("Substitution Available")
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
                Caption = 'No de Documento';
                ToolTip = 'No de Documento';
            }
        }
        addafter("Bin Code")
        {
            field("Initial Time_LDR"; Rec."Initial Time_LDR")
            {
                ApplicationArea = All;
                Caption = 'Tiempo inicial';
                ToolTip = 'Tiempo inicial';
            }
            field("End Time_LDR"; Rec."End Time_LDR")
            {
                ApplicationArea = All;
                Caption = 'Hora de finalización';
                ToolTip = 'Hora de finalización';
            }
        }
        addafter(Control134)
        {
            field("Internal Quantity_LDR"; Rec."Internal Quantity_LDR")
            {
                ApplicationArea = All;
                Caption = 'Cantidad interna';
                ToolTip = 'Cantidad interna';
            }
        }
        addafter(Quantity)
        {
            field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
            {
                ApplicationArea = All;
                Caption = 'Cant. a Factura (Base)';
                ToolTip = 'Cant. a Factura (Base)';
            }
        }
        addafter("Reserved Quantity")
        {
            field(Chargeable_LDR; Rec.Chargeable_LDR)
            {
                ApplicationArea = All;
                Caption = 'Cobrable';
                ToolTip = 'Cobrable';
            }
        }
        addafter("Unit of Measure Code")
        {
            field("Invoicing UOM Code_LDR"; Rec."Invoicing UOM Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Código UOM de facturación';
                ToolTip = 'Código UOM de facturación';
            }
        }
        addafter("Line Amount")
        {
            field("Invoice Line Amount_LDR"; Rec."Invoice Line Amount_LDR")
            {
                ApplicationArea = All;
                Caption = 'Importe de línea de factura';
                ToolTip = 'Importe de línea de factura';
            }
        }
        addafter("Line Discount Amount")
        {
            field("Invoice Line Discount Amount_LDR"; Rec."Invoice Line Discount Amount_LDR")
            {
                ApplicationArea = All;
                Caption = 'Importe de descuento de línea de factura';
                ToolTip = 'Importe de descuento de línea de factura';
            }
        }
        addafter("Gen. Prod. Posting Group")
        {
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo de contabilización comercial de IVA';
                ToolTip = 'Grupo de contabilización comercial de IVA';
            }
            field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo de registro de producción de IVA';
                ToolTip = 'Grupo de registro de producción de IVA';
            }
        }
        addafter("ShortcutDimCode[3]")
        {
            field("Modified Date_LDR"; Rec."Modified Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Fecha de modificación';
                ToolTip = 'Fecha de modificación';
            }
            field("Created Date_LDR"; Rec."Created Date_LDR")
            {
                ApplicationArea = All;
                Caption = 'Fecha de creación';
                ToolTip = 'Fecha de creación';
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("Quote No._LDR"; Rec."Quote No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No. Cotización ';
                ToolTip = 'No. Cotización ';
            }
            field("Quote Line No._LDR"; Rec."Quote Line No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No. Línea de cotización';
                ToolTip = 'No. Línea de cotización';
            }
            field("Quote Invoice Line No._LDR"; Rec."Quote Invoice Line No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de línea de factura de cotización';
                ToolTip = 'Número de línea de factura de cotización';
            }
            field(Revaluation_LDR; Rec.Revaluation_LDR)
            {
                ApplicationArea = All;
                Caption = 'Revalorización';
                ToolTip = 'Revalorización';
            }
            field("Item Entry No._LDR"; Rec."Item Entry No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de entrada de artículo';
                ToolTip = 'Número de entrada de artículo';
            }
            field(Reclasified_LDR; Rec.Reclasified_LDR)
            {
                ApplicationArea = All;
                Caption = 'Reclasificado';
                ToolTip = 'Reclasificado';
            }
        }
    }

    actions
    {
        addafter("Order &Promising")
        {
            separator(Separator1)
            {

            }
            action(Unlock)
            {
                ApplicationArea = All;
                Caption = 'Desbloquear';
                Image = Open;

                trigger OnAction()
                begin
                    Rec."Opened (Quote)_LDR" := TRUE;
                    Rec.MODIFY(TRUE);
                end;
            }
        }
        addafter("Undo Price Adjustment")
        {
            action(ChangeLoc)
            {
                ApplicationArea = All;
                Caption = 'Cambiar Almacen';
                Image = ItemAvailbyLoc;

                trigger OnAction()
                var
                    TempServLine: Record "Service Line";
                //frmConfirm: Page 7122204;
                begin
                    CurrPage.SETSELECTIONFILTER(TempServLine);
                    IF TempServLine.COUNT > 0 THEN BEGIN
                        //CLEAR(frmConfirm);
                        //frmConfirm.SETTABLEVIEW(TempServLine);
                        //frmConfirm.LOOKUPMODE(TRUE);
                        //frmConfirm.RUNMODAL;
                    END;
                end;
            }
        }
        addafter(Preview)
        {
            action(CalcPriceDistDur)
            {
                ApplicationArea = All;
                Caption = 'Calcular precio / distancia / duraci¢n';
                Image = CalculateCost;

                trigger OnAction()
                begin
                    ServMgtSetup.GET;
                    IF ServMgtSetup."Price/Km Advanced Calc_LDR" THEN
                        Rec.CalcPriceDistanceDuration
                    ELSE
                        Rec.CalcDistanceDuration;
                end;
            }
            separator("")
            {

            }
        }
    }

    var
        AddExtendedText: Boolean;
        ServMgtSetup: Record "Service Mgt. Setup";
}