page 50092 "Serv. Item Sinester Card"
{
    // version FAM

    CaptionML = ENU = 'Serv. Item Sinister',
                ESP = 'Siniestro Producto Servicio';
    SourceTable = "Serv. Item Sinister_LDR";

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            ESP = 'General';
                field("Cod. Service Item"; Rec."Cod. Service Item")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Articulo de Servicio';
                    Editable = false;
                    ToolTip = 'Codigo de Articulo de Servicio';
                }
                field("Cod. Document"; Rec."Cod. Document")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Documento';
                    ToolTip = 'Codigo de Documento';
                }
                field("Company Description"; Rec."Company Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción de Compañia';
                    ToolTip = 'Descripción de Compañia';
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    Caption = 'No de Documento';
                    ToolTip = 'No de Documento';
                }
                field("Sinister Date"; Rec."Sinister Date")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha del Siniestro';
                    Editable = true;
                    ToolTip = 'Fecha del Siniestro';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre del Conductor';
                    ToolTip = 'Nombre del Conductor';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    MultiLine = true;
                    ToolTip = 'Descrpción';
                }
                field("Opposite Part"; Rec."Opposite Part")
                {
                    ApplicationArea = All;
                    Caption = 'Parte opuesta';
                    MultiLine = true;
                    ToolTip = 'Parte opuesta';
                }
            }
        }
    }
}

