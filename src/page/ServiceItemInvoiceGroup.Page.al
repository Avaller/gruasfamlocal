/// <summary>
/// Page Service Item Invoice Group (ID 50005).
/// </summary>
page 50005 "Service Item Invoice Group"
{
    Caption = 'Group Invoice Service Item';
    PageType = List;
    SourceTable = "Service Item Invoice Group_LDR";

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
                field("Average Speed"; Rec."Average Speed")
                {
                    ApplicationArea = All;
                    Caption = 'Velocidad media';
                    ToolTip = 'Velocidad media';
                }
                field("Group Type"; Rec."Group Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de grupo';
                    ToolTip = 'Tipo de grupo';
                }
                field("Rate Type"; Rec."Rate Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de cambio';
                    ToolTip = 'Tipo de cambio';
                }
                field("Print Order"; Rec."Print Order")
                {
                    ApplicationArea = All;
                    Caption = 'Orden de impresión';
                    ToolTip = 'Orden de impresión';
                }
                field(Height; Rec.Height)
                {
                    ApplicationArea = All;
                    Caption = 'Altura';
                    ToolTip = 'Altura';
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                    Caption = 'Rama';
                    ToolTip = 'Rama';
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                    Caption = 'Modelo';
                    ToolTip = 'Modelo';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Bonus per company")
            {
                Caption = 'Bonus per company';
                Image = RelatedInformation;
                RunObject = Page "Bonus per Company";
                RunPageLink = "Invoicing Group" = FIELD(Code);
            }
        }
    }
}