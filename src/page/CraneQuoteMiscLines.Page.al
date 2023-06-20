page 50050 "Crane Quote Misc Lines"
{
    AutoSplitKey = true;
    Caption = 'Crane Service Quote Operation Line - Other Services';
    PageType = List;
    SourceTable = "Crane Serv Q Op Mic S Line_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MARK_LDR; Rec.MARK)
                {
                    ApplicationArea = All;
                    Caption = 'MARCA';
                    ToolTip = 'MARCA';
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de operación';
                    ToolTip = 'Número de operación';
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción de la operación';
                    ToolTip = 'Descripción de la operación';
                }
                field("Concept Code"; Rec."Concept Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de concepto';
                    ToolTip = 'Código de concepto';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Cantidad';
                    ToolTip = 'Cantidad';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio unitario';
                    ToolTip = 'Precio unitario';
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

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush
        ELSE
            ERROR(Text002);
    end;

    var
        gServHeader: Record "Service Header";
        Text001: Label 'Misc. Concepts';
        Text002: Label 'Cancelled by the User';

    local procedure LookupOKOnPush()
    var
        ServiceOrderMgt: Codeunit "Service Order Mgt._LDR";
        ServLineType: Option " ",Item,Resource,Cost,"G/L Account";
    begin


        Rec.MARKEDONLY(TRUE);
        IF Rec.FINDSET THEN BEGIN
            ServiceOrderMgt.AddServLine(gServHeader."No.", ServLineType::" ", '', Text001, 0, '', 0, TRUE);
            REPEAT
                ServiceOrderMgt.AddExtraConceptLine(gServHeader."No.", Rec);
            UNTIL Rec.NEXT = 0;
        END;
    end;

    procedure SetParams(pServHeader: Record "Service Header")
    begin
        //gServHeader := pServHeader;
    end;
}