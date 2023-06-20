/// <summary>
/// Page Serv. Item Operations (ID 50058).
/// </summary>
page 50058 "Serv. Item Operations"
{
    Caption = 'Serv. Item Operations';
    CardPageID = "Serv. Item Operations"; //TODO: No econtrado "Serv. Item Op. Entry Card", lo sustitui por lo mas similar
    PageType = List;
    SourceTable = "Serv. Item Operations_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Serv. Item Code"; Rec."Serv. Item Code")
                {
                    ApplicationArea = All;
                    Caption = 'Serv. Código del objeto';
                    ToolTip = 'Serv. Código del objeto';
                    Visible = false;
                }
                field("Operation Code"; Rec."Operation Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de operación';
                    Editable = true;
                    ToolTip = 'Código de operación';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    Editable = false;
                    ToolTip = 'Descripción';
                }
                field("Operation Type"; Rec."Operation Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de operación';
                    Editable = false;
                    ToolTip = 'Tipo de operación';
                }
                field("Period Type"; Rec."Period Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de período';
                    Editable = false;
                    ToolTip = 'Tipo de período';
                }
                field("Next Planned Date"; Rec."Next Planned Date")
                {
                    ApplicationArea = All;
                    Caption = 'Próxima fecha planificada';
                    ToolTip = 'Próxima fecha planificada';
                }
                field("Next Planned Hours"; Rec."Next Planned Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Próximas horas planificadas';
                    ToolTip = 'Próximas horas planificadas';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Suboperation)
            {
                Caption = 'Service Item Suboperations';
                Image = List;

                trigger OnAction()
                var
                    ServItemSuboperation: Record "Serv. Item Suboperation_LDR";
                    error50001: Label 'Operation is not technical or requires service request';
                    ServItemSuboperationList: Page "Service Item Suboperation";
                begin
                    CLEAR(ServItemSuboperation);
                    ServItemSuboperation.SETRANGE("Operation Code", Rec."Operation Code");
                    ServItemSuboperation.SETRANGE("Serv. Item Code", Rec."Serv. Item Code");
                    IF (Rec."Operation Type" = Rec."Operation Type"::Technical) THEN BEGIN
                        ServItemSuboperationList.SETTABLEVIEW(ServItemSuboperation);
                        ServItemSuboperationList.LOOKUPMODE(TRUE);
                        ServItemSuboperationList.RUNMODAL;
                    END ELSE
                        ERROR(error50001);
                end;
            }
            action("Show related Entries")
            {
                Caption = 'Show related Entries';
                Image = MaintenanceLedgerEntries;
                RunObject = Page "Serv. Item Operations Entry";
                RunPageLink = "Serv. Item Code" = FIELD("Serv. Item Code"),
                              "Operation Code" = FIELD("Operation Code");
            }
        }
    }
}