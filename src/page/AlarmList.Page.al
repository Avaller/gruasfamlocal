page 50015 "Alarm List"
{
    Caption = 'Alarm List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Alarms_LDR;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field("Alarm No."; Rec."Alarm No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Alarma';
                    ToolTip = 'No de Alarma';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de inicio';
                    ToolTip = 'Fecha de inicio';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de fin';
                    ToolTip = 'Fecha de fin';
                }
                field("Message Type"; Rec."Message Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de mensaje';
                    ToolTip = 'Tipo de mensaje';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de fuente';
                    ToolTip = 'Tipo de fuente';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Fuente';
                    ToolTip = 'No de Fuente';
                }
                field("Source No. 2"; Rec."Source No. 2")
                {
                    ApplicationArea = All;
                    Caption = 'No de Fuente 2';
                    ToolTip = 'No de Fuente 2';
                }
                field(Message; Rec.Message)
                {
                    ApplicationArea = All;
                    Caption = 'Mensaje';
                    ToolTip = 'Mensaje';
                }
                field("Message 2"; Rec."Message 2")
                {
                    ApplicationArea = All;
                    Caption = 'Mensaje 2';
                    ToolTip = 'Mensaje 2';
                }
                field("Off on next use"; Rec."Off on next use")
                {
                    ApplicationArea = All;
                    Caption = 'Apagado en el próximo uso';
                    ToolTip = 'Apagado en el próximo uso';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'ID de usuario';
                    ToolTip = 'ID de usuario';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Alarm")
            {
                Caption = '&Alarm';

            }
        }
    }

}