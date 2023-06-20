/// <summary>
/// Page Crane Serv. Q. Op. Inv. G Card (ID 50031).
/// </summary>
page 50031 "Crane Serv. Q. Op. Inv. G Card"
{
    Caption = 'Ficha Grupo Facturacion oferta de Grúa';
    PaGetype = Card;
    SourceTable = "Crane Serv Q Op Inv G Line_LDR";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Invoice Group No."; Rec."Invoice Group No.")
                {
                    ApplicationArea = All;
                    Caption = 'Número de grupo de facturas';
                    ToolTip = 'Número de grupo de facturas';
                }
                field("Invoice Group Description"; Rec."Invoice Group Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción del grupo de facturas';
                    ToolTip = 'Descripción del grupo de facturas';
                }
                field("Vehicles Number"; Rec."Vehicles Number")
                {
                    ApplicationArea = All;
                    Caption = 'Número de vehículos';
                    ToolTip = 'Número de vehículos';
                }
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    Caption = 'No. de tarifa';
                    ToolTip = 'No. de tarifa';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ServiceItemInvoiceGroup: Record "Service Item Invoice Group_LDR";
                        ServiceItemRateLineCrane: Record "Servic Item Rat Li - Crane_LDR";
                        ServiceItemRateLinePlatf: Record "Servic Item Rat Lin - Plat_LDR";
                        pageServItemRateCrane: Page "Service Item Prices_LDR";
                        pageServItemRatePlatf: Page "Serv. Item Bin Ent. Jour Temp.";
                    begin
                        Rec.Testfield(Rec."Invoice Group No.");
                        ServiceItemInvoiceGroup.Get(Rec."Invoice Group No.");

                        Case ServiceItemInvoiceGroup."Group Type" of
                            ServiceItemInvoiceGroup."Group Type"::Crane:
                                begin
                                    ServiceItemRateLineCrane.reset;
                                    ServiceItemRateLineCrane.FilterGroup(2);
                                    ServiceItemRateLineCrane.setRange("Invoice Group No.", Rec."Invoice Group No.");
                                    ServiceItemRateLineCrane.setRange("Header Status", ServiceItemRateLineCrane."Header Status"::Locked);
                                    ServiceItemRateLineCrane.FilterGroup(0);
                                    //ServiceItemRateLineCrane.setFilter("Header Valid Start Date",'..%1',workdate);
                                    ServiceItemRateLineCrane.setFilter("Header Valid end Date", '%1..', workdate);
                                    clear(pageServItemRateCrane);
                                    pageServItemRateCrane.setTableView(ServiceItemRateLineCrane);

                                    //CAS-19954-X1T1
                                    if Rec."Rate No." <> '' then begin
                                        ServiceItemRateLineCrane.setRange(Code, Rec."Rate No.");
                                        if ServiceItemRateLineCrane.FindFirst then
                                            pageServItemRateCrane.SetRecord(ServiceItemRateLineCrane);
                                    end;
                                    // FIN CAS-19954-X1T1

                                    pageServItemRateCrane.lookupmode(true);
                                    if pageServItemRateCrane.runmodal = action::LookupOK then begin
                                        pageServItemRateCrane.GetRecord(ServiceItemRateLineCrane);
                                        Rec.Validate(Rec."Rate No.", ServiceItemRateLineCrane.Code);
                                    end;

                                end;
                            ServiceItemInvoiceGroup."Group Type"::Platform:
                                begin

                                    Message('Tarifa Plataforma');
                                end;
                        end;
                    end;

                    trigger OnValidate();
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Rate Description"; Rec."Rate Description")
                {
                    ApplicationArea = All;
                    Caption = 'Tarifa Descripción';
                    DrillDown = false;
                    Lookup = false;
                    ToolTip = 'Tarifa Descripción';
                }
            }
            group(Displacement)
            {
                Caption = 'Desplazamiento';
                field("Invoice Displacement"; Rec."Invoice Displacement")
                {
                    ApplicationArea = All;
                    Caption = 'Desplazamiento de factura';
                    ToolTip = 'Desplazamiento de factura';
                }
                field("Displacement Type"; Rec."Displacement Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de desplazamiento';
                    ToolTip = 'Tipo de desplazamiento';

                    trigger OnValidate();
                    begin
                        Updatefields;
                    end;
                }
                field("Fill minimum with Displ."; Rec."Fill minimum with Displ.")
                {
                    ApplicationArea = All;
                    Caption = 'Rellenar mínimo con Display';
                    Editable = FillMinimumWithDisplacementEnabled;
                    ToolTip = 'Rellenar mínimo con Display';
                    Visible = false;
                }
                field("Apply standard KM"; Rec."Apply standard KM")
                {
                    ApplicationArea = All;
                    Caption = 'Aplicar KM estándar';
                    ToolTip = 'Aplicar KM estándar';

                    trigger OnValidate();
                    begin
                        Updatefields;
                    end;
                }
                field("Displacement Percent"; Rec."Displacement Percent")
                {
                    ApplicationArea = All;
                    Caption = 'Porcentaje de desplazamiento';
                    ToolTip = 'Porcentaje de desplazamiento';
                }
                field("KM Franchise"; Rec."KM Franchise")
                {
                    ApplicationArea = All;
                    Caption = 'Franquicia KM';
                    Editable = KMsFranchiseEnabled;
                    ToolTip = 'Franquicia KM';
                }
                field("KM-Time Qty."; Rec."KM-Time Qty.")
                {
                    ApplicationArea = All;
                    Caption = 'KM-Tiempo Cant.';
                    Enabled = KmsHoursEnabled;
                    ToolTip = 'KM-Tiempo Cant.';
                }
                field("Displacement Amount"; Rec."Displacement Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Cantidad de desplazamiento';
                    Enabled = KmsHoursEnabled;
                    ToolTip = 'Cantidad de desplazamiento';
                }
                field("Invoice Exit Fee"; Rec."Invoice Exit Fee")
                {
                    ApplicationArea = All;
                    Caption = 'Tarifa de salida de factura';
                    ToolTip = 'Tarifa de salida de factura';
                }
            }
            group(Minimums)
            {
                Caption = 'Mínimos';
                field("Minimum Treatment Type"; Rec."Minimum Treatment Type")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de tratamiento mínimo';
                    Enabled = false;
                    ToolTip = 'Tipo de tratamiento mínimo';
                }
                field("Minimum Laboral Hours"; Rec."Minimum Laboral Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas Laborales Mínimas';
                    ToolTip = 'Horas Laborales Mínimas';
                }
                field("Minimum Saturday Hours"; Rec."Minimum Saturday Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas mínimas de sábado';
                    ToolTip = 'Horas mínimas de sábado';
                }
                field("Minimum Holiday Hours"; Rec."Minimum Holiday Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas mínimas de vacaciones';
                    ToolTip = 'Horas mínimas de vacaciones';
                }
                field("Minimum Night Hours"; Rec."Minimum Night Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas mínimas de noche';
                    ToolTip = 'Horas mínimas de noche';
                }
            }
            group(Extras)
            {
                Caption = 'Extras';
                field("Misc. S Line Line No."; Rec."Misc. S Line Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Varios Línea S Número de línea';
                    ToolTip = 'Varios Línea S Número de línea';
                }
                field("Misc. S Line Description"; Rec."Misc. S Line Description")
                {
                    ApplicationArea = All;
                    Caption = 'Varios Descripción de la línea S';
                    ToolTip = 'Varios Descripción de la línea S';
                }
            }
            group(Forfait)
            {
                Caption = 'Forfait';
                Visible = ForfaitVisible;
                field("Maximum Hours"; Rec."Maximum Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Horas máximas';
                    ToolTip = 'Horas máximas';
                }
                field("Hour Price"; Rec."Hour Price")
                {
                    ApplicationArea = All;
                    Caption = 'Precio Hora';
                    Editable = false;
                    ToolTip = 'Precio Hora';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Co&mments")
            {
                Caption = 'C&omentarios';
                Image = ViewComments;
                RunObject = Page "Service Comment Sheet";
                RunPageLink = Type = const(General), "Table Subtype" = const(2), "Table Name" = const("Crane Quote"), "No." = field("Quote No."),
                              "Table Line No." = field("Operation Line No.");
            }
        }
    }

    trigger OnOpenPage();
    begin
        Updatefields;
        SetVisibility;
    end;

    var
        DisplacementCalcTypeEnabled: Boolean;
        KmsHoursEnabled: Boolean;
        QuoteHeader: Record "Crane Service Quote Header_LDR";
        FillMinimumWithDisplacementEnabled: Boolean;
        KMsFranchiseEnabled: Boolean;
        ApplyStandardKmsEnabled: Boolean;
        [InDataSet]
        ForfaitVisible: Boolean;

    local procedure Updatefields();
    begin
        if Rec."Displacement Type" = Rec."Displacement Type"::KMs then begin
            DisplacementCalcTypeEnabled := true;
            KMsFranchiseEnabled := true;
            ApplyStandardKmsEnabled := true;
        end else begin
            DisplacementCalcTypeEnabled := false;
            KMsFranchiseEnabled := false;
            ApplyStandardKmsEnabled := false;
        end;

        if Rec."Apply standard KM" then begin
            KmsHoursEnabled := false;
            KMsFranchiseEnabled := true;
        end else begin
            KmsHoursEnabled := true;
            KMsFranchiseEnabled := false;
        end;

        if Rec."Invoice Displacement" then
            FillMinimumWithDisplacementEnabled := true
        else
            FillMinimumWithDisplacementEnabled := false;
    end;

    local procedure SetVisibility();
    var
        CraneServiceQuote: Record "Crane Service Quote Header_LDR";
    begin
        // CIC Edicion del campo Importe forfait solo si la oferta es de tipo forfait
        if CraneServiceQuote.Get(Rec."Quote No.") then begin
            if CraneServiceQuote."Quote Type" = CraneServiceQuote."Quote Type"::Forfait then
                ForfaitVisible := true
            else
                ForfaitVisible := false;
        end;
    end;
}

