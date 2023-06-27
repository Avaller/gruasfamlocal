/// <summary>
/// PageExtension Resource List (ID 50028) extends Record Resource List.
/// </summary>
pageextension 50028 "Resource List" extends "Resource List"
{
    layout
    {
        addafter("Default Deferral Template Code")
        {
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = All;
                Caption = 'Obstruido';
                ToolTip = 'Obstruido';
            }
            field("Explotation Customer No._LDR"; Rec."Explotation Customer No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Explotación Cliente No.';
                ToolTip = 'Explotación Cliente No.';
            }
            field("Explotation Name_LDR"; Rec."Explotation Name_LDR")
            {
                ApplicationArea = All;
                Caption = 'Nombre de explotación';
                ToolTip = 'Nombre de explotación';
            }
        }
    }

    actions
    {
        addafter(Prices)
        {
            action("Descuentos Lineas")
            {
                ApplicationArea = All;
                Caption = 'Descuentos Lineas';
                Promoted = true;
                Image = LineDiscount;
                PromotedCategory = Process;

                RunObject = Page "Sales Line Discounts";
                RunPageView = SORTING(Type, Code, "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity");
                RunPageLink = Type = CONST(Resource),
                                  Code = FIELD("No.");
            }
        }
    }
}