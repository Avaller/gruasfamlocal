/// <summary>
/// Page Service Item Cancellation Type (ID 50001).
/// </summary>
page 50001 "Service Item Cancellation Type"
{
    Caption = 'Service Item Cancellation Type';
    PageType = List;
    SourceTable = "Cancellat Type Servic Item_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Codigo';
                    ToolTip = 'Codigo';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
            }
        }
    }
}