/// <summary>
/// PageExtension Req. Worksheet_LDR (ID 50062) extends Record Req. Worksheet.
/// </summary>
pageextension 50062 "Req. Worksheet_LDR" extends "Req. Worksheet"
{
    layout
    {
        addafter("Description 2")
        {
            field(Notas1_LDR; Rec.Notas1_LDR)
            {
                ApplicationArea = All;
                Caption = 'Notas';
                ToolTip = 'Notas';
            }
        }
        addafter("Location Code")
        {
            field("Bin Code_LDR"; Rec."Bin Code")
            {
                ApplicationArea = All;
                Caption = 'Código de bandeja';
                ToolTip = 'Código de bandeja';
            }
        }
        addafter(BuyFromVendorName)
        {
            group(Inventory)
            {
                Caption = 'Inventario';
            }
            field(Inventory_LDR; Inventory)
            {
                ApplicationArea = All;
                Caption = 'Inventario';
                ToolTip = 'Inventario';
            }
        }
    }

    /// <summary>
    /// CalcInventory.
    /// </summary>
    procedure CalcInventory()
    var
        Item: Record Item;
    begin
        Inventory := 0;
        if (Rec.Type = Rec.Type::Item) and (Rec."No." <> '') then begin
            Item.Get(Rec."No.");
            if Rec."Variant Code" <> '' then
                Item.SetFilter("Variant Filter", Rec."Variant Code");
            if Rec."Location Code" <> '' then
                Item.SetFilter("Location Filter", Rec."Location Code");

            Item.CalcFields(Inventory);
            Inventory := Item.Inventory;
        end;
    end;

    var
        Inventory: Decimal;
}