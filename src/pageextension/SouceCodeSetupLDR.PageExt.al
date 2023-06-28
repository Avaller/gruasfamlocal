/// <summary>
/// PageExtension Source Code Setup_LDR (ID 50060) extends Record Source Code Setup.
/// </summary>
pageextension 50060 "Source Code Setup_LDR" extends "Source Code Setup"
{
    layout
    {
        addafter("Insurance Journal")
        {
            field("Fixed Asset_LDR"; Rec."Fixed Asset_LDR")
            {
                ApplicationArea = All;
                Caption = 'Activo fijo';
                ToolTip = 'Activo fijo';
            }
            field(Leasing_LDR; Rec.Leasing_LDR)
            {
                ApplicationArea = All;
                Caption = 'Arrendamiento';
                ToolTip = 'Arrendamiento';
            }
        }
        addafter("Service Management")
        {
            field("Service Journal_LDR"; Rec."Service Journal_LDR")
            {
                ApplicationArea = All;
                Caption = 'Diario de servicio';
                ToolTip = 'Diario de servicio';
            }
            field("Service Contract Line_LDR"; Rec."Service Contract Line_LDR")
            {
                ApplicationArea = All;
                Caption = 'Línea de contrato de servicio';
                ToolTip = 'Línea de contrato de servicio';
            }
            field("Internal Contract Line_LDR"; Rec."Internal Contract Line_LDR")
            {
                ApplicationArea = All;
                Caption = 'Línea de contrato interno';
                ToolTip = 'Línea de contrato interno';
            }
            field("Internal Contract Header_LDR"; Rec."Internal Contract Header_LDR")
            {
                ApplicationArea = All;
                Caption = 'Encabezado de contrato interno';
                ToolTip = 'Encabezado de contrato interno';
            }
            field("Service Item Reval Journal_LDR"; Rec."Service Item Reval Journal_LDR")
            {
                ApplicationArea = All;
                Caption = 'Diario de revalidación de artículo de servicio';
                ToolTip = 'Diario de revalidación de artículo de servicio';
            }
            field("Service Item Entry Journal_LDR"; Rec."Service Item Entry Journal_LDR")
            {
                ApplicationArea = All;
                Caption = 'Diario de entrada de artículo de servicio';
                ToolTip = 'Diario de entrada de artículo de servicio';
            }
            field("Item Entry Journal_LDR"; Rec."Item Entry Journal_LDR")
            {
                ApplicationArea = All;
                Caption = 'Diario de entrada de artículos';
                ToolTip = 'Diario de entrada de artículos';
            }
        }
    }
}