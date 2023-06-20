/// <summary>
/// Page Concepts (ID 50220).
/// </summary>
page 50220 Concepts
{
    Caption = 'Concept List';
    PageType = List;
    SourceTable = "Concept_LDR";

    layout
    {
        area(content)
        {
            repeater(Fields)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                    ToolTip = 'No';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cuenta';
                    ToolTip = 'No de Cuenta';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Tipo';
                    ToolTip = 'Tipo';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio por Unidad';
                    ToolTip = 'Precio por Unidad';
                }
            }
        }
    }

    actions
    {
    }
}