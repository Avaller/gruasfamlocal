/// <summary>
/// PageExtension LocationCard_LDR (ID 50104) extends Record Location Card.
/// </summary>
pageextension 50104 "LocationCard_LDR" extends "Location Card"
{
    layout
    {
        addafter("Use As In-Transit")
        {
            field("Show in Warehouse Device_LDR"; Rec."Show in Warehouse Device_LDR")
            {
                ApplicationArea = All;
                Caption = 'Mostrar en dispositivo de almacén';
                ToolTip = 'Mostrar en dispositivo de almacén';
            }
        }
        addafter(Contact)
        {
            field("Main Location Code_LDR"; Rec."Main Location Code_LDR")
            {
                ApplicationArea = All;
                Caption = 'Código de ubicación principal';
                ToolTip = 'Código de ubicación principal';
            }
            field("Linked Machine Resource_LDR"; Rec."Linked Machine Resource_LDR")
            {
                ApplicationArea = All;
                Caption = 'Recurso de máquina vinculada';
                ToolTip = 'Recurso de máquina vinculada';
            }
            field("Responsibility Center_LDR"; Rec."Responsibility Center_LDR")
            {
                ApplicationArea = All;
                Caption = 'Centro de responsabilidad';
                ToolTip = 'Centro de responsabilidad';
            }
        }
    }
}