/// <summary>
/// PageExtension Ship-to Address_LDR (ID 50063) extends Record Ship-to Address.
/// </summary>
pageextension 50063 "Ship-to Address_LDR" extends "Ship-to Address"
{
    layout
    {
        addafter(Name)
        {
            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = All;
                Caption = 'Nombre';
                ToolTip = 'Nombre';
            }
        }
        addafter("Last Date Modified")
        {
            field("Last User Modified_LDR"; Rec."Last User Modified_LDR")
            {
                ApplicationArea = All;
                Caption = 'Último usuario modificado';
                ToolTip = 'Último usuario modificado';
            }
        }
    }

    actions
    {
        addafter("&Address")
        {
            //action("Show Alarms") //TODO: No encontrado
            //{
            //    ApplicationArea = All;
            //    Caption = 'Ver Alarmas';
            //    Image = ErrorFALedgerEntries;
            //
            //    RunObject = Page 70103;
            //    RunPageLink = Field5 = const(0),
            //                Field6 = field("Customer No."),
            //                Field7 = field("Code");
            //}
        }
    }
}