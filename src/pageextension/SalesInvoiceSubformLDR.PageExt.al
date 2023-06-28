pageextension 50018 "Sales Invoice Subform_LDR" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("IC Partner Reference")
        {
            field("Posting Group"; Rec."Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo de contabilización';
                ToolTip = 'Grupo de contabilización';
            }
            field("Gen. Bus. Posting Group_LDR"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo registro neg. gen.';
                ToolTip = 'Grupo registro neg. gen.';
            }
            field("VAT Calculation Type"; Rec."VAT Calculation Type")
            {
                ApplicationArea = All;
                Caption = 'Tipo de cálculo de IVA';
                ToolTip = 'Tipo de cálculo de IVA';
            }
            field("Gen. Prod. Posting Group_LDR"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo registro prod. gen.';
                ToolTip = 'Grupo registro prod. gen.';
            }
            field("VAT Bus. Posting Group_LDR"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Grupo registro IVA neg.';
                ToolTip = 'Grupo registro IVA neg.';
            }
            field("VAT Prod. Posting Group_LDR"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Especifica el grupo de registro de IVA de producto. Vincula las transacciones empresariales realizadas para el producto, el recurso o la cuenta C/G con el fin de contabilizar los importes de IVA que derivan de la comercialización de ese registro.';
                ToolTip = 'Especifica el grupo de registro de IVA de producto. Vincula las transacciones empresariales realizadas para el producto, el recurso o la cuenta C/G con el fin de contabilizar los importes de IVA que derivan de la comercialización de ese registro.';
                Visible = false;
                trigger OnValidate()
                begin
                    DeltaUpdateTotals();
                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    procedure GetWarrantyServiceOrder()
    var
        //ReportGetWarranty: Page 70066;
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        PurchSetup.GET();
        PurchSetup.TestField("Warranty Mgt. Type_LDR", PurchSetup."Warranty Mgt. Type_LDR"::Venta);
    end;

    var
        myInt: Integer;
}