/// <summary>
/// Page Bonus per Company (ID 50090).
/// </summary>
page 50090 "Bonus per Company"
{
    Caption = 'Primas por Empresa';
    PageType = List;
    SourceTable = "Bonus per Company_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Invoicing Group"; Rec."Invoicing Group")
                {
                    ApplicationArea = All;
                    Caption = 'Grupo de facturación';
                    ToolTip = 'Grupo de facturación';
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                    Caption = 'Compañia';
                    ToolTip = 'Compañia';
                }
                field("Bonus %"; Rec."Bonus %")
                {
                    ApplicationArea = All;
                    Caption = '% de bonificación';
                    ToolTip = '% de bonificación';
                }
            }
        }
    }
}

