/// <summary>
/// Page Serv. Item Rate Subfo. - Platf (ID 50018).
/// </summary>
page 50018 "Serv. Item Rate Subfo. - Platf"
{
    Caption = 'Platform Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Servic Item Rat Lin - Plat_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Print Order"; Rec."Print Order")
                {
                    ApplicationArea = All;
                    Caption = 'Orden de impresión';
                    ToolTip = 'Orden de impresión';
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
                field("KM Price"; Rec."KM Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio por kilómetro';
                    ToolTip = 'Precio por kilómetro';
                    Visible = false;
                }
                field("Day Cost"; Rec."Day Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Costo por día';
                    ToolTip = 'Costo por día';
                }
                field("Mouth Cost"; Rec."Mouth Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Costo de boca';
                    ToolTip = 'Costo de boca';
                }
                field("Year Cost"; Rec."Year Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Costo anual';
                    ToolTip = 'Costo anual';
                }
            }
        }
    }
}