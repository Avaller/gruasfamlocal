/// <summary>
/// PageExtension Contact List_LDR (ID 50090) extends Record Contact List.
/// </summary>
pageextension 50090 "Contact List_LDR" extends "Contact List"
{
    layout
    {
        addafter("Company Name")
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
                Caption = 'Dirección';
                ToolTip = 'Dirección';
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
                Caption = 'Ciudad';
                ToolTip = 'Ciudad';
            }
        }
        addafter("Fax No.")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
            }
            field("No. of Business Relations"; Rec."No. of Business Relations")
            {
                ApplicationArea = All;
                Caption = 'No. de Relaciones Comerciales';
                ToolTip = 'No. de Relaciones Comerciales';
            }
        }
        addafter("Language Code")
        {
            field("Organizational Level Code"; Rec."Organizational Level Code")
            {
                ApplicationArea = All;
                Caption = 'Código de nivel organizacional';
                ToolTip = 'Código de nivel organizacional';
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