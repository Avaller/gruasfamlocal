/// <summary>
/// Page Service Item Subtype (ID 50009).
/// </summary>
page 50009 "Service Item Subtype"
{
    Caption = 'Service Item Subtype';
    PageType = List;
    Permissions = TableData "Service Item Type_LDR" = rimd;
    SourceTable = "Service Item Subtype_LDR";

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
                    Visible = false;
                }
                field("Service Item Subtype Code"; Rec."Service Item Subtype Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de subtipo de artículo de servicio';
                    ToolTip = 'Código de subtipo de artículo de servicio';
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

    actions
    {
    }
}