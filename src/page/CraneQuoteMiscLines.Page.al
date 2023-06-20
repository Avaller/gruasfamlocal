page 50050 "Crane Quote Misc Lines"
{
    /*AutoSplitKey = true;
    Caption = 'Crane Service Quote Operation Line - Other Services';
    PageType = List;
    SourceTable = "Crane Serv Q Op Mic S Line_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MARK; MARK)
                {
                }
                field("Operation No."; "Operation No.")
                {
                }
                field("Operation Description"; "Operation Description")
                {
                }
                field("Concept Code"; "Concept Code")
                {
                }
                field(Description; Description)
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Unit Price"; "Unit Price")
                {
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

    trigger OnQueryClosePage(CloseAction: Action): BoolEAN
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush
        ELSE
            ERROR(Text002);
    end;

    var
        gServHeader: Record "5900";
        Text001: Label 'Misc. Concepts';
        Text002: Label 'Cancelled by the User';

    local procedure LookupOKOnPush()
    var
        ServiceOrderMgt: Codeunit "50004";
        ServLineType: Option " ",Item,Resource,Cost,"G/L Account";
    begin


        MARKEDONLY(TRUE);
        IF FINDSET THEN BEGIN
            ServiceOrderMgt.AddServLine(gServHeader."No.", ServLineType::" ", '', Text001, 0, '', 0, TRUE);
            REPEAT
                ServiceOrderMgt.AddExtraConceptLine(gServHeader."No.", Rec);
            UNTIL NEXT = 0;
        END;
    end;*/

    procedure SetParams(pServHeader: Record "Service Header")
    begin
        //gServHeader := pServHeader;
    end;
}