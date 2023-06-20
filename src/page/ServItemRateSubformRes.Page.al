/// <summary>
/// Page Serv. Item Rate Subform - Res. (ID 50016).
/// </summary>
page 50016 "Serv. Item Rate Subform - Res."
{
    Caption = 'Resource Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Servic Item Rat Lin - Res_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Resource Group No."; Rec."Resource Group No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de grupo de recursos';
                    ToolTip = 'Número de grupo de recursos';
                }
                field("Resource Group Description"; Rec."Resource Group Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción del grupo de recursos';
                    ToolTip = 'Descripción del grupo de recursos';
                }
                field("Min Hours"; Rec."Min Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas mínimas';
                    ToolTip = 'Horas mínimas';
                }
                field("Price Hour"; Rec."Price Hour")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Hora';
                    ToolTip = 'Precio Hora';
                }
                field("% Night Time Increase"; Rec."% Night Time Increase")
                {
                    ApplicationArea = All;
                    Caption = '% de aumento de horario nocturno';
                    ToolTip = '% de aumento de horario nocturno';
                }
                field("Price Night Hour"; Rec."Price Night Hour")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Noche Hora';
                    ToolTip = 'Precio Noche Hora';
                }
                field("% Saturday Time Increase"; Rec."% Saturday Time Increase")
                {
                    ApplicationArea = All;
                    Caption = '% de aumento de horario del sábado';
                    ToolTip = '% de aumento de horario del sábado';
                }
                field("Price Saturday Hour"; Rec."Price Saturday Hour")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Sábado Hora';
                    ToolTip = 'Precio Sábado Hora';
                }
                field("% Saturday Night Time Increase"; Rec."% Saturday Night Time Increase")
                {
                    ApplicationArea = All;
                    Caption = '% de aumento del horario de la noche del sábado';
                    ToolTip = '% de aumento del horario de la noche del sábado';
                }
                field("Price Saturday Night Hour"; Rec."Price Saturday Night Hour")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Sábado Noche Hora';
                    ToolTip = 'Precio Sábado Noche Hora';
                }
                field("% Holiday Time Increase"; Rec."% Holiday Time Increase")
                {
                    ApplicationArea = All;
                    Caption = '% de aumento del tiempo de vacaciones';
                    ToolTip = '% de aumento del tiempo de vacaciones';
                }
                field("Price Holiday Hour"; Rec."Price Holiday Hour")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Vacaciones Hora';
                    ToolTip = 'Precio Vacaciones Hora';
                }
                field("% Holiday Night  Time Increase"; Rec."% Holiday Night  Time Increase")
                {
                    ApplicationArea = All;
                    Caption = '% de aumento de tiempo de noche de vacaciones';
                    ToolTip = '% de aumento de tiempo de noche de vacaciones';
                }
                field("Price Holiday Night"; Rec."Price Holiday Night")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Noche Festiva';
                    ToolTip = 'Precio Noche Festiva';
                }
            }
        }
    }

    actions
    {
    }
}