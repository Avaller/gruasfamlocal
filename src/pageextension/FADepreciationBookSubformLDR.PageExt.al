/// <summary>
/// PageExtension FADepreciationBooksSubform_LDR (ID 50101) extends Record FA Depreciation Books Subform.
/// </summary>
pageextension 50101 "FADepreciationBooksSubform_LDR" extends "FA Depreciation Books Subform"
{
    layout
    {
        addafter(AddCurrCode)
        {
            field("Salvage Value"; Rec."Salvage Value")
            {
                ApplicationArea = All;
                Caption = 'Valor del rescate';
                ToolTip = 'Valor del rescate';
            }
        }
        addafter("Depreciation Starting Date")
        {
            field("FA Posting Date Filter"; Rec."FA Posting Date Filter")
            {
                ApplicationArea = All;
                Caption = 'Filtro de fecha de publicación de FA';
                ToolTip = 'Filtro de fecha de publicación de FA';
            }
            field(Depreciation; Rec.Depreciation)
            {
                ApplicationArea = All;
                Caption = 'Depreciación';
                ToolTip = 'Depreciación';
            }
            field("Acquisition Cost"; Rec."Acquisition Cost")
            {
                ApplicationArea = All;
                Caption = 'Coste de adquisición';
                ToolTip = 'Coste de adquisición';
            }
            field("Acquisition Date"; Rec."Acquisition Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de Adquisición';
                ToolTip = 'Fecha de Adquisición';
            }
            field("G/L Acquisition Date"; Rec."G/L Acquisition Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de adquisición del L/M';
                ToolTip = 'Fecha de adquisición del L/M';
            }
        }
    }
}