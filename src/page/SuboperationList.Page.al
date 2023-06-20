/// <summary>
/// Page Suboperation List (ID 50093).
/// </summary>
page 50093 "Suboperation List"
{
    Caption = 'Suboperations';
    PageType = List;
    SourceTable = "Suboperation_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Operation Code"; Rec."Operation Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Operación';
                    Visible = false;
                    ToolTip = 'Codigo de Operación';
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
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    Caption = 'Activo';
                    ToolTip = 'Activo';
                }
            }
        }
    }
}