/// <summary>
/// PageExtension Fixed Asset Card_LDR (ID 50097) extends Record Fixed Asset Card.
/// </summary>
pageextension 50097 "Fixed Asset Card_LDR" extends "Fixed Asset Card"
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
        }
        addafter("Warranty Date")
        {
            field("Service Item No._LDR"; Rec."Service Item No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de artículo de servicio';
                ToolTip = 'Número de artículo de servicio';
            }
        }
    }
}