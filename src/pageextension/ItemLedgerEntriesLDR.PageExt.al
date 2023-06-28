pageextension 50011 "Item Ledger Entries_LDR" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("Source No._LDR"; Rec."Source No.")
            {
                ApplicationArea = All;
                Caption = 'No de Fuente';
                ToolTip = 'No de Fuente';
            }
        }
        addafter("Job Task No.")
        {
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
                Caption = 'Código de categoría de artículo';
                ToolTip = 'Código de categoría de artículo';
            }
        }
    }
}