/// <summary>
/// PageExtension Service Quote_LDR (ID 50131) extends Record Service Quote.
/// </summary>
pageextension 50131 "Service Quote_LDR" extends "Service Quote"
{ //Page 5964
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Service Document Lo&g")
        {
            separator(" ")
            {

            }
            action(Serviceorder)
            {
                ApplicationArea = All;
                Caption = 'Pedido Servicio';
                Image = ViewServiceOrder;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}