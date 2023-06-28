pageextension 50021 "Purchase Credit Memo_LDR" extends "Purchase Credit Memo"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("Vendor Contract No._LDR"; Rec."Vendor Contract No._LDR")
            {
                ApplicationArea = All;
                Caption = 'N.° de contrato de proveedor';
                ToolTip = 'N.° de contrato de proveedor';
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
        }
        addafter("Pay-to Contact")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                Caption = 'Número de contabilización Serie';
                ToolTip = 'Número de contabilización Serie';
            }
        }
    }

    actions
    {
        addafter(GetPostedDocumentLinesToReverse)
        {
            separator(Separator1)
            {

            }
            action(GetWaranty)
            {
                ApplicationArea = All;
                Caption = 'Traer Garantia';

                trigger OnAction()
                begin
                    CurrPage.PurchLines.Page.GetWarrantyServiceOrder;
                end;
            }
            separator(Separator2)
            {

            }
        }
    }

    var
        [InDataSet]
        Tax1Editable: Boolean;
        [InDataSet]
        Tax2Editable: Boolean;
        [InDataSet]
        Tax3Editable: Boolean;
        [InDataSet]
        Tax4Editable: Boolean;
}