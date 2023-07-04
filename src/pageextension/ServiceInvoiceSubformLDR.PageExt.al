pageextension 50125 "Service Invoice Subform" extends "Service Invoice Subform"
{
    layout
    {
        addafter("VAT Prod. Posting Group")
        {
            field("Gen. Prod. Posting Group_LDR"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Prod. gen. Grupo de contabilización';
                ToolTip = 'Prod. gen. Grupo de contabilización';
            }
        }
        addafter(Description)
        {
            field(Grouper_LDR; Rec.Grouper_LDR)
            {
                ApplicationArea = All;
                Caption = 'Agrupador';
                ToolTip = 'Agrupador';
            }
        }
        addafter(Quantity)
        {
            field("Qty. to Ship"; Rec."Qty. to Ship")
            {
                ApplicationArea = All;
                Caption = 'Cant. exportar';
                ToolTip = 'Cant. exportar';
            }
            field("Qty. to Invoice"; Rec."Qty. to Invoice")
            {
                ApplicationArea = All;
                Caption = 'Cant. facturar';
                ToolTip = 'Cant. facturar';
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field(Replicate_LDR; Rec.Replicate_LDR)
            {
                ApplicationArea = All;
                Caption = 'replicar';
                ToolTip = 'replicar';
            }
            field("Replicate Company_LDR"; Rec."Replicate Company_LDR")
            {
                ApplicationArea = All;
                Caption = 'Replicar empresa';
                ToolTip = 'Replicar empresa';
            }
        }
    }

    //
    procedure InsertServItemExtText()
    begin
        InsertServItemExtText;
        UpdateForm(true);
    end;

    //
    procedure OpenQuoteLine()
    begin
        Rec."Opened (Quote)_LDR" := true;
        Rec.Modify(true);
    end;

    //
    procedure GetWarrantyServiceOrder()
    var
        //ReportGetWarranty: Page 7122060;//TODO: No encontrada
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        PurchSetup.GET;
        PurchSetup.TESTFIELD(PurchSetup."Warranty Mgt. Type_LDR", PurchSetup."Warranty Mgt. Type_LDR"::Venta);
        //CLEAR(ReportGetWarranty);
        //ReportGetWarranty.SetCurrentServLine(Rec);
        //ReportGetWarranty.LOOKUPMODE(TRUE);
        //ReportGetWarranty.RUNMODAL;
    end;

    var
        myInt: Integer;
}