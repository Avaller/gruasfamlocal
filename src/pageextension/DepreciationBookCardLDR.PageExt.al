/// <summary>
/// PageExtension DepreciationBookCard_LDR (ID 50099) extends Record Depreciation Book Card.
/// </summary>
pageextension 50099 "DepreciationBookCard_LDR" extends "Depreciation Book Card"
{
    layout
    {
        addafter("Fiscal Year 365 Days")
        {
            field("No. of Days in Fiscal Year"; Rec."No. of Days in Fiscal Year")
            {
                ApplicationArea = All;
                Caption = 'No. de días en el año fiscal';
                ToolTip = 'No. de días en el año fiscal';
            }
        }
    }
}