page 50051 "Crate Quote Op. Lines"
{
    DeleteAllowed = false;
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
                field(MARK_LDR; Rec.MARK)
                {
                    ApplicationArea = All;
                    Caption = '';
                    ToolTip = '';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                    Caption = '';
                    StyleExpr = StyleText;
                    ToolTip = '';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = '';
                    StyleExpr = StyleText;
                    ToolTip = '';
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                    Caption = '';
                    StyleExpr = StyleText;
                    ToolTip = '';
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ApplicationArea = All;
                    Caption = '';
                    StyleExpr = StyleText;
                    ToolTip = '';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = '';
                    StyleExpr = StyleText;
                    ToolTip = '';
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = All;
                    Caption = '';
                    StyleExpr = StyleText;
                    ToolTip = '';
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

                    IF Rec.Processed THEN
                        IF NOT CONFIRM(Text001) THEN
                            ERROR('');

                    Rec.MARK(NOT Rec.MARK);
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
                    Rec.MARKEDONLY(NOT Rec.MARKEDONLY)
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
                    Rec.CLEARMARKS;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyle;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush;
    end;

    var
        StyleText: Text;
        gServHeader: Record "Service Header";
        Text001: Label 'You have choosed a Forfait Invoice Calendar Detail that has been already invoiced. Are you sure you want to proceed?';

    local procedure SetStyle()
    begin
        //////
        StyleText := 'Standard';


        IF Rec.Processed THEN
            StyleText := 'StrongAccent';
    end;

    local procedure LookupOKOnPush()
    var
        ServiceOrderMgt: Codeunit "Service Order Mgt._LDR";
    begin


        Rec.MARKEDONLY(TRUE);

        MESSAGE(FORMAT(Rec.COUNT));
        IF Rec.FINDSET THEN BEGIN
            REPEAT
                ServiceOrderMgt.AddForfaitConceptLine(gServHeader."No.", Rec);
                Rec.Processed := TRUE;
                Rec.MODIFY(FALSE);
            UNTIL Rec.NEXT = 0;
        END ELSE
            ERROR('');
    end;

    procedure SetParams(pServHeader: Record "Service Header")
    begin
        //gServHeader := pServHeader;
    end;
}