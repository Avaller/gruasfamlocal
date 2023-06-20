/// <summary>
/// Page Crane Serv. Quote Calendar (ID 50075).
/// </summary>
page 50075 "Crane Serv. Quote Calendar"
{
    Caption = 'Crane Serv. Quote Calendar';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Crane Serv Q. Forf Calend_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                    ToolTip = 'Procesado';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Factura';
                    ToolTip = 'No de Factura';
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                    Caption = 'No de Operación';
                    ToolTip = 'No de Operación';
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción de Operación';
                    ToolTip = 'Descripción de Operación';
                }
            }
        }
    }
}