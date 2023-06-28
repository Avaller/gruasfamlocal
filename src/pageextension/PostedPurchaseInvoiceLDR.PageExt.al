pageextension 50041 "Posted Purchase Invoice_LDR" extends "Posted Purchase Invoice"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Vendor Contract No._LDR"; Rec."Vendor Contract No._LDR")
            {
                ApplicationArea = All;
                Caption = 'N.° de contrato de proveedor';
                ToolTip = 'N.° de contrato de proveedor';
            }
        }
        addafter("Autoinvoice No.")
        {
            field("Expected Receipt Date_LDR"; Rec."Expected Receipt Date")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Fecha de recepción esperada';
                Editable = false;
                Importance = Promoted;
                ToolTip = 'Fecha de recepción esperada';
            }
        }
    }
}