/// <summary>
/// PageExtension Employee List_LDR (ID 50092) extends Record Employee List.
/// </summary>
pageextension 50092 "Employee List_LDR" extends "Employee List"
{
    layout
    {
        addafter("Statistics Group Code")
        {
            field("Company Dependence_LDR"; Rec."Company Dependence_LDR")
            {
                ApplicationArea = All;
                Caption = 'Dependencia de la empresa';
                ToolTip = 'Dependencia de la empresa';
            }
        }
        addafter(Comment)
        {
            field("VAT Registration No._LDR"; Rec."VAT Registration No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
            field("Social Security No."; Rec."Social Security No.")
            {
                ApplicationArea = All;
                Caption = 'Número de seguridad social.';
                ToolTip = 'Número de seguridad social.';
            }
            field("Birth Date"; Rec."Birth Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de nacimiento';
                ToolTip = 'Fecha de nacimiento';
            }
            field("Employment Date"; Rec."Employment Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha empleo';
                ToolTip = 'Fecha empleo';
            }
            field("Tag Card No._LDR"; Rec."Tag Card No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Nro. de tarjeta de etiqueta';
                ToolTip = 'Nro. de tarjeta de etiqueta';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}