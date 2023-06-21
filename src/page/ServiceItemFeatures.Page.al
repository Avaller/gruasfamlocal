/// <summary>
/// Page Service Item Features (ID 50008).
/// </summary>
page 50008 "Service Item Features"
{
    Caption = 'Service Item Features';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Service Item Features_LDR";

    layout
    {
        area(content)
        {
            group(Crane1)
            {
                Caption = 'Dimensions';
                Visible = craneVisible;
                field("Height Gauge"; Rec."Height Gauge")
                {
                    ApplicationArea = All;
                    Caption = 'Medidor de altura';
                    ToolTip = 'Medidor de altura';
                }
                field("Wheel Measures"; Rec."Wheel Measures")
                {
                    ApplicationArea = All;
                    Caption = 'Medidas de ruedas';
                    ToolTip = 'Medidas de ruedas';
                }
                field("Total Distance"; Rec."Total Distance")
                {
                    ApplicationArea = All;
                    Caption = 'Distancia total';
                    ToolTip = 'Distancia total';
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = All;
                    Caption = 'Ancho';
                    ToolTip = 'Ancho';
                }
                field("Rear Cantilever"; Rec."Rear Cantilever")
                {
                    ApplicationArea = All;
                    Caption = 'Voladizo trasero';
                    ToolTip = 'Voladizo trasero';
                }
            }
            group(Crane2)
            {
                Caption = 'Base Features';
                Visible = craneVisible;
                field("Rear Supports"; Rec."Rear Supports")
                {
                    ApplicationArea = All;
                    Caption = 'Soportes traseros';
                    ToolTip = 'Soportes traseros';
                }
                field("Width Front Supports"; Rec."Width Front Supports")
                {
                    ApplicationArea = All;
                    Caption = 'Ancho Soportes Delanteros';
                    ToolTip = 'Ancho Soportes Delanteros';
                }
                field(Tires; Rec.Tires)
                {
                    ApplicationArea = All;
                    Caption = 'Neumáticos';
                    ToolTip = 'Neumáticos';
                }
                field("Electric Brake"; Rec."Electric Brake")
                {
                    ApplicationArea = All;
                    Caption = 'Freno eléctrico';
                    ToolTip = 'Freno eléctrico';
                }
                field("Spare Wheel"; Rec."Spare Wheel")
                {
                    ApplicationArea = All;
                    Caption = 'Rueda de repuesto';
                    ToolTip = 'Rueda de repuesto';
                }
                field("Pressure Control Supports"; Rec."Pressure Control Supports")
                {
                    ApplicationArea = All;
                    Caption = 'Soportes de control de presión';
                    ToolTip = 'Soportes de control de presión';
                }
                field("Base Counterweight"; Rec."Base Counterweight")
                {
                    ApplicationArea = All;
                    Caption = 'Contrapeso base';
                    ToolTip = 'Contrapeso base';
                }
                field("Maximum Counterweight"; Rec."Maximum Counterweight")
                {
                    ApplicationArea = All;
                    Caption = 'Contrapeso máximo';
                    ToolTip = 'Contrapeso máximo';
                }
                field("Maximum capacity"; Rec."Maximum capacity")
                {
                    ApplicationArea = All;
                    Caption = 'Maxima capacidad';
                    ToolTip = 'Maxima capacidad';
                }
                field("Maximum Slope"; Rec."Maximum Slope")
                {
                    ApplicationArea = All;
                    Caption = 'Pendiente máxima';
                    ToolTip = 'Pendiente máxima';
                }
                field("Total Weight"; Rec."Total Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Peso total';
                    ToolTip = 'Peso total';
                }
            }
            group(Crane3)
            {
                Caption = 'Wheelbase Information';
                Visible = craneVisible;
                field("Axles Traction Direction"; Rec."Axles Traction Direction")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de tracción de los ejes';
                    ToolTip = 'Dirección de tracción de los ejes';
                }
                field("Wheelbase 1-2"; Rec."Wheelbase 1-2")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 1-2';
                    ToolTip = 'distancia entre ejes 1-2';
                }
                field("Wheelbase 2-3"; Rec."Wheelbase 2-3")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 2-3';
                    ToolTip = 'distancia entre ejes 2-3';
                }
                field("Wheelbase 3-4"; Rec."Wheelbase 3-4")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 3-4';
                    ToolTip = 'distancia entre ejes 3-4';
                }
                field("Wheelbase 4-5"; Rec."Wheelbase 4-5")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 4-5';
                    ToolTip = 'distancia entre ejes 4-5';
                }
                field("Wheelbase 5-6"; Rec."Wheelbase 5-6")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 5-6';
                    ToolTip = 'distancia entre ejes 5-6';
                }
                field("Wheelbase 6-7"; Rec."Wheelbase 6-7")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 6-7';
                    ToolTip = 'distancia entre ejes 6-7';
                }
                field("Wheelbase 7-8"; Rec."Wheelbase 7-8")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 7-8';
                    ToolTip = 'distancia entre ejes 7-8';
                }
            }
            group(Crane4)
            {
                Caption = 'Structure Features';
                Visible = craneVisible;
                field("Maximun Load"; Rec."Maximun Load")
                {
                    ApplicationArea = All;
                    Caption = 'Carga Maxima';
                    ToolTip = 'Carga Maxima';
                }
                field("Type Crane Model"; Rec."Type Crane Model")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo Modelo de grúa';
                    ToolTip = 'Tipo Modelo de grúa';
                }
                field("Jib Lenght"; Rec."Jib Lenght")
                {
                    ApplicationArea = All;
                    Caption = 'Longitud de pluma';
                    ToolTip = 'Longitud de pluma';
                }
                field("Jib Extension"; Rec."Jib Extension")
                {
                    ApplicationArea = All;
                    Caption = 'Extensión de pluma';
                    ToolTip = 'Extensión de pluma';
                }
                field("Winches Maximun Load"; Rec."Winches Maximun Load")
                {
                    ApplicationArea = All;
                    Caption = 'Carga máxima de cabrestantes';
                    ToolTip = 'Carga máxima de cabrestantes';
                }
                field("Remote Control"; Rec."Remote Control")
                {
                    ApplicationArea = All;
                    Caption = 'Control remoto';
                    ToolTip = 'Control remoto';
                }
                field("No. Winches"; Rec."No. Winches")
                {
                    ApplicationArea = All;
                    Caption = 'No. Cabrestantes';
                    ToolTip = 'No. Cabrestantes';
                }
                field(Nib; Rec.Nib)
                {
                    ApplicationArea = All;
                    Caption = 'Punta';
                    ToolTip = 'Punta';
                }
                field("Retractable Nib Lenght"; Rec."Retractable Nib Lenght")
                {
                    ApplicationArea = All;
                    Caption = 'Longitud de la punta retráctil';
                    ToolTip = 'Longitud de la punta retráctil';
                }
                field(Hooks; Rec.Hooks)
                {
                    ApplicationArea = All;
                    Caption = 'Ganchos';
                    ToolTip = 'Ganchos';
                }
                field(Runner; Rec.Runner)
                {
                    ApplicationArea = All;
                    Caption = 'Corredor';
                    ToolTip = 'Corredor';
                }
                field("Work Area Limiter"; Rec."Work Area Limiter")
                {
                    ApplicationArea = All;
                    Caption = 'Limitador de área de trabajo';
                    ToolTip = 'Limitador de área de trabajo';
                }
                field(Anemometer; Rec.Anemometer)
                {
                    ApplicationArea = All;
                    Caption = 'Anemómetro';
                    ToolTip = 'Anemómetro';
                }
                field(Superlift; Rec.Superlift)
                {
                    ApplicationArea = All;
                    Caption = 'Superelevador';
                    ToolTip = 'Superelevador';
                }
                field(Control; Rec.Control)
                {
                    ApplicationArea = All;
                    Caption = 'Control';
                    ToolTip = 'Control';
                }
                field("Working Lights"; Rec."Working Lights")
                {
                    ApplicationArea = All;
                    Caption = 'Luces de trabajo';
                    ToolTip = 'Luces de trabajo';
                }
                field(Others; Rec.Others)
                {
                    ApplicationArea = All;
                    Caption = 'Otros';
                    ToolTip = 'Otros';
                }
                field("Light Airplane"; Rec."Light Airplane")
                {
                    ApplicationArea = All;
                    Caption = 'Avión ligero';
                    ToolTip = 'Avión ligero';
                }
                field(Variousbase; Rec.Variousbase)
                {
                    ApplicationArea = All;
                    Caption = 'Base variada';
                    ToolTip = 'Base variada';
                }
                field("Additional Feather"; Rec."Additional Feather")
                {
                    ApplicationArea = All;
                    Caption = 'Pluma adicional';
                    ToolTip = 'Pluma adicional';
                }
                field("<Additional Feather Desc.>"; Rec."Additional Feather Desc.")
                {
                    ApplicationArea = All;
                    Caption = 'Additional Feather Desc.';
                    ToolTip = 'Desc. pluma adicional';
                }
            }
            group(Truck1)
            {
                Caption = 'Dimensions';
                Visible = TruckVisible;
                field("Height Gauge_2"; Rec."Height Gauge")
                {
                    ApplicationArea = All;
                    Caption = 'Medidor de altura';
                    ToolTip = 'Medidor de altura';
                }
                field("Total Distance_2"; Rec."Total Distance")
                {
                    ApplicationArea = All;
                    Caption = 'Distancia total';
                    ToolTip = 'Distancia total';
                }
                field("Rear Cantilever_2"; Rec."Rear Cantilever")
                {
                    ApplicationArea = All;
                    Caption = 'Voladizo trasero';
                    ToolTip = 'Voladizo trasero';
                }
                field(Width_2; Rec.Width)
                {
                    ApplicationArea = All;
                    Caption = 'Ancho';
                    ToolTip = 'Ancho';
                }
            }
            group(Truck2)
            {
                Caption = 'Base Features';
                Visible = TruckVisible;
                field("Maximun Load_2"; Rec."Maximun Load")
                {
                    ApplicationArea = All;
                    Caption = 'Carga máxima';
                    ToolTip = 'Carga máxima';
                }
                field("Rear Supports_2"; Rec."Rear Supports")
                {
                    ApplicationArea = All;
                    Caption = 'Soportes traseros';
                    ToolTip = 'Soportes traseros';
                }
                field("Width Front Supports_2"; Rec."Width Front Supports")
                {
                    ApplicationArea = All;
                    Caption = 'Ancho Soportes Delanteros';
                    ToolTip = 'Ancho Soportes Delanteros';
                }
                field(Tires_2; Rec.Tires)
                {
                    ApplicationArea = All;
                    Caption = 'Llantas';
                    ToolTip = 'Llantas';
                }
                field("Electric Brake_2"; Rec."Electric Brake")
                {
                    ApplicationArea = All;
                    Caption = 'Freno eléctrico';
                    ToolTip = 'Freno eléctrico';
                }
                field("Spare Wheel_2"; Rec."Spare Wheel")
                {
                    ApplicationArea = All;
                    Caption = 'Rueda de repuesto';
                    ToolTip = 'Rueda de repuesto';
                }
                field("Wheel Measures_2"; Rec."Wheel Measures")
                {
                    ApplicationArea = All;
                    Caption = 'Medidas de ruedas';
                    ToolTip = 'Medidas de ruedas';
                }
                field("Pressure Control Supports_2"; Rec."Pressure Control Supports")
                {
                    ApplicationArea = All;
                    Caption = 'Soportes de control de presión';
                    ToolTip = 'Soportes de control de presión';
                }
                field(Others_2; Rec.Others)
                {
                    ApplicationArea = All;
                    Caption = 'Otros';
                    ToolTip = 'Otros';
                }
                field("Maximum Load Drag - trailer"; Rec."Maximum Load Drag - trailer")
                {
                    ApplicationArea = All;
                    Caption = 'Arrastre máximo de carga: remolque';
                    ToolTip = 'Arrastre máximo de carga: remolque';
                }
                field("Admit Trailers_2"; Rec."Admit Trailers")
                {
                    ApplicationArea = All;
                    Caption = 'Admitir remolques';
                    ToolTip = 'Admitir remolques';
                }
                field("Maximum capacity_2"; Rec."Maximum capacity")
                {
                    ApplicationArea = All;
                    Caption = 'Maxima capacidad';
                    ToolTip = 'Maxima capacidad';
                }
                field("Maximum Slope_2"; Rec."Maximum Slope")
                {
                    ApplicationArea = All;
                    Caption = 'Pendiente máxima';
                    ToolTip = 'Pendiente máxima';
                }
                field("Total Weight_2"; Rec."Total Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Peso total';
                    ToolTip = 'Peso total';
                }
            }
            group(Truck3)
            {
                Caption = 'Wheelbase Information';
                Visible = TruckVisible;
                field("Axles Traction Direction_2"; Rec."Axles Traction Direction")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de tracción de los ejes';
                    ToolTip = 'Dirección de tracción de los ejes';
                }
                field("Wheelbase 1-2_2"; Rec."Wheelbase 1-2")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 1-2';
                    ToolTip = 'distancia entre ejes 1-2';
                }
                field("Wheelbase 2-3_2"; Rec."Wheelbase 2-3")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 2-3';
                    ToolTip = 'distancia entre ejes 2-3';
                }
                field("Wheelbase 3-4_2"; Rec."Wheelbase 3-4")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 3-4';
                    ToolTip = 'distancia entre ejes 3-4';
                }
                field("Wheelbase 4-5_2"; Rec."Wheelbase 4-5")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 4-5';
                    ToolTip = 'distancia entre ejes 4-5';
                }
                field("Wheelbase 5-6_2"; Rec."Wheelbase 5-6")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 5-6';
                    ToolTip = 'distancia entre ejes 5-6';
                }
                field("Wheelbase 6-7_2"; Rec."Wheelbase 6-7")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 6-7';
                    ToolTip = 'distancia entre ejes 6-7';
                }
                field("Wheelbase 7-8_2"; Rec."Wheelbase 7-8")
                {
                    ApplicationArea = All;
                    Caption = 'distancia entre ejes 7-8';
                    ToolTip = 'distancia entre ejes 7-8';
                }
                field("5th Wheel to Last Distance_2"; Rec."5th Wheel to Last Distance")
                {
                    ApplicationArea = All;
                    Caption = '5ª rueda hasta la última distancia';
                    ToolTip = '5ª rueda hasta la última distancia';
                }
            }
            group(Truck4)
            {
                Caption = 'Structure Features';
                Visible = TruckVisible;
                field(JIB; Rec.JIB)
                {
                    ApplicationArea = All;
                    Caption = 'JIB';
                    ToolTip = 'JIB';
                }
                field(Bed; Rec.Bed)
                {
                    ApplicationArea = All;
                    Caption = 'Cama';
                    ToolTip = 'Cama';
                }
                field("Type Crane Model_2"; Rec."Type Crane Model")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo Modelo de grúa';
                    ToolTip = 'Tipo Modelo de grúa';
                }
                field("Jib Lenght_2"; Rec."Jib Lenght")
                {
                    ApplicationArea = All;
                    Caption = 'Longitud de pluma';
                    ToolTip = 'Longitud de pluma';
                }
                field("Jib Extension_2"; Rec."Jib Extension")
                {
                    ApplicationArea = All;
                    Caption = 'Extensión de pluma';
                    ToolTip = 'Extensión de pluma';
                }
                field("Winches Maximun Load_2"; Rec."Winches Maximun Load")
                {
                    ApplicationArea = All;
                    Caption = 'Carga máxima de cabrestantes';
                    ToolTip = 'Carga máxima de cabrestantes';
                }
                field("Remote Control_2"; Rec."Remote Control")
                {
                    ApplicationArea = All;
                    Caption = 'Control remoto';
                    ToolTip = 'Control remoto';
                }
                field("No. Winches_2"; Rec."No. Winches")
                {
                    ApplicationArea = All;
                    Caption = 'No. Cabrestantes';
                    ToolTip = 'No. Cabrestantes';
                }
                field(Hooks_2; Rec.Hooks)
                {
                    ApplicationArea = All;
                    Caption = 'Anzuelos';
                    ToolTip = 'Anzuelos';
                }
                field("Working Lights_2"; Rec."Working Lights")
                {
                    ApplicationArea = All;
                    Caption = 'Luces de trabajo';
                    ToolTip = 'Luces de trabajo';
                }
            }
            group(Platform1)
            {
                Caption = 'Dimensions';
                Visible = PlatformVisible;
                field("Height Gauge_3"; Rec."Height Gauge")
                {
                    ApplicationArea = All;
                    Caption = 'Medidor de altura';
                    ToolTip = 'Medidor de altura';
                }
                field("Total Distance_3"; Rec."Total Distance")
                {
                    ApplicationArea = All;
                    Caption = 'Distancia total';
                    ToolTip = 'Distancia total';
                }
            }
            group(Platform2)
            {
                Caption = 'General';
                Visible = PlatformVisible;
                field("Maximun Load_3"; Rec."Maximun Load")
                {
                    ApplicationArea = All;
                    Caption = 'Carga máxima';
                    ToolTip = 'Carga máxima';
                }
                field("Axles Traction Direction_3"; Rec."Axles Traction Direction")
                {
                    ApplicationArea = All;
                    Caption = 'Dirección de tracción de los ejes';
                    ToolTip = 'Dirección de tracción de los ejes';
                }
                field(Tires_3; Rec.Tires)
                {
                    ApplicationArea = All;
                    Caption = 'Llantas';
                    ToolTip = 'Llantas';
                }
                field("Wheel Measures_3"; Rec."Wheel Measures")
                {
                    ApplicationArea = All;
                    Caption = 'Medidas de ruedas';
                    ToolTip = 'Medidas de ruedas';
                }
                field(Others_3; Rec.Others)
                {
                    ApplicationArea = All;
                    Caption = 'Otros';
                    ToolTip = 'Otros';
                }
                field("Power System_3"; Rec."Power System")
                {
                    ApplicationArea = All;
                    Caption = 'Sistema de poder';
                    ToolTip = 'Sistema de poder';
                }
                field("Speed Translation_3"; Rec."Speed Translation")
                {
                    ApplicationArea = All;
                    Caption = 'Traducción rápida';
                    ToolTip = 'Traducción rápida';
                }
                field("Turning Radius_3"; Rec."Turning Radius")
                {
                    ApplicationArea = All;
                    Caption = 'Radio de giro';
                    ToolTip = 'Radio de giro';
                }
                field("Maximum Slope_3"; Rec."Maximum Slope")
                {
                    ApplicationArea = All;
                    Caption = 'Pendiente máxima';
                    ToolTip = 'Pendiente máxima';
                }
                field(Power_3; Rec.Power)
                {
                    ApplicationArea = All;
                    Caption = 'Fuerza';
                    ToolTip = 'Fuerza';
                }
                field("Total Weight_3"; Rec."Total Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Total Weight';
                    ToolTip = 'Total Weight';
                }
                field("Rear Range"; Rec."Rear Range")
                {
                    ApplicationArea = All;
                    Caption = 'Reorganizar';
                    ToolTip = 'Reorganizar';
                }
            }
            group(Platform3)
            {
                Caption = 'Platform';
                Visible = PlatformVisible;
                field("Working Height_3"; Rec."Working Height")
                {
                    ApplicationArea = All;
                    Caption = 'Altura de trabajo';
                    ToolTip = 'Altura de trabajo';
                }
                field("Platform Height_3"; Rec."Platform Height")
                {
                    ApplicationArea = All;
                    Caption = 'Altura de la plataforma';
                    ToolTip = 'Altura de la plataforma';
                }
                field("Maximum capacity_3"; Rec."Maximum capacity")
                {
                    ApplicationArea = All;
                    Caption = 'Maxima capacidad';
                    ToolTip = 'Maxima capacidad';
                }
                field(Width_3; Rec.Width)
                {
                    ApplicationArea = All;
                    Caption = 'Ancho';
                    ToolTip = 'Ancho';
                }
                field("Extended Dimensions_3"; Rec."Extended Dimensions")
                {
                    ApplicationArea = All;
                    Caption = 'Dimensiones extendidas';
                    ToolTip = 'Dimensiones extendidas';
                }
                field("Height Retracted Railings"; Rec."Height Retracted Railings")
                {
                    ApplicationArea = All;
                    Caption = 'Barandillas Retraídas en Altura';
                    ToolTip = 'Barandillas Retraídas en Altura';
                }
                field("Retracted Height"; Rec."Retracted Height")
                {
                    ApplicationArea = All;
                    Caption = 'Altura retraída';
                    ToolTip = 'Altura retraída';
                }
                field("Upload-Download Time"; Rec."Upload-Download Time")
                {
                    ApplicationArea = All;
                    Caption = 'Tiempo de carga y descarga';
                    ToolTip = 'Tiempo de carga y descarga';
                }
                field("Point Articulation"; Rec."Point Articulation")
                {
                    ApplicationArea = All;
                    Caption = 'Punto de articulación';
                    ToolTip = 'Punto de articulación';
                }
                field("Platform Dimensions"; Rec."Platform Dimensions")
                {
                    ApplicationArea = All;
                    Caption = 'Dimensiones de la plataforma';
                    ToolTip = 'Dimensiones de la plataforma';
                }
                field("Retracted Long"; Rec."Retracted Long")
                {
                    ApplicationArea = All;
                    Caption = 'Retraído largo';
                    ToolTip = 'Retraído largo';
                }
                field("Maximum Range"; Rec."Maximum Range")
                {
                    ApplicationArea = All;
                    Caption = 'Rango maximo';
                    ToolTip = 'Rango maximo';
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = All;
                    Caption = 'Longitud';
                    ToolTip = 'Longitud';
                }
                field(Height; Rec.Height)
                {
                    ApplicationArea = All;
                    Caption = 'Altura';
                    ToolTip = 'Altura';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        ServItem.GET(Rec."Service Item No.");
        ServItemType.GET(ServItem."Service Item Type Code_LDR");


        CraneVisible := ServItemType."Features Type" = ServItemType."Features Type"::Crane;
        TruckVisible := ServItemType."Features Type" = ServItemType."Features Type"::Truck;
        PlatformVisible := ServItemType."Features Type" = ServItemType."Features Type"::Platform;
    end;

    var
        ServItem: Record "Service Item";
        ServItemType: Record "Service Item Type_LDR";
        CraneVisible: Boolean;
        TruckVisible: Boolean;
        PlatformVisible: Boolean;
}