/// <summary>
/// Page Expenses Types (ID 50095).
/// </summary>
page 50095 "Expenses Types"
{
    Caption = 'Expenses Types';
    PageType = List;
    SourceTable = "Expenses Types_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Codigo';
                    ToolTip = 'Codigo';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    Caption = 'Precio';
                    ToolTip = 'Precio';
                }
                field("Mobility Exp. Type"; Rec."Mobility Exp. Type")
                {
                    ApplicationArea = All;
                    Caption = 'Movilidad Exp. Tipo';
                    ToolTip = 'Movilidad Exp. Tipo';
                }
                field("Reduced Bonus"; Rec."Reduced Bonus")
                {
                    ApplicationArea = All;
                    Caption = 'Bonos Reducidos';
                    ToolTip = 'Bonos Reducidos';
                }
                field("Complete Bonus"; Rec."Complete Bonus")
                {
                    ApplicationArea = All;
                    Caption = 'Bonos Completos';
                    ToolTip = 'Bonos Completos';
                }
            }
        }
    }
}