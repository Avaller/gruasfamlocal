/// <summary>
/// Page Breakdown Category (ID 50003).
/// </summary>
page 50003 "Breakdown Category"
{
    Caption = 'Breakdown Category';
    PageType = List;
    SourceTable = "Breakdown Category_LDR";

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
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Breakdown &Subcategories")
            {
                Caption = 'Breakdown &Subcategories';
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Breakdown Subcategory";
                RunPageLink = "Code" = field("Code");
            }
        }
    }
}