/// <summary>
/// PageExtension FixedAssetList_LDR (ID 50098) extends Record Fixed Asset List.
/// </summary>
pageextension 50098 "FixedAssetList_LDR" extends "Fixed Asset List"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                Caption = 'Descripción';
                ToolTip = 'Descripción';
            }
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = All;
                Caption = 'Bloqueado';
                ToolTip = 'Bloqueado';
            }
            field(Inactive; Rec.Inactive)
            {
                ApplicationArea = All;
                Caption = 'Inactivo';
                ToolTip = 'Inactivo';
            }
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
                Caption = 'Comentarios';
                ToolTip = 'Comentarios';
            }
            field("Serial No."; Rec."Serial No.")
            {
                ApplicationArea = All;
                Caption = 'No de Serie';
                ToolTip = 'No de Serie';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                Caption = 'Código de Dimensión Global 2';
                ToolTip = 'Código de Dimensión Global 2';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Código de Dimensión Global 1';
                ToolTip = 'Código de Dimensión Global 1';
            }
            field("Service Item No._LDR"; Rec."Service Item No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de artículo de servicio';
                ToolTip = 'Número de artículo de servicio';
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