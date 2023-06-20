/// <summary>
/// Page Serv. Contract Inv. Group List (ID 50028).
/// </summary>
page 50028 "Serv. Contract Inv. Group List"
{
    Caption = 'Serv. Contract Inv. Group List';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Servic Contra Invoic Group_LDR";

    layout
    {
        area(content)
        {
            repeater(Conten)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                    Editable = false;
                    ToolTip = 'No';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    Editable = false;
                    ToolTip = 'Descripción';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cliente';
                    Editable = false;
                    ToolTip = 'No de Cliente';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de Cliente';
                    Editable = false;
                    ToolTip = 'Nombre de Cliente';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de envío';
                    ToolTip = 'Código de envío';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de creación';
                    Editable = false;
                    ToolTip = 'Fecha de creación';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Groups)
            {
                Caption = 'Group';
                action("&Contracts")
                {
                    Caption = '&Contracts';
                    Image = Documents;
                    RunObject = Page "Service Contract List";
                    RunPageLink = "Serv. Contract Inv. Group" = FIELD("No.");
                    RunPageView = SORTING("Contract Type", "Contract No.");
                }
            }
        }
    }
}