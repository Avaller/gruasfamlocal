/// <summary>
/// PageExtension Sales&ReceivablesSetup_LDR (ID 50078) extends Record Sales & Receivables Setup.
/// </summary>
pageextension 50078 "Sales&ReceivablesSetup_LDR" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Archive Quotes and Orders")
        {
            field("CIF/NIF Obligatory_LDR"; Rec."CIF/NIF Obligatory_LDR")
            {
                ApplicationArea = All;
                Caption = 'CIF / NIF Obligatorio';
                ToolTip = 'CIF / NIF Obligatorio';
            }
            field("Create Payment Days_LDR"; Rec."Create Payment Days_LDR")
            {
                ApplicationArea = All;
                Caption = 'Crear Días de Pago';
                ToolTip = 'Crear Días de Pago';
            }
        }
    }
}