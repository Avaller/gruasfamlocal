pageextension 50019 "Purchase Order" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(SendCustom)
        {
            action("Enviar a AS400")
            {
                ApplicationArea = All;
                Caption = 'Enviar a AS400';

                trigger OnAction()
                var
                    recPurchHeader: Record "Purchase Header";
                //reportAs400: Report 70008;
                begin
                    recPurchHeader.COPY(Rec);
                    recPurchHeader.SETRECFILTER();
                end;
            }
            Separator(Separator1)
            {

            }
            group("Print Labels")
            {
                Caption = 'Imprimir Etiquetado';
                Image = BarCode;
                action("Imprimir Intermec")
                {
                    ApplicationArea = All;
                    Caption = 'Imprimir Intermec';
                    Image = BarCode;

                    trigger OnAction()

                    begin

                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
}