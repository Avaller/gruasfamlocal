/// <summary>
/// Page Serv. Item Bin Ent. Jour Temp. (ID 50033).
/// </summary>
page 50033 "Serv. Item Bin Ent. Jour Temp."
{
    Caption = 'Service Item Bin Entry Journal Templates';
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Serv Item Entr Journ Templ_LDR";


    layout
    {
        area(content)
        {
            repeater(contents)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre';
                    ToolTip = 'Nombre';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field("Form ID"; Rec."Form ID")
                {
                    ApplicationArea = All;
                    Caption = 'ID de formulario';
                    ToolTip = 'ID de formulario';
                    Visible = false;
                }
                field("ID de informe de publicación"; Rec."Posting Report ID")
                {
                    ApplicationArea = All;
                    Caption = 'ID de informe de publicación';
                    ToolTip = 'ID de informe de publicación';
                    Visible = false;
                }
                field("Force Posting Report"; Rec."Force Posting Report")
                {
                    ApplicationArea = All;
                    Caption = 'Informe de publicación forzada';
                    ToolTip = 'Informe de publicación forzada';
                    Visible = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    Caption = 'Código fuente';
                    ToolTip = 'Código fuente';
                }
                field(Recurring; Rec.Recurring)
                {
                    ApplicationArea = All;
                    Caption = 'Periódico';
                    ToolTip = 'Periódico';
                }
                field("Test Report Name"; Rec."Test Report Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre del informe de prueba';
                    ToolTip = 'Nombre del informe de prueba';
                    Visible = false;
                }
                field("Form Name"; Rec."Form Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre del formulario';
                    ToolTip = 'Nombre del formulario';
                    Visible = false;
                }
                field("Posting Report Name"; Rec."Posting Report Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre del informe de publicación';
                    ToolTip = 'Nombre del informe de publicación';
                    Visible = false;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'Nº Serie';
                    ToolTip = 'Nº Serie';
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'Número de contabilización Serie';
                    ToolTip = 'Número de contabilización Serie';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Te&mplate")
            {
                Caption = 'Te&mplate';
                Image = Template;
                //TODO: Aqui habia un actión con una Page no existente

            }
        }
    }

}