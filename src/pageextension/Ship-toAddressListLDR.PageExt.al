/// <summary>
/// PageExtension Ship-to Address List_LDR (ID 50064) extends Record Ship-to Address List.
/// </summary>
pageextension 50064 "Ship-to Address List_LDR" extends "Ship-to Address List"
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
        addafter("Post Code")
        {
            field(County; Rec.County)
            {
                ApplicationArea = All;
                Caption = 'Condado';
                ToolTip = 'Condado';
            }
        }
        addafter(Contact)
        {
            field("Service Zone Code"; Rec."Service Zone Code")
            {
                ApplicationArea = All;
                Caption = 'Código de zona de servicio';
                ToolTip = 'Código de zona de servicio';
            }
        }
    }
}