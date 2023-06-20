/// <summary>
/// Page Service Item Suboperation (ID 50094).
/// </summary>
page 50094 "Service Item Suboperation"
{
    Caption = 'Serv. Item Suboperations';
    PageType = List;
    SourceTable = "Serv. Item Suboperation_LDR";

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
                }
                field("Operation Code"; Rec."Operation Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de operación';
                    ToolTip = 'Código de operación';
                }
                field("Suboperation Code"; Rec."Suboperation Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de suboperación';
                    ToolTip = 'Código de suboperación';
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                    Caption = 'Area';
                    ToolTip = 'Area';
                }
                field(Element; Rec.Element)
                {
                    ApplicationArea = All;
                    Caption = 'Elemento';
                    ToolTip = 'Elemento';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
            }
        }
    }

    actions
    {
    }
}