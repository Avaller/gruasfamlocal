page 50027 "Service Item Prices"
{
    Caption = 'Service Item Group Prices';
    PageType = List;
    SourceTable = "Service Item Price_LDR";

    layout
    {
        area(content)
        {
            repeater(Fields)
            {
                field("Service Price Group"; Rec."Service Price Group")
                {
                    ApplicationArea = All;
                    Caption = 'Grupo de precios de servicio';
                    ToolTip = 'Grupo de precios de servicio';
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de versión';
                    ToolTip = 'Número de versión';
                }
                field("Month Price"; Rec."Month Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Mes';
                    ToolTip = 'Precio Mes';
                }
                field("Week Price"; Rec."Week Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Semanal';
                    ToolTip = 'Precio Semanal';
                }
                field("Day Price"; Rec."Day Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio del día';
                    ToolTip = 'Precio del día';
                }
                field("Hour Price"; Rec."Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Hora';
                    ToolTip = 'Precio Hora';
                }
            }
        }
    }
}