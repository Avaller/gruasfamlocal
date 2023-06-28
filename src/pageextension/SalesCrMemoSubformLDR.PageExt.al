pageextension 50029 "Sales Cr. Memo Subform" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter("IC Partner Code")
        {
            field("Gen. Prod. Posting Group_LDR"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Prod. gen. Grupo de contabilización';
                ToolTip = 'Prod. gen. Grupo de contabilización';
            }
        }
    }

    /// <summary>
    /// GetWarrantyServiceOrder.
    /// </summary>
    procedure GetWarrantyServiceOrder()
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        PurchSetup.GET;
        PurchSetup.TESTFIELD(PurchSetup."Warranty Mgt. Type_LDR", PurchSetup."Warranty Mgt. Type_LDR"::Venta);
    end;
}