/// <summary>
/// PageExtension Units of Measure_LDR (ID 50056) extends Record Units of Measure.
/// </summary>
pageextension 50056 "Units of Measure_LDR" extends "Units of Measure"
{
    layout
    {
        addafter(Description)
        {
            field(Mobility_LDR; Rec.Mobility_LDR)
            {
                ApplicationArea = All;
                Caption = 'Movilidad';
                ToolTip = 'Movilidad';
            }
            field("Invoicing Text_LDR"; Rec."Invoicing Text_LDR")
            {
                ApplicationArea = All;
                Caption = 'Texto de facturación';
                ToolTip = 'Texto de facturación';
            }
            field("Time Measure Unit_LDR"; Rec."Time Measure Unit_LDR")
            {
                ApplicationArea = All;
                Caption = 'Unidad de medida de tiempo';
                ToolTip = 'Unidad de medida de tiempo';
            }
        }
        addafter("International Standard Code")
        {
            field("Expenses Type_LDR"; Rec."Expenses Type_LDR")
            {
                ApplicationArea = All;
                Caption = 'Tipo de gastos';
                ToolTip = 'Tipo de gastos';
            }
            field("Invoicing UOM_LDR"; Rec."Invoicing UOM_LDR")
            {
                ApplicationArea = All;
                Caption = 'UOM de facturación';
                ToolTip = 'UOM de facturación';
            }
            field("Hour Type_LDR"; Rec."Hour Type_LDR")
            {
                ApplicationArea = All;
                Caption = 'Tipo de hora';
                ToolTip = 'Tipo de hora';
            }
        }
    }

    actions
    {
        addafter(Translations)
        {
            action(Dimensions)
            {
                ApplicationArea = All;
                Caption = 'Dimensiones';
                Image = Dimensions;

                RunObject = Page "Default Dimensions";
                RunPageLink = "Table ID" = const(204),
                                "No." = field(Code);
            }
        }
    }

    var
        myInt: Integer;
}