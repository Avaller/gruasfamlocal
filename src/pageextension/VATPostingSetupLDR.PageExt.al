/// <summary>
/// PageExtension VAT Posting Setup (ID 50082) extends Record VAT Posting Setup.
/// </summary>
pageextension 50082 "VAT Posting Setup" extends "VAT Posting Setup"
{
    layout
    {
        addafter("VAT Identifier")
        {
            field("VAT Text_LDR"; Rec."VAT Text_LDR")
            {
                ApplicationArea = All;
                Caption = 'Texto de IVA';
                ToolTip = 'Texto de IVA';
            }
        }
    }
}