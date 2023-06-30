/// <summary>
/// PageExtension General Journal_LDR (ID 50012) extends Record General Journal.
/// </summary>
pageextension 50012 "General Journal_LDR" extends "General Journal"
{
    layout
    {
        addafter("Document Date")
        {
            field("Document Date2"; Rec."Document Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de Documento';
                ToolTip = 'Fecha de Documento';
            }
        }
        addafter("Document Type")
        {
            field("FA Posting Date"; Rec."FA Posting Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de publicación de FA';
                ToolTip = 'Fecha de publicación de FA';
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                Caption = 'Número de contabilización Serie';
                ToolTip = 'Número de contabilización Serie';
            }
            field("FA Posting Type"; Rec."FA Posting Type")
            {
                ApplicationArea = All;
                Caption = 'Tipo de publicación FA';
                ToolTip = 'Tipo de publicación FA';
            }
            field(Correction1; Rec.Correction)
            {
                ApplicationArea = All;
                Caption = 'Corrección';
                ToolTip = 'Corrección';
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Código de método de pago';
                ToolTip = 'Código de método de pago';
            }
            field("Depreciation Book Code"; Rec."Depreciation Book Code")
            {
                ApplicationArea = All;
                Caption = 'Código del libro de amortización';
                ToolTip = 'Código del libro de amortización';
            }
        }
        addafter("Document No.")
        {
            field("Register on Exploit Account_LDR"; Rec."Register on Exploit Account_LDR")
            {
                ApplicationArea = All;
                Caption = 'Regístrese en Exploit Cuenta';
                ToolTip = 'Regístrese en Exploit Cuenta';
            }
            field("Leasing No._LDR"; Rec."Leasing No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Nro. de arrendamiento';
                ToolTip = 'Nro. de arrendamiento';
            }
            field("Leasing Line No._LDR"; Rec."Leasing Line No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Número de línea de arrendamiento';
                ToolTip = 'Número de línea de arrendamiento';
            }
            field("Service Cost No._LDR"; Rec."Service Cost No._LDR")
            {
                ApplicationArea = All;
                Caption = 'Servicio Costo No.';
                ToolTip = 'Servicio Costo No.';
            }
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = All;
                Caption = 'Fecha de vencimiento';
                ToolTip = 'Fecha de vencimiento';
            }
        }
    }
}