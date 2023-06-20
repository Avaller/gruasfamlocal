/// <summary>
/// Page Service Item Group Templates (ID 50036).
/// </summary>
page 50036 "Service Item Group Templates"
{
    // CIC IALFONSO 20070308 Este formulario representa la lista de plantillas asociadas a un grupo de producto servicio

    Caption = 'Service Item Group Templates';
    PageType = List;
    SourceTable = "Service Item Group Templat_LDR";

    layout
    {
        area(content)
        {
            repeater(Fields)
            {
                field("Service Item Group Code"; Rec."Service Item Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de grupo de artículo de servicio';
                    ToolTip = 'Código de grupo de artículo de servicio';
                    Visible = false;
                }
                field("Service Template Code"; Rec."Service Template Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código de plantilla de servicio';
                    ToolTip = 'Código de plantilla de servicio';
                }
                field("Service Template Description"; Rec."Service Template Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción de la plantilla de servicio';
                    ToolTip = 'Descripción de la plantilla de servicio';
                }
            }
        }
    }
}