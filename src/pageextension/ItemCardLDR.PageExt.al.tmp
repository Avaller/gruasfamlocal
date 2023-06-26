pageextension 50008 "Item Card" extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("Large Description_LDR"; Rec."Large Description_LDR")
            {
                ApplicationArea = All;
                Caption = 'Descripción grande';
                ToolTip = 'Descripción grande';
            }
            field(EAN_LDR; Rec.EAN_LDR)
            {
                ApplicationArea = All;
                Caption = 'EAN';
                ToolTip = 'EAN';
            }
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                Caption = 'No';
                ToolTip = 'No';
            }
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                Caption = 'Descripción';
                ToolTip = 'Descripción';
            }
            field("Qty. in Transit_LDR"; Rec."Qty. in Transit")
            {
                ApplicationArea = All;
                Caption = 'Cantidad en Tránsito';
                ToolTip = 'Cantidad en Tránsito';
            }
        }
        addafter("Created From Nonstock Item")
        {
            field("Common Item No._LDR"; Rec."Common Item No.")
            {
                ApplicationArea = All;
                Caption = 'Artículo común n.º';
                ToolTip = 'Artículo común n.º';
                Importance = Additional;
            }
        }
        addafter("Stockkeeping Unit Exists")
        {
            field("Alternative Item No."; Rec."Alternative Item No.")
            {
                ApplicationArea = All;
                Caption = 'Número de artículo alternativo';
                ToolTip = 'Número de artículo alternativo';
            }
            field("Exclude armopa_LDR"; Rec."Exclude armopa_LDR")
            {
                ApplicationArea = All;
                Caption = 'Excluir armopa';
                ToolTip = 'Excluir armopa';
            }
        }
        addafter("Use Cross-Docking")
        {
            group(Features)
            {
                Caption = 'Caracter¡sticas';
                group(Group)
                {
                    field(Type2_LDR; Rec.Type2_LDR)
                    {
                        ApplicationArea = All;
                        Caption = 'Tipo';
                        ToolTip = 'Tipo';
                        trigger OnValidate()
                        begin
                            FormatearFormulario();
                        end;
                    }
                    field(Subtype_LDR; Rec.Subtype_LDR)
                    {
                        ApplicationArea = All;
                        Caption = 'Subtipo';
                        ToolTip = 'Subtipo';
                        trigger OnValidate()
                        begin
                            FormatearFormulario();
                        end;
                    }
                    field("Manufacturer Code_LDR"; Rec."Manufacturer Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Código del fabricante';
                        ToolTip = 'Código del fabricante';
                    }
                    field(Model_LDR; Rec.Model_LDR)
                    {
                        ApplicationArea = All;
                        Caption = 'Modelo';
                        Enabled = true;
                        ToolTip = 'Modelo';
                    }
                    field("Medea Code_LDR"; Rec."Medea Code_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Código Medea';
                        Enabled = true;
                        ToolTip = 'Código Medea';
                    }
                    field("Item Type_LDR"; Rec."Item Type_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Tipo de artículo';
                        Enabled = true;
                        ToolTip = 'Tipo de artículo';
                    }
                    field("Series Code_LDR"; Rec."Series Code_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Código de serie';
                        Enabled = true;
                        ToolTip = 'Código de serie';
                    }
                    field("Charge Capacity_LDR"; Rec."Charge Capacity_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Capacidad de carga';
                        Enabled = true;
                        ToolTip = 'Capacidad de carga';
                    }
                    field(Heightss_LDR; Rec.Heightss_LDR)
                    {
                        ApplicationArea = All;
                        Caption = 'Alturas';
                        Enabled = true;
                        ToolTip = 'Alturas';
                    }
                    field(Folded_LDR; Rec.Folded_LDR)
                    {
                        ApplicationArea = All;
                        Caption = 'Doblada';
                        Enabled = true;
                        ToolTip = 'Doblada';
                    }
                    field("Free Elevation_LDR"; Rec."Free Elevation_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Elevación libre';
                        Enabled = true;
                        ToolTip = 'Elevación libre';
                    }
                    field("Valid For_LDR"; Rec."Valid For_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Válido para';
                        Enabled = true;
                        ToolTip = 'Válido para';
                    }
                    field(Characteristics_LDR; Rec.Characteristics_LDR)
                    {
                        ApplicationArea = All;
                        Caption = 'Características';
                        ToolTip = 'Características';
                    }
                }
                group(group2)
                {
                    field("Bracket Length_LDR"; Rec."Bracket Length_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Longitud del soporte';
                        Enabled = true;
                        ToolTip = 'Longitud del soporte';
                    }
                    field("Bracket Gross_LDR"; Rec."Bracket Gross_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Soporte Bruto';
                        Enabled = true;
                        ToolTip = 'Soporte Bruto';
                    }
                    field("Bracket Width_LDR"; Rec."Bracket Width_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Ancho del soporte';
                        Enabled = true;
                        ToolTip = 'Ancho del soporte';
                    }
                    field(Plates_LDR; Rec.Plates_LDR)
                    {
                        ApplicationArea = All;
                        Caption = 'Placas';
                        Enabled = true;
                        ToolTip = 'Placas';
                    }
                    field(Volt_LDR; Rec.Volt_LDR)
                    {
                        ApplicationArea = All;
                        Caption = 'Voltaje';
                        Enabled = true;
                        ToolTip = 'Voltaje';
                    }
                    field(Amp_LDR; Rec.Amp_LDR)
                    {
                        ApplicationArea = All;
                        Caption = 'Amperaje';
                        Enabled = true;
                        ToolTip = 'Amperaje';
                    }
                    field("Wheels front measures_LDR"; Rec."Wheels front measures_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Medidas ruedas delanteras';
                        Enabled = true;
                        ToolTip = 'Medidas ruedas delanteras';
                    }
                    field("Wheels rear measures_LDR"; Rec."Wheels rear measures_LDR")
                    {
                        ApplicationArea = All;
                        Caption = 'Medidas ruedas traseras';
                        Enabled = true;
                        ToolTip = 'Medidas ruedas traseras';
                    }
                }
            }
        }
    }

    actions
    {
        addafter(CalculateCountingPeriod)
        {
            group(PrintLabels)
            {
                Caption = 'Imprimir Etiquetado';
                Image = BarCode;

                action("Print Intermec")
                {
                    ApplicationArea = All;
                    Caption = 'Imprimir Intermec';
                    Image = BarCode;

                    trigger OnAction()
                    var
                        RecBinContent: Record "Bin Content";
                        reportSelection: Record "Report Selections Labels_LDR";
                    begin
                        Clear(RecBinContent);
                        RecBinContent.SetRange(RecBinContent."Item No.", Rec."No.");
                        //if RecBinContent.FindFirst() then
                        //    Report.RunModal(Report::Report7122020, true, false, RecBinContent);
                    end;
                }
                action(PrintLabels_LDR)
                {
                    ApplicationArea = All;
                    Caption = '&Imprimir Etiquetas EAN13';
                    Image = BarCode;

                    trigger OnAction()
                    var
                        RecBinContent: Record "Bin Content";
                        reportSelection: Record "Report Selections Labels_LDR";
                    begin
                        Clear(RecBinContent);
                        RecBinContent.SetRange(RecBinContent."Item No.", Rec."No.");
                        if RecBinContent.FindSet() then begin
                            reportSelection.SetRange(Usage, reportSelection.Usage::Item);
                            reportSelection.FindSet();
                            repeat
                                Report.RunModal(reportSelection."Report ID", true, false, RecBinContent);
                            until reportSelection.Next() = 0;
                        end;
                    end;
                }
                action("AssignNo.2")
                {
                    ApplicationArea = All;
                    Caption = 'Asignar Nº 2';
                    Image = AllocatedCapacity;

                    trigger OnAction()
                    begin
                        Rec.AssignNo2();
                    end;
                }
            }
        }
        addafter("Stockkeepin&g Units")
        {
            group("Deliveries / Pickups")
            {
                Caption = 'Entregas / Recogidas';

                action(GenerateDelivery)
                {
                    ApplicationArea = All;
                    Caption = 'Generar Entrega';
                    Image = Delivery;

                    trigger OnAction()
                    begin
                        Rec.GenerateDelivery();
                    end;
                }
                action(GenerateCollection)
                {
                    ApplicationArea = All;
                    Caption = 'Generar Recogida';
                    Image = Production;

                    trigger OnAction()
                    begin
                        Rec.GenerateCollection();
                    end;
                }
                separator(Separador)
                { }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EnablePlanningControls();
        EnableCostingControls();
    end;

    /// <summary>
    /// FormatearFormulario.
    /// </summary>
    procedure FormatearFormulario()
    begin
        CASE Type2 OF
            Type2::Component:
                BEGIN
                    CASE Subtype OF
                        Subtype::Chasis:
                            BEGIN
                                ItemTypeEnabled := FALSE;
                                ModelEnabled := TRUE;
                                SeriesCodeEnabled := TRUE;
                                ChargeCapacityEnabled := TRUE;
                                HeightEnabled := FALSE;
                                FoldedEnabled := FALSE;
                                FreeElevationEnabled := FALSE;
                                ValidForEnabled := FALSE;
                                CharacteristicsEnabled := FALSE;
                                WheelsFrontMeasuresEnabled := FALSE;
                                WheelsRearMeasuresEnabled := FALSE;
                                BracketLengthEnabled := FALSE;
                                BracketGrossEnabled := FALSE;
                                BracketWidthEnabled := FALSE;
                                VoltEnabled := FALSE;
                                AmpEnabled := FALSE;
                                PlatesEnabled := FALSE;
                                MedeaCodeEnabled := TRUE;
                            END;
                        Subtype::Mast:
                            BEGIN
                                ItemTypeEnabled := TRUE;
                                ModelEnabled := FALSE;
                                SeriesCodeEnabled := FALSE;
                                ChargeCapacityEnabled := FALSE;
                                HeightEnabled := TRUE;
                                FoldedEnabled := TRUE;
                                FreeElevationEnabled := TRUE;
                                ValidForEnabled := TRUE;
                                CharacteristicsEnabled := FALSE;
                                WheelsFrontMeasuresEnabled := FALSE;
                                WheelsRearMeasuresEnabled := FALSE;
                                BracketLengthEnabled := FALSE;
                                BracketGrossEnabled := FALSE;
                                BracketWidthEnabled := FALSE;
                                VoltEnabled := FALSE;
                                AmpEnabled := FALSE;
                                PlatesEnabled := FALSE;
                                MedeaCodeEnabled := FALSE;
                            END;
                        Subtype::Engine:
                            BEGIN
                                ItemTypeEnabled := FALSE;
                                ModelEnabled := TRUE;
                                SeriesCodeEnabled := FALSE;
                                ChargeCapacityEnabled := FALSE;
                                HeightEnabled := FALSE;
                                FoldedEnabled := FALSE;
                                FreeElevationEnabled := FALSE;
                                ValidForEnabled := FALSE;
                                CharacteristicsEnabled := FALSE;
                                WheelsFrontMeasuresEnabled := FALSE;
                                WheelsRearMeasuresEnabled := FALSE;
                                BracketLengthEnabled := FALSE;
                                BracketGrossEnabled := FALSE;
                                BracketWidthEnabled := FALSE;
                                VoltEnabled := FALSE;
                                AmpEnabled := FALSE;
                                PlatesEnabled := FALSE;
                                MedeaCodeEnabled := TRUE;
                            END;
                        Subtype::Wheels:
                            BEGIN
                                ItemTypeEnabled := TRUE;
                                ModelEnabled := FALSE;
                                SeriesCodeEnabled := FALSE;
                                ChargeCapacityEnabled := FALSE;
                                HeightEnabled := FALSE;
                                FoldedEnabled := FALSE;
                                FreeElevationEnabled := FALSE;
                                ValidForEnabled := FALSE;
                                CharacteristicsEnabled := TRUE;
                                WheelsFrontMeasuresEnabled := TRUE;
                                WheelsRearMeasuresEnabled := TRUE;
                                BracketLengthEnabled := FALSE;
                                BracketGrossEnabled := FALSE;
                                BracketWidthEnabled := FALSE;
                                VoltEnabled := FALSE;
                                AmpEnabled := FALSE;
                                PlatesEnabled := FALSE;
                                MedeaCodeEnabled := TRUE;
                            END;
                        Subtype::Brackets:
                            BEGIN
                                ItemTypeEnabled := TRUE;
                                ModelEnabled := FALSE;
                                SeriesCodeEnabled := FALSE;
                                ChargeCapacityEnabled := FALSE;
                                HeightEnabled := FALSE;
                                FoldedEnabled := FALSE;
                                FreeElevationEnabled := FALSE;
                                ValidForEnabled := FALSE;
                                CharacteristicsEnabled := FALSE;
                                WheelsFrontMeasuresEnabled := FALSE;
                                WheelsRearMeasuresEnabled := FALSE;
                                BracketLengthEnabled := TRUE;
                                BracketGrossEnabled := TRUE;
                                BracketWidthEnabled := TRUE;
                                VoltEnabled := FALSE;
                                AmpEnabled := FALSE;
                                PlatesEnabled := FALSE;
                                MedeaCodeEnabled := TRUE;
                            END;
                        Subtype::Batery:
                            BEGIN
                                ItemTypeEnabled := FALSE;
                                ModelEnabled := TRUE;
                                SeriesCodeEnabled := FALSE;
                                ChargeCapacityEnabled := FALSE;
                                HeightEnabled := FALSE;
                                FoldedEnabled := FALSE;
                                FreeElevationEnabled := FALSE;
                                ValidForEnabled := TRUE;
                                CharacteristicsEnabled := FALSE;
                                WheelsFrontMeasuresEnabled := FALSE;
                                WheelsRearMeasuresEnabled := FALSE;
                                BracketLengthEnabled := FALSE;
                                BracketGrossEnabled := FALSE;
                                BracketWidthEnabled := FALSE;
                                VoltEnabled := TRUE;
                                AmpEnabled := TRUE;
                                PlatesEnabled := TRUE;
                                MedeaCodeEnabled := TRUE;
                            END;
                        Subtype::Charger:
                            BEGIN
                                ItemTypeEnabled := TRUE;
                                ModelEnabled := TRUE;
                                SeriesCodeEnabled := FALSE;
                                ChargeCapacityEnabled := FALSE;
                                HeightEnabled := FALSE;
                                FoldedEnabled := FALSE;
                                FreeElevationEnabled := FALSE;
                                ValidForEnabled := TRUE;
                                CharacteristicsEnabled := FALSE;
                                WheelsFrontMeasuresEnabled := FALSE;
                                WheelsRearMeasuresEnabled := FALSE;
                                BracketLengthEnabled := FALSE;
                                BracketGrossEnabled := FALSE;
                                BracketWidthEnabled := FALSE;
                                VoltEnabled := TRUE;
                                AmpEnabled := TRUE;
                                PlatesEnabled := FALSE;
                                MedeaCodeEnabled := TRUE;
                            END;
                        Subtype::" ":
                            BEGIN
                                ItemTypeEnabled := FALSE;
                                ModelEnabled := FALSE;
                                SeriesCodeEnabled := FALSE;
                                ChargeCapacityEnabled := FALSE;
                                HeightEnabled := FALSE;
                                FoldedEnabled := FALSE;
                                FreeElevationEnabled := FALSE;
                                ValidForEnabled := FALSE;
                                CharacteristicsEnabled := TRUE;
                                WheelsFrontMeasuresEnabled := FALSE;
                                WheelsRearMeasuresEnabled := FALSE;
                                BracketLengthEnabled := FALSE;
                                BracketGrossEnabled := FALSE;
                                BracketWidthEnabled := FALSE;
                                PlatesEnabled := FALSE;
                                VoltEnabled := FALSE;
                                AmpEnabled := FALSE;
                                MedeaCodeEnabled := TRUE;

                            END;
                    END;

                END;
            Type2::Implement:
                BEGIN
                    ItemTypeEnabled := FALSE;
                    ModelEnabled := TRUE;
                    SeriesCodeEnabled := TRUE;
                    ChargeCapacityEnabled := FALSE;
                    HeightEnabled := FALSE;
                    FoldedEnabled := FALSE;
                    FreeElevationEnabled := FALSE;
                    ValidForEnabled := FALSE;
                    CharacteristicsEnabled := FALSE;
                    WheelsFrontMeasuresEnabled := FALSE;
                    WheelsRearMeasuresEnabled := FALSE;
                    BracketLengthEnabled := FALSE;
                    BracketGrossEnabled := FALSE;
                    BracketWidthEnabled := FALSE;
                    PlatesEnabled := FALSE;
                    VoltEnabled := FALSE;
                    AmpEnabled := FALSE;
                    MedeaCodeEnabled := TRUE;

                END;
            Type2::"Spare Part":
                BEGIN
                    ItemTypeEnabled := FALSE;
                    ModelEnabled := FALSE;
                    SeriesCodeEnabled := FALSE;
                    ChargeCapacityEnabled := FALSE;
                    HeightEnabled := FALSE;
                    FoldedEnabled := FALSE;
                    FreeElevationEnabled := FALSE;
                    ValidForEnabled := FALSE;
                    CharacteristicsEnabled := FALSE;
                    WheelsFrontMeasuresEnabled := FALSE;
                    WheelsRearMeasuresEnabled := FALSE;
                    BracketLengthEnabled := FALSE;
                    BracketGrossEnabled := FALSE;
                    BracketWidthEnabled := FALSE;
                    PlatesEnabled := FALSE;
                    VoltEnabled := FALSE;
                    AmpEnabled := FALSE;
                    MedeaCodeEnabled := TRUE;

                END;
            Type2::Machine:
                BEGIN
                    ItemTypeEnabled := FALSE;
                    ModelEnabled := TRUE;
                    SeriesCodeEnabled := TRUE;
                    ChargeCapacityEnabled := TRUE;
                    HeightEnabled := FALSE;
                    FoldedEnabled := FALSE;
                    FreeElevationEnabled := FALSE;
                    ValidForEnabled := FALSE;
                    CharacteristicsEnabled := FALSE;
                    WheelsFrontMeasuresEnabled := FALSE;
                    WheelsRearMeasuresEnabled := FALSE;
                    BracketLengthEnabled := FALSE;
                    BracketGrossEnabled := FALSE;
                    BracketWidthEnabled := FALSE;
                    PlatesEnabled := FALSE;
                    VoltEnabled := FALSE;
                    AmpEnabled := FALSE;
                    MedeaCodeEnabled := TRUE;

                END;
            Type2::" ":
                BEGIN
                    ItemTypeEnabled := FALSE;
                    ModelEnabled := FALSE;
                    SeriesCodeEnabled := FALSE;
                    ChargeCapacityEnabled := FALSE;
                    HeightEnabled := FALSE;
                    FoldedEnabled := FALSE;
                    FreeElevationEnabled := FALSE;
                    ValidForEnabled := FALSE;
                    CharacteristicsEnabled := FALSE;
                    WheelsFrontMeasuresEnabled := FALSE;
                    WheelsRearMeasuresEnabled := FALSE;
                    BracketLengthEnabled := FALSE;
                    BracketGrossEnabled := FALSE;
                    BracketWidthEnabled := FALSE;
                    PlatesEnabled := FALSE;
                    VoltEnabled := FALSE;
                    AmpEnabled := FALSE;
                    MedeaCodeEnabled := TRUE;

                END;


        END;
    end;

    var
        Text001: Label 'El producto ya tiene un c¢digo EAN asignado\¨Desea asignarle uno nuevo?';
        ItemTypeEnabled: Boolean;
        ModelEnabled: Boolean;
        SeriesCodeEnabled: Boolean;
        ChargeCapacityEnabled: Boolean;
        HeightEnabled: Boolean;
        FoldedEnabled: Boolean;
        FreeElevationEnabled: Boolean;
        ValidForEnabled: Boolean;
        CharacteristicsEnabled: Boolean;
        WheelsFrontMeasuresEnabled: Boolean;
        WheelsRearMeasuresEnabled: Boolean;
        BracketLengthEnabled: Boolean;
        BracketGrossEnabled: Boolean;
        BracketWidthEnabled: Boolean;
        VoltEnabled: Boolean;
        AmpEnabled: Boolean;
        PlatesEnabled: Boolean;
        MedeaCodeEnabled: Boolean;
        PurchSetup: Record "Purchases & Payables Setup";
}