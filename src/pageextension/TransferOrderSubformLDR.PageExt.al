/// <summary>
/// PageExtension TransferOrderSubform_LDR (ID 50108) extends Record Transfer Order Subform.
/// </summary>
pageextension 50108 "TransferOrderSubform_LDR" extends "Transfer Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Nº EAN labels_LDR"; Rec."Nº EAN labels_LDR")
            {
                ApplicationArea = All;
                Caption = 'Nº Etiquetas EAN';
                ToolTip = 'Nº Etiquetas EAN';
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Prod. gen. Grupo de contabilización';
                ToolTip = 'Prod. gen. Grupo de contabilización';
            }
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo de registro de inventario';
                ToolTip = 'Grupo de registro de inventario';
            }
        }
    }

    actions
    {
        addafter(Receipt)
        {
            action(Labels)
            {
                ApplicationArea = All;
                Caption = 'Etiquetas';
                Image = BarCode;

                trigger OnAction()
                var
                    TransferLine: Record "Transfer Line";
                //ReportSelection: Record 7122074;
                begin
                    TransferLine.Copy(Rec);
                    CurrPage.SetSelectionFilter(TransferLine);
                    //ReportSelection.SetRange(Usage, ReportSelection.Usage::"6");
                    //ReportSelection.findset();
                    //repeat
                    //    Report.RunModal(ReportSelection."Report ID", true, false, TransferLine);
                    //until ReportSelection.Next() = 0;
                end;
            }
        }
    }

    var
        myInt: Integer;
}