/// <summary>
/// Page Service Item Model (ID 50007).
/// </summary>
page 50007 "Service Item Model"
{
    Caption = 'Mod. Service Item';
    PageType = List;
    SourceTable = "Service Item Model_LDR";

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
                    Visible = false;
                }
                field("Model Code"; Rec."Model Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Modelo';
                    ToolTip = 'Codigo de Modelo';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field(Tonnage; Rec.Tonnage)
                {
                    ApplicationArea = All;
                    Caption = 'Tonelaje';
                    ToolTip = 'Tonelaje';
                }
            }
        }
    }

    actions
    {
    }
}