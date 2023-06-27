/// <summary>
/// Page Crane Service Quotes (ID 50023).
/// </summary>
page 50023 "Crane Service Quotes"
{
    Caption = 'Crane Service Quotes';
    CardPageID = "Crane Service Quote Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Crane Service Quote Header_LDR";
    //SourceTableView = where(Historical = const("No."),
    //                        "Platform Quote" = const("No."));   //TODO: No permite transformar un boolean a un Option 

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Quote no."; Rec."Quote no.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cita';
                    ToolTip = 'No de Cita';
                }
                field("Quote Type"; Rec."Quote Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de Cita';
                    ToolTip = 'Tipo de Cita';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cliente';
                    ToolTip = 'No de Cliente';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de Cliente';
                    ToolTip = 'Nombre de Cliente';
                }
                field("Ship-to Address Code"; Rec."Ship-to Address Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de dirección de envío';
                    ToolTip = 'Código de dirección de envío';
                }
                field("Ship-to Address Name"; Rec."Ship-to Address Name")
                {
                    ApplicationArea = All;
                    Caption = 'Envio a Dirección de Nombre';
                    ToolTip = 'Envio a Dirección de Nombre';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Comienzo';
                    ToolTip = 'Fecha de Comienzo';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Fin';
                    ToolTip = 'Fecha de Fin';
                }
                field("Quote Date"; Rec."Quote Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de cotización';
                    ToolTip = 'Fecha de cotización';
                    Visible = false;
                }
                field("Quote Status"; Rec."Quote Status")
                {
                    ApplicationArea = All;
                    Caption = 'Estado de cotización';
                    ToolTip = 'Estado de cotización';
                    Visible = false;
                }
                field("Invoice Period"; Rec."Invoice Period")
                {
                    ApplicationArea = All;
                    Caption = 'Período de facturación';
                    ToolTip = 'Período de facturación';
                }
                field("Invoicing Type"; Rec."Invoicing Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de facturación';
                    ToolTip = 'Tipo de facturación';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de vendedor';
                    ToolTip = 'Código de vendedor';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Co&mments")
            {
                Caption = 'Co&mments';
                Image = ViewComments;
                RunObject = Page "Service Comment Sheet";
                RunPageLink = Type = const(General),
                              "Table Subtype" = const(0),
                              "Table Name" = const("Crane Quote"),
                              "No." = field("Quote no."),
                              "Table Line No." = const(0);
            }
        }
    }

}