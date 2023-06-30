/// <summary>
/// PageExtension ShippingAgents_LDR (ID 50077) extends Record Shipping Agents.
/// </summary>
pageextension 50077 "ShippingAgents_LDR" extends "Shipping Agents"
{
    layout
    {
        addafter("Internet Address")
        {
            field(Enrollment_LDR; Rec.Enrollment_LDR)
            {
                ApplicationArea = All;
                Caption = 'Inscripción';
                ToolTip = 'Inscripción';
            }
        }
        addafter("Account No.")
        {
            field("VAT Registration No._LDR"; Rec."VAT Registration No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de registro de IVA';
                ToolTip = 'Número de registro de IVA';
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