pageextension 50034 "Posted Sales Shipment_LDR" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Cust. Bank Acc. Code")
        {
            field("Language Code"; Rec."Language Code")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Lengaje';
                ToolTip = 'Codigo de Lengaje';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                Caption = 'Tu referencia';
                ToolTip = 'Tu referencia';
            }
        }
    }

    actions
    {
        addafter("&Track Package")
        {
            group(Print)
            {
                Caption = 'Imprimir';
                action("Print Shipment")
                {
                    ApplicationArea = All;
                    Ellipsis = true;
                    Caption = 'Imprimir Albaran';
                    Promoted = true;

                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(SalesShptHeader);
                        SalesShptHeader.PrintRecords(true);
                    end;
                }
                action("Print Valued Shipment")
                {
                    ApplicationArea = All;
                    Caption = 'Imprimir Albaran Valorado';
                    Promoted = true;
                    Image = Print;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                        SalesShptHeader.PrintRecordsValued(TRUE);
                    end;
                }
            }
        }
    }
}