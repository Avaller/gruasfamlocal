/// <summary>
/// Page Crane Serv. Q. Op. Mic S. Line (ID 50025).
/// </summary>
page 50025 "Crane Serv. Q. Op. Mic S. Line"
{
    // version FAM

    AutoSplitKey = true;
    CaptionML = ENU = 'Crane Service Quote Operation Line - Other Services',
                ESP = 'Linea de Operacion de Oferta Servicio Grúa - Otros Servicios';
    PageType = List;
    SourceTable = "Crane Serv Q Op Mic S Line_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
        area(navigation)
        {

            action("Co&mments")
            {
                CaptionML = ENU = 'Co&mments',
                            ESP = 'C&omentarios';
                Image = ViewComments;
                RunObject = Page "Service Comment Sheet";
                RunPageLink = Type = const(General),
                              "Table Subtype" = const(1),
                              "Table Name" = const("Crane Quote"),
                              "No." = field("Quote No."),
                              "Table Line No." = field("Operation Line No.");
            }
        }
    }
}

