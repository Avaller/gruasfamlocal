/// <summary>
/// Page Service Item Rate List (ID 50014).
/// </summary>
page 50014 "Service Item Rate List"
{
    Caption = 'Service Item Tariffs';
    CardPageID = "Service Item Card"; //TODO: No se encontraba "Service Item Rate Card", asi que lo sustitui por lo mas similar
    Editable = false;
    PageType = List;
    SourceTable = "Service Item Rate Header_LDR";

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
                field("Valid Start Date"; Rec."Valid Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de inicio válida';
                    ToolTip = 'Fecha de inicio válida';
                }
                field("Valid End Date"; Rec."Valid End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de finalización válida';
                    ToolTip = 'Fecha de finalización válida';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Estado';
                    ToolTip = 'Estado';
                }
            }
        }
    }

    actions
    {
    }
}