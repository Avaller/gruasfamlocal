/// <summary>
/// PageExtension Item List_LDR (ID 50010) extends Record Item List.
/// </summary>
pageextension 50010 "Item List_LDR" extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                Caption = 'No 2';
                ToolTip = 'No 2';
            }
        }
        addafter(Description)
        {
            field(Type2_LDR; Rec.Type2_LDR)
            {
                ApplicationArea = All;
                Caption = 'Tipo 2';
                ToolTip = 'Tipo 2';
            }
            field(Subtype_LDR; Rec.Subtype_LDR)
            {
                ApplicationArea = All;
                Caption = 'Subtipo';
                ToolTip = 'Subtipo';
            }
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = All;
                Caption = 'Inventario';
                ToolTip = 'Inventario';
            }
            field("Manufacturer Code"; Rec."Manufacturer Code")
            {
                ApplicationArea = All;
                Caption = 'Codigo de Manufactura';
                ToolTip = 'Codigo de Manufactura';
            }
            field(EAN_LDR; Rec.EAN_LDR)
            {
                ApplicationArea = All;
                Caption = 'EAN';
                ToolTip = 'EAN';
            }
            field(Model_LDR; Rec.Model_LDR)
            {
                ApplicationArea = All;
                Caption = 'Modelo';
                ToolTip = 'Modelo';
            }
            field("No. Series"; Rec."No. Series")
            {
                ApplicationArea = All;
                Caption = 'Nº Serie';
                ToolTip = 'Nº Serie';
            }
        }
        addafter("Unit Price")
        {
            field("Alternative Item No."; Rec."Alternative Item No.")
            {
                ApplicationArea = All;
                Caption = 'Número de artículo alternativo';
                ToolTip = 'Número de artículo alternativo';
            }
        }
        addafter("Item Tracking Code")
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                Caption = 'Descripción 2';
                ToolTip = 'Descripción 2';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}