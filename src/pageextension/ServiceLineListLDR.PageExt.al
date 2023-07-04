/// <summary>
/// PageExtension Service Line List_LDR (ID 50115) extends Record Service Line List.
/// </summary>
pageextension 50115 "Service Line List_LDR" extends "Service Line List"
{
    layout
    {
        addafter("Document No.")
        {
            field("Service Order Description_LDR"; Rec."Service Order Description_LDR")
            {
                ApplicationArea = All;
                Caption = 'Descripción de la orden de servicio';
                ToolTip = 'Descripción de la orden de servicio';
            }
            field("Work Type Code"; Rec."Work Type Code")
            {
                ApplicationArea = All;
                Caption = 'Código de tipo de trabajo';
                ToolTip = 'Código de tipo de trabajo';
            }
        }
        addafter("No.")
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
                Caption = 'Descripción';
                ToolTip = 'Descripción';
            }
        }
        addafter("Location Code")
        {
            field("Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
                Caption = 'Código de bandeja';
                ToolTip = 'Código de bandeja';
            }
        }
        addafter("Line Amount")
        {
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Costo unitario';
                Caption = '';
            }
        }
    }
}