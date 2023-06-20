/// <summary>
/// Page Breakdown Subcategory (ID 50010).
/// </summary>
page 50010 "Breakdown Subcategory"
{
    Caption = 'Breakdown Subcategory ';
    PageType = List;
    SourceTable = "Breakdown Subcategory_LDR";

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
                field(Subcategory; Rec.Subcategory)
                {
                    ApplicationArea = All;
                    Caption = 'Subcategoria';
                    ToolTip = 'Subcategoria';
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
}