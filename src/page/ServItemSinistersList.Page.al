/// <summary>
/// Page Serv. Item Sinisters List (ID 50091).
/// </summary>
page 50091 "Serv. Item Sinisters List"
{
    Caption = 'Serv. Item Sinester';
    CardPageID = "Serv. Item Sinester Card";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Serv. Item Sinister_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Service Item"; Rec."Cod. Service Item")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Articulo de Servicio';
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
                    Caption = 'Fecha de Sinistro';
                    ToolTip = 'Fecha de Sinistro';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre de Conductor';
                    ToolTip = 'Nombre de Conductor';
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
            }
            systempart(Links; Links)
            {
            }
        }
    }
}