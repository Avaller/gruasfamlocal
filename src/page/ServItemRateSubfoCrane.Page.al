/// <summary>
/// Page Serv. Item Rate Subfo. - Crane (ID 50017).
/// </summary>
page 50017 "Serv. Item Rate Subfo. - Crane"
{
    Caption = 'Invoice Group Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Servic Item Rat Li - Crane_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Print Order"; Rec."Print Order")
                {
                    ApplicationArea = All;
                    Caption = 'Orden de impresión';
                    ToolTip = 'Orden de impresión';
                }
                field("Invoice Group No."; Rec."Invoice Group No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de grupo de facturas';
                    ToolTip = 'Número de grupo de facturas';
                }
                field("Invoice Group Description"; Rec."Invoice Group Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción del grupo de facturas';
                    ToolTip = 'Descripción del grupo de facturas';
                }
                field("KM Price"; Rec."KM Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio por kilómetro';
                    ToolTip = 'Precio por kilómetro';
                }
                field("Min working Time"; Rec."Min working Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de trabajo mínimo';
                    ToolTip = 'Tiempo de trabajo mínimo';
                }
                field("Hour Price"; Rec."Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Hora';
                    ToolTip = 'Precio Hora';
                }
                field("Stop Hour Price"; Rec."Stop Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio de la hora de parada';
                    ToolTip = 'Precio de la hora de parada';
                }
                field("% Night Increment"; Rec."% Night Increment")
                {
                    ApplicationArea = All;
                    Caption = '% Incremento Noche';
                    ToolTip = '% Incremento Noche';
                }
                field("Night Hour Price"; Rec."Night Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Hora Noche';
                    ToolTip = 'Precio Hora Noche';
                }
                field("Min Night Hours"; Rec."Min Night Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas nocturnas mínimas';
                    ToolTip = 'Horas nocturnas mínimas';
                }
                field("Exit Fee Price"; Rec."Exit Fee Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio de la tarifa de salida';
                    ToolTip = 'Precio de la tarifa de salida';
                }
                field("Min Saturday Hours"; Rec."Min Saturday Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas mínimas del sábado';
                    ToolTip = 'Horas mínimas del sábado';
                }
                field("% Saturday Increment"; Rec."% Saturday Increment")
                {
                    ApplicationArea = All;
                    Caption = '% Incremento Sábado';
                    ToolTip = '% Incremento Sábado';
                }
                field("Saturday Hour Price"; Rec."Saturday Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Sábado Hora Precio';
                    ToolTip = 'Sábado Hora Precio';
                }
                field("% Saturday Stop Increment"; Rec."% Saturday Stop Increment")
                {
                    ApplicationArea = All;
                    Caption = '% Incremento de parada de sábado';
                    ToolTip = '% Incremento de parada de sábado';
                }
                field("Saturday Stop Hour Price"; Rec."Saturday Stop Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio de la hora de parada del sábado';
                    ToolTip = 'Precio de la hora de parada del sábado';
                }
                field("% Saturday Night Increment"; Rec."% Saturday Night Increment")
                {
                    ApplicationArea = All;
                    Caption = '% de incremento de sábado por la noche';
                    ToolTip = '% de incremento de sábado por la noche';
                    Visible = false;
                }
                field("Saturday Nigth Hour Price"; Rec."Saturday Nigth Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio de la hora del sábado por la noche';
                    ToolTip = 'Precio de la hora del sábado por la noche';
                    Visible = false;
                }
                field("% Saturday Exit Fee Increment"; Rec."% Saturday Exit Fee Increment")
                {
                    ApplicationArea = All;
                    Caption = '% de incremento de la tarifa de salida del sábado';
                    ToolTip = '% de incremento de la tarifa de salida del sábado';
                }
                field("Saturday Exit Fee Price"; Rec."Saturday Exit Fee Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio de la tarifa de salida del sábado';
                    ToolTip = 'Precio de la tarifa de salida del sábado';
                }
                field("Min Holiday Time"; Rec."Min Holiday Time")
                {
                    ApplicationArea = All;
                    Caption = '';
                    ToolTip = '';
                }
                field("% Holiday Increment"; Rec."% Holiday Increment")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo mínimo de vacaciones';
                    ToolTip = 'Tiempo mínimo de vacaciones';
                }
                field("Holiday Hour Price"; Rec."Holiday Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio de la hora de vacaciones';
                    ToolTip = 'Precio de la hora de vacaciones';
                }
                field("% Holiday Stop Increment"; Rec."% Holiday Stop Increment")
                {
                    ApplicationArea = All;
                    Caption = '% de incremento de parada de vacaciones';
                    ToolTip = '% de incremento de parada de vacaciones';
                }
                field("Holiday Stop Hour Price"; Rec."Holiday Stop Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio de la hora de parada de vacaciones';
                    ToolTip = 'Precio de la hora de parada de vacaciones';
                }
                field("% Holiday Night Increment"; Rec."% Holiday Night Increment")
                {
                    ApplicationArea = All;
                    Caption = '% de incremento de noche de vacaciones';
                    ToolTip = '% de incremento de noche de vacaciones';
                    Visible = false;
                }
                field("Holiday Night Hour Price"; Rec."Holiday Night Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio de la hora de la noche de vacaciones';
                    ToolTip = 'Precio de la hora de la noche de vacaciones';
                    Visible = false;
                }
                field("% Holiday Exit Fee Increment"; Rec."% Holiday Exit Fee Increment")
                {
                    ApplicationArea = All;
                    Caption = '% de incremento de tarifa de salida de vacaciones';
                    ToolTip = '% de incremento de tarifa de salida de vacaciones';
                }
                field("Holiday Exit Fee Price"; Rec."Holiday Exit Fee Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio de la tarifa de salida de vacaciones';
                    ToolTip = 'Precio de la tarifa de salida de vacaciones';
                }
            }
        }
    }
}