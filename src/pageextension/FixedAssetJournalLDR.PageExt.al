/// <summary>
/// PageExtension FixedAssetJournal_LDR (ID 50100) extends Record Fixed Asset Journal.
/// </summary>
pageextension 50100 "FixedAssetJournal_LDR" extends "Fixed Asset Journal"
{
    layout
    {
        addafter("Document Type")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                Caption = 'Nº de línea';
                ToolTip = 'Nº de línea';
            }
        }
    }
}