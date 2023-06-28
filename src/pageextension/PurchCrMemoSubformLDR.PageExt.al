/// <summary>
/// PageExtension Purch. Cr. Memo Subform (ID 50030) extends Record Purch. Cr. Memo Subform.
/// </summary>
pageextension 50030 "Purch. Cr. Memo Subform" extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("IC Partner Ref. Type")
        {
            field(Warranty_LDR; Rec.Warranty_LDR)
            {
                ApplicationArea = All;
                Caption = 'Garantia';
                ToolTip = 'Garantia';
            }
            field("Service Item No._LDR"; Rec."Service Item No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de artículo de servicio';
                ToolTip = 'Número de artículo de servicio';
            }
        }
        addafter("IC Partner Reference")
        {
            field("Warranty Service Code_LDR"; Rec."Warranty Service Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Código de servicio de garantía';
                ToolTip = 'Código de servicio de garantía';
            }
        }
        addafter("Allow Item Charge Assignment")
        {
            field("Vendor Contract No._LDR"; Rec."Vendor Contract No._LDR")
            {
                ApplicationArea = All;
                Caption = 'N.° de contrato de proveedor';
                ToolTip = 'N.° de contrato de proveedor';
            }
            field("Service Contract No._LDR"; Rec."Service Contract No._LDR")
            {
                ApplicationArea = All;
                Caption = 'No. Contrato de Servicio';
                ToolTip = 'No. Contrato de Servicio';
            }
            field("Service Contract Line No._LDR"; Rec."Service Contract Line No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de línea del contrato de servicio';
                ToolTip = 'Número de línea del contrato de servicio';
            }
        }
    }

    procedure GetWarrantyServiceOrder()
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        PurchSetup.GET;
        PurchSetup.TESTFIELD(PurchSetup."Warranty Mgt. Type_LDR", PurchSetup."Warranty Mgt. Type_LDR"::Compra);
    end;

    var
        myInt: Integer;
}