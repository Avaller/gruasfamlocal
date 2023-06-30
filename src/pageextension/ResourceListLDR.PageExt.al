/// <summary>
/// PageExtension Resource List (ID 50028) extends Record Resource List.
/// </summary>
pageextension 50043 "Resource List_LDR" extends "Resource List"
{
    layout
    {
        addafter("Default Deferral Template Code")
        {
            field(Blocked_LDR; Rec.Blocked)
            {
                ApplicationArea = All;
                Caption = 'Obstruido';
                ToolTip = 'Obstruido';
            }
            field(ExplotationCustomerNo_LDR; Rec."Explotation Customer No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Explotación Cliente No.';
                ToolTip = 'Explotación Cliente No.';
            }
            field(ExplotationName_LDR; Rec."Explotation Name_LDR")
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
            action("DescuentosLineas")
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