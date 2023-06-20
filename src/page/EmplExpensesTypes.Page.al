/// <summary>
/// Page Empl. Expenses Types (ID 50082).
/// </summary>
page 50082 "Empl. Expenses Types"
{
    Caption = 'Res. Expenses Types';
    PageType = List;
    SourceTable = "Empl. Expenses Types_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Empleado';
                    ToolTip = 'No de Empleado';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Codigo';
                    ToolTip = 'Codigo';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Decripción';
                    ToolTip = 'Decripción';
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
                    Editable = false;
                    ToolTip = 'Movilidad Exp. Tipo';
                }
                field("Reduced Bonus"; Rec."Reduced Bonus")
                {
                    ApplicationArea = All;
                    Caption = 'Bono Reducido';
                    ToolTip = 'Bono Reducido';
                }
                field("Complete Bonus"; Rec."Complete Bonus")
                {
                    ApplicationArea = All;
                    Caption = 'Bono Completo';
                    ToolTip = 'Bono Completo';
                }
            }
        }
    }
}