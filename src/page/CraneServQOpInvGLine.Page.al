/// <summary>
/// Page Crane Serv. Q. Op. Inv. G Line (ID 50035).
/// </summary>
page 50035 "Crane Serv. Q. Op. Inv. G Line"
{
    Caption = 'Crane Service Quote Operation Line - Invoice Group';
    CardPageID = "Crane Service Quote Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Crane Serv Q Op Inv G Line_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cotización No.';
                    ToolTip = 'Cotización No.';
                    Visible = false;
                }
                field("Operation Line No."; Rec."Operation Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de línea de operación';
                    ToolTip = 'Número de línea de operación';
                    Visible = false;
                }
                field("Invoice Group No."; Rec."Invoice Group No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de grupo de facturas';
                    ToolTip = 'Número de grupo de facturas';
                }
                field("Invoice Group Description"; Rec."Invoice Group Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción del grupo de facturas';
                    ToolTip = 'Descripción del grupo de facturas';
                }
                field("Vehicles Number"; Rec."Vehicles Number")
                {
                    ApplicationArea = All;
                    Caption = 'Número de vehículos';
                    ToolTip = 'Número de vehículos';
                }
                field("Minimum Treatment Type"; Rec."Minimum Treatment Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de tratamiento mínimo';
                    ToolTip = 'Tipo de tratamiento mínimo';
                }
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    Caption = 'No. de tarifa';
                    ToolTip = 'No. de tarifa';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Comments)
            {
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Service Comment Sheet";
                    RunPageLink = Type = const("General"),
                                  "Table Subtype" = const(2),
                                  "Table Name" = const("Crane Quote"), //TODO: Crane Quote
                                  "No." = field("Quote No."),
                                  "Table Line No." = field("Operation Line No.");
                }
            }
        }
        area(processing)
        {
            group(LoadServiceRate)
            {
                action("Load Service Rate")
                {
                    Caption = 'Load Service Rate';
                    Image = LinesFromJob;

                    trigger OnAction()
                    var
                        GetServRateGroups: Report "Get Serv Rate Crane Groups";
                        CraneServQOpInvGLine: Record "Crane Serv Q Op Inv G Line_LDR";
                    begin
                        CLEAR(CraneServQOpInvGLine);
                        CraneServQOpInvGLine.setRange("Quote No.", CraneServQOpInvGLine."Quote No.");
                        CraneServQOpInvGLine.setRange("Operation Line No.", CraneServQOpInvGLine."Operation Line No.");
                        if CraneServQOpInvGLine.findFirst then
                            if not Confirm(Text001, false, CraneServQOpInvGLine."Operation Line No.", CraneServQOpInvGLine."Quote No.") then
                                error('');


                        CLEAR(GetServRateGroups);
                        GetServRateGroups.SetParams(CraneServQOpInvGLine."Quote No.", CraneServQOpInvGLine."Operation Line No.");
                        GetServRateGroups.runModal;

                        CurrPage.UpDate(false);
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Operation No. %1 - %2, already has some Invoice Groups specified. By continuing you will add all the Service Rate''s Invoices Groups to the existing ones.';
}