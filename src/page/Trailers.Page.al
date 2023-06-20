/// <summary>
/// Page Trailers (ID 50002).
/// </summary>
page 50002 Trailers
{
    Caption = 'Trailers';
    PageType = List;
    SourceTable = "Trailers_LDR";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Codigo';
                    ToolTip = 'Codigo';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción';
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = All;
                    Caption = 'Longitud';
                    ToolTip = 'Longitud';
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = All;
                    Caption = 'Ancho';
                    ToolTip = 'Ancho';
                }
                field("Bed Height"; Rec."Bed Height")
                {
                    ApplicationArea = All;
                    Caption = 'Altura de la cama';
                    ToolTip = 'Altura de la cama';
                }
                field("Neck Height"; Rec."Neck Height")
                {
                    ApplicationArea = All;
                    Caption = 'Altura del cuello';
                    ToolTip = 'Altura del cuello';
                }
                field("Distance Between Axis 1-2"; Rec."Distance Between Axis 1-2")
                {
                    ApplicationArea = All;
                    Caption = 'Distancia entre ejes 1-2';
                    ToolTip = 'Distancia entre ejes 1-2';
                }
                field("Distance Between Axis 2-3"; Rec."Distance Between Axis 2-3")
                {
                    ApplicationArea = All;
                    Caption = 'Distancia entre ejes 2-3';
                    ToolTip = 'Distancia entre ejes 2-3';
                }
                field("Distance Between Axis 3-4"; Rec."Distance Between Axis 3-4")
                {
                    ApplicationArea = All;
                    Caption = 'Distancia entre ejes 3-4';
                    ToolTip = 'Distancia entre ejes 3-4';
                }
                field("Distance Between Axis 4-5"; Rec."Distance Between Axis 4-5")
                {
                    ApplicationArea = All;
                    Caption = 'Distancia entre ejes 4-5';
                    ToolTip = 'Distancia entre ejes 4-5';
                }
                field("Distance Between Axis 5-6"; Rec."Distance Between Axis 5-6")
                {
                    ApplicationArea = All;
                    Caption = 'Distancia entre ejes 5-6';
                    ToolTip = 'Distancia entre ejes 5-6';
                }
                field("Fifth wheel Distance"; Rec."Fifth wheel Distance")
                {
                    ApplicationArea = All;
                    Caption = 'Distancia de la quinta rueda';
                    ToolTip = 'Distancia de la quinta rueda';
                }
                field(Overhang; Rec.Overhang)
                {
                    ApplicationArea = All;
                    Caption = 'Sobresalir';
                    ToolTip = 'Sobresalir';
                }
                field("Rear Overhang"; Rec."Rear Overhang")
                {
                    ApplicationArea = All;
                    Caption = 'Voladizo trasero';
                    ToolTip = 'Voladizo trasero';
                }
                field(Tare; Rec.Tare)
                {
                    ApplicationArea = All;
                    Caption = 'Tarea';
                    ToolTip = 'Tarea';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Tipo';
                    ToolTip = 'Tipo';
                }
                field("Max Charge"; Rec."Max Charge")
                {
                    ApplicationArea = All;
                    Caption = 'Carga Maxima';
                    ToolTip = 'Carga Maxima';
                }
            }
        }
    }
}