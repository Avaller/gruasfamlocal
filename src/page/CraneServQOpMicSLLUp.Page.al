/// <summary>
/// Page Crane Serv. Q.Op.Mic S.L. LUp (ID 50098).
/// </summary>
page 50098 "Crane Serv. Q.Op.Mic S.L. LUp"
{
    Caption = 'Crane Service Quote Operation Line - Other Services';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Crane Serv Q Op Mic S Line_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Concept Code"; Rec."Concept Code")
                {
                    ApplicationArea = All;
                    Caption = 'Codigo de Concepto';
                    ToolTip = 'Codigo de Concepto';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Cantidad';
                    ToolTip = 'Cantidad';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio de Unidad';
                    ToolTip = 'Precio de Unidad';
                }
            }
        }
    }
}