/// <summary>
/// Page Service Crane Quote Op. Subf. (ID 50026).
/// </summary>
page 50026 "Service Crane Quote Op. Subf."
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Crane Servic Quote Op. Lin_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                    Caption = 'Operación No.';
                    ToolTip = 'Operación No.';
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción de la operación';
                    ToolTip = 'Descripción de la operación';
                }
                field("Forfait Amount"; Rec."Forfait Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Importe del forfait';
                    ToolTip = 'Importe del forfait';
                    Visible = ForfaitAmountEditable;

                    trigger OnDrillDown()
                    var
                        pCraneServQForfaitCalenda: Page "Crane Serv. Q. Forfait Calenda";
                        rCraneServQForfaitCalendar: Record "Crane Serv Q. Forf Calend_LDR";
                    begin
                        CLEAR(rCraneServQForfaitCalendar);
                        rCraneServQForfaitCalendar.SETRANGE("Quote No.", Rec."Quote No.");
                        rCraneServQForfaitCalendar.SETRANGE("Quote Op. Line No.", Rec."Line No.");

                        pCraneServQForfaitCalenda.SETTABLEVIEW(rCraneServQForfaitCalendar);
                        pCraneServQForfaitCalenda.RUNMODAL;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Service Comment Sheet";
                    RunPageLink = Type = Const(General),
                                  "Table Subtype" = Const(0),
                                  "Table Name" = Const("Crane Quote"),
                                  "No." = field("Quote No."),
                                  "Table Line No." = field("Line No.");
                }
                action("Service Order Line Operations - Other Services")
                {
                    Caption = 'Service Order Line Operations - Other Services';
                    RunObject = Page "Crane Serv. Q. Op. Mic S. Line";
                    RunPageLink = "Quote No." = field("Quote No."),
                                  "Operation Line No." = field("Line No.");
                }
                action("Crane Service Quote Operation Line - Invoice Group")
                {
                    Caption = 'Crane Service Quote Operation Line - Invoice Group';
                    RunObject = Page "Crane Serv. Q. Op. Inv. G Line";
                    RunPageLink = "Quote No." = field("Quote No."),
                                  "Operation Line No." = field("Line No.");
                }
            }
            group("&Forfait")
            {
                Caption = '&Forfait';
                action("Forfait Invoicing Calendar")
                {
                    Caption = 'Forfait Invoicing Calendar';
                    Visible = ForfaitAmountEditable;

                    trigger OnAction()
                    var
                        pCraneServQForfaitCalenda: Page "Crane Serv. Q. Forfait Calenda";
                        rCraneServQForfaitCalendar: Record "Crane Serv Q. Forf Calend_LDR";
                    begin
                        CLEAR(rCraneServQForfaitCalendar);
                        rCraneServQForfaitCalendar.SETRANGE("Quote No.", Rec."Quote No.");
                        rCraneServQForfaitCalendar.SETRANGE("Quote Op. Line No.", Rec."Line No.");

                        pCraneServQForfaitCalenda.SETTABLEVIEW(rCraneServQForfaitCalendar);
                        pCraneServQForfaitCalenda.RUNMODAL;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetVisibility;
    end;

    trigger OnOpenPage()
    begin
        SetVisibility;
    end;

    var
        [InDataSet]
        ForfaitAmountEditable: BoolEAN;

    local procedure SetVisibility()
    var
        CraneServiceQuote: Record "Crane Service Quote Header_LDR";
    begin
        // CIC Edicion del campo Importe forfait solo si la oferta es de tipo forfait
        IF CraneServiceQuote.GET(Rec."Quote No.") THEN BEGIN
            IF CraneServiceQuote."Quote Type" = CraneServiceQuote."Quote Type"::Forfait THEN
                ForfaitAmountEditable := TRUE
            ELSE
                ForfaitAmountEditable := FALSE;
        END;
    end;
}