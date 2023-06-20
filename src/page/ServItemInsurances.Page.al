/// <summary>
/// Page Serv. Item Insurances (ID 50064).
/// </summary>
page 50064 "Serv. Item Insurances"
{
    Caption = 'Service Item Insurances';
    PageType = List;
    SourceTable = "Serv. Item Insuranc/Author_LDR";
    SourceTableView = where("Document Type" = const("insurance"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Serv. Item No."; Rec."Serv. Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Serv. Artículo No.';
                    ToolTip = 'Serv. Artículo No.';
                    Visible = false;
                }
                field("Document Code"; Rec."Document Code")
                {
                    ApplicationArea = All;
                    Caption = 'Coverage Type';
                    ToolTip = 'Coverage Type';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de Documento';
                    ToolTip = 'Tipo de Documento';
                    Visible = false;
                }
                field("Company Description"; Rec."Company Description")
                {
                    ApplicationArea = All;
                    Caption = 'Insurance Company';
                    ToolTip = 'Insurance Company';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Policy No.';
                    ToolTip = 'Policy No.';
                }
                field("Serv. Item Operation Code"; Rec."Serv. Item Operation Code")
                {
                    ApplicationArea = All;
                    Caption = 'Serv. Artículo Código de operación';
                    ToolTip = 'Serv. Artículo Código de operación';
                }
            }
        }
    }
}