/// <summary>
/// PageExtension Service Quote Lines_LDR (ID 50133) extends Record Service Quote Lines.
/// </summary>
pageextension 50133 "Service Quote Lines_LDR" extends "Service Quote Lines"
{
    layout
    {
        addafter("Fault Area Code")
        {
            field("Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
                Caption = 'Código de bandeja';
                ToolTip = 'Código de bandeja';
            }
        }
        addafter("Unit Cost (LCY)")
        {
            field("Convert to Order_LDR"; Rec."Convert to Order_LDR")
            {
                ApplicationArea = All;
                Caption = 'Convertir a pedido';
                ToolTip = 'Convertir a pedido';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        ServHeaderAux: Record "Service Header";
        txt001: Label 'Esta acci½n no se puede llevar a cabo con una Oferta Hist½rica';

}