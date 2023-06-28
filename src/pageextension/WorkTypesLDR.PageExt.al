/// <summary>
/// PageExtension Work Types_LDR (ID 50055) extends Record Work Types.
/// </summary>
pageextension 50055 "Work Types_LDR" extends "Work Types"
{
    layout
    {
        addafter(Description)
        {
            field(Type_LDR; Rec.Type_LDR)
            {
                ApplicationArea = All;
                Caption = 'Tipo';
                ToolTip = 'Tipo';
            }
        }
        addafter("Unit of Measure Code")
        {
            field(Nonfacturable_LDR; Rec.Nonfacturable_LDR)
            {
                ApplicationArea = All;
                Caption = 'No Facturable';
                ToolTip = 'No Facturable';
            }
            field("Res. Journal Type_LDR"; Rec."Res. Journal Type_LDR")
            {
                ApplicationArea = All;
                Caption = 'Res. Tipo de diario';
                ToolTip = 'Res. Tipo de diario';
            }
            field("Internal discount %_LDR"; Rec."Internal discount %_LDR")
            {
                ApplicationArea = All;
                Caption = '% de descuento interno';
                ToolTip = '% de descuento interno';
            }
            field("NonWorktime Presence_LDR"; Rec."NonWorktime Presence_LDR")
            {
                ApplicationArea = All;
                Caption = 'Presencia fuera del tiempo de trabajo';
                ToolTip = 'Presencia fuera del tiempo de trabajo';
            }
        }
    }
}