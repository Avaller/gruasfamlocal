page 50051 "Crate Quote Op. Lines"
{
    /*DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Crane Serv Q. Forf Calend_LDR";
    SourceTableView = sorting("Quote No.", "Quote Op. Line No.", "Line No.");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MARK; MARK)
                {
                }
                field("Quote No."; "Quote No.")
                {
                    StyleExpr = StyleText;
                }
                field("Line No."; "Line No.")
                {
                    StyleExpr = StyleText;
                }
                field("Operation No."; "Operation No.")
                {
                    StyleExpr = StyleText;
                }
                field("Operation Description"; "Operation Description")
                {
                    StyleExpr = StyleText;
                }
                field(Amount; Amount)
                {
                    StyleExpr = StyleText;
                }
                field(Processed; Processed)
                {
                    StyleExpr = StyleText;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Mark)
            {
                Caption = 'Mark';
                Image = SelectLineToApply;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //CLEARMARKS;

                    IF Processed THEN
                        IF NOT CONFIRM(Text001) THEN
                            ERROR('');

                    MARK(NOT MARK);
                end;
            }
            action("Marked Only")
            {
                Caption = 'Marked Only';
                Image = ShowSelected;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    MARKEDONLY(NOT MARKEDONLY)
                end;
            }
            action("Clear Marks")
            {
                Caption = 'Clear Marks';
                Image = RemoveFilterLines;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CLEARMARKS;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyle;
    end;

    trigger OnQueryClosePage(CloseAction: Action): BoolEAN
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush;
    end;

    var
        StyleText: Text;
        gServHeader: Record "5900";
        Text001: Label 'You have choosed a Forfait Invoice Calendar Detail that has been already invoiced. Are you sure you want to proceed?';

    local procedure SetStyle()
    begin
        //////
        StyleText := 'Standard';


        IF Processed THEN
            StyleText := 'StrongAccent';
    end;

    local procedure LookupOKOnPush()
    var
        ServiceOrderMgt: Codeunit "50004";
    begin


        MARKEDONLY(TRUE);

        MESSAGE(FORMAT(COUNT));
        IF FINDSET THEN BEGIN
            REPEAT
                ServiceOrderMgt.AddForfaitConceptLine(gServHeader."No.", Rec);
                Processed := TRUE;
                MODIFY(FALSE);
            UNTIL NEXT = 0;
        END ELSE
            ERROR('');
    end; */

    procedure SetParams(pServHeader: Record "Service Header")
    begin
        //gServHeader := pServHeader;
    end;
}