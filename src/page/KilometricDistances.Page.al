/// <summary>
/// 
/// 
/// </summary>
page 50236 "Kilometric distances"
{
    // version ALQUINTA9.00,FAM

    Caption = 'Distancias Kilométricas';
    PageType = List;
    SourceTable = "Kilometric distance_LDR";

    layout
    {
        area(content)
        {
            repeater(fields)
            {
                field("From Post Code"; Rec."From Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Desde el Codigo de Envio';
                    ToolTip = 'Desde el Codigo de Envio';
                }
                field("From City"; Rec."From City")
                {
                    ApplicationArea = All;
                    Caption = 'Desde Ciudad';
                    ToolTip = 'Desde Ciudad';
                }
                field("From County"; Rec."From County")
                {
                    ApplicationArea = All;
                    Caption = 'Desde Pais';
                    ToolTip = 'Desde Pais';
                }
                field("To Post Code"; Rec."To Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'A Dirección de Envio';
                    ToolTip = 'A Dirección de Envio';
                }
                field("To City"; Rec."To City")
                {
                    ApplicationArea = All;
                    Caption = 'A Ciudad';
                    ToolTip = 'A Ciudad';
                }
                field("To County"; Rec."To County")
                {
                    ApplicationArea = All;
                    Caption = 'A Pais';
                    ToolTip = 'A Pais';
                }
                field("Distance (Km)"; Rec."Distance (Km)")
                {
                    ApplicationArea = All;
                    Caption = 'Distancia (Km)';
                    ToolTip = 'Distancia (Km)';
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                    Caption = 'Duración';
                    ToolTip = 'Duración';
                }
            }
        }
    }

    var
        PostCode: Record "Post Code";
}

