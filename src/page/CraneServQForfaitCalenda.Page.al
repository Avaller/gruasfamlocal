/// <summary>
/// Page Crane Serv. Q. Forfait Calenda (ID 50068).
/// </summary>
page 50068 "Crane Serv. Q. Forfait Calenda"
{
    AutoSplitKey = true;
    Caption = 'Crane Serv Q. Forfait Calendar';
    PageType = List;
    SourceTable = "Crane Serv Q. Forf Calend_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Cita';
                    ToolTip = 'No de Cita';
                    Visible = false;
                }
                field("Quote Op. Line No."; Rec."Quote Op. Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cita Op. No de línea';
                    ToolTip = 'Cita Op. No de línea';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Linea';
                    ToolTip = 'No de Linea';
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Operación';
                    ToolTip = 'No de Operación';
                    Visible = false;
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción de la Operación';
                    ToolTip = 'Descripción de la Operación';
                    Visible = false;
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = All;
                    Caption = 'Cita agendada';
                    ToolTip = 'Cita agendada';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Cantidad';
                    ToolTip = 'Cantidad';
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = All;
                    Caption = 'Procesado';
                    Editable = false;
                    ToolTip = 'Procesado';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Factura';
                    Editable = false;
                    ToolTip = 'No de Factura';
                }
            }
        }
    }
}