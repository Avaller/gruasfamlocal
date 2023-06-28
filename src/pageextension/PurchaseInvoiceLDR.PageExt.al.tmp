pageextension 50020 "Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
        }
        addafter("Vendor Invoice No.")
        {
            field("Vendor Order No._LDR"; Rec."Vendor Order No.")
            {
                ApplicationArea = All;
                Caption = 'Número de pedido del proveedor';
                ToolTip = 'Número de pedido del proveedor';
            }
            field("Vendor Contract No._LDR"; Rec."Vendor Contract No._LDR")
            {
                ApplicationArea = All;
                Caption = 'N.° de contrato de proveedor';
                ToolTip = 'N.° de contrato de proveedor';
            }
        }
        addafter(Status)
        {
            field(Forecast_LDR; Rec.Forecast_LDR)
            {
                ApplicationArea = All;
                Caption = 'Pronóstico';
                ToolTip = 'Pronóstico';
            }
        }
        addafter("Vendor Bank Acc. Code")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                Caption = 'Nº de publicación';
                ToolTip = 'Nº de publicación';
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
        addafter(RemoveFromJobQueue)
        {
            separator(Separator1)
            {

            }
            action(GetWarranty)
            {
                ApplicationArea = All;
                Caption = 'Traer Garantia';

                trigger OnAction()
                begin
                    CurrPage.PurchLines.Page.GetWarrantyServiceOrder;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        Rec.SetForecast(Rec."Pay-to Vendor No.");
        CurrPage.PurchLines.PAGE.SetForecastVendor(Rec."Pay-to Vendor No.", Forecast, Rec."No.");

    end;

    var
        Tax1Editable: Boolean INDATASET;
        Tax2Editable: Boolean INDATASET;
        Tax3Editable: Boolean INDATASET;
        Tax4Editable: Boolean INDATASET;
        PurchLines: Page "Purchase Lines";
}