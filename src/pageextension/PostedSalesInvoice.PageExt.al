pageextension 50036 "Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(ActivityLog)
        {
            group(Print1)
            {
                Caption = 'Imprimir';
                action("&Print")
                {
                    ApplicationArea = All;
                    Caption = 'Imprimir';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        SalesInvHeader := Rec;
                        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                        SalesInvHeader.PrintRecords(true);
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}