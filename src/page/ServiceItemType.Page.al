/// <summary>
/// Page Service Item Type (ID 50006).
/// </summary>
page 50006 "Service Item Type"
{
    Caption = 'Type Service Item';
    PageType = List;
    SourceTable = "Service Item Type_LDR";

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
                field("Accept Towing"; Rec."Accept Towing")
                {
                    ApplicationArea = All;
                    Caption = 'Aceptar remolque';
                    ToolTip = 'Aceptar remolque';
                }
                field("Features Type"; Rec."Features Type")
                {
                    ApplicationArea = All;
                    Caption = 'Características Tipo';
                    ToolTip = 'Características Tipo';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Serv. Item Subtypes")
            {
                Caption = 'Serv. Item Subtypes';
                Image = ItemGroup;
                Promoted = true;
                RunObject = Page "Service Item Subtype";
                RunPageLink = Code = FIELD(Code);
            }
        }
    }
}